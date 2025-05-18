package com.ruoyi.system.domain;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.Table;
import com.ruoyi.common.orm.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * OSS对象存储服务对象
 *
 * @author Lion Li
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Table("sys_oss")
public class SysOss extends BaseEntity {

    /**
     * 对象存储主键
     */
    @Id
    private Long ossId;

    /**
     * 文件名
     */
    private String fileName;

    /**
     * 原名
     */
    private String originalName;

    /**
     * 文件后缀名
     */
    private String fileSuffix;

    /**
     * URL地址
     */
    private String url;

    /**
     * 服务商
     */
    private String service;

}
