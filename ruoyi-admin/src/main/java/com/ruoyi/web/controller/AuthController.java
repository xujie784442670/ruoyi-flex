package com.ruoyi.web.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.core.domain.model.SocialLoginBody;
import com.ruoyi.common.core.utils.*;
import com.ruoyi.common.encrypt.annotation.ApiEncrypt;
import com.ruoyi.common.json.utils.JsonUtils;
import com.ruoyi.common.security.utils.LoginHelper;
import com.ruoyi.common.social.config.properties.SocialLoginConfigProperties;
import com.ruoyi.common.social.config.properties.SocialProperties;
import com.ruoyi.common.social.utils.SocialUtils;
import com.ruoyi.common.websocket.dto.WebSocketMessageDto;
import com.ruoyi.common.websocket.utils.WebSocketUtils;
import com.ruoyi.system.domain.bo.SysTenantBo;
import com.ruoyi.system.domain.vo.SysClientVo;
import com.ruoyi.system.domain.vo.SysTenantVo;
import com.ruoyi.system.service.*;
import com.ruoyi.web.domain.vo.LoginTenantVo;
import com.ruoyi.web.domain.vo.LoginVo;
import com.ruoyi.web.domain.vo.TenantListVo;
import com.ruoyi.web.service.SysRegisterService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.core.core.domain.model.LoginBody;
import com.ruoyi.common.core.core.domain.model.RegisterBody;
import com.ruoyi.web.service.IAuthStrategy;
import com.ruoyi.web.service.SysLoginService;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthUser;
import me.zhyd.oauth.request.AuthRequest;
import me.zhyd.oauth.utils.AuthStateUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.net.URL;
import java.util.List;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import static com.ruoyi.system.domain.table.SysClientTableDef.SYS_CLIENT;


/**
 * 认证
 *
 * @author Lion Li
 */
@Slf4j
@SaIgnore
@RequiredArgsConstructor
@RestController
@RequestMapping("/auth")
public class AuthController {

    @Resource
    private  SysLoginService loginService;
    @Resource
    private  ISysClientService clientService;
    @Resource
    private SysRegisterService registerService;
    @Resource
    private ISysConfigService configService;
    @Resource
    private ISysTenantService tenantService;
    @Resource
    private ISysSocialService socialService;

    private final ScheduledExecutorService scheduledExecutorService;
    private final SocialProperties socialProperties;

    /**
     * 登录方法
     *
     * @param body 登录信息
     * @return 结果
     */
    @ApiEncrypt
    @PostMapping("/login")
    public R<LoginVo> login(@RequestBody String body) {
        LoginBody loginBody = JsonUtils.parseObject(body, LoginBody.class);
        ValidatorUtils.validate(loginBody);
        // 授权类型和客户端id
        String clientId = loginBody.getClientId();
        String grantType = loginBody.getGrantType();
        QueryWrapper query=QueryWrapper.create().from(SYS_CLIENT).where(SYS_CLIENT.CLIENT_ID.eq(clientId));
        SysClientVo client = clientService.getOneAs(query,SysClientVo.class);
        // 查询不到 client 或 client 内不包含 grantType
        if (ObjectUtil.isNull(client) || !StringUtils.contains(client.getGrantType(), grantType)) {
            log.info("客户端id: {} 认证类型：{} 异常!.", clientId, grantType);
            return R.fail(MessageUtils.message("auth.grant.type.error"));
        } else if (!UserConstants.NORMAL.equals(client.getStatus())) {
            return R.fail(MessageUtils.message("auth.grant.type.blocked"));
        }
        // 校验租户
        loginService.checkTenant(loginBody.getTenantId());

        // 登录
        LoginVo loginVo =IAuthStrategy.login(body, client, grantType);

        Long userId = LoginHelper.getUserId();
        scheduledExecutorService.schedule(() -> {
            WebSocketMessageDto dto = new WebSocketMessageDto();
            dto.setMessage("欢迎登录RuoYi-Flex多租户管理系统");
            dto.setSessionKeys(List.of(userId));
            WebSocketUtils.publishMessage(dto);
        }, 3, TimeUnit.SECONDS);

        return R.ok(loginVo);
    }

    /**
     * 第三方登录请求
     *
     * @param source 登录来源
     * @return 结果
     */
    @GetMapping("/binding/{source}")
    public R<String> authBinding(@PathVariable("source") String source) {
        SocialLoginConfigProperties obj = socialProperties.getType().get(source);
        if (ObjectUtil.isNull(obj)) {
            return R.fail(source + "平台账号暂不支持");
        }
        AuthRequest authRequest = SocialUtils.getAuthRequest(source, socialProperties);
        String authorizeUrl = authRequest.authorize(AuthStateUtils.createState());
        return R.ok("操作成功", authorizeUrl);
    }

    /**
     * 第三方登录回调业务处理 绑定授权
     *
     * @param loginBody 请求体
     * @return 结果
     */
    @PostMapping("/social/callback")
    public R<Void> socialCallback(@RequestBody SocialLoginBody loginBody) {
        // 获取第三方登录信息
        AuthResponse<AuthUser> response = SocialUtils.loginAuth(
            loginBody.getSource(), loginBody.getSocialCode(),
            loginBody.getSocialState(), socialProperties);
        AuthUser authUserData = response.getData();
        // 判断授权响应是否成功
        if (!response.ok()) {
            return R.fail(response.getMsg());
        }
        loginService.socialRegister(authUserData);
        return R.ok();
    }


    /**
     * 取消授权
     *
     * @param socialId socialId
     */
    @DeleteMapping(value = "/unlock/{socialId}")
    public R<Void> unlockSocial(@PathVariable Long socialId) {
        Boolean rows = socialService.deleteWithValidById(socialId);
        return rows ? R.ok() : R.fail("取消授权失败");
    }

    /**
     * 退出登录
     */
    @PostMapping("/logout")
    public R<Void> logout() {
        loginService.logout();
        return R.ok("退出成功！");
    }

    /**
     * 用户注册
     */
    @PostMapping("/register")
    public R<Void> register(@Validated @RequestBody RegisterBody user) {
        if (!configService.selectRegisterEnabled(user.getTenantId()))
        {
            return R.fail("当前系统没有开启注册功能！");
        }
        registerService.register(user);
        return R.ok();
    }

    /**
     * 登录页面租户下拉框
     *
     * @return 租户列表
     */
    @GetMapping("/tenant/list")
    public R<LoginTenantVo> tenantList(HttpServletRequest request) throws Exception {
        List<SysTenantVo> tenantList = tenantService.selectList(new SysTenantBo());
        List<TenantListVo> voList = MapstructUtils.convert(tenantList, TenantListVo.class);
        // 获取域名
        String host;
        String referer = request.getHeader("referer");
        if (StringUtils.isNotBlank(referer)) {
            // 这里从referer中取值是为了本地使用hosts添加虚拟域名，方便本地环境调试
            host = referer.split("//")[1].split("/")[0];
        } else {
            host = new URL(request.getRequestURL().toString()).getHost();
        }
        // 根据域名进行筛选
        List<TenantListVo> list = StreamUtils.filter(voList, vo ->
            StringUtils.equals(vo.getDomain(), host));
        // 返回对象
        LoginTenantVo vo = new LoginTenantVo();
        vo.setTenantEnabled(true);
        vo.setVoList(CollUtil.isNotEmpty(list) ? list : voList);
        return R.ok(vo);
    }


}
