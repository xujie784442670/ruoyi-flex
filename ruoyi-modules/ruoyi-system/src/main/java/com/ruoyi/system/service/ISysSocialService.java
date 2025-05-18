package com.ruoyi.system.service;

import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysSocial;
import com.ruoyi.system.domain.bo.SysSocialBo;
import com.ruoyi.system.domain.vo.SysSocialVo;

import java.util.List;

/**
 * 社会化关系Service接口
 *
 * @author thiszhc
 */
public interface ISysSocialService extends IBaseService<SysSocial> {


    /**
     * 查询社会化关系
     */
    SysSocialVo queryById(Long socialId);

    /**
     * 查询社会化关系列表
     */
    List<SysSocialVo> queryList();

    /**
     * 查询社会化关系列表
     */
    List<SysSocialVo> selectListByUserId(Long userId);

    /**
     * 新增授权关系
     */
    Boolean insertByBo(SysSocialBo bo);

    /**
     * 更新社会化关系
     */
    Boolean updateByBo(SysSocialBo bo);

    /**
     * 删除社会化关系信息
     */
    Boolean deleteWithValidById(Long id);


    /**
     * 根据 authId 查询 SysSocial 表和 SysUser 表，返回 SysSocialAuthResult 映射的对象
     * @param authId 认证ID
     * @return SysSocial
     */
    List<SysSocialVo> selectListByAuthId(String authId);


}
