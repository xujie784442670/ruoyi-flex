package com.ruoyi.system.controller.system;

import java.util.List;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.excel.utils.ExcelUtil;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.system.domain.bo.SysPostBo;
import com.ruoyi.system.domain.vo.SysPostVo;
import com.ruoyi.system.service.ISysUserPostService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.web.core.BaseController;
import com.ruoyi.system.service.ISysPostService;

/**
 * 岗位信息操作处理
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/post")
public class SysPostController extends BaseController
{
    @Resource
    private ISysPostService postService;
    @Resource
    private ISysUserPostService userPostService;

    /**
     * 获取岗位列表
     */
    @SaCheckPermission("system:post:list")
    @GetMapping("/list")
    public TableDataInfo<SysPostVo> list(SysPostBo postBo)
    {
        return postService.selectPage(postBo);
    }

    @Log(title = "岗位管理", businessType = BusinessType.EXPORT)
    @SaCheckPermission("system:post:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysPostBo postBo)
    {
        List<SysPostVo> list = postService.selectPostList(postBo);
        ExcelUtil.exportExcel(list, "岗位管理数据", SysPostVo.class, response);
    }

    /**
     * 根据岗位编号获取详细信息
     */
    @SaCheckPermission("system:post:query")
    @GetMapping(value = "/{postId}")
    public R<SysPostVo> getInfo(@PathVariable Long postId)
    {
        return R.ok(postService.selectPostById(postId));
    }

    /**
     * 新增岗位
     */
    @SaCheckPermission("system:post:add")
    @Log(title = "岗位管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody SysPostBo postBo)
    {
        if (!postService.checkPostNameUnique(postBo))
        {
            return R.fail("新增岗位'" + postBo.getPostName() + "'失败，岗位名称已存在");
        }
        else if (!postService.checkPostCodeUnique(postBo))
        {
            return R.fail("新增岗位'" + postBo.getPostName() + "'失败，岗位编码已存在");
        }
        boolean inserted = postService.insertPost(postBo);
        if (!inserted) {
            return R.fail("新增岗位记录失败！");
        }
        return R.ok();
    }

    /**
     * 修改岗位
     */
    @SaCheckPermission("system:post:edit")
    @Log(title = "岗位管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody SysPostBo postBo)
    {
        if (!postService.checkPostNameUnique(postBo))
        {
            return R.fail("修改岗位'" + postBo.getPostName() + "'失败，岗位名称已存在");
        }
        else if (!postService.checkPostCodeUnique(postBo))
        {
            return R.fail("修改岗位'" + postBo.getPostName() + "'失败，岗位编码已存在");
        }
        else if (UserConstants.POST_DISABLE.equals(postBo.getStatus())
            && userPostService.countUserPostById(postBo.getPostId()) > 0) {
            return R.fail("该岗位下存在已分配用户，不能禁用!");
        }
        boolean updated = postService.updatePost(postBo);
        if (!updated) {
            return R.fail("修改岗位记录失败!");
        }
        return R.ok();
    }

    /**
     * 删除岗位
     */
    @SaCheckPermission("system:post:remove")
    @Log(title = "岗位管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{postIds}")
    public R<Void> remove(@PathVariable Long[] postIds)
    {
        boolean deleted = postService.deletePostByIds(postIds);
        if (!deleted) {
            return R.fail("删除岗位记录失败!");
        }
        return R.ok();
    }

    /**
     * 获取岗位选择框列表
     *
     * @param postIds 岗位ID串
     */
    @SaCheckPermission("system:post:query")
    @GetMapping("/optionselect")
    public R<List<SysPostVo>> optionselect(@RequestParam(required = false) Long[] postIds) {
        return R.ok(postService.selectPostByIds(postIds == null ? null : List.of(postIds)));
    }
}
