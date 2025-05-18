package com.ruoyi.system.domain;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 角色和菜单关联 sys_role_menu
 *
 * @author ruoyi
 */
@Data
@Table(value = "sys_role_menu")
public class SysRoleMenu
{
    /** 角色ID */
    @Id(keyType = KeyType.None)
    private Long roleId;

    /** 菜单ID */
    @Id(keyType = KeyType.None)
    private Long menuId;
}
