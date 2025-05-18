package com.ruoyi.common.tenant.manager;

import com.ruoyi.common.core.constant.GlobalConstants;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.redis.manager.FlexSpringCacheManager;
import com.ruoyi.common.tenant.helper.TenantHelper;
import org.springframework.cache.Cache;

/**
 * 重写 cacheName 处理方法 支持多租户
 *
 * @author Lion Li
 */
public class TenantSpringCacheManager extends FlexSpringCacheManager {

    public TenantSpringCacheManager() {
    }

    @Override
    public Cache getCache(String name) {
        if (StringUtils.contains(name, GlobalConstants.GLOBAL_REDIS_KEY)) {
            return super.getCache(name);
        }
        Long tenantId = TenantHelper.getTenantId();
        if (StringUtils.startsWith(name, tenantId + "")) {
            // 如果存在则直接返回
            return super.getCache(name);
        }
        return super.getCache(tenantId + ":" + name);
    }

}
