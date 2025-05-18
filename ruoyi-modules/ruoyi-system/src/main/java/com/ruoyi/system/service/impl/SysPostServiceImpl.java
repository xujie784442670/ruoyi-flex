package com.ruoyi.system.service.impl;

import java.util.Arrays;
import java.util.List;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.common.orm.core.page.PageQuery;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.system.domain.bo.SysPostBo;
import com.ruoyi.system.domain.vo.SysPostVo;
import com.ruoyi.system.service.ISysUserPostService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.mapper.SysPostMapper;
import com.ruoyi.system.service.ISysPostService;
import org.springframework.transaction.annotation.Transactional;

import static com.ruoyi.system.domain.table.SysPostTableDef.SYS_POST;
import static com.ruoyi.system.domain.table.SysUserPostTableDef.SYS_USER_POST;
import static com.ruoyi.system.domain.table.SysUserTableDef.SYS_USER;

/**
 * 岗位信息 服务层处理
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@Service
public class SysPostServiceImpl extends BaseServiceImpl<SysPostMapper, SysPost> implements ISysPostService {
    @Resource
    private ISysUserPostService userPostService;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_POST);
    }

    /**
     * 根据postBo构建QueryWrapper查询条件
     *
     * @param postBo
     * @return 查询条件
     */
    private QueryWrapper buildQueryWrapper(SysPostBo postBo) {
        QueryWrapper queryWrapper = super.buildBaseQueryWrapper()
            .and(SYS_POST.POST_CODE.like(postBo.getPostCode()))
            .and(SYS_POST.STATUS.eq(postBo.getStatus()))
            .and(SYS_POST.POST_NAME.like(postBo.getPostName()));
        return queryWrapper;
    }

    /**
     * 查询岗位信息集合
     *
     * @param postBo 岗位信息
     * @return 岗位信息集合
     */
    @Override
    public List<SysPostVo> selectPostList(SysPostBo postBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(postBo);
        return this.listAs(queryWrapper, SysPostVo.class);
    }

    /**
     * 分页查询公告列表
     *
     * @param postBo 公告信息
     * @return 公告集合
     */
    @Override
    public TableDataInfo<SysPostVo> selectPage(SysPostBo postBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(postBo);
        Page<SysPostVo> page = this.pageAs(PageQuery.build(), queryWrapper, SysPostVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 查询所有岗位
     *
     * @return 岗位列表
     */
    @Override
    public List<SysPostVo> selectPostAll() {
        return this.listAs(query(), SysPostVo.class);
    }

    /**
     * 通过岗位ID查询岗位信息
     *
     * @param postId 岗位ID
     * @return 角色对象信息
     */
    @Override
    public SysPostVo selectPostById(Long postId) {
        return this.getOneAs(query().where(SYS_POST.POST_ID.eq(postId)), SysPostVo.class);
    }

    /**
     * 根据用户ID获取岗位选择框列表
     *
     * @param userId 用户ID
     * @return 选中岗位ID列表
     */
    @Override
    public List<Long> selectPostListByUserId(Long userId) {
        /*select p.post_id
        from sys_post p
        left join sys_user_post up on up.post_id = p.post_id
        left join sys_user u on u.user_id = up.user_id
        where u.user_id = #{userId}*/

        QueryWrapper queryWrapper = QueryWrapper.create().select(SYS_POST.POST_ID)
            .from(SYS_POST).as("p")
            .leftJoin(SYS_USER_POST).as("up").on(SYS_USER_POST.POST_ID.eq(SYS_POST.POST_ID))
            .leftJoin(SYS_USER).as("u").on(SYS_USER.USER_ID.eq(SYS_USER_POST.USER_ID))
            .where(SYS_USER.USER_ID.eq(userId));
        return this.listAs(queryWrapper, Long.class);
    }

    /**
     * 查询用户所属岗位组
     *
     * @param userName 用户名
     * @return 结果:SysPostVo集合
     */
    @Override
    public List<SysPostVo> selectPostsByUserName(String userName) {
         /* select p.post_id, p.post_name, p.post_code
        from sys_post p
        left join sys_user_post up on up.post_id = p.post_id
        left join sys_user u on u.user_id = up.user_id
        where u.user_name = #{userName}*/
        QueryWrapper queryWrapper = QueryWrapper.create().select(SYS_POST.POST_ID, SYS_POST.POST_NAME, SYS_POST.POST_CODE)
            .from(SYS_POST).as("p")
            .leftJoin(SYS_USER_POST).as("up").on(SYS_USER_POST.POST_ID.eq(SYS_POST.POST_ID))
            .leftJoin(SYS_USER).as("u").on(SYS_USER.USER_ID.eq(SYS_USER_POST.USER_ID))
            .where(SYS_USER.USER_NAME.eq(userName));
        return this.listAs(queryWrapper, SysPostVo.class);
    }

    /**
     * 通过岗位ID串查询岗位
     *
     * @param postIds 岗位id串
     * @return 岗位列表信息
     */
    @Override
    public List<SysPostVo> selectPostByIds(List<Long> postIds) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(SYS_POST.POST_ID, SYS_POST.POST_NAME, SYS_POST.POST_CODE)
            .from(SYS_POST)
            .where(SYS_POST.STATUS.eq(UserConstants.POST_NORMAL))
            .and(SYS_POST.POST_ID.in(postIds));
        return this.listAs(queryWrapper, SysPostVo.class);
    }

    /**
     * 校验岗位名称是否唯一
     *
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public boolean checkPostNameUnique(SysPostBo post) {
        Long postId = StringUtils.isNull(post.getPostId()) ? -1L : post.getPostId();
        SysPost info = this.getOne(query().where(SYS_POST.POST_NAME.eq(post.getPostName())));
        if (StringUtils.isNotNull(info) && info.getPostId().longValue() != postId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验岗位编码是否唯一
     *
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public boolean checkPostCodeUnique(SysPostBo post) {
        Long postId = StringUtils.isNull(post.getPostId()) ? -1L : post.getPostId();
        SysPost info = this.getOne(query().where(SYS_POST.POST_CODE.eq(post.getPostCode())));
        if (StringUtils.isNotNull(info) && info.getPostId().longValue() != postId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

//    /**
//     * 通过岗位ID查询岗位使用数量
//     *
//     * @param postId 岗位ID
//     * @return 结果
//     */
//    @Override
//    public int countUserPostById(Long postId)
//    {
//        return userPostMapper.countUserPostById(postId);
//    }

    /**
     * 删除岗位信息
     *
     * @param postId 岗位ID
     * @return 结果:true 删除成功，false 删除失败。
     */
    @Override
    public boolean deletePostById(Long postId) {
        return this.removeById(postId);
    }

    /**
     * 批量删除岗位信息
     *
     * @param postIds 需要删除的岗位ID
     * @return 结果:true 删除成功，false 删除失败。
     */
    @Override
    @Transactional
    public boolean deletePostByIds(Long[] postIds) {
        for (Long postId : postIds) {
            SysPostVo post = selectPostById(postId);
            if (userPostService.countUserPostById(postId) > 0) {
                throw new ServiceException(String.format("%1$s已分配，不能删除！", post.getPostName()));
            }
        }
        return this.removeByIds(Arrays.asList(postIds));
    }

    /**
     * 新增保存岗位信息
     *
     * @param postBo 岗位信息
     * @return true 操作成功，false 操作失败
     */
    @Override
    public boolean insertPost(SysPostBo postBo) {
        SysPost sysPost = MapstructUtils.convert(postBo, SysPost.class);
        return this.save(sysPost);
    }

    /**
     * 修改保存岗位信息
     *
     * @param postBo 岗位信息
     * @return 结果:true 更新成功，false 更新失败
     */
    @Override
    public boolean updatePost(SysPostBo postBo) {
        SysPost sysPost = MapstructUtils.convert(postBo, SysPost.class);
        return this.updateById(sysPost);
    }
}
