package com.ruoyi.system.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.util.UpdateEntity;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.common.security.utils.LoginHelper;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import com.ruoyi.common.core.constant.TenantConstants;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.orm.core.page.PageQuery;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.system.domain.SysTenantPackage;
import com.ruoyi.system.domain.bo.SysTenantPackageBo;
import com.ruoyi.system.domain.vo.SysTenantPackageVo;
import com.ruoyi.system.mapper.SysTenantMapper;
import com.ruoyi.system.mapper.SysTenantPackageMapper;
import com.ruoyi.system.service.ISysTenantPackageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static com.ruoyi.system.domain.table.SysTenantPackageTableDef.SYS_TENANT_PACKAGE;
import static com.ruoyi.system.domain.table.SysTenantTableDef.SYS_TENANT;

/**
 * 租户套餐Service业务层处理
 *
 * @author 数据小王子
 */
@RequiredArgsConstructor
@Service
public class SysTenantPackageServiceImpl extends BaseServiceImpl<SysTenantPackageMapper, SysTenantPackage> implements ISysTenantPackageService {

    @Resource
    private  SysTenantPackageMapper tenantPackageMapper;
    @Resource
    private  SysTenantMapper tenantMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_TENANT_PACKAGE);
    }

    private QueryWrapper buildQueryWrapper(SysTenantPackageBo bo) {
        return  super.buildBaseQueryWrapper()
            .and(SYS_TENANT_PACKAGE.PACKAGE_NAME.like(bo.getPackageName()))
            .and(SYS_TENANT_PACKAGE.STATUS.eq(bo.getStatus()))
            .orderBy(SYS_TENANT_PACKAGE.PACKAGE_ID.desc());
    }

    /**
     * 查询租户套餐
     */
    @Override
    public SysTenantPackageVo selectById(Long packageId){
        return this.getOneAs(query().where(SYS_TENANT_PACKAGE.PACKAGE_ID.eq(packageId)), SysTenantPackageVo.class);
    }

    /**
     * 分页查询租户套餐
     *
     * @param sysTenantPackageBo 租户套餐Bo
     * @return 租户套餐集合
     */
    @Override
    public TableDataInfo<SysTenantPackageVo> selectPage(SysTenantPackageBo sysTenantPackageBo)
    {
        QueryWrapper queryWrapper = buildQueryWrapper(sysTenantPackageBo);
        Page<SysTenantPackageVo> page = this.pageAs(PageQuery.build(), queryWrapper, SysTenantPackageVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 查询租户套餐下拉选列表
     */
    @Override
    public List<SysTenantPackageVo> selectList() {
        SysTenantPackageBo tenantPackageBo = new SysTenantPackageBo();
        tenantPackageBo.setStatus(TenantConstants.NORMAL);
        QueryWrapper queryWrapper = buildQueryWrapper(tenantPackageBo);
        return this.listAs(queryWrapper, SysTenantPackageVo.class);
    }

    /**
     * 查询租户套餐列表
     */
    @Override
    public List<SysTenantPackageVo> queryList(SysTenantPackageBo sysTenantPackageBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(sysTenantPackageBo);
        return this.listAs(queryWrapper, SysTenantPackageVo.class);
    }

    /**
     * 新增租户套餐
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insert(SysTenantPackageBo sysTenantPackageBo) {
        SysTenantPackage sysTenantPackage = MapstructUtils.convert(sysTenantPackageBo, SysTenantPackage.class);
        if(ObjectUtil.isNull(sysTenantPackage)){
            return true;
        }
        // 保存菜单id
        List<Long> menuIds = Arrays.asList(sysTenantPackageBo.getMenuIds());
        if (CollUtil.isNotEmpty(menuIds)) {
            sysTenantPackage.setMenuIds(StringUtils.join(menuIds, ", "));
        } else {
            sysTenantPackage.setMenuIds("");
        }

        Long loginUserId = LoginHelper.getUserId();
        Date createTime = new Date();
        sysTenantPackage.setCreateBy(loginUserId);
        sysTenantPackage.setCreateTime(createTime);
        sysTenantPackage.setUpdateBy(loginUserId);
        sysTenantPackage.setUpdateTime(createTime);

        return this.save(sysTenantPackage);
    }

    /**
     * 修改租户套餐
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(SysTenantPackageBo sysTenantPackageBo) {
        SysTenantPackage sysTenantPackage = MapstructUtils.convert(sysTenantPackageBo, SysTenantPackage.class);
        if(ObjectUtil.isNull(sysTenantPackage)){
            return true;
        }
        // 保存菜单id
        List<Long> menuIds = Arrays.asList(sysTenantPackageBo.getMenuIds());
        if (CollUtil.isNotEmpty(menuIds)) {
            sysTenantPackage.setMenuIds(StringUtils.join(menuIds, ", "));
        } else {
            sysTenantPackage.setMenuIds("");
        }

        Long loginUserId = LoginHelper.getUserId();
        Date createTime = new Date();
        sysTenantPackage.setUpdateBy(loginUserId);
        sysTenantPackage.setUpdateTime(createTime);

        return this.updateById(sysTenantPackage);
    }

    /**
     * 修改套餐状态
     *
     * @param sysTenantPackageBo 套餐信息
     * @return 结果
     */
    @Override
    public boolean updatePackageStatus(SysTenantPackageBo sysTenantPackageBo) {
        SysTenantPackage sysTenantPackage = MapstructUtils.convert(sysTenantPackageBo,SysTenantPackage.class);

        Long loginUserId = LoginHelper.getUserId();
        Date createTime = new Date();
        sysTenantPackage.setUpdateBy(loginUserId);
        sysTenantPackage.setUpdateTime(createTime);

        return this.updateById(sysTenantPackage);
    }

    /**
     * 批量删除租户套餐
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteByIds(Long[] packageIds, Boolean isValid) {
        if(isValid){
            boolean exists = tenantMapper.selectCountByQuery(QueryWrapper.create().from(SYS_TENANT).where(SYS_TENANT.PACKAGE_ID.in(List.of(packageIds)))) >0;
            if (exists) {
                throw new ServiceException("租户套餐已被使用");
            }
        }
        return this.removeByIds(Arrays.asList(packageIds));
    }

}
