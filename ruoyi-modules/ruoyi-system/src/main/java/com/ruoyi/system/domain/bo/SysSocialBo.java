package com.ruoyi.system.domain.bo;

import com.ruoyi.common.orm.core.domain.BaseEntity;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import com.ruoyi.system.domain.SysSocial;

/**
 * 社会化关系业务对象 sys_social
 *
 * @author Lion Li
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = SysSocial.class, reverseConvertGenerate = false)
public class SysSocialBo extends BaseEntity {

    /**
     * 主键
     */
    @NotNull(message = "主键不能为空")
    private Long socialId;

    /**
     * 的唯一ID
     */
    @NotBlank(message = "的唯一ID不能为空")
    private String authId;

    /**
     * 用户来源
     */
    @NotBlank(message = "用户来源不能为空")
    private String source;

    /**
     * 用户的授权令牌
     */
    @NotBlank(message = "用户的授权令牌不能为空")
    private String accessToken;

    /**
     * 用户的授权令牌的有效期，部分平台可能没有
     */
    private int expireIn;

    /**
     * 刷新令牌，部分平台可能没有
     */
    private String refreshToken;

    /**
     * 平台唯一id
     */
    private String openId;

    /**
     * 用户的 ID
     */
    @NotBlank(message = "用户的 ID不能为空")
    private Long userId;

    /**
     * 平台的授权信息，部分平台可能没有
     */
    private String accessCode;

    /**
     * 用户的 unionid
     */
    private String unionId;

    /**
     * 授予的权限，部分平台可能没有
     */
    private String scope;

    /**
     * 授权的第三方账号
     */
    private String userName;

    /**
     * 授权的第三方昵称
     */
    private String nickName;

    /**
     * 授权的第三方邮箱
     */
    private String email;

    /**
     * 授权的第三方头像地址
     */
    private String avatar;

    /**
     * 个别平台的授权信息，部分平台可能没有
     */
    private String tokenType;

    /**
     * id token，部分平台可能没有
     */
    private String idToken;

    /**
     * 小米平台用户的附带属性，部分平台可能没有
     */
    private String macAlgorithm;

    /**
     * 小米平台用户的附带属性，部分平台可能没有
     */
    private String macKey;

    /**
     * 用户的授权code，部分平台可能没有
     */
    private String code;

    /**
     * Twitter平台用户的附带属性，部分平台可能没有
     */
    private String oauthToken;

    /**
     * Twitter平台用户的附带属性，部分平台可能没有
     */
    private String oauthTokenSecret;

    /**
     * 删除标志（0就代表存在 1就代表删除）
     */
    private Integer delFlag;
}
