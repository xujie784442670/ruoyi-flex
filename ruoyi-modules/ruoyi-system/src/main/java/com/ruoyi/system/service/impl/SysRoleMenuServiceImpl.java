package com.ruoyi.system.service.impl;

import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.system.domain.SysRoleMenu;
import com.ruoyi.system.mapper.SysRoleMenuMapper;
import com.ruoyi.system.service.ISysRoleMenuService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.Arrays;

import static com.ruoyi.system.domain.table.SysRoleMenuTableDef.SYS_ROLE_MENU;

/**
 * SysRoleMenu服务实现类
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@Service
public class SysRoleMenuServiceImpl extends BaseServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements ISysRoleMenuService {
    @Resource
    private SysRoleMenuMapper roleMenuMapper;

    /**
     * 批量删除角色菜单关联信息
     * delete from sys_role_menu where role_id in
     * @param ids 需要删除的数据ID
     * @return true 删除成功，false 删除失败。
     */
    @Override
    public boolean deleteRoleMenu(Long[] ids) {
        QueryWrapper queryWrapper = QueryWrapper.create().from(SYS_ROLE_MENU).where(SYS_ROLE_MENU.ROLE_ID.in(Arrays.asList(ids)));
        return this.remove(queryWrapper);
    }

    /**
     * 通过角色ID删除用户和菜单关联
     *
     * @param roleId 角色ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteRoleMenuByRoleId(Long roleId) {
        QueryWrapper queryWrapper = QueryWrapper.create().from(SYS_ROLE_MENU).where(SYS_ROLE_MENU.ROLE_ID.eq(roleId));
        return this.remove(queryWrapper);
    }

    /**
     * 查询菜单使用数量
     * select count(1) from sys_role_menu where menu_id = #{menuId}
     * @param menuId 菜单ID
     * @return 结果
     */
    @Override
    public int checkMenuExistRole(Long menuId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.count(SYS_ROLE_MENU.ROLE_ID))
            .from(SYS_ROLE_MENU)
            .where(SYS_ROLE_MENU.MENU_ID.eq(menuId));

        return roleMenuMapper.selectObjectByQueryAs(queryWrapper,Integer.class);
    }
}
