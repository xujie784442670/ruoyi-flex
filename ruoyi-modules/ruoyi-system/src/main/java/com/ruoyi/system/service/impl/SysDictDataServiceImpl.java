package com.ruoyi.system.service.impl;

import java.util.Arrays;
import java.util.List;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.update.UpdateChain;
import com.ruoyi.common.core.constant.CacheNames;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.common.orm.core.page.PageQuery;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.common.redis.utils.CacheUtils;
import com.ruoyi.system.domain.SysDictData;
import com.ruoyi.system.domain.bo.SysDictDataBo;
import com.ruoyi.system.domain.vo.SysDictDataVo;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysDictDataMapper;
import com.ruoyi.system.service.ISysDictDataService;
import org.springframework.transaction.annotation.Transactional;

import static com.ruoyi.system.domain.table.SysDictDataTableDef.SYS_DICT_DATA;

/**
 * 字典 业务层处理
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@RequiredArgsConstructor
@Service
public class SysDictDataServiceImpl extends BaseServiceImpl<SysDictDataMapper, SysDictData> implements ISysDictDataService {
    @Resource
    private SysDictDataMapper dictDataMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_DICT_DATA);
    }

    /**
     * 构造查询条件
     *
     * @param dictDataBo
     * @return QueryWrapper
     */
    private QueryWrapper buildQueryWrapper(SysDictDataBo dictDataBo) {
        QueryWrapper queryWrapper = super.buildBaseQueryWrapper()
            .and(SYS_DICT_DATA.DICT_TYPE.eq(dictDataBo.getDictType()))
            .and(SYS_DICT_DATA.DICT_LABEL.eq(dictDataBo.getDictLabel()))
            .orderBy(SYS_DICT_DATA.DICT_SORT.asc());
        return queryWrapper;
    }

    /**
     * 根据条件查询字典数据
     *
     * @param dictDataBo 字典数据信息
     * @return 字典数据集合信息
     */
    @Override
    public List<SysDictDataVo> selectDictDataList(SysDictDataBo dictDataBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(dictDataBo);
        return this.listAs(queryWrapper, SysDictDataVo.class);
    }

    /**
     * 分页查询字典数据
     *
     * @param dictDataBo 字典类型信息
     * @return 字典数据集合信息
     */
    @Override
    public TableDataInfo<SysDictDataVo> selectPage(SysDictDataBo dictDataBo) {
        QueryWrapper queryWrapper = buildQueryWrapper(dictDataBo);
        Page<SysDictDataVo> page = this.pageAs(PageQuery.build(), queryWrapper, SysDictDataVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 根据字典类型和字典键值查询字典数据信息
     *
     * @param dictType  字典类型
     * @param dictValue 字典键值
     * @return 字典标签
     */
    @Override
    public String selectDictLabel(String dictType, String dictValue) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(SYS_DICT_DATA.DICT_LABEL)
            .from(SYS_DICT_DATA)
            .where(SYS_DICT_DATA.DICT_TYPE.eq(dictType))
            .and(SYS_DICT_DATA.DICT_VALUE.eq(dictValue));

        return dictDataMapper.selectObjectByQueryAs(queryWrapper, String.class);
    }

    /**
     * 根据字典数据ID查询信息
     *
     * @param dictCode 字典数据ID
     * @return 字典数据
     */
    @Override
    public SysDictDataVo selectDictDataById(Long dictCode) {
        return this.getOneAs(query().where(SYS_DICT_DATA.DICT_CODE.eq(dictCode)), SysDictDataVo.class);

    }

    /**
     * 查询字典数据记录数量
     *
     * @param dictType 字典类型
     * @return 字典数据
     */
    @Override
    public Integer countDictDataByType(String dictType) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.count(SYS_DICT_DATA.DICT_CODE))
            .from(SYS_DICT_DATA)
            .where(SYS_DICT_DATA.DICT_TYPE.eq(dictType));

        return dictDataMapper.selectObjectByQueryAs(queryWrapper, Integer.class);
    }

    /**
     * 根据字典类型查询字典数据
     *
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    @Cacheable(cacheNames = CacheNames.SYS_DICT, key = "#dictType")
    @Override
    public List<SysDictDataVo> selectDictDataByType(String dictType) {
        QueryWrapper queryWrapper = query().and(SYS_DICT_DATA.DICT_TYPE.eq(dictType)).orderBy(SYS_DICT_DATA.DICT_SORT.asc());
        return this.listAs(queryWrapper, SysDictDataVo.class);
    }

    /**
     * 批量删除字典数据信息
     *
     * @param dictCodes 需要删除的字典数据ID
     * @return 结果:true 删除成功，false 删除失败。
     */
    @Override
    @Transactional
    public boolean deleteDictDataByIds(Long[] dictCodes) {
        for (Long dictCode : dictCodes) {
            SysDictDataVo data = selectDictDataById(dictCode);
            CacheUtils.evict(CacheNames.SYS_DICT, data.getDictType());
        }
        return this.removeByIds(Arrays.asList(dictCodes));
    }

    /**
     * 新增保存字典数据信息
     *
     * @param dataBo 字典数据信息
     * @return true 操作成功，false 操作失败
     */
    @CacheEvict(cacheNames = CacheNames.SYS_DICT, key = "#dataBo.dictType")
    @Override
    public boolean insertDictData(SysDictDataBo dataBo) {
        SysDictData data = MapstructUtils.convert(dataBo, SysDictData.class);
        return this.save(data);
    }

    /**
     * 修改保存字典数据信息
     *
     * @param dataBo 字典数据信息
     * @return 结果:true 更新成功，false 更新失败。
     */
    @CacheEvict(cacheNames = CacheNames.SYS_DICT, key = "#dataBo.dictType")
    @Override
    public boolean updateDictData(SysDictDataBo dataBo) {
        SysDictData data = MapstructUtils.convert(dataBo, SysDictData.class);
        return this.updateById(data);
    }

    @Override
    public boolean updateDictDataType(String oldDictType, String newDictType) {
        return UpdateChain.of(SysDictData.class)
            .set(SysDictData::getDictType, newDictType)
            .where(SysDictData::getDictType).eq(oldDictType)
            .update();
    }
}
