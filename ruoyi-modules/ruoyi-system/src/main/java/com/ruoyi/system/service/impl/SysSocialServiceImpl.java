package com.ruoyi.system.service.impl;

import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.system.domain.SysSocial;
import com.ruoyi.system.domain.bo.SysSocialBo;
import com.ruoyi.system.domain.vo.SysSocialVo;
import com.ruoyi.system.mapper.SysSocialMapper;
import com.ruoyi.system.service.ISysSocialService;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.ruoyi.system.domain.table.SysSocialTableDef.SYS_SOCIAL;

/**
 * 社会化关系Service业务层处理
 *
 * @author thiszhc
 * @date 2023-06-12
 */
@RequiredArgsConstructor
@Service
public class SysSocialServiceImpl extends BaseServiceImpl<SysSocialMapper, SysSocial> implements ISysSocialService {

    @Resource
    private SysSocialMapper sysSocialMapper;


    /**
     * 查询社会化关系
     */
    @Override
    public SysSocialVo queryById(Long socialId) {
        return sysSocialMapper.selectOneWithRelationsByIdAs(socialId, SysSocialVo.class);
    }

    /**
     * 授权列表
     */
    @Override
    public List<SysSocialVo> queryList() {
        return sysSocialMapper.selectListByQueryAs(QueryWrapper.create().from(SYS_SOCIAL), SysSocialVo.class);
    }

    @Override
    public List<SysSocialVo> selectListByUserId(Long userId) {
        return sysSocialMapper.selectListByQueryAs(QueryWrapper.create().from(SYS_SOCIAL).where(SYS_SOCIAL.USER_ID.eq(userId)), SysSocialVo.class);
    }


    /**
     * 新增社会化关系
     */
    @Override
    public Boolean insertByBo(SysSocialBo bo) {
        SysSocial add = MapstructUtils.convert(bo, SysSocial.class);
        validEntityBeforeSave(add);
        return sysSocialMapper.insert(add, true) > 0;
    }

    /**
     * 更新社会化关系
     */
    @Override
    public Boolean updateByBo(SysSocialBo bo) {
        SysSocial update = MapstructUtils.convert(bo, SysSocial.class);
        validEntityBeforeSave(update);
        return sysSocialMapper.update(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(SysSocial entity) {
        //TODO 做一些数据校验,如唯一约束
    }


    /**
     * 删除社会化关系
     */
    @Override
    public Boolean deleteWithValidById(Long socialId) {
        return sysSocialMapper.deleteById(socialId) > 0;
    }


    /**
     * 根据 authId 查询用户信息
     *
     * @param authId 认证id
     * @return 授权信息
     */
    @Override
    public List<SysSocialVo> selectListByAuthId(String authId) {
        return sysSocialMapper.selectListByQueryAs(QueryWrapper.create().from(SYS_SOCIAL).where(SYS_SOCIAL.AUTH_ID.eq(authId)), SysSocialVo.class);
    }

}
