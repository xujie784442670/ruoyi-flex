package com.ruoyi.system.controller.system;

import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import com.ruoyi.common.core.core.domain.R;
import com.ruoyi.common.security.utils.LoginHelper;
import com.ruoyi.common.web.core.BaseController;
import com.ruoyi.system.domain.vo.SysSocialVo;
import com.ruoyi.system.service.ISysSocialService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 社会化关系
 *
 * @author thiszhc
 * @date 2023-06-16
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/social")
public class SysSocialController extends BaseController {

    @Resource
    private ISysSocialService sysSocialService;

    /**
     * 查询社会化关系列表
     */
    @GetMapping("/list")
    public R<List<SysSocialVo>> list() {
        return R.ok(sysSocialService.selectListByUserId(LoginHelper.getUserId()));
    }

}
