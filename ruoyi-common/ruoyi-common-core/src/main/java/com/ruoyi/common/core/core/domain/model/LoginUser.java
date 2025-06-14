package com.ruoyi.common.core.core.domain.model;

import com.ruoyi.common.core.core.domain.dto.RoleDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Set;
import java.io.Serial;

/**
 * 登录用户身份权限
 *
 * @author Lion Li
 */
@Data
@NoArgsConstructor
public class LoginUser
{
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 租户ID
     */
    private Long tenantId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 部门名
     */
    private String deptName;

    /**
     * 用户唯一标识
     */
    private String token;

    /**
     * 用户类型
     */
    private String userType;

    /**
     * 登录时间
     */
    private Long loginTime;

    /**
     * 过期时间
     */
    private Long expireTime;

    /**
     * 登录IP地址
     */
    private String ipaddr;

    /**
     * 登录地点
     */
    private String loginLocation;

    /**
     * 浏览器类型
     */
    private String browser;

    /**
     * 操作系统
     */
    private String os;

    /**
     * 菜单权限
     */
    private Set<String> menuPermission;

    /**
     * 角色权限
     */
    private Set<String> rolePermission;

    /**
     * 用户名
     */
    private String username;

    /**
     * 用户昵称
     */
    private String nickname;


    /**
     * 角色对象
     */
    private List<RoleDTO> roles;

    /**
     * 数据权限 当前角色ID
     */
    private Long roleId;

    /**
     * 客户端
     */
    private String clientKey;

    /**
     * 设备类型
     */
    private String deviceType;

    /**
     * 获取登录id
     */
    public String getLoginId() {
        if (userType == null) {
            throw new IllegalArgumentException("用户类型不能为空");
        }
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        return userType + ":" + userId;
    }

    }
