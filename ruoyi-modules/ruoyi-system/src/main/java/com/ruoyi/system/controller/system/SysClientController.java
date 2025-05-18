package com.ruoyi.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.excel.utils.ExcelUtil;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.web.annotation.RepeatSubmit;
import com.ruoyi.system.domain.bo.SysClientBo;
import com.ruoyi.system.domain.vo.SysClientVo;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ruoyi.system.service.ISysClientService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 系统授权表 控制层。
 *
 * @author 数据小王子
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/client")
public class SysClientController {

    @Resource
    private ISysClientService sysClientService;

    /**
     * 查询客户端管理列表
     */
    @SaCheckPermission("system:client:list")
    @GetMapping("/list")
    public TableDataInfo<SysClientVo> list(SysClientBo sysClientBo) {
        return sysClientService.selectPage(sysClientBo);
    }

    /**
     * 导出客户端管理列表
     */
    @SaCheckPermission("system:client:export")
    @Log(title = "客户端管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(SysClientBo sysClientBo, HttpServletResponse response) {
        List<SysClientVo> list = sysClientService.selectList(sysClientBo);
        ExcelUtil.exportExcel(list, "客户端管理", SysClientVo.class, response);
    }

    /**
     * 获取客户端管理详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("system:client:query")
    @GetMapping("/{id}")
    public R<SysClientVo> getInfo(@NotNull(message = "主键不能为空")
                                  @PathVariable Long id) {
        return R.ok(sysClientService.selectById(id));
    }

    /**
     * 新增客户端管理
     */
    @SaCheckPermission("system:client:add")
    @Log(title = "客户端管理", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated @RequestBody SysClientBo sysClientBo) {
        boolean inserted = sysClientService.insert(sysClientBo);
        if (!inserted) {
            return R.fail("新增客户端管理记录失败！");
        }
        return R.ok();
    }

    /**
     * 修改客户端管理
     */
    @SaCheckPermission("system:client:edit")
    @Log(title = "客户端管理", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated @RequestBody SysClientBo sysClientBo) {
        boolean updated = sysClientService.update(sysClientBo);
        if (!updated) {
            return R.fail("修改客户端管理记录失败!");
        }
        return R.ok();
    }

    /**
     * 状态修改
     */
    @SaCheckPermission("system:client:edit")
    @Log(title = "客户端管理", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public R<Void> changeStatus(@RequestBody SysClientBo sysClientBo) {
        boolean updated = sysClientService.updateStatus(sysClientBo);
        if (!updated) {
            return R.fail("修改客户端管理状态失败!");
        }
        return R.ok();
    }

    /**
     * 删除客户端管理
     *
     * @param ids 主键串
     */
    @SaCheckPermission("system:client:remove")
    @Log(title = "客户端管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        boolean deleted = sysClientService.deleteByIds(List.of(ids));
        if (!deleted) {
            return R.fail("删除客户端管理记录失败!");
        }
        return R.ok();
    }
}
