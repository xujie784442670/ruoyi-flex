package com.ruoyi.system.mapper;

import java.util.List;

import com.mybatisflex.core.BaseMapper;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.domain.vo.SysUserVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 用户表 数据层
 *
 * @author ruoyi
 */
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser>
{

}
