package com.ruoyi.system.service.impl;

import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.system.domain.SysRoleDept;
import com.ruoyi.system.mapper.SysRoleDeptMapper;
import com.ruoyi.system.service.ISysRoleDeptService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.Arrays;

import static com.ruoyi.system.domain.table.SysRoleDeptTableDef.SYS_ROLE_DEPT;

/**
 * SysRoleDept服务实现
 *
 * @author dataprince数据小王子
 */
@Service
public class SysRoleDeptServiceImpl extends BaseServiceImpl<SysRoleDeptMapper, SysRoleDept> implements ISysRoleDeptService {

    @Resource
    private SysRoleDeptMapper roleDeptMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_ROLE_DEPT);
    }

    /**
     * 通过角色ID删除角色和部门关联
     * delete from sys_role_dept where role_id=#{roleId}
     * @param roleId 角色ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteRoleDeptByRoleId(Long roleId) {
        QueryWrapper queryWrapper = query().where(SYS_ROLE_DEPT.ROLE_ID.eq(roleId));
        return this.remove(queryWrapper);
    }

    /**
     * 批量删除角色部门关联信息
     * delete from sys_role_dept where role_id in
     * @param ids 需要删除的数据ID
     * @return 结果:true 删除成功，false 删除失败。
     */
    @Override
    public boolean deleteRoleDept(Long[] ids) {
        QueryWrapper queryWrapper = QueryWrapper.create().from(SYS_ROLE_DEPT).where(SYS_ROLE_DEPT.ROLE_ID.in(Arrays.asList(ids)));
        return this.remove(queryWrapper);
    }
    /**
     * 查询部门使用数量
     * select count(1) from sys_role_dept where dept_id=#{deptId}
     * @param deptId 部门ID
     * @return 结果
     */
    @Override
    public int selectCountRoleDeptByDeptId(Long deptId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.count(SYS_ROLE_DEPT.ROLE_ID))
            .from(SYS_ROLE_DEPT)
            .where(SYS_ROLE_DEPT.DEPT_ID.eq(deptId));

        return roleDeptMapper.selectObjectByQueryAs(queryWrapper,Integer.class);
    }
}
