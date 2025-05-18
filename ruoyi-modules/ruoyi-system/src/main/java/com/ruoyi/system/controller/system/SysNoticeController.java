package com.ruoyi.system.controller.system;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.core.service.DictService;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.web.annotation.RepeatSubmit;
import com.ruoyi.common.websocket.utils.WebSocketUtils;
import com.ruoyi.system.domain.bo.SysNoticeBo;
import com.ruoyi.system.domain.vo.SysNoticeVo;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.web.core.BaseController;
import com.ruoyi.system.service.ISysNoticeService;

/**
 * 公告 信息操作处理
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/notice")
public class SysNoticeController extends BaseController
{
    @Resource
    private ISysNoticeService noticeService;
    @Resource
    private DictService dictService;

    /**
     * 获取通知公告列表
     */
    @SaCheckPermission("system:notice:list")
    @GetMapping("/list")
    public TableDataInfo<SysNoticeVo> list(SysNoticeBo noticeBo)
    {
       return  noticeService.selectPage(noticeBo);
    }

    /**
     * 根据通知公告编号获取详细信息
     */
    @SaCheckPermission("system:notice:query")
    @GetMapping(value = "/{noticeId}")
    public R<SysNoticeVo> getInfo(@PathVariable Long noticeId)
    {
        return R.ok(noticeService.selectNoticeById(noticeId));
    }

    /**
     * 新增通知公告
     */
    @SaCheckPermission("system:notice:add")
    @Log(title = "通知公告", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated @RequestBody SysNoticeBo noticeBo)
    {
        boolean inserted = noticeService.insertNotice(noticeBo);
        if (!inserted) {
            return R.fail("新增通知公告记录失败！");
        }
        String type = dictService.getDictLabel("sys_notice_type", noticeBo.getNoticeType());
        WebSocketUtils.publishAll("[" + type + "] " + noticeBo.getNoticeTitle());
        return R.ok();
    }

    /**
     * 修改通知公告
     */
    @SaCheckPermission("system:notice:edit")
    @Log(title = "通知公告", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody SysNoticeBo noticeBo)
    {
        boolean updated = noticeService.updateNotice(noticeBo);
        if (!updated) {
            return R.fail("修改通知公告记录失败!");
        }
        return R.ok();
    }

    /**
     * 删除通知公告
     */
    @SaCheckPermission("system:notice:remove")
    @Log(title = "通知公告", businessType = BusinessType.DELETE)
    @DeleteMapping("/{noticeIds}")
    public R<Void> remove(@PathVariable Long[] noticeIds)
    {
        boolean deleted = noticeService.deleteNoticeByIds(noticeIds);
        if (!deleted) {
            return R.fail("删除通知公告记录失败!");
        }
        return R.ok();
    }
}
