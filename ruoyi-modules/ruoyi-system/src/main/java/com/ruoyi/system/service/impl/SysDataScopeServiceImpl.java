package com.ruoyi.system.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.mybatisflex.core.query.QueryCondition;
import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.core.core.domain.model.LoginUser;
import com.ruoyi.common.security.utils.LoginHelper;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.domain.vo.SysRoleVo;
import com.ruoyi.system.mapper.SysRoleMapper;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.service.ISysDataScopeService;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.mybatisflex.core.query.QueryMethods.bracket;
import static com.mybatisflex.core.query.QueryMethods.select;
import static com.ruoyi.system.domain.table.SysDeptTableDef.SYS_DEPT;
import static com.ruoyi.system.domain.table.SysRoleDeptTableDef.SYS_ROLE_DEPT;
import static com.ruoyi.system.domain.table.SysUserTableDef.SYS_USER;

/**
 * 通用"数据权限过滤“服务
 *
 * @author dataprince数据小王子
 */
@RequiredArgsConstructor
@Service
public class SysDataScopeServiceImpl implements ISysDataScopeService {
    /**
     * 全部数据权限
     */
    public static final String DATA_SCOPE_ALL = "1";

    /**
     * 自定数据权限
     */
    public static final String DATA_SCOPE_CUSTOM = "2";

    /**
     * 部门数据权限
     */
    public static final String DATA_SCOPE_DEPT = "3";

    /**
     * 部门及以下数据权限
     */
    public static final String DATA_SCOPE_DEPT_AND_CHILD = "4";

    /**
     * 仅本人数据权限
     */
    public static final String DATA_SCOPE_SELF = "5";

    @Resource
    private SysUserMapper userMapper;

    @Resource
    private SysRoleMapper roleMapper;

    /**
     * 添加数据查询过滤条件
     *
     * @param queryWrapper
     * @return 添加了过滤条件后的queryWrapper
     */
    @Override
    public QueryWrapper addCondition(QueryWrapper queryWrapper) {
        QueryCondition queryCondition = QueryCondition.createEmpty();
        // 获取当前的用户
        LoginUser loginUser = LoginHelper.getLoginUser();
        if (ObjectUtil.isNotNull(loginUser)) {
            Long userId = loginUser.getUserId();
            if (userId > 0) {
                //SysUserVo currentUser = userService.selectUserById(userId);
                SysUser currentUser = userMapper.selectOneById(userId);
                List<SysRoleVo> roleList = roleMapper.selectUserRolesByUserId(userId);
                // 如果是超级管理员，则不过滤数据
                if (ObjectUtil.isNotNull(currentUser) && !LoginHelper.isSuperAdmin(userId)) {
                    List<String> dataScopeList = new ArrayList<>();
                    //除了“2：自定义数据权限”，其它值去重存入dataScopeList列表
                    for (SysRoleVo role : roleList) {
                        String dataScope = role.getDataScope();//数据范围（1：全部数据权限，2：自定义数据权限，3：本部门数据权限，4：本部门及以下数据权限，5：仅本人数据权限）
                        if (!DATA_SCOPE_CUSTOM.equals(dataScope) && dataScopeList.contains(dataScope)) {
                            continue;
                        }
                        dataScopeList.add(dataScope);
                    }

                    //如果数据范围是“1：全部数据权限”，则不再添加过滤条件，直接返回queryWrapper原值
                    if (dataScopeList.contains(DATA_SCOPE_ALL)) {
                        return queryWrapper;
                    }

                    //单独处理数据范围是“2：自定义数据权限”
                    for (SysRoleVo role : roleList) {
                        String dataScope = role.getDataScope();//数据范围
                        if (DATA_SCOPE_CUSTOM.equals(dataScope)) {
                            //OR {}.dept_id IN ( SELECT dept_id FROM sys_role_dept WHERE role_id = {} )
                            queryCondition.or(SYS_DEPT.DEPT_ID.in(select(SYS_ROLE_DEPT.DEPT_ID).from(SYS_ROLE_DEPT).where(SYS_ROLE_DEPT.ROLE_ID.eq(role.getRoleId()))));
                        }
                    }

                    //单独处理数据范围是" 3：本部门数据权限"
                    if (dataScopeList.contains(DATA_SCOPE_DEPT)) {
                        //OR {}.dept_id = {}
                        queryCondition.or(SYS_DEPT.DEPT_ID.eq(currentUser.getDeptId()));
                    }

                    //单独处理数据范围是" 4：本部门及以下数据权限"
                    if (dataScopeList.contains(DATA_SCOPE_DEPT_AND_CHILD)) {
                        //OR {}.dept_id IN ( SELECT dept_id FROM sys_dept WHERE dept_id = {} or find_in_set( {} , ancestors )
                        queryCondition.or(SYS_DEPT.DEPT_ID.in(select(SYS_DEPT.DEPT_ID).from(SYS_DEPT).where(SYS_DEPT.DEPT_ID.eq(currentUser.getDeptId())).or(QueryMethods.findInSet(QueryMethods.number(currentUser.getDeptId()),SYS_DEPT.ANCESTORS).gt(0))));
                    }

                    //单独处理数据范围是" 5：仅本人数据权限"
                    if (dataScopeList.contains(DATA_SCOPE_SELF)) {
                        //OR {}.user_id = {}
                        queryCondition.or(SYS_USER.USER_ID.eq(currentUser.getUserId()));
                    }
                }
            }

        }

        queryWrapper.and(bracket(queryCondition));//所有新增的查询条件外边用圆括号包括起来

        return queryWrapper;
    }
}
