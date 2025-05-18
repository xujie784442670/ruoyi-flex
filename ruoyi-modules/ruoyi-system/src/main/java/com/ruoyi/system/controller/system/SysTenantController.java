package com.ruoyi.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaCheckRole;
import com.baomidou.lock.annotation.Lock4j;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import com.ruoyi.common.core.constant.TenantConstants;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.encrypt.annotation.ApiEncrypt;
import com.ruoyi.common.excel.utils.ExcelUtil;
import com.ruoyi.common.web.annotation.RepeatSubmit;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.tenant.helper.TenantHelper;
import com.ruoyi.common.web.core.BaseController;
import com.ruoyi.system.domain.bo.SysTenantBo;
import com.ruoyi.system.domain.vo.SysTenantVo;
import com.ruoyi.system.service.ISysTenantService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 租户管理
 *
 * @author Michelle.Chung
 * author 数据小王子
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/tenant")
public class SysTenantController extends BaseController {

    @Resource
    private ISysTenantService tenantService;

    /**
     * 分页查询租户列表
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:list")
    @GetMapping("/list")
    public TableDataInfo<SysTenantVo> list(SysTenantBo sysTenantBo) {
        return tenantService.selectPage(sysTenantBo);
    }

    /**
     * 导出租户列表
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:export")
    @Log(title = "租户", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(SysTenantBo sysTenantBo, HttpServletResponse response) {
        List<SysTenantVo> list = tenantService.selectList(sysTenantBo);
        ExcelUtil.exportExcel(list, "租户", SysTenantVo.class, response);
    }

    /**
     * 获取租户详细信息
     *
     * @param tenantId 主键
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:query")
    @GetMapping("/{tenantId}")
    public R<SysTenantVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long tenantId) {
        return R.ok(tenantService.selectById(tenantId));
    }

    /**
     * 新增租户
     */
    @ApiEncrypt
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:add")
    @Log(title = "租户", businessType = BusinessType.INSERT)
    @Lock4j
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated @RequestBody SysTenantBo sysTenantBo) {
        if (!tenantService.checkCompanyNameUnique(sysTenantBo)) {
            return R.fail("新增租户'" + sysTenantBo.getCompanyName() + "'失败，企业名称已存在");
        }
        boolean inserted = tenantService.insert(sysTenantBo);
        if (!inserted) {
            return R.fail("新增租户记录失败！");
        }
        return R.ok();
    }

    /**
     * 修改租户
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:edit")
    @Log(title = "租户", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated @RequestBody SysTenantBo sysTenantBo) {
        tenantService.checkTenantAllowed(sysTenantBo.getTenantId());
        boolean updated = tenantService.update(sysTenantBo);
        if (!updated) {
            return R.fail("修改租户记录失败!");
        }
        return R.ok();
    }

    /**
     * 状态修改
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:edit")
    @Log(title = "租户", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public R<Void> changeStatus(@RequestBody SysTenantBo sysTenantBo) {
        tenantService.checkTenantAllowed(sysTenantBo.getTenantId());
        boolean updated = tenantService.updateTenantStatus(sysTenantBo);
        if (!updated) {
            return R.fail("修改租户状态失败!");
        }
        return R.ok();
    }

    /**
     * 删除租户
     *
     * @param tenantIds 主键串
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:remove")
    @Log(title = "租户", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tenantIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] tenantIds) {
        boolean deleted = tenantService.deleteByIds(List.of(tenantIds), true);
        if (!deleted) {
            return R.fail("删除租户记录失败!");
        }
        return R.ok();
    }

    /**
     * 动态切换租户
     *
     * @param tenantId 租户ID
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @GetMapping("/dynamic/{tenantId}")
    public R<Void> dynamicTenant(@NotNull(message = "租户ID不能为空") @PathVariable Long tenantId) {
        TenantHelper.setDynamic(tenantId);
        return R.ok();
    }

    /**
     * 清除动态租户
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @GetMapping("/dynamic/clear")
    public R<Void> dynamicClear() {
        TenantHelper.clearDynamic();
        return R.ok();
    }


    /**
     * 同步租户套餐
     *
     * @param tenantId  租户id
     * @param packageId 套餐id
     */
    @SaCheckRole(TenantConstants.SUPER_ADMIN_ROLE_KEY)
    @SaCheckPermission("system:tenant:edit")
    @Log(title = "租户", businessType = BusinessType.UPDATE)
    @GetMapping("/syncTenantPackage")
    public R<Void> syncTenantPackage(@NotNull(message = "租户ID不能为空") Long tenantId,
                                     @NotNull(message = "套餐ID不能为空") Long packageId) {
        boolean synced = tenantService.syncTenantPackage(tenantId, packageId);
        if (!synced) {
            return R.fail("同步租户套餐失败!");
        }
        return R.ok();
    }

}
