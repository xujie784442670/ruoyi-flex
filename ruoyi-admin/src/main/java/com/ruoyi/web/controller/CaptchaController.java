package com.ruoyi.web.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import java.time.Duration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import cn.hutool.captcha.AbstractCaptcha;
import cn.hutool.captcha.generator.CodeGenerator;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import com.ruoyi.common.core.annotation.RateLimiter;
import com.ruoyi.common.core.constant.GlobalConstants;
import com.ruoyi.common.core.core.domain.AjaxResult;
import com.ruoyi.common.core.enums.LimitType;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.reflect.ReflectUtils;
import com.ruoyi.common.core.utils.SpringUtils;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.encrypt.utils.RSAUtils;
import com.ruoyi.common.mail.config.properties.MailProperties;
import com.ruoyi.common.mail.utils.MailUtils;
import com.ruoyi.common.redis.utils.RedisUtils;
import com.ruoyi.common.web.enums.CaptchaType;
import com.ruoyi.web.domain.vo.CaptchaVo;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.dromara.sms4j.api.SmsBlend;
import org.dromara.sms4j.api.entity.SmsResponse;
import org.dromara.sms4j.core.factory.SmsFactory;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.constant.Constants;
import com.ruoyi.common.web.config.properties.CaptchaProperties;

/**
 * 验证码操作处理
 *
 * @author ruoyi
 * @author 数据小王子
 */
@SaIgnore
@Slf4j
@Validated
@RequiredArgsConstructor
@RestController
public class CaptchaController
{
    private final CaptchaProperties captchaProperties;
    private final MailProperties mailProperties;

    /**
     * 生成验证码
     */
    @RateLimiter(time = 60, count = 10, limitType = LimitType.IP)
    @GetMapping("/auth/code")
    public R<CaptchaVo> getCode() {
        CaptchaVo captchaVo = new CaptchaVo();
        boolean captchaEnabled = captchaProperties.getEnable();
        if (!captchaEnabled) {
            captchaVo.setCaptchaEnabled(false);
            return R.ok(captchaVo);
        }
        // 保存验证码信息
        String uuid = IdUtil.simpleUUID();
        String verifyKey = GlobalConstants.CAPTCHA_CODE_KEY + uuid;
        // 生成验证码
        CaptchaType captchaType = captchaProperties.getType();
        boolean isMath = CaptchaType.MATH == captchaType;
        Integer length = isMath ? captchaProperties.getNumberLength() : captchaProperties.getCharLength();
        CodeGenerator codeGenerator = ReflectUtils.newInstance(captchaType.getClazz(), length);
        AbstractCaptcha captcha = SpringUtils.getBean(captchaProperties.getCategory().getClazz());
        captcha.setGenerator(codeGenerator);
        captcha.createCode();
        // 如果是数学验证码，使用SpEL表达式处理验证码结果
        String code = captcha.getCode();
        if (isMath) {
            ExpressionParser parser = new SpelExpressionParser();
            Expression exp = parser.parseExpression(StringUtils.remove(code, "="));
            code = exp.getValue(String.class);
        }
        RedisUtils.setCacheObject(verifyKey, code, Duration.ofMinutes(Constants.CAPTCHA_EXPIRATION));

        captchaVo.setUuid(uuid);
        captchaVo.setImg(captcha.getImageBase64());
        return R.ok(captchaVo);
    }

    /**
     * 邮箱验证码
     *
     * @param email 邮箱
     */
    @RateLimiter(key = "#email", time = 60, count = 1)
    @GetMapping("/resource/email/code")
    public R<Void> emailCode(@NotBlank(message = "{user.email.not.blank}") String email) {
        if (!mailProperties.getEnabled()) {
            return R.fail("当前系统没有开启邮箱功能！");
        }
        String key = GlobalConstants.CAPTCHA_CODE_KEY + email;
        String code = RandomUtil.randomNumbers(4);
        RedisUtils.setCacheObject(key, code, Duration.ofMinutes(Constants.CAPTCHA_EXPIRATION));
        try {
            MailUtils.sendText(email, "登录验证码", "您本次验证码为：" + code + "，有效性为" + Constants.CAPTCHA_EXPIRATION + "分钟，请尽快填写。");
        } catch (Exception e) {
            log.error("验证码短信发送异常 => {}", e.getMessage());
            return R.fail(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 短信验证码
     *
     * @param phonenumber 用户手机号
     */
    @RateLimiter(key = "#phonenumber", time = 60, count = 1)
    @GetMapping("/resource/sms/code")
    public R<Void> smsCode(@NotBlank(message = "{user.phonenumber.not.blank}") String phonenumber) {
        String key = GlobalConstants.CAPTCHA_CODE_KEY + phonenumber;
        String code = RandomUtil.randomNumbers(4);
        RedisUtils.setCacheObject(key, code, Duration.ofMinutes(Constants.CAPTCHA_EXPIRATION));
        // 验证码模板id 自行处理 (查数据库或写死均可)
        String templateId = "";
        LinkedHashMap<String, String> map = new LinkedHashMap<>(1);
        map.put("code", code);
        SmsBlend smsBlend = SmsFactory.getSmsBlend("config1");
        SmsResponse smsResponse = smsBlend.sendMessage(phonenumber, templateId, map);
        if (!smsResponse.isSuccess()) {
            log.error("验证码短信发送异常 => {}", smsResponse);
            return R.fail(smsResponse.getData().toString());
        }
        return R.ok();
    }

    @GetMapping("/genKeyPair")
    public R genKeyPair() {
        Map<String,String> map=new HashMap<>();
        try {
            log.info("开始生产rsa秘钥");

            Map<String, Object> keyPair = RSAUtils.genKeyPair();
            String publicKey = RSAUtils.getPublicKey(keyPair);
            String privateKey = RSAUtils.getPrivateKey(keyPair);
            log.info("privateKey："+privateKey);
            String uuid="ruoyi_"+ UUID.randomUUID().toString().replace("-","");
            RedisUtils.setCacheMapValue("loginRsa",uuid,privateKey);
            RedisUtils.expire("loginRsa",60*60);
            log.info("写入redis完成");

            map.put("uuidPrivateKey",uuid);
            map.put("RSA_PUBLIC_KEY",publicKey);
        } catch (Exception e) {
            return R.fail("生成RSA秘钥失败,"+e.getMessage());
        }
        return R.ok(map);
    }
}
