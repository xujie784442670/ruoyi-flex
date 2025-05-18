package com.ruoyi.system.domain;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.ruoyi.common.orm.core.domain.BaseEntity;

/**
 * 字典类型表 sys_dict_type
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Table(value = "sys_dict_type")
public class SysDictType extends BaseEntity
{
    /** 字典主键 */
    @Id
    private Long dictId;

    /** 字典名称 */
    private String dictName;

    /** 字典类型 */
    private String dictType;

    /** 备注   */
    private String remark;
}
