package com.ruoyi.system.service;

import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysUserPost;

/**
 * ruoyi-flex
 *
 * @author dataprince数据小王子
 */
public interface ISysUserPostService extends IBaseService<SysUserPost> {

    /**
     * 通过用户ID删除用户和岗位关联
     *
     * @param userId 用户ID
     * @return 结果:true 删除成功，false 删除失败
     */
    boolean deleteUserPostByUserId(Long userId);

    /**
     * 批量删除用户和岗位关联
     *
     * @param ids 需要删除的数据ID
     * @return 结果:true 删除成功，false 删除失败
     */
    boolean deleteUserPost(Long[] ids);

    /**
     * 通过岗位ID查询岗位使用数量
     *
     * @param postId 岗位ID
     * @return 结果：数量
     */
    int countUserPostById(Long postId);

}
