-- V4.1.8升级到V4.2.0：
-- sys_menu菜单表结构修改、去掉主键自增
ALTER TABLE `sys_menu`
	CHANGE COLUMN `menu_id` `menu_id` BIGINT(19) NOT NULL COMMENT '菜单ID' FIRST,
	CHANGE COLUMN `order_num` `order_num` INT(4) NULL DEFAULT '0' COMMENT '显示顺序' AFTER `parent_id`,
	CHANGE COLUMN `query` `query_param` VARCHAR(255) NULL DEFAULT NULL COMMENT '路由参数' COLLATE 'utf8mb4_bin' AFTER `component`,
	CHANGE COLUMN `is_frame` `is_frame` INT(1) NULL DEFAULT '1' COMMENT '是否为外链（0是 1否）' AFTER `query_param`,
	CHANGE COLUMN `is_cache` `is_cache` INT(1) NULL DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）' AFTER `is_frame`;
-- gen_table表去掉主键自增
ALTER TABLE `gen_table`
    CHANGE COLUMN `table_id` `table_id` BIGINT(19) NOT NULL COMMENT '编号' FIRST;
-- gen_table_column表去掉主键自增
ALTER TABLE `gen_table_column`
    CHANGE COLUMN `column_id` `column_id` BIGINT(19) NOT NULL COMMENT '编号' FIRST;

ALTER TABLE `sys_tenant` DROP COLUMN `create_dept`;

-- 修改数据库表的del_flag字段为smallint类型
ALTER TABLE `sys_client`
    CHANGE COLUMN `del_flag` `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）' COLLATE 'utf8mb4_bin' AFTER `status`;
ALTER TABLE `sys_dept`
    CHANGE COLUMN `del_flag` `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）' COLLATE 'utf8mb4_bin' AFTER `status`;
ALTER TABLE `sys_role`
    CHANGE COLUMN `del_flag` `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）' COLLATE 'utf8mb4_bin' AFTER `status`;
ALTER TABLE `sys_tenant`
    CHANGE COLUMN `del_flag` `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）' COLLATE 'utf8mb4_bin' AFTER `status`;
ALTER TABLE `sys_user`
    CHANGE COLUMN `del_flag` `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）' COLLATE 'utf8mb4_bin' AFTER `status`;

-- -- 升级 from V4.2.0 to V5.0.0:
-- 修正“任务调度”的“任务管理”错误：
UPDATE `pj_job_info` SET `processor_info`='com.ruoyi.job.processors.StandaloneProcessorDemo' WHERE  `id`=1;
UPDATE `pj_job_info` SET `processor_info`='com.ruoyi.job.processors.BroadcastProcessorDemo' WHERE  `id`=2;
UPDATE `pj_job_info` SET `processor_info`='com.ruoyi.job.processors.MapProcessorDemo' WHERE  `id`=3;
UPDATE `pj_job_info` SET `processor_info`='com.ruoyi.job.processors.MapReduceProcessorDemo' WHERE  `id`=4;

-- 升级“文件管理配置”相关脚本
ALTER TABLE `sys_menu`
    CHANGE COLUMN `update_by` `update_by` BIGINT(19) NULL DEFAULT '0' COMMENT '更新者' AFTER `create_time`;
delete from sys_menu where menu_id in (1604, 1605);
insert into sys_menu values('1600', '文件查询', '118', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:query',        '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1601', '文件上传', '118', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:upload',       '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1602', '文件下载', '118', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:download',     '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1603', '文件删除', '118', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:remove',       '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1620', '配置列表', '118', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:list',   '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1621', '配置添加', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:add',    '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1622', '配置编辑', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:edit',   '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1623', '配置删除', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:remove', '#', 1, sysdate(), null, null, '');

-- 租户套餐表
drop table if exists sys_tenant_package;
create table sys_tenant_package (
    package_id              bigint    not null         comment '租户套餐id',
    package_name            varchar(20)                comment '套餐名称',
    menu_ids                varchar(3000)              comment '关联菜单id',
    remark                  varchar(200)               comment '备注',
    menu_check_strictly     tinyint(1)     default 1   comment '菜单树选择项是否关联显示',
    status                  char(1)        default '0' comment '状态（0正常 1停用）',
    del_flag                SMALLINT       default '0' comment '删除标志（0代表存在 1代表删除）',
    create_by               bigint                     comment '创建者',
    create_time             datetime                   comment '创建时间',
    update_by               bigint                     comment '更新者',
    update_time             datetime                   comment '更新时间',
    primary key (package_id)
) engine=innodb comment = '租户套餐表';

-- 租户表
drop table if exists sys_tenant;
create table sys_tenant
(
    tenant_id         bigint        not null        comment '租户编号',
    contact_user_name varchar(20)                   comment '联系人',
    contact_phone     varchar(20)                   comment '联系电话',
    company_name      varchar(50)                   comment '企业名称',
    license_number    varchar(30)                   comment '统一社会信用代码',
    address           varchar(200)                  comment '地址',
    intro             varchar(200)                  comment '企业简介',
    domain            varchar(200)                  comment '域名',
    remark            varchar(200)                  comment '备注',
    package_id        bigint                        comment '租户套餐编号',
    expire_time       datetime                      comment '过期时间',
    account_count     int           default -1      comment '用户数量（-1不限制）',
    status            char(1)       default '0'     comment '租户状态（0正常 1停用）',
    del_flag          SMALLINT      default '0'     comment '删除标志（0代表存在 1代表删除）',
    create_by         bigint                        comment '创建者',
    create_time       datetime                      comment '创建时间',
    update_by         bigint                        comment '更新者',
    update_time       datetime                      comment '更新时间',
    primary key (tenant_id)
) engine=innodb comment = '租户表';

-- 初始化-租户表数据
insert into sys_tenant values(0, '联系人', '16888888888', 'Ruoyi-Flex公司', null, null, '多租户通用后台管理管理系统', null, null, null, null, -1, '0', 0, 1, sysdate(), null, null);

-- 租户菜单
insert into sys_menu values('6', '租户管理', '0', '2', 'tenant',           null, '', '1', '0', 'M', '0', '0', '', 'chart', 1, sysdate(), null, null, '租户管理目录');
insert into sys_menu values('121',  '租户管理',     '6',   '1', 'tenant',           'system/tenant/index',          '', '1', '0', 'C', '0', '0', 'system:tenant:list',          'list',  1, sysdate(), null, null, '租户管理菜单');
insert into sys_menu values('122',  '租户套餐管理', '6',   '2', 'tenantPackage',    'system/tenantPackage/index',   '', '1', '0', 'C', '0', '0', 'system:tenantPackage:list',   'form',  1, sysdate(), null, null, '租户套餐管理菜单');

-- 租户管理相关按钮
insert into sys_menu values('1606', '租户查询', '121', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:query',   '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1607', '租户新增', '121', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:add',     '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1608', '租户修改', '121', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:edit',    '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1609', '租户删除', '121', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:remove',  '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1610', '租户导出', '121', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:export',  '#', 1, sysdate(), null, null, '');
-- 租户套餐管理相关按钮
insert into sys_menu values('1611', '租户套餐查询', '122', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:query',   '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1612', '租户套餐新增', '122', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:add',     '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1613', '租户套餐修改', '122', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:edit',    '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1614', '租户套餐删除', '122', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:remove',  '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1615', '租户套餐导出', '122', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:export',  '#', 1, sysdate(), null, null, '');

-- 添加tenant_id字段
ALTER TABLE `sys_role`  ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `role_id`;
ALTER TABLE `sys_dept`  ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `dept_id`;
ALTER TABLE `sys_dict_type` ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `dict_id`;
ALTER TABLE `sys_dict_type` DROP INDEX `dict_type`;
ALTER TABLE `sys_dict_type` ADD UNIQUE INDEX `dict_type_unq_idx` (`tenant_id`, `dict_type`);
ALTER TABLE `sys_dict_data` ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `dict_code`;
ALTER TABLE `sys_config`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `config_id`;
ALTER TABLE `sys_user`    CHANGE COLUMN `email` `email` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '用户邮箱' COLLATE 'utf8mb4_bin' AFTER `user_type`;
ALTER TABLE `sys_user`    ADD UNIQUE INDEX `sys_user_unqindex_tenant_username` (`tenant_id`, `user_name`);
-- 修改“超级用户”为"superadmin"
UPDATE sys_user SET tenant_id=0,user_name="superadmin",nick_name="超级管理员" WHERE user_id=1;

ALTER TABLE `sys_logininfor`
    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `info_id`,
	ADD COLUMN `client_key` VARCHAR(32) NULL DEFAULT '' COMMENT '客户端' AFTER `user_name`,
	ADD COLUMN `device_type` VARCHAR(32) NULL DEFAULT '' COMMENT '设备类型' AFTER `client_key`;

-- 客户端管理菜单
insert into sys_menu values('123',  '客户端管理',   '1',   '11', 'client',           'system/client/index',          '', '1', '0', 'C', '0', '0', 'system:client:list',          'international', 1, sysdate(), null, null, '客户端管理菜单');
-- 客户端管理按钮
insert into sys_menu values('1061', '客户端管理查询', '123', '1',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:query',        '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1062', '客户端管理新增', '123', '2',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:add',          '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1063', '客户端管理修改', '123', '3',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:edit',         '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1064', '客户端管理删除', '123', '4',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:remove',       '#', 1, sysdate(), null, null, '');
insert into sys_menu values('1065', '客户端管理导出', '123', '5',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:export',       '#', 1, sysdate(), null, null, '');

ALTER TABLE `sys_oper_log`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `oper_id`;
ALTER TABLE `sys_post`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `post_id`;
ALTER TABLE `sys_notice`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `notice_id`;
ALTER TABLE `sys_oss_config`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `oss_config_id`;
ALTER TABLE `sys_oss`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `oss_id`;

-- 演示表
ALTER TABLE `mf_student`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `student_id`;
ALTER TABLE `mf_product`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `product_id`;
ALTER TABLE `mf_customer`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `customer_id`;
ALTER TABLE `mf_goods`    ADD COLUMN `tenant_id` BIGINT NOT NULL DEFAULT '0' COMMENT '租户编号' AFTER `goods_id`;

-- 添加乐观锁字段
ALTER TABLE `gen_table` ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `options`;
ALTER TABLE `gen_table_column`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `sort`;
ALTER TABLE `sys_client`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;
ALTER TABLE `sys_config`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `config_type`;
ALTER TABLE `sys_dept`   ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;
ALTER TABLE `sys_dict_data`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `is_default`;
ALTER TABLE `sys_dict_type`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `dict_type`;
ALTER TABLE `sys_menu`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `icon`;
ALTER TABLE `sys_notice`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;
ALTER TABLE `sys_oss`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `service`;
ALTER TABLE `sys_oss_config`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `ext1`;
ALTER TABLE `sys_post`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;
ALTER TABLE `sys_role`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;
ALTER TABLE `sys_tenant` ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `account_count`;
ALTER TABLE `sys_tenant_package`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;
ALTER TABLE `sys_user`  ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`;

-- 演示模块增加乐观锁、逻辑删除字段
ALTER TABLE `mf_student` ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `student_birthday`,
	ADD COLUMN `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '逻辑删除标志（0代表存在 1代表删除）' AFTER `version`;
ALTER TABLE `mf_product` ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `status`,
	ADD COLUMN `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '逻辑删除标志（0代表存在 1代表删除）' AFTER `version`;
ALTER TABLE `mf_customer` ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `remark`,
	ADD COLUMN `del_flag` SMALLINT NULL DEFAULT '0' COMMENT '逻辑删除标志（0代表存在 1代表删除）' AFTER `version`;
ALTER TABLE `mf_goods`    ADD COLUMN `version` INT NULL DEFAULT '0' COMMENT '乐观锁' AFTER `type`;

--修改重复的tenant
UPDATE `sys_menu` SET `path`='tenantMenu' WHERE  `menu_id`=121;



