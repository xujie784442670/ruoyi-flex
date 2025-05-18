package com.ruoyi.system.service;

import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysRoleMenu;

/**
 * ruoyi-flex
 *
 * @author dataprince数据小王子
 */
public interface ISysRoleMenuService extends IBaseService<SysRoleMenu> {

     /**
     * 批量删除角色菜单关联信息
     *
     * @param ids 需要删除的数据ID
     * @return true 删除成功，false 删除失败。
     */
    boolean deleteRoleMenu(Long[] ids);

    /**
     * 通过角色ID删除用户和菜单关联
     *
     * @param roleId 角色ID
     * @return 结果:true 删除成功，false 删除失败
     */
    boolean deleteRoleMenuByRoleId(Long roleId);

    /**
     * 查询菜单使用数量
     *
     * @param menuId 菜单ID
     * @return 结果
     */
    int checkMenuExistRole(Long menuId);

}
