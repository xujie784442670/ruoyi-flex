package com.ruoyi.common.orm.listener;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.http.HttpStatus;
import com.mybatisflex.annotation.InsertListener;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.orm.core.domain.BaseEntity;
import com.ruoyi.common.orm.helper.ListenerManager;
import com.ruoyi.common.security.utils.LoginHelper;

import java.util.Date;

/**
 * Entity实体类全局插入数据监听器
 *
 * @author dataprince数据小王子
 */
public class EntityInsertListener implements InsertListener {

    @Override
    public void onInsert(Object entity) {
        try {
            if (ListenerManager.isDoInsertListener() && ObjectUtil.isNotNull(entity) && (entity instanceof BaseEntity)) {
                BaseEntity baseEntity = (BaseEntity) entity;

                Long loginUserId = LoginHelper.getUserId();

                Date createTime = ObjectUtil.isNotNull(baseEntity.getCreateTime())
                    ? baseEntity.getCreateTime() : new Date();

                baseEntity.setCreateBy(loginUserId);
                baseEntity.setCreateTime(createTime);
                baseEntity.setUpdateBy(loginUserId);
                baseEntity.setUpdateTime(createTime);
            }
        } catch (Exception e) {
            throw new ServiceException("全局插入数据监听器注入异常 => " + e.getMessage(), HttpStatus.HTTP_UNAUTHORIZED);
        }
    }
}
