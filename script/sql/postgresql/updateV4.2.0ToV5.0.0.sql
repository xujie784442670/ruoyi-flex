-- -- 升级 from V4.2.0 to V5.0.0:
-- 修正“任务调度”的“任务管理”错误：
UPDATE "public"."pj_job_info" SET "alarm_config"='{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', "log_config"='{"type":1}', "processor_info"='com.ruoyi.job.processors.StandaloneProcessorDemo' WHERE  "id"=1;
UPDATE "public"."pj_job_info" SET "alarm_config"='{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', "log_config"='{"type":1}', "processor_info"='com.ruoyi.job.processors.BroadcastProcessorDemo' WHERE  "id"=2;
UPDATE "public"."pj_job_info" SET "alarm_config"='{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', "log_config"='{"type":1}', "processor_info"='com.ruoyi.job.processors.MapProcessorDemo' WHERE  "id"=3;
UPDATE "public"."pj_job_info" SET "alarm_config"='{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', "log_config"='{"type":1}', "processor_info"='com.ruoyi.job.processors.MapReduceProcessorDemo' WHERE  "id"=4;

-- 修改powerjob的库结构的错误oid类型为text类型；
ALTER TABLE "pj_workflow_info"
ALTER COLUMN "pedag" TYPE TEXT,
	ALTER COLUMN "pedag" DROP NOT NULL,
	ALTER COLUMN "pedag" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_info"."pedag" IS '';
ALTER TABLE "pj_workflow_instance_info"
ALTER COLUMN "dag" TYPE TEXT,
	ALTER COLUMN "dag" DROP NOT NULL,
	ALTER COLUMN "dag" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_instance_info"."dag" IS '';
ALTER TABLE "pj_workflow_instance_info"
ALTER COLUMN "result" TYPE TEXT,
	ALTER COLUMN "result" DROP NOT NULL,
	ALTER COLUMN "result" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_instance_info"."result" IS '';
ALTER TABLE "pj_workflow_instance_info"
ALTER COLUMN "wf_context" TYPE TEXT,
	ALTER COLUMN "wf_context" DROP NOT NULL,
	ALTER COLUMN "wf_context" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_instance_info"."wf_context" IS '';
ALTER TABLE "pj_workflow_instance_info"
ALTER COLUMN "wf_init_params" TYPE TEXT,
	ALTER COLUMN "wf_init_params" DROP NOT NULL,
	ALTER COLUMN "wf_init_params" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_instance_info"."wf_init_params" IS '';
ALTER TABLE "pj_workflow_node_info"
ALTER COLUMN "extra" TYPE TEXT,
	ALTER COLUMN "extra" DROP NOT NULL,
	ALTER COLUMN "extra" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_node_info"."extra" IS '';
ALTER TABLE "pj_workflow_node_info"
ALTER COLUMN "node_params" TYPE TEXT,
	ALTER COLUMN "node_params" DROP NOT NULL,
	ALTER COLUMN "node_params" DROP DEFAULT;
COMMENT ON COLUMN "pj_workflow_node_info"."node_params" IS '';

-- 升级“文件管理配置”相关脚本
delete from sys_menu where menu_id in (1604, 1605);
insert into sys_menu values('1600', '文件查询', '118', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:query',        '#', 1, now(), null, null, '');
insert into sys_menu values('1601', '文件上传', '118', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:upload',       '#', 1, now(), null, null, '');
insert into sys_menu values('1602', '文件下载', '118', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:download',     '#', 1, now(), null, null, '');
insert into sys_menu values('1603', '文件删除', '118', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:remove',       '#', 1, now(), null, null, '');
insert into sys_menu values('1620', '配置列表', '118', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:list',   '#', 1, now(), null, null, '');
insert into sys_menu values('1621', '配置添加', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:add',    '#', 1, now(), null, null, '');
insert into sys_menu values('1622', '配置编辑', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:edit',   '#', 1, now(), null, null, '');
insert into sys_menu values('1623', '配置删除', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:remove', '#', 1, now(), null, null, '');

-- postgresql创建与mysql等效的的find_in_set函数
CREATE OR REPLACE FUNCTION find_in_set(
		value anyelement,
		string_list text)
		RETURNS integer
		LANGUAGE 'plpgsql'
		COST 100
		VOLATILE PARALLEL UNSAFE
	AS $BODY$
	DECLARE
position INTEGER;
BEGIN
		IF string_list = '' THEN
			RETURN 0;
ELSE
			position := array_position(string_to_array(string_list, ','), value::TEXT);
RETURN position;
END IF;
END;
$BODY$;

-- 租户套餐表
drop table if exists sys_tenant_package;
create table if not exists sys_tenant_package
(
    package_id          bigint,
    package_name        varchar(20)     default ''::varchar,
    menu_ids            varchar(3000)   default ''::varchar,
    remark              varchar(200)    default ''::varchar,
    menu_check_strictly boolean         default true,
    status              char            default '0'::bpchar,
    del_flag            smallint        default  0,
    create_by           bigint,
    create_time         timestamp,
    update_by           bigint,
    update_time         timestamp,
    constraint "pk_sys_tenant_package" primary key (package_id)
);
comment on table   sys_tenant_package                    is '租户套餐表';
comment on column  sys_tenant_package.package_id         is '租户套餐id';
comment on column  sys_tenant_package.package_name       is '套餐名称';
comment on column  sys_tenant_package.menu_ids           is '关联菜单id';
comment on column  sys_tenant_package.remark             is '备注';
comment on column  sys_tenant_package.status             is '状态（0正常 1停用）';
comment on column  sys_tenant_package.del_flag           is '删除标志（0代表存在 1代表删除）';
comment on column  sys_tenant_package.create_by          is '创建者';
comment on column  sys_tenant_package.create_time        is '创建时间';
comment on column  sys_tenant_package.update_by          is '更新者';
comment on column  sys_tenant_package.update_time        is '更新时间';

-- 租户表
drop table if exists sys_tenant;
create table if not exists sys_tenant
(
    tenant_id         bigint        not null,
    contact_user_name varchar(20)   default null::varchar,
    contact_phone     varchar(20)   default null::varchar,
    company_name      varchar(50)   default null::varchar,
    license_number    varchar(30)   default null::varchar,
    address           varchar(200)  default null::varchar,
    intro             varchar(200)  default null::varchar,
    domain            varchar(200)  default null::varchar,
    remark            varchar(200)  default null::varchar,
    package_id        bigint,
    expire_time       timestamp,
    account_count     integer       default -1,
    status            char          default '0'::bpchar,
    del_flag          smallint      default  0,
    create_by         bigint,
    create_time       timestamp,
    update_by         bigint,
    update_time       timestamp,
    constraint "pk_sys_tenant" primary key (tenant_id)
);
comment on table   sys_tenant                    is '租户表';
comment on column  sys_tenant.tenant_id          is '租户编号';
comment on column  sys_tenant.contact_user_name  is '联系人';
comment on column  sys_tenant.contact_phone      is '联系电话';
comment on column  sys_tenant.company_name       is '企业名称';
comment on column  sys_tenant.license_number     is '统一社会信用代码';
comment on column  sys_tenant.address            is '地址';
comment on column  sys_tenant.intro              is '企业简介';
comment on column  sys_tenant.domain             is '域名';
comment on column  sys_tenant.remark             is '备注';
comment on column  sys_tenant.package_id         is '租户套餐编号';
comment on column  sys_tenant.expire_time        is '过期时间';
comment on column  sys_tenant.account_count      is '用户数量（-1不限制）';
comment on column  sys_tenant.status             is '租户状态（0正常 1停用）';
comment on column  sys_tenant.del_flag           is '删除标志（0代表存在 1代表删除）';
comment on column  sys_tenant.create_by          is '创建者';
comment on column  sys_tenant.create_time        is '创建时间';
comment on column  sys_tenant.update_by          is '更新者';
comment on column  sys_tenant.update_time        is '更新时间';
-- 初始化-租户表数据
insert into sys_tenant values(0,  '联系人', '16888888888', 'Ruoyi-Flex公司', null, null, '多租户通用后台管理管理系统', null, null, null, null, -1, '0', 0, 1, now(), null, null);

-- 租户菜单
insert into sys_menu values('6', '租户管理', '0', '2', 'tenant',           null, '', '1', '0', 'M', '0', '0', '', 'chart', 1, now(), null, null, '租户管理目录');
insert into sys_menu values('121',  '租户管理',     '6',   '1', 'tenant',           'system/tenant/index',          '', '1', '0', 'C', '0', '0', 'system:tenant:list',          'list',  1, now(), null, null, '租户管理菜单');
insert into sys_menu values('122',  '租户套餐管理', '6',   '2', 'tenantPackage',    'system/tenantPackage/index',   '', '1', '0', 'C', '0', '0', 'system:tenantPackage:list',   'form',  1, now(), null, null, '租户套餐管理菜单');

-- 租户管理相关按钮
insert into sys_menu values('1606', '租户查询', '121', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:query',   '#', 1, now(), null, null, '');
insert into sys_menu values('1607', '租户新增', '121', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:add',     '#', 1, now(), null, null, '');
insert into sys_menu values('1608', '租户修改', '121', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:edit',    '#', 1, now(), null, null, '');
insert into sys_menu values('1609', '租户删除', '121', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:remove',  '#', 1, now(), null, null, '');
insert into sys_menu values('1610', '租户导出', '121', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:export',  '#', 1, now(), null, null, '');
-- 租户套餐管理相关按钮
insert into sys_menu values('1611', '租户套餐查询', '122', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:query',   '#', 1, now(), null, null, '');
insert into sys_menu values('1612', '租户套餐新增', '122', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:add',     '#', 1, now(), null, null, '');
insert into sys_menu values('1613', '租户套餐修改', '122', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:edit',    '#', 1, now(), null, null, '');
insert into sys_menu values('1614', '租户套餐删除', '122', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:remove',  '#', 1, now(), null, null, '');
insert into sys_menu values('1615', '租户套餐导出', '122', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:export',  '#', 1, now(), null, null, '');

ALTER TABLE "sys_role" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_role"."tenant_id" IS '租户编号';

ALTER TABLE "sys_dept" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_dept"."tenant_id" IS '租户编号';

ALTER TABLE "sys_dict_type"	ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_dict_type"."tenant_id" IS '租户编号';

DROP INDEX sys_dict_type_index1;
CREATE UNIQUE INDEX sys_dict_type_index1 ON sys_dict_type(tenant_id, dict_type);

ALTER TABLE "sys_dict_data"	ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_dict_data"."tenant_id" IS '租户编号';

ALTER TABLE "sys_config"	ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_config"."tenant_id" IS '租户编号';

ALTER TABLE "sys_user"
    ALTER COLUMN "email" TYPE VARCHAR(50),
    ALTER COLUMN "email" SET NOT NULL,
    ALTER COLUMN "email" SET DEFAULT '';
COMMENT ON COLUMN "sys_user"."email" IS '用户邮箱';

DROP INDEX if exists sys_user_unqindex_tenant_username;
CREATE UNIQUE INDEX sys_user_unqindex_tenant_username ON sys_user(tenant_id, user_name);

-- 修改“超级用户”为"superadmin"
UPDATE sys_user SET user_name='superadmin',nick_name='超级管理员' WHERE user_id=1;

ALTER TABLE "sys_logininfor"
    ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_logininfor"."tenant_id" IS '租户编号';
ALTER TABLE "sys_logininfor"
    ADD "client_key" VARCHAR(32) NULL DEFAULT '';
COMMENT ON COLUMN "sys_logininfor"."client_key" IS '客户端';
ALTER TABLE "sys_logininfor"
    ADD "device_type" VARCHAR(32) NULL DEFAULT '';
COMMENT ON COLUMN "sys_logininfor"."device_type" IS '设备类型';

-- 客户端管理菜单
insert into sys_menu values('123',  '客户端管理',   '1',   '11', 'client',           'system/client/index',          '', '1', '0', 'C', '0', '0', 'system:client:list',          'international', 1, now(), null, null, '客户端管理菜单');
-- 客户端管理按钮
insert into sys_menu values('1061', '客户端管理查询', '123', '1',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:query',        '#', 1, now(), null, null, '');
insert into sys_menu values('1062', '客户端管理新增', '123', '2',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:add',          '#', 1, now(), null, null, '');
insert into sys_menu values('1063', '客户端管理修改', '123', '3',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:edit',         '#', 1, now(), null, null, '');
insert into sys_menu values('1064', '客户端管理删除', '123', '4',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:remove',       '#', 1, now(), null, null, '');
insert into sys_menu values('1065', '客户端管理导出', '123', '5',  '#', '', '', '1', '0', 'F', '0', '0', 'system:client:export',       '#', 1, now(), null, null, '');

-- 操作日志租户编号
ALTER TABLE "sys_oper_log"   ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_oper_log"."tenant_id" IS '租户编号';

-- 岗位
ALTER TABLE "sys_post" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_post"."tenant_id" IS '租户编号';

-- 通知公告
ALTER TABLE "sys_notice" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_notice"."tenant_id" IS '租户编号';

-- 文件管理
ALTER TABLE "sys_oss_config" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_oss_config"."tenant_id" IS '租户编码';
ALTER TABLE "sys_oss" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "sys_oss"."tenant_id" IS '租户编码';

-- 演示表
ALTER TABLE "mf_student"  ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_student"."tenant_id" IS '租户编码';
ALTER TABLE "mf_product"  ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_product"."tenant_id" IS '租户编码';
ALTER TABLE "mf_customer" ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_customer"."tenant_id" IS '租户编码';
ALTER TABLE "mf_goods"   ADD "tenant_id" BIGINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_goods"."tenant_id" IS '租户编码';

-- 添加乐观锁字段
ALTER TABLE "gen_table"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "gen_table"."version" IS '乐观锁';
ALTER TABLE "gen_table_column"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "gen_table_column"."version" IS '乐观锁';
ALTER TABLE "sys_client"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_client"."version" IS '乐观锁';
ALTER TABLE "sys_config" ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_config"."version" IS '乐观锁';
ALTER TABLE "sys_dept"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_dept"."version" IS '乐观锁';
ALTER TABLE "sys_dict_data"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_dict_data"."version" IS '乐观锁';
ALTER TABLE "sys_dict_type"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_dict_type"."version" IS '乐观锁';
ALTER TABLE "sys_menu"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_menu"."version" IS '乐观锁';
ALTER TABLE "sys_notice"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_notice"."version" IS '乐观锁';
ALTER TABLE "sys_oss"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_oss"."version" IS '乐观锁';
ALTER TABLE "sys_oss_config"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_oss_config"."version" IS '乐观锁';
ALTER TABLE "sys_post"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_post"."version" IS '乐观锁';
ALTER TABLE "sys_role"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_role"."version" IS '乐观锁';
ALTER TABLE "sys_tenant"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_tenant"."version" IS '乐观锁';
ALTER TABLE "sys_tenant_package"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_tenant_package"."version" IS '乐观锁';
ALTER TABLE "sys_user"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "sys_user"."version" IS '乐观锁';

-- 演示示例增加乐观锁、逻辑删除字段
ALTER TABLE "mf_student"  ADD "version" INTEGER NULL DEFAULT '0';
COMMENT ON COLUMN "mf_student"."version" IS '乐观锁';
ALTER TABLE "mf_student"  ADD "del_flag" SMALLINT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_student"."del_flag" IS '逻辑删除标志（0代表存在 1代表删除）';
ALTER TABLE "mf_product"  ADD "version" INTEGER NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_product"."version" IS '乐观锁';
ALTER TABLE "mf_product"  ADD "del_flag" SMALLINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_product"."del_flag" IS '逻辑删除标志（0代表存在 1代表删除）';
ALTER TABLE "mf_customer" ADD "version" INTEGER NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_customer"."version" IS '乐观锁';
ALTER TABLE "mf_customer" ADD "del_flag" SMALLINT NOT NULL DEFAULT '0';
COMMENT ON COLUMN "mf_customer"."del_flag" IS '逻辑删除标志（0代表存在 1代表删除）';

--修改重复的tenant
UPDATE "sys_menu" SET "path"='tenantMenu' WHERE  "menu_id"=121;
