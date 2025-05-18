package com.ruoyi.web.service.impl;

import cn.dev33.satoken.stp.SaLoginModel;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
import com.ruoyi.common.core.core.domain.model.LoginUser;
import com.ruoyi.common.core.core.domain.model.SmsLoginBody;
import com.ruoyi.system.service.ISysUserService;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.ruoyi.common.core.constant.Constants;
import com.ruoyi.common.core.constant.GlobalConstants;
import com.ruoyi.common.core.enums.LoginType;
import com.ruoyi.common.core.enums.UserStatus;
import com.ruoyi.common.core.exception.user.CaptchaExpireException;
import com.ruoyi.common.core.exception.user.UserException;
import com.ruoyi.common.core.utils.MessageUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.ValidatorUtils;
import com.ruoyi.common.json.utils.JsonUtils;
import com.ruoyi.common.redis.utils.RedisUtils;
import com.ruoyi.common.security.utils.LoginHelper;
import com.ruoyi.system.domain.vo.SysClientVo;
import com.ruoyi.system.domain.vo.SysUserVo;
import com.ruoyi.web.domain.vo.LoginVo;
import com.ruoyi.web.service.IAuthStrategy;
import com.ruoyi.web.service.SysLoginService;
import org.springframework.stereotype.Service;

/**
 * 短信认证策略
 *
 * @author Michelle.Chung
 */
@Slf4j
@Service("sms" + IAuthStrategy.BASE_NAME)
@RequiredArgsConstructor
public class SmsAuthStrategy implements IAuthStrategy {

    @Resource
    private SysLoginService loginService;
    @Resource
    private ISysUserService userService;

    @Override
    public LoginVo login(String body, SysClientVo client) {
        SmsLoginBody loginBody = JsonUtils.parseObject(body, SmsLoginBody.class);
        ValidatorUtils.validate(loginBody);
        Long tenantId = loginBody.getTenantId();
        String phonenumber = loginBody.getPhonenumber();
        String smsCode = loginBody.getSmsCode();

        // 通过手机号查找用户
        SysUserVo user = loadUserByPhonenumber(tenantId, phonenumber);

        loginService.checkLogin(LoginType.SMS, tenantId, user.getUserName(), () -> !validateSmsCode(tenantId, phonenumber, smsCode));
        // 此处可根据登录用户的数据不同 自行创建 loginUser 属性不够用继承扩展就行了
        LoginUser loginUser = loginService.buildLoginUser(user);
        loginUser.setClientKey(client.getClientKey());
        loginUser.setDeviceType(client.getDeviceType());
        SaLoginModel model = new SaLoginModel();
        model.setDevice(client.getDeviceType());
        // 自定义分配 不同用户体系 不同 token 授权时间 不设置默认走全局 yml 配置
        // 例如: 后台用户30分钟过期 app用户1天过期
        model.setTimeout(client.getTimeout());
        model.setActiveTimeout(client.getActiveTimeout());
        model.setExtra(LoginHelper.CLIENT_KEY, client.getClientId());
        // 生成token
        LoginHelper.login(loginUser, model);

        LoginVo loginVo = new LoginVo();
        loginVo.setAccessToken(StpUtil.getTokenValue());
        loginVo.setExpireIn(StpUtil.getTokenTimeout());
        loginVo.setClientId(client.getClientId());
        return loginVo;
    }

    /**
     * 校验短信验证码
     */
    private boolean validateSmsCode(Long tenantId, String phonenumber, String smsCode) {
        String code = RedisUtils.getCacheObject(GlobalConstants.CAPTCHA_CODE_KEY + phonenumber);
        if (StringUtils.isBlank(code)) {
            loginService.recordLogininfor(tenantId, phonenumber, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire"));
            throw new CaptchaExpireException();
        }
        return code.equals(smsCode);
    }

    private SysUserVo loadUserByPhonenumber(Long tenantId, String phonenumber) {
        SysUserVo user = userService.selectTenantUserByPhonenumber(tenantId, phonenumber);
        if (ObjectUtil.isNull(user)) {
            log.info("登录用户：{} 不存在.", phonenumber);
            throw new UserException("user.not.exists", phonenumber);
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", phonenumber);
            throw new UserException("user.blocked", phonenumber);
        }
        return user;
    }

}
