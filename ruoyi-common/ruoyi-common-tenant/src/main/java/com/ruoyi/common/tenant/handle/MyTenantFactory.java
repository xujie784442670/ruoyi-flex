package com.ruoyi.common.tenant.handle;

import cn.hutool.core.util.ObjectUtil;
import com.mybatisflex.core.tenant.TenantFactory;
import com.ruoyi.common.security.utils.LoginHelper;
import com.ruoyi.common.tenant.helper.TenantHelper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 自定义租户工厂
 *
 * @author 数据小王子
 */
@Slf4j
@AllArgsConstructor
public class MyTenantFactory implements TenantFactory {

    @Override
    public Object[] getTenantIds() {
        Long tenantId = LoginHelper.getTenantId();
        if (ObjectUtil.isNull(tenantId)) {
            return null;
        }
        Long dynamicTenantId = TenantHelper.getDynamic();
        if (ObjectUtil.isNotNull(dynamicTenantId)) {
            // 返回动态租户
            return new Object[]{dynamicTenantId};
        }
        // 返回固定租户
        return new Object[]{tenantId};
    }

}
