package com.ruoyi.generator.service;

import java.util.Date;
import java.util.List;

import com.mybatisflex.core.query.QueryWrapper;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.common.security.utils.LoginHelper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.core.text.Convert;
import com.ruoyi.generator.domain.GenTableColumn;
import com.ruoyi.generator.mapper.GenTableColumnMapper;

import static com.ruoyi.generator.domain.table.GenTableColumnTableDef.GEN_TABLE_COLUMN;

/**
 * 业务字段 服务层实现
 *
 * @author ruoyi
 * @author 数据小王子
 */
@Service
public class GenTableColumnServiceImpl extends BaseServiceImpl<GenTableColumnMapper, GenTableColumn> implements IGenTableColumnService
{
	@Resource
	private GenTableColumnMapper genTableColumnMapper;

    @Override
    public QueryWrapper query() {
        return super.query().from(GEN_TABLE_COLUMN);
    }

	/**
     * 查询业务字段列表
     *
     * @param tableId 业务字段编号
     * @return 业务字段集合
     */
	@Override
	public List<GenTableColumn> selectGenTableColumnListByTableId(Long tableId)
	{
        QueryWrapper queryWrapper = query()
            .where(GEN_TABLE_COLUMN.TABLE_ID.eq(tableId))
            .orderBy(GEN_TABLE_COLUMN.SORT.asc());
        return this.list(queryWrapper);
	}

    /**
     * 新增业务字段
     *
     * @param genTableColumn 业务字段信息
     * @return 结果
     */
	@Override
	public int insertGenTableColumn(GenTableColumn genTableColumn)
	{
        Long loginUserId = LoginHelper.getUserId();
        Date createTime = new Date();
        genTableColumn.setCreateBy(loginUserId);
        genTableColumn.setCreateTime(createTime);
        genTableColumn.setUpdateBy(loginUserId);
        genTableColumn.setUpdateTime(createTime);

        return genTableColumnMapper.insertSelective(genTableColumn);
	}

	/**
     * 修改业务字段
     *
     * @param genTableColumn 业务字段信息
     * @return 结果
     */
	@Override
	public int updateGenTableColumn(GenTableColumn genTableColumn)
	{
        Long loginUserId = LoginHelper.getUserId();
        Date createTime = new Date();
        genTableColumn.setUpdateBy(loginUserId);
        genTableColumn.setUpdateTime(createTime);

	    return genTableColumnMapper.update(genTableColumn);
	}

	/**
     * 删除业务字段对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGenTableColumnByIds(String ids)
	{
		return genTableColumnMapper.deleteGenTableColumnByIds(Convert.toLongArray(ids));
	}
}
