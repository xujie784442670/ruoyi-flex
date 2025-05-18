package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.IBaseService;
import com.ruoyi.system.domain.SysOperLog;
import com.ruoyi.system.domain.bo.SysOperLogBo;
import com.ruoyi.system.domain.vo.SysOperLogVo;

/**
 * 操作日志 服务层
 *
 * @author ruoyi
 */
public interface ISysOperLogService extends IBaseService<SysOperLog>
{
    /**
     * 新增操作日志
     *
     * @param operLog 操作日志对象
     */
    void insertOperlog(SysOperLogBo operLog);

    /**
     * 查询系统操作日志集合
     *
     * @param operLogBo 操作日志对象
     * @return 操作日志集合
     */
    List<SysOperLogVo> selectOperLogList(SysOperLogBo operLogBo);

    /**
     * 分页查询系统操作日志集合
     *
     * @param operLogBo 操作日志对象
     * @return 分页操作日志对象集合
     */
    TableDataInfo<SysOperLogVo> selectPage(SysOperLogBo operLogBo);

    /**
     * 批量删除系统操作日志
     *
     * @param operIds 需要删除的操作日志ID
     * @return 结果:true 删除成功，false 删除失败。
     */
    boolean deleteOperLogByIds(Long[] operIds);

    /**
     * 查询操作日志详细
     *
     * @param operId 操作ID
     * @return 操作日志对象
     */
    SysOperLogVo selectOperLogById(Long operId);

    /**
     * 清空操作日志
     */
    boolean cleanOperLog();
}
