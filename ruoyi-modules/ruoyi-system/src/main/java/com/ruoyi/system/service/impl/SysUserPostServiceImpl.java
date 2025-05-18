package com.ruoyi.system.service.impl;

import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.system.domain.SysUserPost;
import com.ruoyi.system.mapper.SysUserPostMapper;
import com.ruoyi.system.service.ISysUserPostService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.Arrays;

import static com.ruoyi.system.domain.table.SysUserPostTableDef.SYS_USER_POST;

/**
 * ruoyi-flex
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@Service
public class SysUserPostServiceImpl  extends BaseServiceImpl<SysUserPostMapper, SysUserPost> implements ISysUserPostService {
    @Resource
    private SysUserPostMapper userPostMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_USER_POST);
    }


    /**
     * 通过用户ID删除用户和岗位关联
     * delete from sys_user_post where user_id=#{userId}
     * @param userId 用户ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteUserPostByUserId(Long userId) {
        QueryWrapper queryWrapper = query().where(SYS_USER_POST.USER_ID.eq(userId));
        return this.remove(queryWrapper);
    }

    /**
     * 批量删除用户和岗位关联
     * delete from sys_user_post where user_id in
     * @param ids 需要删除的数据ID
     * @return 结果:true 删除成功，false 删除失败
     */
    @Override
    public boolean deleteUserPost(Long[] ids) {
        QueryWrapper queryWrapper = query().where(SYS_USER_POST.USER_ID.in(Arrays.asList(ids)));
        return this.remove(queryWrapper);
    }

    /**
     * 通过岗位ID查询岗位使用数量
     * select count(1) from sys_user_post where post_id=#{postId}
     * @param postId 岗位ID
     * @return 结果：数量
     */
    @Override
    public int countUserPostById(Long postId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.count(SYS_USER_POST.USER_ID))
            .from(SYS_USER_POST)
            .where(SYS_USER_POST.POST_ID.eq(postId));

        return userPostMapper.selectObjectByQueryAs(queryWrapper,Integer.class);
    }
}
