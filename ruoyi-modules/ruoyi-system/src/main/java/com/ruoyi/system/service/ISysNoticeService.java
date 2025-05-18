package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.domain.bo.SysNoticeBo;
import com.ruoyi.system.domain.vo.SysNoticeVo;

/**
 * 公告 服务层
 *
 * @author 数据小王子
 */
public interface ISysNoticeService extends IBaseService<SysNotice>
{
    /**
     * 查询公告信息
     *
     * @param noticeId 公告ID
     * @return 公告信息
     */
    SysNoticeVo selectNoticeById(Long noticeId);

    /**
     * 查询公告列表
     *
     * @param noticeBo 公告信息
     * @return 公告集合
     */
    List<SysNoticeVo> selectNoticeList(SysNoticeBo noticeBo);

    /**
     * 分页查询公告列表
     *
     * @param noticeBo 公告信息
     * @return 公告集合
     */
    TableDataInfo<SysNoticeVo> selectPage(SysNoticeBo noticeBo);

    /**
     * 新增公告
     *
     * @param noticeBo 公告信息
     * @return true 操作成功，false 操作失败
     */
    boolean insertNotice(SysNoticeBo noticeBo);

    /**
     * 修改公告
     *
     * @param noticeBo 公告信息
     * @return 结果:true 更新成功，false 更新失败
     */
    Boolean updateNotice(SysNoticeBo noticeBo);

    /**
     * 批量删除公告信息
     *
     * @param noticeIds 需要删除的公告ID
     * @return 结果:true 删除成功，false 删除失败
     */
    boolean deleteNoticeByIds(Long[] noticeIds);
}
