package com.ruoyi.web.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.config.RuoYiConfig;
import com.ruoyi.common.core.utils.StringUtils;

/**
 * 首页
 *
 * @author ruoyi
 */
@SaIgnore
@RestController
public class SysIndexController
{
    /** 系统基础配置 */
    @Resource
    private RuoYiConfig ruoyiConfig;

    /**
     * 访问首页，提示语
     */
    @RequestMapping("/")
    public String index()
    {
        return StringUtils.format("欢迎使用{}后台管理框架，当前版本：v{}，请通过前端地址访问。", ruoyiConfig.getName(), ruoyiConfig.getVersion());
    }
}
