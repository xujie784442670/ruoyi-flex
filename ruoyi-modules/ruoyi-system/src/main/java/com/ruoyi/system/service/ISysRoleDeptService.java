package com.ruoyi.system.service;

import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysRoleDept;

/**
 * SysRoleDept服务接口
 *
 * @author dataprince数据小王子
 */
public interface ISysRoleDeptService extends IBaseService<SysRoleDept> {

     /**
     * 通过角色ID删除角色和部门关联
     *
     * @param roleId 角色ID
     * @return 结果:true 删除成功，false 删除失败
     */
    boolean deleteRoleDeptByRoleId(Long roleId);

    /**
     * 批量删除角色部门关联信息
     *
     * @param ids 需要删除的数据ID
     * @return 结果:true 删除成功，false 删除失败。
     */
    boolean deleteRoleDept(Long[] ids);

    /**
     * 查询部门使用数量
     *
     * @param deptId 部门ID
     * @return 结果
     */
    int selectCountRoleDeptByDeptId(Long deptId);

}
