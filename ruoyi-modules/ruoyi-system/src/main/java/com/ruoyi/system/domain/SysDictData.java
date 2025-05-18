package com.ruoyi.system.domain;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.orm.core.domain.BaseEntity;

/**
 * 字典数据表 sys_dict_data
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Table(value = "sys_dict_data")
public class SysDictData extends BaseEntity
{
    /** 字典编码 */
    @Id
    private Long dictCode;

    /** 字典排序 */
    private Long dictSort;

    /** 字典标签 */
    private String dictLabel;

    /** 字典键值 */
    private String dictValue;

    /** 字典类型 */
    private String dictType;

    /** 样式属性（其他样式扩展） */
    private String cssClass;

    /** 表格字典样式 */
    private String listClass;

    /** 是否默认（Y是 N否） */
    private String isDefault;

    /** 备注   */
    private String remark;

    public boolean getDefault() {
        return UserConstants.YES.equals(this.isDefault);
    }
}
