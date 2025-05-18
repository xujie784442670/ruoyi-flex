package com.ruoyi.system.service.impl;

import java.util.Arrays;
import java.util.List;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.common.orm.core.page.PageQuery;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.system.domain.bo.SysNoticeBo;
import com.ruoyi.system.domain.vo.SysNoticeVo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.mapper.SysNoticeMapper;
import com.ruoyi.system.service.ISysNoticeService;
import org.springframework.transaction.annotation.Transactional;

import static com.ruoyi.system.domain.table.SysNoticeTableDef.SYS_NOTICE;

/**
 * 公告 服务层实现
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@Service
public class SysNoticeServiceImpl extends BaseServiceImpl<SysNoticeMapper, SysNotice> implements ISysNoticeService {

    @Resource
    private SysNoticeMapper noticeMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_NOTICE);
    }

    /**
     * 查询公告信息
     *
     * @param noticeId 公告ID
     * @return 公告信息
     */
    @Override
    public SysNoticeVo selectNoticeById(Long noticeId) {
        return noticeMapper.selectOneWithRelationsByQueryAs(query().where(SYS_NOTICE.NOTICE_ID.eq(noticeId)), SysNoticeVo.class);
    }

    /**
     * 根据noticeBo构建QueryWrapper查询条件
     *
     * @param noticeBo
     * @return 查询条件
     */
    private QueryWrapper buildQueryWrapper(SysNoticeBo noticeBo) {
        QueryWrapper queryWrapper = super.buildBaseQueryWrapper()
            .and(SYS_NOTICE.NOTICE_TITLE.like(noticeBo.getNoticeTitle()))
            .and(SYS_NOTICE.NOTICE_TYPE.eq(noticeBo.getNoticeType()))
            .and(SYS_NOTICE.CREATE_BY.like(noticeBo.getCreateBy()));
        return queryWrapper;
    }

    /**
     * 查询公告列表
     *
     * @param noticeBo 公告信息
     * @return 公告集合
     */
    @Override
    public List<SysNoticeVo> selectNoticeList(SysNoticeBo noticeBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(noticeBo);
        return noticeMapper.selectListWithRelationsByQueryAs(queryWrapper, SysNoticeVo.class);
    }

    /**
     * 分页查询公告列表
     *
     * @param noticeBo 公告信息
     * @return 公告集合
     */
    @Override
    public TableDataInfo<SysNoticeVo> selectPage(SysNoticeBo noticeBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(noticeBo);
        Page<SysNoticeVo> page = noticeMapper.paginateWithRelationsAs(PageQuery.build(), queryWrapper, SysNoticeVo.class);
        return TableDataInfo.build(page);
    }


    /**
     * 新增公告
     *
     * @param noticeBo 公告信息
     * @return true 操作成功，false 操作失败
     */
    @Override
    public boolean insertNotice(SysNoticeBo noticeBo) {
        SysNotice sysNotice = MapstructUtils.convert(noticeBo, SysNotice.class);
        return this.save(sysNotice);
    }

    /**
     * 修改公告
     *
     * @param noticeBo 公告信息
     * @return true 更新成功，false 更新失败
     */
    @Override
    public Boolean updateNotice(SysNoticeBo noticeBo) {
        SysNotice sysNotice = MapstructUtils.convert(noticeBo, SysNotice.class);
        return this.updateById(sysNotice);
    }

    /**
     * 批量删除公告信息
     *
     * @param noticeIds 需要删除的公告ID
     * @return true 删除成功，false 删除失败
     */
    @Override
    @Transactional
    public boolean deleteNoticeByIds(Long[] noticeIds) {
        return this.removeByIds(Arrays.asList(noticeIds));
    }
}
