package com.ruoyi.system.domain;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.ruoyi.common.orm.core.domain.BaseEntity;

/**
 * 通知公告表 sys_notice
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Table(value = "sys_notice")
public class SysNotice extends BaseEntity
{
    /** 公告ID */
    @Id
    private Long noticeId;

    /** 公告标题 */
    private String noticeTitle;

    /** 公告类型（1通知 2公告） */
    private String noticeType;

    /** 公告内容 */
    private String noticeContent;

    /** 公告状态（0正常 1关闭） */
    private String status;

    /** 备注   */
    private String remark;
}
