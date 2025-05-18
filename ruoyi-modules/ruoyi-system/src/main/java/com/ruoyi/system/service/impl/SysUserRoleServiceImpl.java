package com.ruoyi.system.service.impl;

import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.system.domain.SysUserRole;
import com.ruoyi.system.mapper.SysUserRoleMapper;
import com.ruoyi.system.service.ISysUserRoleService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static com.ruoyi.system.domain.table.SysUserRoleTableDef.SYS_USER_ROLE;

/**
 * SysUserRoleService实现类
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@Service
public class SysUserRoleServiceImpl extends BaseServiceImpl<SysUserRoleMapper, SysUserRole> implements ISysUserRoleService {

    @Resource
    private SysUserRoleMapper userRoleMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_USER_ROLE);
    }

    /**
     * 通过角色ID查询角色使用数量
     *
     * @param roleId 角色ID
     * @return 结果
     */
    @Override
    public int countUserRoleByRoleId(Long roleId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.count(SYS_USER_ROLE.ROLE_ID))
            .from(SYS_USER_ROLE)
            .where(SYS_USER_ROLE.ROLE_ID.eq(roleId));

        return userRoleMapper.selectObjectByQueryAs(queryWrapper,Integer.class);
    }

    /**
     * 取消授权用户:删除用户和角色关联信息
     * delete from sys_user_role where user_id=#{userId} and role_id=#{roleId}
     * @param userRole 用户和角色关联信息
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteUserRoleInfo(SysUserRole userRole) {
        QueryWrapper queryWrapper = QueryWrapper.create().from(SYS_USER_ROLE).where(SYS_USER_ROLE.USER_ID.eq(userRole.getUserId()))
            .and(SYS_USER_ROLE.ROLE_ID.eq(userRole.getRoleId()));
        return this.remove(queryWrapper);
    }

    /**
     * 批量取消授权用户角色
     * delete from sys_user_role where role_id=#{roleId} and user_id in
     * @param roleId 角色ID
     * @param userIds 需要删除的用户数据ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteUserRoleInfos(Long roleId, Long[] userIds) {
        QueryWrapper queryWrapper = QueryWrapper.create().from(SYS_USER_ROLE).where(SYS_USER_ROLE.ROLE_ID.eq(roleId))
            .and(SYS_USER_ROLE.USER_ID.in(Arrays.asList(userIds)));
        return this.remove(queryWrapper);
    }

    /**
     * 批量选择授权用户角色
     * insert into sys_user_role(user_id, role_id) values
     * @param roleId 角色ID
     * @param userIds 需要新增的用户数据ID
     * @return 结果:true 保存成功，false 保存失败
     */
    @Override
    public boolean insertAuthUsers(Long roleId, Long[] userIds) {
        // 新增用户与角色管理
        List<SysUserRole> list = new ArrayList<>();
        for (Long userId : userIds) {
            SysUserRole ur = new SysUserRole();
            ur.setUserId(userId);
            ur.setRoleId(roleId);
            list.add(ur);
        }
        return this.saveBatchWithPk(list,100);//批量插入
    }

    /**
     * 新增用户角色
     *
     * @param userId 用户ID
     * @param roleIds 需要新增的角色数据ID
     * @return 结果：true 保存成功，false 保存失败
     */
    @Override
    public boolean insertUserRoles(Long userId, Long[] roleIds) {
        // 新增用户与角色管理
        List<SysUserRole> list = new ArrayList<>();
        for (Long roleId : roleIds) {
            SysUserRole ur = new SysUserRole();
            ur.setUserId(userId);
            ur.setRoleId(roleId);
            list.add(ur);
        }
        return this.saveBatchWithPk(list,100);//批量插入
    }

    /**
     * 通过用户ID删除用户和角色关联
     * delete from sys_user_role where user_id=#{userId}
     * @param userId 用户ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteUserRoleByUserId(Long userId) {
        QueryWrapper queryWrapper = query().where(SYS_USER_ROLE.USER_ID.eq(userId));
        return this.remove(queryWrapper);
    }

    /**
     * 批量删除用户和角色关联
     * delete from sys_user_role where user_id in
     * @param ids 需要删除的数据ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteUserRole(Long[] ids) {
        QueryWrapper queryWrapper = query().where(SYS_USER_ROLE.USER_ID.in(Arrays.asList(ids)));
        return this.remove(queryWrapper);
    }
}
