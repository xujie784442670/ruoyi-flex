package com.ruoyi.system.domain.vo;

import com.alibaba.excel.annotation.ExcelProperty;
import com.mybatisflex.annotation.RelationOneToOne;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;



/**
 * 通知公告视图对象 sys_notice
 *
 * @author Michelle.Chung
 */
@Data
public class SysNoticeVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 公告ID
     */
    private Long noticeId;

    /**
     * 公告标题
     */
    private String noticeTitle;

    /**
     * 公告类型（1通知 2公告）
     */
    private String noticeType;

    /**
     * 公告内容
     */
    private String noticeContent;

    /**
     * 公告状态（0正常 1关闭）
     */
    private String status;

    /**
     * 备注
     */
    private String remark;

    /** 乐观锁 */
    @ExcelProperty(value = "乐观锁版本号")
    private Integer version;

    /**
     * 创建者
     */
    private Long createBy;


    /**
     * 创建人名称
     */
    @RelationOneToOne(
        selfField = "createBy",
        targetTable = "sys_user",
        targetField = "userId",
        valueField = "userName"
    )
    private String createByName;

    /**
     * 创建时间
     */
    private Date createTime;

}
