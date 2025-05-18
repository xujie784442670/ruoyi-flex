package com.ruoyi.system.service;

import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysDictType;
import com.ruoyi.system.domain.bo.SysDictTypeBo;
import com.ruoyi.system.domain.vo.SysDictDataVo;
import com.ruoyi.system.domain.vo.SysDictTypeVo;

import java.util.List;

/**
 * 字典 业务层
 *
 * @author ruoyi
 */
public interface ISysDictTypeService extends IBaseService<SysDictType>
{
    /**
     * 根据条件分页查询字典类型
     *
     * @param dictType 字典类型信息
     * @return 字典类型集合信息
     */
    List<SysDictTypeVo> selectDictTypeList(SysDictTypeBo dictType);

    /**
     * 分页查询公告列表
     *
     * @param dictTypeBo 字典类型信息
     * @return 分页字典类型集合信息
     */
    TableDataInfo<SysDictTypeVo> selectPage(SysDictTypeBo dictTypeBo);

    /**
     * 根据所有字典类型
     *
     * @return 字典类型集合信息
     */
    List<SysDictTypeVo> selectDictTypeAll();

    /**
     * 根据字典类型查询字典数据
     *
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    List<SysDictDataVo> selectDictDataByType(String dictType);

    /**
     * 根据字典类型ID查询信息
     *
     * @param dictId 字典类型ID
     * @return 字典类型
     */
    SysDictTypeVo selectDictTypeById(Long dictId);

    /**
     * 根据字典类型查询信息
     *
     * @param dictType 字典类型
     * @return 字典类型
     */
    SysDictTypeVo selectDictTypeByType(String dictType);

    /**
     * 批量删除字典信息
     *
     * @param dictIds 需要删除的字典ID
     * @return  true 删除成功，false 删除失败。
     */
    boolean deleteDictTypeByIds(Long[] dictIds);

    /**
     * 加载字典缓存数据
     */
    //void loadingDictCache();

    /**
     * 清空字典缓存数据
     */
    //void clearDictCache();

    /**
     * 重置字典缓存数据
     */
    void resetDictCache();

    /**
     * 新增保存字典类型信息
     *
     * @param sysDictTypeBo 字典类型信息
     * @return 结果
     */
    List<SysDictDataVo> insertDictType(SysDictTypeBo sysDictTypeBo);

    /**
     * 修改保存字典类型信息
     *
     * @param dictTypeBo 字典类型信息
     * @return 结果
     */
    public List<SysDictDataVo> updateDictType(SysDictTypeBo dictTypeBo);

    /**
     * 校验字典类型称是否唯一
     *
     * @param dictTypeBo 字典类型
     * @return 结果
     */
    boolean checkDictTypeUnique(SysDictTypeBo dictTypeBo);


}
