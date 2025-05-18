package com.ruoyi.generator.mapper;

import java.util.List;

import com.mybatisflex.core.BaseMapper;
import com.ruoyi.generator.domain.GenTableColumn;
import org.apache.ibatis.annotations.Mapper;

/**
 * 业务字段 数据层
 *
 * @author ruoyi
 * @author 数据小王子
 */
@Mapper
public interface GenTableColumnMapper extends BaseMapper<GenTableColumn>
{
    /**
     * 根据表名称查询列信息
     *
     * @param tableName 表名称
     * @return 列信息
     */
    List<GenTableColumn> selectDbTableColumnsByName(String tableName);

    /**
     * 批量删除业务字段
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteGenTableColumnByIds(Long[] ids);
}
