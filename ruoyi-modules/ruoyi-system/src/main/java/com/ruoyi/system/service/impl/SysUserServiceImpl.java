package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import cn.dev33.satoken.secure.BCrypt;
import cn.hutool.core.util.ObjectUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.update.UpdateChain;
import com.ruoyi.common.core.constant.CacheNames;
import com.ruoyi.common.core.service.UserService;
import com.ruoyi.common.core.utils.MapstructUtils;
import com.ruoyi.common.orm.core.page.PageQuery;
import com.ruoyi.common.orm.core.page.TableDataInfo;
import com.ruoyi.common.orm.core.service.impl.BaseServiceImpl;
import com.ruoyi.common.security.utils.LoginHelper;
import com.ruoyi.common.tenant.helper.TenantHelper;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.domain.bo.SysUserBo;
import com.ruoyi.system.domain.vo.SysPostVo;
import com.ruoyi.system.domain.vo.SysRoleVo;
import com.ruoyi.system.domain.vo.SysUserVo;
import com.ruoyi.system.mapper.*;
import com.ruoyi.system.service.*;
import jakarta.annotation.Resource;
import jakarta.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.bean.BeanValidators;
import com.ruoyi.common.core.utils.SpringUtils;

import static com.mybatisflex.core.query.QueryMethods.*;
import static com.ruoyi.system.domain.table.SysDeptTableDef.SYS_DEPT;
import static com.ruoyi.system.domain.table.SysRoleTableDef.SYS_ROLE;
import static com.ruoyi.system.domain.table.SysUserRoleTableDef.SYS_USER_ROLE;
import static com.ruoyi.system.domain.table.SysUserTableDef.SYS_USER;

/**
 * 用户 业务层处理
 *
 * @author ruoyi
 * @author dataprince数据小王子
 */
@Service
public class SysUserServiceImpl extends BaseServiceImpl<SysUserMapper, SysUser> implements ISysUserService, UserService {
    private static final Logger log = LoggerFactory.getLogger(SysUserServiceImpl.class);

    @Resource
    private SysUserMapper userMapper;

    @Resource
    private ISysRoleService roleService;

    @Resource
    private ISysPostService postService;

    @Resource
    private ISysUserRoleService userRoleService;

    @Resource
    private ISysUserPostService userPostService;

    @Resource
    private ISysConfigService configService;

    @Resource
    protected Validator validator;

    @Resource
    private ISysDataScopeService dataScopeService;

    @Override
    public QueryWrapper query() {
        return super.query().from(SYS_USER);
    }

    private QueryWrapper buildListQueryWrapper(SysUserBo userBo) {
        /*select u.user_id, u.tenant_id, u.dept_id, u.nick_name, u.user_name, u.user_type, u.email, u.avatar, u.phonenumber, u.gender, u.status, u.del_flag, u.login_ip, u.login_date, u.create_by, u.create_time, u.remark, d.dept_name, d.leader
        from sys_user u
        left join sys_dept d on u.dept_id = d.dept_id
        where u.del_flag = '0'*/
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(SYS_USER.USER_ID, SYS_USER.TENANT_ID, SYS_USER.DEPT_ID, SYS_USER.NICK_NAME, SYS_USER.USER_NAME, SYS_USER.USER_TYPE, SYS_USER.EMAIL, SYS_USER.AVATAR, SYS_USER.PHONENUMBER, SYS_USER.GENDER, SYS_USER.STATUS, SYS_USER.VERSION, SYS_USER.DEL_FLAG, SYS_USER.LOGIN_IP, SYS_USER.LOGIN_DATE, SYS_USER.CREATE_BY, SYS_USER.CREATE_TIME, SYS_USER.REMARK, SYS_DEPT.DEPT_NAME, SYS_DEPT.LEADER)
            .from(SYS_USER.as("u"))
            .leftJoin(SYS_DEPT).as("d").on(SYS_DEPT.DEPT_ID.eq(SYS_USER.DEPT_ID))
            .where(SYS_USER.DEL_FLAG.eq(0));
        if (ObjectUtil.isNotNull(userBo.getUserId())) {
            queryWrapper.and(SYS_USER.USER_ID.eq(userBo.getUserId()));
        }
        if (StringUtils.isNotEmpty(userBo.getUserName())) {
            queryWrapper.and(SYS_USER.USER_NAME.like(userBo.getUserName()));
        }
        if (StringUtils.isNotEmpty(userBo.getStatus())) {
            queryWrapper.and(SYS_USER.STATUS.eq(userBo.getStatus()));
        }
        if (StringUtils.isNotEmpty(userBo.getPhonenumber())) {
            queryWrapper.and(SYS_USER.PHONENUMBER.like(userBo.getPhonenumber()));
        }
        Map<String, Object> params = userBo.getParams();
        if (params.get("beginTime") != null && params.get("endTime") != null) {
            queryWrapper.and(SYS_USER.CREATE_TIME.between(params.get("beginTime"), params.get("endTime")));
        }
        if (ObjectUtil.isNotNull(userBo.getDeptId())) {
            queryWrapper.and(SYS_USER.DEPT_ID.eq(userBo.getDeptId()).or(SYS_USER.DEPT_ID.in(select(SYS_DEPT.DEPT_ID).from(SYS_DEPT.as("t")).where(findInSet(number(userBo.getDeptId()), SYS_DEPT.ANCESTORS).gt(0)))));
        }
        queryWrapper.orderBy(SYS_USER.USER_ID.desc());
        return queryWrapper;
    }

    private QueryWrapper buildOneQueryWrapper() {
        /*  select u.user_id, u.tenant_id,u.dept_id, u.user_name, u.nick_name, u.user_type, u.email, u.avatar, u.phonenumber, u.password, u.gender, u.status, u.del_flag, u.login_ip, u.login_date, u.create_by, u.create_time, u.remark,
        d.dept_id, d.parent_id, d.ancestors, d.dept_name, d.order_num, d.leader, d.status as dept_status,
        r.role_id, r.role_name, r.role_key, r.role_sort, r.data_scope, r.status as role_status
        from sys_user u
		    left join sys_dept d on u.dept_id = d.dept_id
		    left join sys_user_role ur on u.user_id = ur.user_id
		    left join sys_role r on r.role_id = ur.role_id */
        /*return QueryWrapper.create()
            .select(QueryMethods.distinct(SYS_USER.USER_ID,SYS_USER.TENANT_ID,SYS_USER.DEPT_ID,SYS_USER.NICK_NAME,SYS_USER.USER_NAME,SYS_USER.USER_TYPE,SYS_USER.EMAIL,SYS_USER.AVATAR,SYS_USER.PHONENUMBER,SYS_USER.PASSWORD,SYS_USER.GENDER,SYS_USER.STATUS,SYS_USER.DEL_FLAG,SYS_USER.LOGIN_IP,SYS_USER.LOGIN_DATE,SYS_USER.CREATE_BY,SYS_USER.CREATE_TIME,SYS_USER.REMARK,
                SYS_DEPT.DEPT_ID,SYS_DEPT.PARENT_ID,SYS_DEPT.ANCESTORS,SYS_DEPT.DEPT_NAME,SYS_DEPT.ORDER_NUM,SYS_DEPT.LEADER,SYS_DEPT.STATUS.as("dept_status"),
                SYS_ROLE.ROLE_ID,SYS_ROLE.ROLE_NAME,SYS_ROLE.ROLE_KEY,SYS_ROLE.ROLE_SORT,SYS_ROLE.DATA_SCOPE,SYS_ROLE.STATUS.as("role_status")))
            .from(SYS_USER.as("u"))
            .leftJoin(SYS_DEPT).as("d").on(SYS_DEPT.DEPT_ID.eq(SYS_USER.DEPT_ID))
            .leftJoin(SYS_USER_ROLE).as("ur").on(SYS_USER_ROLE.USER_ID.eq(SYS_USER.USER_ID))
            .leftJoin(SYS_ROLE).as("r").on(SYS_ROLE.ROLE_ID.eq(SYS_USER_ROLE.ROLE_ID));*/
        return QueryWrapper.create()
            .select(QueryMethods.distinct(SYS_USER.USER_ID, SYS_USER.TENANT_ID, SYS_USER.DEPT_ID, SYS_USER.NICK_NAME, SYS_USER.USER_NAME, SYS_USER.USER_TYPE, SYS_USER.EMAIL, SYS_USER.AVATAR, SYS_USER.PHONENUMBER, SYS_USER.PASSWORD, SYS_USER.GENDER, SYS_USER.STATUS, SYS_USER.VERSION, SYS_USER.DEL_FLAG, SYS_USER.LOGIN_IP, SYS_USER.LOGIN_DATE, SYS_USER.CREATE_BY, SYS_USER.CREATE_TIME, SYS_USER.REMARK,
                SYS_DEPT.DEPT_ID, SYS_DEPT.PARENT_ID, SYS_DEPT.ANCESTORS, SYS_DEPT.DEPT_NAME, SYS_DEPT.ORDER_NUM, SYS_DEPT.LEADER, SYS_DEPT.STATUS.as("dept_status")
            ))
            .from(SYS_USER.as("u"))
            .leftJoin(SYS_DEPT).as("d").on(SYS_DEPT.DEPT_ID.eq(SYS_USER.DEPT_ID));
        //.leftJoin(SYS_USER_ROLE).as("ur").on(SYS_USER_ROLE.USER_ID.eq(SYS_USER.USER_ID))
        //.leftJoin(SYS_ROLE).as("r").on(SYS_ROLE.ROLE_ID.eq(SYS_USER_ROLE.ROLE_ID));
    }


    /**
     * 根据条件分页查询用户列表
     *
     * @param userBo 用户信息
     * @return 用户信息集合信息
     */
    @Override
    public List<SysUserVo> selectUserList(SysUserBo userBo) {
        QueryWrapper queryWrapper = dataScopeService.addCondition(buildListQueryWrapper(userBo));
        return this.listAs(queryWrapper, SysUserVo.class);
    }

    /**
     * 分页查询用户信息
     *
     * @param userBo 用户信息
     * @return 用户信息集合信息
     */
    @Override
    public TableDataInfo<SysUserVo> selectPage(SysUserBo userBo) {
        QueryWrapper queryWrapper = dataScopeService.addCondition(buildListQueryWrapper(userBo));
        Page<SysUserVo> page = this.pageAs(PageQuery.build(), queryWrapper, SysUserVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 根据条件分页查询已分配用户角色分页列表
     *
     * @param userBo 用户信息
     * @return 用户信息集合信息
     */
    @Override
    public TableDataInfo<SysUserVo> selectAllocatedPage(SysUserBo userBo) {
       /* select distinct u.user_id, u.tenant_id, u.dept_id, u.user_name, u.nick_name, u.user_type, u.email, u.phonenumber, u.status, u.create_time
        from sys_user u
        left join sys_dept d on u.dept_id = d.dept_id
        left join sys_user_role ur on u.user_id = ur.user_id
        left join sys_role r on r.role_id = ur.role_id
        where u.del_flag = '0' and r.role_id = #{roleId}
	    <if test="userName != null and userName != ''">
            AND u.user_name like concat('%', #{userName}, '%')
		</if>
		<if test="phonenumber != null and phonenumber != ''">
            AND u.phonenumber like concat('%', #{phonenumber}, '%')
		</if>
		<!-- 数据范围过滤 -->
            ${params.dataScope}*/
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.distinct(SYS_USER.USER_ID, SYS_USER.TENANT_ID, SYS_USER.DEPT_ID, SYS_USER.USER_NAME, SYS_USER.NICK_NAME, SYS_USER.USER_TYPE, SYS_USER.EMAIL, SYS_USER.PHONENUMBER, SYS_USER.STATUS, SYS_USER.CREATE_TIME))
            .from(SYS_USER.as("u"))
            .leftJoin(SYS_DEPT).as("d").on(SYS_DEPT.DEPT_ID.eq(SYS_USER.DEPT_ID))
            .leftJoin(SYS_USER_ROLE).as("ur").on(SYS_USER_ROLE.USER_ID.eq(SYS_USER.USER_ID))
            .leftJoin(SYS_ROLE).as("r").on(SYS_ROLE.ROLE_ID.eq(SYS_USER_ROLE.ROLE_ID))
            .where(SYS_USER.DEL_FLAG.eq(0))
            .and(SYS_ROLE.ROLE_ID.eq(userBo.getRoleId()));
        if (StringUtils.isNotEmpty(userBo.getUserName())) {
            queryWrapper.and(SYS_USER.USER_NAME.like(userBo.getUserName()));
        }
        if (StringUtils.isNotEmpty(userBo.getPhonenumber())) {
            queryWrapper.and(SYS_USER.PHONENUMBER.like(userBo.getPhonenumber()));
        }

        Page<SysUserVo> page = this.pageAs(PageQuery.build(), queryWrapper, SysUserVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 根据条件分页查询未分配用户角色分页列表
     *
     * @param userBo 用户信息
     * @return 用户信息集合信息
     */
    @Override
    public TableDataInfo<SysUserVo> selectUnallocatedPage(SysUserBo userBo) {
        /*select distinct u.user_id,  u.tenant_id, u.dept_id, u.user_name, u.nick_name, u.user_type, u.email, u.phonenumber, u.status, u.create_time
        from sys_user u
        left join sys_dept d on u.dept_id = d.dept_id
        left join sys_user_role ur on u.user_id = ur.user_id
        left join sys_role r on r.role_id = ur.role_id
        where u.del_flag = '0' and (r.role_id != #{roleId} or r.role_id IS NULL)
        and u.user_id not in (select u.user_id from sys_user u inner join sys_user_role ur on u.user_id = ur.user_id and ur.role_id = #{roleId})
	    <if test="userName != null and userName != ''">
            AND u.user_name like concat('%', #{userName}, '%')
		</if>
		<if test="phonenumber != null and phonenumber != ''">
            AND u.phonenumber like concat('%', #{phonenumber}, '%')
		</if>
		<!-- 数据范围过滤 -->
            ${params.dataScope}*/
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.distinct(SYS_USER.USER_ID, SYS_USER.TENANT_ID, SYS_USER.DEPT_ID, SYS_USER.USER_NAME, SYS_USER.NICK_NAME, SYS_USER.USER_TYPE, SYS_USER.EMAIL, SYS_USER.PHONENUMBER, SYS_USER.STATUS, SYS_USER.CREATE_TIME))
            .from(SYS_USER.as("u"))
            .leftJoin(SYS_DEPT).as("d").on(SYS_DEPT.DEPT_ID.eq(SYS_USER.DEPT_ID))
            .leftJoin(SYS_USER_ROLE).as("ur").on(SYS_USER_ROLE.USER_ID.eq(SYS_USER.USER_ID))
            .leftJoin(SYS_ROLE).as("r").on(SYS_ROLE.ROLE_ID.eq(SYS_USER_ROLE.ROLE_ID))
            .where(SYS_USER.DEL_FLAG.eq(0))
            .and(SYS_USER.STATUS.eq("0"))
            .and(SYS_ROLE.ROLE_ID.ne(userBo.getRoleId()).or(SYS_ROLE.ROLE_ID.isNull()))
            .and(SYS_USER.USER_ID.notIn(select(SYS_USER.USER_ID).from(SYS_USER.as("u")).innerJoin(SYS_USER_ROLE).as("ur").on(SYS_USER_ROLE.USER_ID.eq(SYS_USER.USER_ID).and(SYS_USER_ROLE.ROLE_ID.eq(userBo.getRoleId())))));
        if (StringUtils.isNotEmpty(userBo.getUserName())) {
            queryWrapper.and(SYS_USER.USER_NAME.like(userBo.getUserName()));
        }
        if (StringUtils.isNotEmpty(userBo.getPhonenumber())) {
            queryWrapper.and(SYS_USER.PHONENUMBER.like(userBo.getPhonenumber()));
        }

        Page<SysUserVo> page = this.pageAs(PageQuery.build(), dataScopeService.addCondition(queryWrapper), SysUserVo.class);
        return TableDataInfo.build(page);
    }

    /**
     * 通过用户名查询用户
     *
     * @param userName 用户名
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectUserByUserName(String userName) {
        QueryWrapper queryWrapper = buildOneQueryWrapper();
        queryWrapper.where(SYS_USER.DEL_FLAG.eq(0));
        if (StringUtils.isNotEmpty(userName)) {
            queryWrapper.and(SYS_USER.USER_NAME.eq(userName));
        }
        return this.getOneAs(queryWrapper, SysUserVo.class);
    }

    /**
     * 登录时通过用户名、租户编号查询用户（不走Mybatis-Flex租户插件）
     *
     * @param tenantId 租户编号
     * @param userName 用户名
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectTenantUserByUserName(Long tenantId, String userName) {
        return TenantHelper.ignore(() -> {
            QueryWrapper queryWrapper = buildOneQueryWrapper()
                .where(SYS_USER.TENANT_ID.eq(tenantId))
                .and(SYS_USER.USER_NAME.eq(userName));
            return userMapper.selectOneWithRelationsByQueryAs(queryWrapper, SysUserVo.class);
        });
    }

    /**
     * 登录时通过用户名、租户编号查询用户（不走Mybatis-Flex租户插件）
     *
     * @param tenantId   租户编号
     * @param phonenumber 手机号
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectTenantUserByPhonenumber(Long tenantId, String phonenumber) {
        return TenantHelper.ignore(() -> {
            QueryWrapper queryWrapper = buildOneQueryWrapper()
                .where(SYS_USER.TENANT_ID.eq(tenantId))
                .and(SYS_USER.PHONENUMBER.eq(phonenumber));
            return userMapper.selectOneWithRelationsByQueryAs(queryWrapper, SysUserVo.class);
        });
    }

    /**
     * 登录时通过租户编号、邮箱查询用户（不走Mybatis-Flex租户插件）
     *
     * @param tenantId 租户编号
     * @param email 邮箱
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectTenantUserByEmail(Long tenantId, String email) {
        return TenantHelper.ignore(() -> {
            QueryWrapper queryWrapper = buildOneQueryWrapper()
                .where(SYS_USER.TENANT_ID.eq(tenantId))
                .and(SYS_USER.EMAIL.eq(email));
            return userMapper.selectOneWithRelationsByQueryAs(queryWrapper, SysUserVo.class);
        });
    }

    /**
     * 登录时通过租户编号、邮箱查询用户（不走Mybatis-Flex租户插件）
     *
     * @param tenantId 租户编号
     * @param userId 用户id
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectTenantUserById(Long tenantId, Long userId) {
        return TenantHelper.ignore(() -> {
            QueryWrapper queryWrapper = buildOneQueryWrapper()
                .where(SYS_USER.TENANT_ID.eq(tenantId))
                .and(SYS_USER.USER_ID.eq(userId));
            return userMapper.selectOneWithRelationsByQueryAs(queryWrapper, SysUserVo.class);
        });
    }

    /**
     * 通过用户ID查询用户
     *
     * @param userId 用户ID
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectUserById(Long userId) {
        //QueryWrapper queryWrapper = buildOneQueryWrapper();//当角色有多个时，如果使用leftjoin角色表，后面通过关联查询在提取角色时会出错，所以弃用！
        QueryWrapper queryWrapper = query();
        if (ObjectUtil.isNotNull(userId)) {
            queryWrapper.where(SYS_USER.USER_ID.eq(userId));
        }
        return userMapper.selectOneWithRelationsByQueryAs(queryWrapper, SysUserVo.class);//使用Relation注解获取dept、roles、从sys_oss中查询头像地址URL
    }

    /**
     * 通过用户ID串查询用户
     *
     * @param userIds 用户ID串
     * @param deptId  部门id
     * @return 用户列表信息
     */
    @Override
    public List<SysUserVo> selectUserByIds(List<Long> userIds, Long deptId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(SYS_USER.USER_ID, SYS_USER.USER_NAME, SYS_USER.NICK_NAME)
            .from(SYS_USER)
            .where(SYS_USER.STATUS.eq(UserConstants.USER_NORMAL))
            .and(SYS_USER.DEPT_ID.eq(deptId))
            .and(SYS_USER.USER_ID.in(userIds));
        return this.listAs(queryWrapper, SysUserVo.class);
    }

    /**
     * 个人中心模块通过用户ID查询用户
     *
     * @param userId 用户ID
     * @return 用户对象信息
     */
    @Override
    public SysUserVo selectProfileUserById(Long userId) {
        //使用leftjoin取得部门名称
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.distinct(SYS_USER.USER_ID, SYS_USER.TENANT_ID, SYS_USER.DEPT_ID, SYS_USER.NICK_NAME, SYS_USER.USER_NAME, SYS_USER.USER_TYPE, SYS_USER.EMAIL, SYS_USER.AVATAR, SYS_USER.PHONENUMBER, SYS_USER.PASSWORD, SYS_USER.GENDER, SYS_USER.STATUS, SYS_USER.DEL_FLAG, SYS_USER.LOGIN_IP, SYS_USER.LOGIN_DATE, SYS_USER.CREATE_BY, SYS_USER.CREATE_TIME, SYS_USER.REMARK
                //SYS_DEPT.DEPT_ID, SYS_DEPT.PARENT_ID, SYS_DEPT.ANCESTORS, SYS_DEPT.DEPT_NAME, SYS_DEPT.ORDER_NUM, SYS_DEPT.LEADER, SYS_DEPT.STATUS.as("dept_status")
            ))
            .from(SYS_USER.as("u"))
            //.leftJoin(SYS_DEPT).as("d").on(SYS_DEPT.DEPT_ID.eq(SYS_USER.DEPT_ID))
            .where(SYS_USER.DEL_FLAG.eq(0));
        if (ObjectUtil.isNotNull(userId)) {
            queryWrapper.and(SYS_USER.USER_ID.eq(userId));
        }
        //return this.getOneAs(queryWrapper, SysUserVo.class);
        return userMapper.selectOneWithRelationsByQueryAs(queryWrapper, SysUserVo.class);
    }

    /**
     * 查询用户所属角色组
     *
     * @param userName 用户名
     * @return 结果
     */
    @Override
    public String selectUserRoleGroup(String userName) {
        List<SysRoleVo> list = roleService.selectRolesByUserName(userName);
        if (CollectionUtils.isEmpty(list)) {
            return StringUtils.EMPTY;
        }
        return list.stream().map(SysRoleVo::getRoleName).collect(Collectors.joining("，"));
    }

    /**
     * 查询用户所属岗位组
     *
     * @param userName 用户名
     * @return 结果
     */
    @Override
    public String selectUserPostGroup(String userName) {
        List<SysPostVo> list = postService.selectPostsByUserName(userName);
        if (CollectionUtils.isEmpty(list)) {
            return StringUtils.EMPTY;
        }
        return list.stream().map(SysPostVo::getPostName).collect(Collectors.joining("，"));
    }

    /**
     * 校验用户名称是否唯一
     *
     * @param userBo 用户信息
     * @return 结果
     */
    @Override
    public boolean checkUserNameUnique(SysUserBo userBo) {
        Long userId = ObjectUtil.isNull(userBo.getUserId()) ? -1L : userBo.getUserId();
        QueryWrapper queryWrapper = query().where(SYS_USER.USER_NAME.eq(userBo.getUserName()))
            .and(SYS_USER.DEL_FLAG.eq(0));
        SysUser info = this.getOne(queryWrapper);
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验手机号码是否唯一
     *
     * @param user 用户信息
     * @return UNIQUE或者NOT_UNIQUE
     */
    @Override
    public boolean checkPhoneUnique(SysUserBo user) {
        Long userId = StringUtils.isNull(user.getUserId()) ? -1L : user.getUserId();
        QueryWrapper queryWrapper = query().where(SYS_USER.PHONENUMBER.eq(user.getPhonenumber()))
            .and(SYS_USER.DEL_FLAG.eq(0));
        SysUser info = this.getOne(queryWrapper);
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验email是否唯一
     *
     * @param user 用户信息
     * @return true或者false
     */
    @Override
    public boolean checkEmailUnique(SysUserBo user) {
        Long userId = StringUtils.isNull(user.getUserId()) ? -1L : user.getUserId();
        QueryWrapper queryWrapper = query().where(SYS_USER.EMAIL.eq(user.getEmail()))
            .and(SYS_USER.DEL_FLAG.eq(0));
        SysUser info = this.getOne(queryWrapper);
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验用户是否允许操作
     *
     * @param userId 用户Id
     */
    @Override
    public void checkUserAllowed(Long userId) {
        if (ObjectUtil.isNotNull(userId) && LoginHelper.isSuperAdmin(userId)) {
            throw new ServiceException("不允许操作超级管理员用户");
        }
    }

    /**
     * 校验用户是否有数据权限
     *
     * @param userId 用户id
     */
    @Override
    public void checkUserDataScope(Long userId) {
        if (ObjectUtil.isNull(userId)) {
            return;
        }
        if (LoginHelper.isSuperAdmin()) {
            return;
        }

        SysUserBo user = new SysUserBo();
        user.setUserId(userId);
        List<SysUserVo> users = SpringUtils.getAopProxy(this).selectUserList(user);
        if (StringUtils.isEmpty(users)) {
            throw new ServiceException("没有权限访问用户数据！");
        }
    }

    /**
     * 查询部门是否存在用户
     *
     * @param deptId 部门ID
     * @return 结果 true 存在 false 不存在
     */
    @Override
    public boolean checkDeptExistUser(Long deptId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
            .select(QueryMethods.count(SYS_USER.USER_ID))
            .from(SYS_USER)
            .where(SYS_USER.DEPT_ID.eq(deptId))
            .and(SYS_USER.DEL_FLAG.eq(0));

        int result = userMapper.selectObjectByQueryAs(queryWrapper, Integer.class);
        return result > 0;
    }

    /**
     * 新增保存用户信息
     *
     * @param userBo 用户信息
     * @return 结果:true 保存成功，false 保存失败
     */
    @Override
    @Transactional
    public boolean insertUser(SysUserBo userBo) {
        SysUser user = MapstructUtils.convert(userBo, SysUser.class);
        // 新增用户信息
        boolean saved = this.save(user);
        if (saved) {
            // 新增用户岗位关联
            insertUserPost(user);
            // 新增用户与角色管理
            insertUserRole(user);
            return true;
        }
        return false;
    }

    /**
     * 注册用户信息
     *
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public boolean registerUser(SysUserBo user, Long tenantId) {
        SysUser sysUser = MapstructUtils.convert(user, SysUser.class);
        sysUser.setTenantId(tenantId);
        return this.save(sysUser);
    }

    /**
     * 修改保存用户信息
     *
     * @param userBo 用户信息
     * @return 结果：true 更新成功，false 更新失败
     */
    @Override
    @Transactional
    public boolean updateUser(SysUserBo userBo) {
        SysUser user = MapstructUtils.convert(userBo, SysUser.class);
        if (ObjectUtil.isNotNull(user)) {
            Long userId = user.getUserId();
            // 删除用户与角色关联
            userRoleService.deleteUserRoleByUserId(userId);
            // 新增用户与角色管理
            insertUserRole(user);

            // 删除用户与岗位关联
            userPostService.deleteUserPostByUserId(userId);
            // 新增用户与岗位管理
            insertUserPost(user);

            return this.updateById(user);
        }
        return false;
    }

    /**
     * 用户授权角色
     *
     * @param userId  用户ID
     * @param roleIds 角色组
     */
    @Override
    @Transactional
    public void insertUserAuth(Long userId, Long[] roleIds) {
        userRoleService.deleteUserRoleByUserId(userId);
        userRoleService.insertUserRoles(userId, roleIds);
    }

    /**
     * 修改用户状态
     * update sys_user set status = #{status},version=version+1 where user_id = #{userId} and version=#{version}
     *
     * @param user 用户信息
     * @return 结果：true 操作成功，false 操作失败。
     */
    @Override
    public boolean updateUserStatus(SysUserBo user) {
        return UpdateChain.of(SysUser.class)
            .set(SysUser::getStatus, user.getStatus())
            .where(SysUser::getUserId).eq(user.getUserId())
            .and(SysUser::getVersion).eq(user.getVersion())  //手动添加乐观锁条件
            .update();
    }

    /**
     * 修改用户基本信息
     *
     * @param userBo 用户信息
     * @return 结果
     */
    @Override
    public boolean updateUserProfile(SysUserBo userBo) {
        SysUser user = MapstructUtils.convert(userBo, SysUser.class);
        return this.updateById(user);
    }

    /**
     * 修改用户头像
     *
     * @param userId 用户ID
     * @param avatar 头像地址
     * @return 结果:true 更新成功，false 更新失败
     */
    @Override
    public boolean updateUserAvatar(Long userId, Long avatar) {
        QueryWrapper queryWrapper = query().where(SYS_USER.USER_ID.eq(userId));
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        sysUser.setAvatar(avatar);
        return this.update(sysUser, queryWrapper);
    }

    /**
     * 重置用户密码
     *
     * @param user 用户信息
     * @return 结果：true 操作成功，false 操作失败。
     */
    @Override
    public boolean resetPwd(SysUserBo user) {
        return UpdateChain.of(SysUser.class)
            .set(SysUser::getPassword, user.getPassword())
            .where(SysUser::getUserId).eq(user.getUserId())
            .and(SysUser::getVersion).eq(user.getVersion())  //手动添加乐观锁条件
            .update();
    }

    /**
     * 新增用户角色信息
     *
     * @param user 用户对象
     */
    public void insertUserRole(SysUser user) {
        if (ObjectUtil.isNotEmpty(user.getUserId()) && ObjectUtil.isNotEmpty(user.getRoleIds())) {
            userRoleService.insertUserRoles(user.getUserId(), user.getRoleIds());
        }
    }

    /**
     * 新增用户岗位信息
     *
     * @param user 用户对象
     */
    public boolean insertUserPost(SysUser user) {
        boolean inserted = true;
        Long[] posts = user.getPostIds();
        if (ObjectUtil.isNotEmpty(posts)) {
            // 新增用户与岗位管理
            List<SysUserPost> list = new ArrayList<>(posts.length);
            for (Long postId : posts) {
                SysUserPost up = new SysUserPost();
                up.setUserId(user.getUserId());
                up.setPostId(postId);
                list.add(up);
            }
            if (!list.isEmpty()) {
                return userPostService.saveBatchWithPk(list, 100);//批量保存
            }
        }
        return inserted;
    }

    /**
     * 批量删除用户信息
     *
     * @param userIds 需要删除的用户ID
     * @return 结果：true 更新成功，false 更新失败。
     */
    @Override
    @Transactional
    public boolean deleteUserByIds(Long[] userIds) {
        for (Long userId : userIds) {
            checkUserAllowed(userId);
            checkUserDataScope(userId);
        }
        // 删除用户与角色关联
        userRoleService.deleteUserRole(userIds);
        // 删除用户与岗位关联
        userPostService.deleteUserPost(userIds);

        //逻辑删除：UPDATE `sys_user` SET `del_flag` = 1 WHERE (`user_id` = 101810794781507584 ) AND `del_flag` = 0 AND `tenant_id` = 0
        return this.removeByIds(Arrays.asList(userIds));
    }

    /**
     * 导入用户数据
     *
     * @param userList        用户数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operId          操作用户ID
     * @return 结果
     */
    @Override
    public String importUser(List<SysUser> userList, Boolean isUpdateSupport, Long operId) {
        if (StringUtils.isNull(userList) || userList.isEmpty()) {
            throw new ServiceException("导入用户数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        String initPassword = configService.selectConfigByKey("sys.user.initPassword").getConfigValue();
        for (SysUser user : userList) {
            try {
                // 验证是否存在这个用户
                SysUserVo u = selectUserByUserName(user.getUserName());
                if (StringUtils.isNull(u)) {
                    BeanValidators.validateWithException(validator, user);
                    user.setPassword(BCrypt.hashpw(initPassword));
                    user.setCreateBy(operId);
                    this.save(user);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、账号 " + user.getUserName() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, user);
                    checkUserAllowed(u.getUserId());
                    checkUserDataScope(u.getUserId());
                    user.setVersion(u.getVersion());
                    user.setUserId(u.getUserId());
                    user.setUpdateBy(operId);
                    this.updateById(user);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、账号 " + user.getUserName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、账号 " + user.getUserName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、账号 " + user.getUserName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

    /**
     * 通过用户ID查询用户账户
     *
     * @param userId 用户ID
     * @return 用户账户
     */
    @Cacheable(cacheNames = CacheNames.SYS_USER_NAME, key = "#userId")
    @Override
    public String selectUserNameById(Long userId) {
        SysUserVo sysUser = selectUserById(userId);
        return ObjectUtil.isNull(sysUser) ? null : sysUser.getUserName();
    }

    /**
     * 通过部门id查询当前部门所有用户
     *
     * @param deptId 部门主键
     * @return 用户vo列表
     */
    @Override
    public List<SysUserVo> selectUserListByDept(Long deptId) {
        QueryWrapper queryWrapper = query().where(SYS_USER.DEPT_ID.eq(deptId)).and(SYS_USER.DEL_FLAG.eq(0));
        return this.listAs(queryWrapper, SysUserVo.class);
    }
}
