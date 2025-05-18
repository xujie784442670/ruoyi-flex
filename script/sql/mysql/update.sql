-- -- 升级 from V5.0.0 to V5.1.0:

-- ----------------------------
-- 第三方平台授权表
-- ----------------------------
drop table if exists sys_social;
create table sys_social
(
    social_id          bigint           not null        comment '主键',
    user_id            bigint           not null        comment '用户ID',
    tenant_id          varchar(20)      default null    comment '租户id',
    auth_id            varchar(255)     not null        comment '平台+平台唯一id',
    source             varchar(255)     not null        comment '用户来源',
    open_id            varchar(255)     default null    comment '平台编号唯一id',
    user_name          varchar(30)      not null        comment '登录账号',
    nick_name          varchar(30)      default ''      comment '用户昵称',
    email              varchar(255)     default ''      comment '用户邮箱',
    avatar             varchar(500)     default ''      comment '头像地址',
    access_token       varchar(255)     not null        comment '用户的授权令牌',
    expire_in          int              default null    comment '用户的授权令牌的有效期，部分平台可能没有',
    refresh_token      varchar(255)     default null    comment '刷新令牌，部分平台可能没有',
    access_code        varchar(255)     default null    comment '平台的授权信息，部分平台可能没有',
    union_id           varchar(255)     default null    comment '用户的 unionid',
    scope              varchar(255)     default null    comment '授予的权限，部分平台可能没有',
    token_type         varchar(255)     default null    comment '个别平台的授权信息，部分平台可能没有',
    id_token           varchar(255)     default null    comment 'id token，部分平台可能没有',
    mac_algorithm      varchar(255)     default null    comment '小米平台用户的附带属性，部分平台可能没有',
    mac_key            varchar(255)     default null    comment '小米平台用户的附带属性，部分平台可能没有',
    code               varchar(255)     default null    comment '用户的授权code，部分平台可能没有',
    oauth_token        varchar(255)     default null    comment 'Twitter平台用户的附带属性，部分平台可能没有',
    oauth_token_secret varchar(255)     default null    comment 'Twitter平台用户的附带属性，部分平台可能没有',
    `version`           int             DEFAULT '0'     COMMENT '乐观锁',
    `del_flag`          smallint        DEFAULT '0'     COMMENT '删除标志（0代表存在 1代表删除）',
    create_by          bigint(20)                       comment '创建者',
    create_time        datetime                         comment '创建时间',
    update_by          bigint(20)                       comment '更新者',
    update_time        datetime                         comment '更新时间',
    PRIMARY KEY (social_id)
) engine=innodb comment = '社会化关系表';

-- tenant_id由0修改为1
UPDATE `sys_tenant` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `mf_customer` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `mf_goods` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `mf_product` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `mf_student` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_config` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_dept` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_dict_data` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_dict_type` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_logininfor` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_notice` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_oper_log` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_oss` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_oss_config` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_post` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_role` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_social` SET `tenant_id`=1 WHERE  `tenant_id`=0;
UPDATE `sys_user` SET `tenant_id`=1 WHERE  `tenant_id`=0;

-- -- 升级 from V5.1.0 to V5.2.0:
-- 修改数据库id_token字段宽度
ALTER TABLE `sys_social`
    CHANGE COLUMN `id_token` `id_token` VARCHAR(2000) NULL DEFAULT NULL COMMENT 'id token，部分平台可能没有' COLLATE 'utf8mb4_bin' AFTER `token_type`;

-- 数据库超级管理员的role_key由admin修改为SuperAdminRole
UPDATE `sys_role` SET `role_key`='SuperAdminRole' WHERE  `role_id`=1;

-- retry server控制台
insert into sys_menu values('130',  'EasyRetry控制台',  '2',   '6',  'easyretry',     'monitor/easyretry/index',    '', 1, 0, 'C', '0', '0', 'monitor:easyretry:list',          'job',           103, 1, sysdate(), null, null, 'EasyRetry控制台菜单');

-- 增加ancestors字段
ALTER TABLE `mf_product` ADD COLUMN `ancestors` VARCHAR(760) NULL DEFAULT '' COMMENT '祖级列表' AFTER `parent_id`;
ALTER TABLE `demo_product` ADD COLUMN `ancestors` VARCHAR(760) NULL DEFAULT '' COMMENT '祖级列表' AFTER `parent_id`;

-- 增加edit_columns字段
ALTER TABLE `gen_table` ADD COLUMN `edit_columns` TINYINT NULL DEFAULT 1 AFTER `remark`;
