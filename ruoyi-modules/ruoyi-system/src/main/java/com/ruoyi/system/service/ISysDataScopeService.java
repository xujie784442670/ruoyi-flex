package com.ruoyi.system.service;

import com.mybatisflex.core.query.QueryWrapper;

/**
 * 通用"数据权限过滤“服务
 *
 * @author dataprince数据小王子
 */
public interface ISysDataScopeService {
    /**
     * 添加数据查询过滤条件
     * @param queryWrapper
     * @return 添加了过滤条件后的queryWrapper
     */
    QueryWrapper addCondition(QueryWrapper queryWrapper);
}
