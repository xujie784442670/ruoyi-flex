package com.ruoyi.system.service.impl;

import java.util.List;

import cn.hutool.core.util.ObjectUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.core.constant.CacheNames;
import com.ruoyi.common.core.service.ConfigService;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.common.core.utils.SpringUtils;
import com.ruoyi.common.orm.core.page.PageQuery;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.common.redis.utils.CacheUtils;
import com.ruoyi.common.tenant.helper.TenantHelper;
import com.ruoyi.system.domain.bo.SysConfigBo;
import com.ruoyi.system.domain.vo.SysConfigVo;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.core.text.Convert;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.system.domain.SysConfig;
import com.ruoyi.system.mapper.SysConfigMapper;
import com.ruoyi.system.service.ISysConfigService;
import org.springframework.transaction.annotation.Transactional;

import static com.ruoyi.system.domain.table.SysConfigTableDef.SYS_CONFIG;

/**
 * 参数配置 服务层实现
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class SysConfigServiceImpl extends BaseServiceImpl<SysConfigMapper, SysConfig> implements ISysConfigService, ConfigService {

    @Resource
    private SysConfigMapper configMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_CONFIG);
    }

    /**
     * 查询参数配置信息
     *
     * @param configId 参数配置ID
     * @return 参数配置信息
     */
    @Override
    public SysConfigVo selectConfigById(Long configId) {
        return this.getOneAs(query().where(SYS_CONFIG.CONFIG_ID.eq(configId)), SysConfigVo.class);
    }

    /**
     * 根据键名查询参数配置信息
     *
     * @param configKey 参数key
     * @return 参数键值
     */
    @Cacheable(cacheNames = CacheNames.SYS_CONFIG, key = "#configKey")
    @Override
    public SysConfigVo selectConfigByKey(String configKey) {
        return this.getOneAs(query().where(SYS_CONFIG.CONFIG_KEY.eq(configKey)), SysConfigVo.class);
    }

    /**
     * 获取验证码开关
     *
     * @return true开启，false关闭
     */
    @Override
    public boolean selectCaptchaEnabled() {
        String captchaEnabled = selectConfigByKey("sys.account.captchaEnabled").getConfigValue();
        if (StringUtils.isEmpty(captchaEnabled)) {
            return true;
        }
        return Convert.toBool(captchaEnabled);
    }

    /**
     * 获取注册开关（不走Mybatis-Flex租户插件）
     *
     * @param tenantId 租户id
     * @return true开启，false关闭
     */
    @Override
    public boolean selectRegisterEnabled(Long tenantId) {
        return TenantHelper.ignore(() -> {
            QueryWrapper queryWrapper = query()
                .where(SYS_CONFIG.TENANT_ID.eq(tenantId))
                .and(SYS_CONFIG.CONFIG_KEY.eq("sys.account.registerUser"));
            SysConfig config = this.getOne(queryWrapper);
            if (ObjectUtil.isNull(config)) {
                return false;
            }
            return Convert.toBool(config.getConfigValue());
        });
    }

    /**
     * 构造查询条件
     *
     * @param config
     * @return 查询条件
     */

    private QueryWrapper buildQueryWrapper(SysConfigBo config) {
        QueryWrapper queryWrapper = super.buildBaseQueryWrapper()
            .and(SYS_CONFIG.CONFIG_NAME.like(config.getConfigName()))
            .and(SYS_CONFIG.CONFIG_TYPE.eq(config.getConfigType()))
            .and(SYS_CONFIG.CONFIG_KEY.like(config.getConfigKey()))
            .and(SYS_CONFIG.CREATE_TIME.between(config.getParams().get("beginTime"), config.getParams().get("endTime")));
        return queryWrapper;
    }

    /**
     * 查询参数配置列表
     *
     * @param config 参数配置信息
     * @return 参数配置集合
     */
    @Override
    public List<SysConfigVo> selectConfigList(SysConfigBo config) {
        QueryWrapper queryWrapper = buildQueryWrapper(config);

        return this.listAs(queryWrapper, SysConfigVo.class);
    }

    /**
     * 分页查询参数配置
     *
     * @param config 参数配置信息
     * @return 分页数据
     */
    @Override
    public TableDataInfo<SysConfigVo> selectConfigPage(SysConfigBo config) {
        QueryWrapper queryWrapper = buildQueryWrapper(config);
        Page<SysConfigVo> page = this.pageAs(PageQuery.build(), queryWrapper, SysConfigVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 新增参数配置
     *
     * @param configBo 参数配置信息
     * @return true 操作成功，false 操作失败
     */
    @CacheEvict(cacheNames = CacheNames.SYS_CONFIG, key = "#configBo.configKey")
    @Override
    public boolean insertConfig(SysConfigBo configBo) {
        SysConfig sysConfig = MapstructUtils.convert(configBo, SysConfig.class);
        return this.save(sysConfig);
    }

    /**
     * 修改参数配置
     *
     * @param configBo 参数配置信息
     * @return true 更新成功，false 更新失败。
     */
    @CacheEvict(cacheNames = CacheNames.SYS_CONFIG, key = "#configBo.configKey")
    @Override
    public boolean updateConfig(SysConfigBo configBo) {
        SysConfig config = MapstructUtils.convert(configBo, SysConfig.class);
        return this.updateById(config);
    }

    /**
     * 根据Key修改参数配置
     * UPDATE "sys_config" SET "config_key" = 'sys.oss.previewListResource' , "config_value" = 'false' , "update_by" = 1 , "update_time" = '2024-01-19 11:20:01' , "version" = "version" + 1  WHERE "tenant_id" = 0 AND "config_key" = 'sys.oss.previewListResource' AND "version" = 0
     * @param configBo 参数配置信息
     * @return true 更新成功，false 更新失败。
     */
    @CacheEvict(cacheNames = CacheNames.SYS_CONFIG, key = "#configBo.configKey")
    @Override
    public boolean updateConfigByKey(SysConfigBo configBo) {
        SysConfig config = MapstructUtils.convert(configBo, SysConfig.class);
        QueryWrapper queryWrapper = query().where(SYS_CONFIG.CONFIG_KEY.eq(config.getConfigKey()))
            .and(SYS_CONFIG.VERSION.eq(config.getVersion()));
        int updatedRows = configMapper.updateByQuery(config, queryWrapper);
        return updatedRows > 0;
    }

    /**
     * 批量删除参数信息
     *
     * @param configIds 需要删除的参数ID
     */
    @Override
    @Transactional
    public void deleteConfigByIds(Long[] configIds) {
        for (Long configId : configIds) {
            SysConfigVo config = selectConfigById(configId);
            if (StringUtils.equals(UserConstants.YES, config.getConfigType())) {
                throw new ServiceException(String.format("内置参数【%1$s】不能删除 ", config.getConfigKey()));
            }
            this.removeById(configId);
            CacheUtils.evict(CacheNames.SYS_CONFIG, config.getConfigKey());
        }
    }

    /**
     * 重置参数缓存数据
     */
    @Override
    public void resetConfigCache() {
        CacheUtils.clear(CacheNames.SYS_CONFIG);
    }

    /**
     * 校验参数键名是否唯一
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public boolean checkConfigKeyUnique(SysConfigBo config) {
        Long configId = StringUtils.isNull(config.getConfigId()) ? -1L : config.getConfigId();
        SysConfig info = this.getOne(query().where(SYS_CONFIG.CONFIG_KEY.eq(config.getConfigKey())));
        if (StringUtils.isNotNull(info) && info.getConfigId().longValue() != configId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }


    /**
     * 根据参数 key 获取参数值
     *
     * @param configKey 参数 key
     * @return 参数值
     */
    @Override
    public String getConfigValue(String configKey) {
        return SpringUtils.getAopProxy(this).selectConfigByKey(configKey).getConfigValue();
    }
}
