-- -- 升级 from V5.0.0 to V5.1.0:

-- 修正修改PostgreSQL数据库结构：由integer修改为text类型：
ALTER TABLE "pj_instance_info"
ALTER COLUMN "instance_params" TYPE TEXT,
	ALTER COLUMN "instance_params" DROP NOT NULL,
	ALTER COLUMN "instance_params" DROP DEFAULT;
COMMENT ON COLUMN "pj_instance_info"."instance_params" IS '';
ALTER TABLE "pj_instance_info"
ALTER COLUMN "job_params" TYPE TEXT,
	ALTER COLUMN "job_params" DROP NOT NULL,
	ALTER COLUMN "job_params" DROP DEFAULT;
COMMENT ON COLUMN "pj_instance_info"."job_params" IS '';
ALTER TABLE "pj_instance_info"
ALTER COLUMN "result" TYPE TEXT,
	ALTER COLUMN "result" DROP NOT NULL,
	ALTER COLUMN "result" DROP DEFAULT;
COMMENT ON COLUMN "pj_instance_info"."result" IS '';

ALTER TABLE "pj_job_info"
ALTER COLUMN "job_params" TYPE TEXT,
	ALTER COLUMN "job_params" DROP NOT NULL,
	ALTER COLUMN "job_params" DROP DEFAULT;
COMMENT ON COLUMN "pj_job_info"."job_params" IS '';

-- 添加乐观锁字段
ALTER TABLE "mf_goods" ADD "version" INTEGER NULL DEFAULT 0;
COMMENT ON COLUMN "mf_goods"."version" IS '乐观锁';

-- ----------------------------
-- 第三方平台授权表
-- ----------------------------
drop table if exists sys_social;
create table if not exists sys_social
(
    social_id          bigint           not null,
    user_id            bigint           not null,
    tenant_id          bigint           NOT NULL DEFAULT '0',
    auth_id            varchar(255)     not null,
    source             varchar(255)     not null,
    open_id            varchar(255)     default null::varchar,
    user_name          varchar(30)      not null,
    nick_name          varchar(30)      default ''::varchar,
    email              varchar(255)     default ''::varchar,
    avatar             varchar(500)     default ''::varchar,
    access_token       varchar(255)     not null,
    expire_in          bigint           default null,
    refresh_token      varchar(255)     default null::varchar,
    access_code        varchar(255)     default null::varchar,
    union_id           varchar(255)     default null::varchar,
    scope              varchar(255)     default null::varchar,
    token_type         varchar(255)     default null::varchar,
    id_token           varchar(255)     default null::varchar,
    mac_algorithm      varchar(255)     default null::varchar,
    mac_key            varchar(255)     default null::varchar,
    code               varchar(255)     default null::varchar,
    oauth_token        varchar(255)     default null::varchar,
    oauth_token_secret varchar(255)     default null::varchar,
    "version"           INTEGER NULL DEFAULT 0,
    "del_flag"          SMALLINT NULL DEFAULT '0',
    create_by          bigint,
    create_time        timestamp,
    update_by          bigint,
    update_time        timestamp,
    constraint "pk_sys_social" primary key (social_id)
    );

comment on table   sys_social                   is '社会化关系表';
comment on column  sys_social.social_id         is '主键';
comment on column  sys_social.user_id           is '用户ID';
comment on column  sys_social.tenant_id         is '租户id';
comment on column  sys_social.auth_id           is '平台+平台唯一id';
comment on column  sys_social.source            is '用户来源';
comment on column  sys_social.open_id           is '平台编号唯一id';
comment on column  sys_social.user_name         is '登录账号';
comment on column  sys_social.nick_name         is '用户昵称';
comment on column  sys_social.email             is '用户邮箱';
comment on column  sys_social.avatar            is '头像地址';
comment on column  sys_social.access_token      is '用户的授权令牌';
comment on column  sys_social.expire_in         is '用户的授权令牌的有效期，部分平台可能没有';
comment on column  sys_social.refresh_token     is '刷新令牌，部分平台可能没有';
comment on column  sys_social.access_code       is '平台的授权信息，部分平台可能没有';
comment on column  sys_social.union_id          is '用户的 unionid';
comment on column  sys_social.scope             is '授予的权限，部分平台可能没有';
comment on column  sys_social.token_type        is '个别平台的授权信息，部分平台可能没有';
comment on column  sys_social.id_token          is 'id token，部分平台可能没有';
comment on column  sys_social.mac_algorithm     is '小米平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.mac_key           is '小米平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.code              is '用户的授权code，部分平台可能没有';
comment on column  sys_social.oauth_token       is 'Twitter平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.oauth_token_secret is 'Twitter平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.version           is '乐观锁';
comment on column  sys_social.del_flag          is '逻辑删除标志（0代表存在 1代表删除）';
comment on column  sys_social.create_by         is '创建者';
comment on column  sys_social.create_time       is '创建时间';
comment on column  sys_social.update_by         is '更新者';
comment on column  sys_social.update_time       is '更新时间';

-- tenant_id由0修改为1
UPDATE "public"."sys_tenant" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."mf_customer" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."mf_goods" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."mf_product" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."mf_student" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_config" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_dept" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_dict_data" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_dict_type" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_logininfor" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_notice" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_oper_log" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_oss" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_oss_config" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_post" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_role" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_social" SET "tenant_id"=1 WHERE  "tenant_id"=0;
UPDATE "public"."sys_user" SET "tenant_id"=1 WHERE  "tenant_id"=0;

-- -- 升级 from V5.1.0 to V5.2.0:
-- 修改数据库id_token字段宽度
ALTER TABLE "sys_social"
ALTER COLUMN "id_token" TYPE VARCHAR(2000),
	ALTER COLUMN "id_token" DROP NOT NULL,
	ALTER COLUMN "id_token" SET DEFAULT NULL::character varying;
COMMENT ON COLUMN "sys_social"."id_token" IS 'id token，部分平台可能没有';

-- 数据库超级管理员的role_key由admin修改为SuperAdminRole
UPDATE "public"."sys_role" SET "role_key"='SuperAdminRole' WHERE  "role_id"=1;

-- retry server控制台
insert into sys_menu values('130',  'EasyRetry控制台',  '2',   '6',  'easyretry',     'monitor/easyretry/index',    '', '1', '0', 'C', '0', '0', 'monitor:easyretry:list',          'job',           103, 1, now(), null, null, 'EasyRetry控制台菜单');

-- 增加ancestors字段
ALTER TABLE "mf_product" ADD "ancestors" VARCHAR(760) NULL;
COMMENT ON COLUMN "mf_product"."ancestors" IS '祖级列表';

-- 增加edit_columns字段
ALTER TABLE "gen_table" ADD "edit_columns" SMALLINT NULL DEFAULT '1';
COMMENT ON COLUMN "gen_table"."edit_columns" IS '编辑列数';
