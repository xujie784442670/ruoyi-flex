package com.ruoyi.web.service;


import com.ruoyi.common.core.core.domain.AjaxResult;
import com.ruoyi.common.core.core.domain.model.LoginBody;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.SpringUtils;
import com.ruoyi.system.domain.SysClient;
import com.ruoyi.system.domain.vo.SysClientVo;
import com.ruoyi.web.domain.vo.LoginVo;

/**
 * 授权策略
 *
 * @author Michelle.Chung
 */
public interface IAuthStrategy {

    String BASE_NAME = "AuthStrategy";

    /**
     * 登录
     *
     * @param body      登录对象
     * @param client    授权管理视图对象
     * @param grantType 授权类型
     * @return 登录验证信息
     */
    static LoginVo login(String body, SysClientVo client, String grantType) {
        // 授权类型和客户端id
        String beanName = grantType + BASE_NAME;
        if (!SpringUtils.containsBean(beanName)) {
            throw new ServiceException("授权类型不正确!");
        }
        IAuthStrategy instance = SpringUtils.getBean(beanName);
        return instance.login(body,client);
    }

    /**
     * 登录
     *
     * @param body   登录对象
     * @param client 授权管理视图对象
     * @return 登录验证信息
     */
    LoginVo login(String body, SysClientVo client);

}
