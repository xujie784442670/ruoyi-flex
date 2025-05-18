package com.ruoyi.web.service;

import cn.dev33.satoken.secure.BCrypt;
import com.ruoyi.common.core.constant.GlobalConstants;
import com.ruoyi.common.core.enums.UserType;
import com.ruoyi.common.core.exception.user.UserException;
import com.ruoyi.common.core.utils.ServletUtils;
import com.ruoyi.common.core.utils.SpringUtils;
import com.ruoyi.common.log.event.LogininforEvent;
import com.ruoyi.common.redis.utils.RedisUtils;
import com.ruoyi.common.tenant.helper.TenantHelper;
import com.ruoyi.common.web.config.properties.CaptchaProperties;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.domain.bo.SysUserBo;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import com.ruoyi.common.core.constant.Constants;
import com.ruoyi.common.core.core.domain.model.RegisterBody;
import com.ruoyi.common.core.exception.user.CaptchaException;
import com.ruoyi.common.core.exception.user.CaptchaExpireException;
import com.ruoyi.common.core.utils.MessageUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.stereotype.Service;

/**
 * 注册校验方法
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class SysRegisterService {
    @Resource
    private ISysUserService userService;

    @Resource
    private ISysConfigService configService;

    private final CaptchaProperties captchaProperties;

    /**
     * 注册
     */
    public void register(RegisterBody registerBody) {
        Long tenantId = registerBody.getTenantId();
        TenantHelper.dynamic(tenantId, () -> {
            String username = registerBody.getUsername();
            String password = registerBody.getPassword();
            // 校验用户类型是否存在
            String userType = UserType.getUserType(registerBody.getUserType()).getUserType();

            boolean captchaEnabled = captchaProperties.getEnable();
            // 验证码开关
            if (captchaEnabled) {
                validateCaptcha(tenantId, username, registerBody.getCode(), registerBody.getUuid());
            }
            SysUserBo sysUser = new SysUserBo();
            sysUser.setUserName(username);
            sysUser.setNickName(username);
            sysUser.setPassword(BCrypt.hashpw(password));
            sysUser.setUserType(userType);

            boolean unique = userService.checkUserNameUnique(sysUser);

            if (!unique) {
                throw new UserException("user.register.save.error", username);
            }
            boolean regFlag = userService.registerUser(sysUser, tenantId);
            if (!regFlag) {
                throw new UserException("user.register.error");
            }
            recordLogininfor(tenantId, username, Constants.REGISTER, MessageUtils.message("user.register.success"));
        });
    }

    /**
     * 校验验证码
     *
     * @param tenantId 租户ID
     * @param username 用户名
     * @param code     验证码
     * @param uuid     唯一标识
     */
    public void validateCaptcha(Long tenantId, String username, String code, String uuid) {
        String verifyKey = GlobalConstants.CAPTCHA_CODE_KEY + StringUtils.blankToDefault(uuid, "");
        String captcha = RedisUtils.getCacheObject(verifyKey);
        RedisUtils.deleteObject(verifyKey);
        if (captcha == null) {
            recordLogininfor(tenantId, username, Constants.REGISTER, MessageUtils.message("user.jcaptcha.expire"));
            throw new CaptchaExpireException();
        }
        if (!code.equalsIgnoreCase(captcha)) {
            recordLogininfor(tenantId, username, Constants.REGISTER, MessageUtils.message("user.jcaptcha.error"));
            throw new CaptchaException();
        }
    }

    /**
     * 记录登录信息
     *
     * @param tenantId 租户ID
     * @param username 用户名
     * @param status   状态
     * @param message  消息内容
     * @return
     */
    private void recordLogininfor(Long tenantId, String username, String status, String message) {
        LogininforEvent logininforEvent = new LogininforEvent();
        logininforEvent.setTenantId(tenantId);
        logininforEvent.setUsername(username);
        logininforEvent.setStatus(status);
        logininforEvent.setMessage(message);
        logininforEvent.setRequest(ServletUtils.getRequest());
        SpringUtils.context().publishEvent(logininforEvent);
    }
}
