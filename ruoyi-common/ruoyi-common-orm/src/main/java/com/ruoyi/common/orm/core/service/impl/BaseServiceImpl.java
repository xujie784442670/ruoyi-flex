package com.ruoyi.common.orm.core.service.impl;

import com.mybatisflex.core.BaseMapper;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import com.ruoyi.common.core.core.page.PageDomain;
import com.ruoyi.common.core.core.page.TableSupport;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.sql.SqlUtil;
import com.ruoyi.common.orm.core.domain.BaseEntity;
import com.ruoyi.common.orm.core.service.IBaseService;

/**
 * 自定义的服务基类接口实现
 *
 * @author dataprince数据小王子
 */
public class BaseServiceImpl<M extends BaseMapper<T>, T> extends ServiceImpl<M , T> implements IBaseService<T> {

    /**
     * 构造基本查询条件
     * @return QueryWrapper
     */
    protected QueryWrapper buildBaseQueryWrapper(){
        QueryWrapper queryWrapper = query();
        PageDomain pageDomain = TableSupport.buildPageRequest();
        if (StringUtils.isNotEmpty(pageDomain.getOrderBy())) {
            String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
            queryWrapper.orderBy(orderBy);
        }
        return queryWrapper;
    }
}
