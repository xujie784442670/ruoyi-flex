package com.ruoyi.system.service;

import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysTenant;
import com.ruoyi.system.domain.vo.SysTenantVo;
import com.ruoyi.system.domain.bo.SysTenantBo;
import com.ruoyi.common.orm.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 租户Service接口
 *
 * @author Michelle.Chung
 * author 数据小王子
 */
public interface ISysTenantService extends IBaseService<SysTenant> {

    /**
     * 基于租户ID查询租户
     */
    SysTenantVo selectById(Long tenantId);

//    /**
//     * 基于租户ID查询租户
//     */
//    SysTenantVo queryByTenantId(String tenantId);

    /**
     * 分页查询租户列表
     *
     * @param sysTenantBo 租户Bo
     * @return 租户列表集合
     */
    TableDataInfo<SysTenantVo> selectPage(SysTenantBo sysTenantBo);

    /**
     * 查询租户列表
     */
    List<SysTenantVo> selectList(SysTenantBo sysTenantBo);

    /**
     * 新增租户
     */
    boolean insert(SysTenantBo sysTenantBo);

    /**
     * 修改租户
     */
    boolean update(SysTenantBo sysTenantBo);

    /**
     * 修改租户状态
     */
    boolean updateTenantStatus(SysTenantBo sysTenantBo);

    /**
     * 校验租户是否允许操作
     */
    void checkTenantAllowed(Long tenantId);

    /**
     * 校验并批量删除租户信息
     */
    boolean deleteByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 校验企业名称是否唯一
     */
    boolean checkCompanyNameUnique(SysTenantBo bo);

    /**
     * 校验账号余额
     */
    boolean checkAccountBalance(Long tenantId);

    /**
     * 校验有效期
     */
    boolean checkExpireTime(Long tenantId);

    /**
     * 同步租户套餐
     */
    boolean syncTenantPackage(Long tenantId, Long packageId);
}
