package com.ruoyi.system.controller.monitor;

import java.util.List;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ruoyi.common.core.constant.GlobalConstants;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.excel.utils.ExcelUtil;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.redis.utils.RedisUtils;
import com.ruoyi.system.domain.bo.SysLogininforBo;
import com.ruoyi.system.domain.vo.SysLogininforVo;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.web.core.BaseController;
import com.ruoyi.common.core.core.domain.AjaxResult;
import com.ruoyi.system.service.ISysLogininforService;

/**
 * 系统访问记录
 *
 * @author ruoyi
 */
@Validated
@RestController
@RequestMapping("/monitor/logininfor")
public class SysLogininforController extends BaseController
{
    @Resource
    private ISysLogininforService logininforService;

    @SaCheckPermission("monitor:logininfor:list")
    @GetMapping("/list")
    public TableDataInfo<SysLogininforVo>  list(SysLogininforBo logininforBo)
    {
        return logininforService.selectPage(logininforBo);
    }

    /**
     * 导出系统访问记录列表
     */
    @Log(title = "登录日志", businessType = BusinessType.EXPORT)
    @SaCheckPermission("monitor:logininfor:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysLogininforBo logininfor)
    {
        List<SysLogininforVo> list = logininforService.selectLogininforList(logininfor);
        ExcelUtil.exportExcel(list, "登录日志", SysLogininforVo.class, response);
    }

    /**
     * 批量删除登录日志
     * @param infoIds 日志ids
     */
    @SaCheckPermission("monitor:logininfor:remove")
    @Log(title = "登录日志", businessType = BusinessType.DELETE)
    @DeleteMapping("/{infoIds}")
    public R<Void> remove(@PathVariable Long[] infoIds)
    {
        boolean deleted = logininforService.deleteLogininforByIds(infoIds);
        if (!deleted) {
            R.fail("删除登录日志记录失败!");
        }
        return R.ok();
    }

    /**
     * 清理系统访问记录
     */
    @SaCheckPermission("monitor:logininfor:remove")
    @Log(title = "登录日志", businessType = BusinessType.CLEAN)
    @DeleteMapping("/clean")
    public R<Void> clean()
    {
        boolean cleaned = logininforService.cleanLogininfor();
        if (!cleaned) {
            R.fail("清除登录日志记录失败!");
        }
        return R.ok();
    }

    @SaCheckPermission("monitor:logininfor:unlock")
    @Log(title = "账户解锁", businessType = BusinessType.OTHER)
    @GetMapping("/unlock/{userName}")
    public AjaxResult unlock(@PathVariable("userName") String userName)
    {
        String loginName = GlobalConstants.PWD_ERR_CNT_KEY + userName;
        if (RedisUtils.hasKey(loginName)) {
            RedisUtils.deleteObject(loginName);
        }
        return success();
    }
}
