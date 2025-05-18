package com.ruoyi.system.domain;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 角色和部门关联 sys_role_dept
 *
 * @author ruoyi
 */
@Data
@Table(value = "sys_role_dept")
public class SysRoleDept
{
    /** 角色ID */
    @Id
    private Long roleId;

    /** 部门ID */
    @Id
    private Long deptId;
}
