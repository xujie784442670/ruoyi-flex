package com.ruoyi.generator.mapper;

import java.util.List;

import com.mybatisflex.core.BaseMapper;
import com.ruoyi.generator.domain.GenTable;
import org.apache.ibatis.annotations.Mapper;

/**
 * 业务 数据层
 *
 * @author ruoyi
 * @author 数据小王子
 */
@Mapper
public interface GenTableMapper extends BaseMapper<GenTable>
{
    /**
     * 查询据库列表
     *
     * @param genTable 业务信息
     * @return 数据库表集合
     */
    List<GenTable> selectDbTableList(GenTable genTable);

    /**
     * 查询据库列表
     *
     * @param tableNames 表名称组
     * @return 数据库表集合
     */
    List<GenTable> selectDbTableListByNames(String[] tableNames);

    /**
     * 查询表名称业务信息
     *
     * @param tableName 表名称
     * @return 业务信息
     */
    GenTable selectGenTableByName(String tableName);

}
