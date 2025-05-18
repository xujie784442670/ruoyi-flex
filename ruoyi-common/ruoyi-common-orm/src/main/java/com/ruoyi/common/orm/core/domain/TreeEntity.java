package com.ruoyi.common.orm.core.domain;

import com.alibaba.excel.annotation.ExcelProperty;
import com.mybatisflex.annotation.Column;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serial;
import java.util.ArrayList;
import java.util.List;

/**
 * Tree基类
 *
 * @author ruoyi
 * @author 数据小王子
 */
@Data
public class TreeEntity extends BaseEntity
{
    @Serial
    private static final long serialVersionUID = 1L;

    /** 父级名称 */
    @Column(ignore = true)
    private String parentName;

    /** 父亲ID */
    @ExcelProperty(value = "上级编号")
    @NotNull(message = "上级编号不能为空")
    private Long parentId;

    /** 显示顺序 */
    @ExcelProperty(value = "显示顺序")
    private Integer orderNum;

    /** 祖级列表 */
    //@Column(ignore = true)
    private String ancestors;

    /** 子部门 */
    @Column(ignore = true)
    private List<Object> children = new ArrayList<>();
}
