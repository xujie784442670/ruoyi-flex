drop table if exists demo_student;
create table if not exists demo_student (
  student_id BIGSERIAL,
  student_name varchar(30) not null,
  student_age integer,
  student_hobby varchar(30) not null,
  student_sex char not null,
  student_status char         default '0'::bpchar,
  student_birthday timestamp,   
  constraint "demo_student_pk" primary key (student_id)  
);
comment on table demo_student                   is '学生信息单表(mb)';
comment on column demo_student.student_id       is '编号';
comment on column demo_student.student_name     is '学生名称';
comment on column demo_student.student_age      is '年龄';
comment on column demo_student.student_hobby    is '爱好（0代码 1音乐 2电影）';
comment on column demo_student.student_sex   is '性别（1男 2女 3未知）';
comment on column demo_student.student_status   is '状态（0正常 1停用）';
comment on column demo_student.student_birthday is '生日';

drop table if exists demo_product;
create table if not exists demo_product (
  product_id BIGSERIAL NOT NULL,
  parent_id bigint  NULL DEFAULT 0,
  product_name varchar(30) NOT NULL,
  order_num INTEGER DEFAULT 0,
  status char(1) NULL DEFAULT '0',  
  constraint "demo_product_pk" PRIMARY KEY (product_id) 
);
comment on table demo_product                   is '产品树表(mb)';
comment on column demo_product.product_id       is '产品id';
comment on column demo_product.parent_id        is '父产品id';
comment on column demo_product.product_name     is '产品名称';
comment on column demo_product.order_num        is '显示顺序';
comment on column demo_product.status           is '产品状态（0正常 1停用）';

drop table if exists demo_customer;
create table if not exists demo_customer (
  customer_id BIGSERIAL NOT NULL,
  customer_name varchar(30) not null DEFAULT '',
  phonenumber varchar(11) NULL DEFAULT NULL,
  sex char(1)  NULL DEFAULT NULL,
  birthday TIMESTAMP NULL DEFAULT NULL,
  remark varchar(500) NULL DEFAULT NULL,  
  constraint "demo_customer_pk" PRIMARY KEY (customer_id)   
);
comment on table demo_customer                   is '客户主表(mb)';
comment on column demo_customer.customer_id      is '客户id';
comment on column demo_customer.customer_name    is '客户姓名';
comment on column demo_customer.phonenumber      is '手机号码';
comment on column demo_customer.sex              is '客户性别';
comment on column demo_customer.birthday         is '客户生日';
comment on column demo_customer.remark           is '客户描述';

DROP TABLE IF EXISTS demo_goods;
CREATE TABLE IF NOT EXISTS demo_goods (
  goods_id BIGSERIAL NOT NULL,
  customer_id bigint NOT NULL,
  name varchar(30) NULL DEFAULT NULL,
  weight INTEGER NULL DEFAULT 0,
  price decimal(6,2) NULL DEFAULT NULL,
  "date" timestamp NULL DEFAULT NULL,
  "type" char(1) NULL DEFAULT NULL,
  constraint "demo_goods_pk" PRIMARY KEY (goods_id)   
);
comment on table demo_goods                   is '商品子表(mb)';
comment on column demo_goods.goods_id         is '商品id';
comment on column demo_goods.customer_id      is '客户id';
comment on column demo_goods.name             is '商品名称';
comment on column demo_goods.weight           is '商品重量';
comment on column demo_goods.price            is '商品价格';
comment on column demo_goods."date"           is '商品时间';
comment on column demo_goods."type"           is '商品种类';

drop table if exists gen_table;
create table if not exists gen_table
(
    table_id          bigint,    
    table_name        varchar(200)  default ''::varchar,
    table_comment     varchar(500)  default ''::varchar,
    sub_table_name    varchar(64)   default ''::varchar,
    sub_table_fk_name varchar(64)   default ''::varchar,
    class_name        varchar(100)  default ''::varchar,
    tpl_category      varchar(200)  default 'crud'::varchar,
    package_name      varchar(100)  default null::varchar,
    module_name       varchar(30)   default null::varchar,
    business_name     varchar(30)   default null::varchar,
    function_name     varchar(50)   default null::varchar,
    function_author   varchar(50)   default null::varchar,
    gen_type          char          default '0'::bpchar not null,
    gen_path          varchar(200)  default '/'::varchar,
    options           varchar(1000) default null::varchar,   
    create_by         bigint,
    create_time       timestamp,
    update_by         bigint,
    update_time       timestamp,
    remark            varchar(500)  default null::varchar,
    constraint gen_table_pk primary key (table_id)
);

comment on table gen_table is '代码生成业务表';
comment on column gen_table.table_id is '编号';
comment on column gen_table.table_name is '表名称';
comment on column gen_table.table_comment is '表描述';
comment on column gen_table.sub_table_name is '关联子表的表名';
comment on column gen_table.sub_table_fk_name is '子表关联的外键名';
comment on column gen_table.class_name is '实体类名称';
comment on column gen_table.tpl_category is '使用的模板（CRUD单表操作 TREE树表操作）';
comment on column gen_table.package_name is '生成包路径';
comment on column gen_table.module_name is '生成模块名';
comment on column gen_table.business_name is '生成业务名';
comment on column gen_table.function_name is '生成功能名';
comment on column gen_table.function_author is '生成功能作者';
comment on column gen_table.gen_type is '生成代码方式（0zip压缩包 1自定义路径）';
comment on column gen_table.gen_path is '生成路径（不填默认项目路径）';
comment on column gen_table.options is '其它生成选项';
comment on column gen_table.create_by is '创建者';
comment on column gen_table.create_time is '创建时间';
comment on column gen_table.update_by is '更新者';
comment on column gen_table.update_time is '更新时间';
comment on column gen_table.remark is '备注';

INSERT INTO gen_table VALUES
	(13, 'mf_student', '学生信息单表', NULL, NULL, 'Student', 'crud', 'com.ruoyi.mf', 'mf', 'student', '学生信息表', '数据小王子', '0', '/', '{"parentMenuId":"2018"}', 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36', 'mybatis-flex版本的学生信息单表演示'),
	(15, 'mf_product', '产品树表', '', '', 'MfProduct', 'tree', 'com.ruoyi.mf', 'mf', 'product', '产品树', '数据小王子', '0', '/', '{"treeCode":"product_id","treeName":"product_name","treeParentCode":"parent_id","parentMenuId":"2018"}', 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43', 'mybatis-flex版本的产品树表演示'),
	(16, 'mf_customer', '客户主表', 'mf_goods', 'customer_id', 'Customer', 'sub', 'com.ruoyi.mf', 'mf', 'customer', '客户主表', '数据小王子', '0', '/', '{"parentMenuId":"2018"}', 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57', 'mybatis-flex格式的主子表测试'),
	(17, 'mf_goods', '商品子表', NULL, NULL, 'Goods', 'crud', 'com.ruoyi.demo', 'demo', 'goods', '商品子表', '数据小王子', '0', '/', '{}', 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30', NULL);

drop table if exists gen_table_column;
create table if not exists gen_table_column
(
    column_id      bigint,
    table_id       bigint,
    column_name    varchar(200) default null::varchar,
    column_comment varchar(500) default null::varchar,
    column_type    varchar(100) default null::varchar,
    java_type      varchar(500) default null::varchar,
    java_field     varchar(200) default null::varchar,
    is_pk          char         default null::bpchar,
    is_increment   char         default null::bpchar,
    is_required    char         default null::bpchar,
    is_insert      char         default null::bpchar,
    is_edit        char         default null::bpchar,
    is_list        char         default null::bpchar,
    is_query       char         default null::bpchar,
    query_type     varchar(200) default 'EQ'::varchar,
    html_type      varchar(200) default null::varchar,
    dict_type      varchar(200) default ''::varchar,
    sort           int4,    
    create_by      bigint,
    create_time    timestamp,
    update_by      bigint,
    update_time    timestamp,
    constraint gen_table_column_pk primary key (column_id)
);

comment on table gen_table_column is '代码生成业务表字段';
comment on column gen_table_column.column_id is '编号';
comment on column gen_table_column.table_id is '归属表编号';
comment on column gen_table_column.column_name is '列名称';
comment on column gen_table_column.column_comment is '列描述';
comment on column gen_table_column.column_type is '列类型';
comment on column gen_table_column.java_type is 'JAVA类型';
comment on column gen_table_column.java_field is 'JAVA字段名';
comment on column gen_table_column.is_pk is '是否主键（1是）';
comment on column gen_table_column.is_increment is '是否自增（1是）';
comment on column gen_table_column.is_required is '是否必填（1是）';
comment on column gen_table_column.is_insert is '是否为插入字段（1是）';
comment on column gen_table_column.is_edit is '是否编辑字段（1是）';
comment on column gen_table_column.is_list is '是否列表字段（1是）';
comment on column gen_table_column.is_query is '是否查询字段（1是）';
comment on column gen_table_column.query_type is '查询方式（等于、不等于、大于、小于、范围）';
comment on column gen_table_column.html_type is '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
comment on column gen_table_column.dict_type is '字典类型';
comment on column gen_table_column.sort is '排序';
comment on column gen_table_column.create_by is '创建者';
comment on column gen_table_column.create_time is '创建时间';
comment on column gen_table_column.update_by is '更新者';
comment on column gen_table_column.update_time is '更新时间';

INSERT INTO gen_table_column VALUES
	(74, 13, 'student_id', '编号', 'bigint', 'Long', 'studentId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(75, 13, 'student_name', '学生名称', 'varchar(30)', 'String', 'studentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(76, 13, 'student_age', '年龄', 'int', 'Long', 'studentAge', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 3, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(77, 13, 'student_hobby', '爱好（0代码 1音乐 2电影）', 'varchar(30)', 'String', 'studentHobby', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'select', 'sys_student_hobby', 4, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(78, 13, 'student_gender', '性别（1男 2女 3未知）', 'char(1)', 'String', 'studentGender', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'radio', 'sys_user_gender', 5, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(79, 13, 'student_status', '状态（0正常 1停用）', 'char(1)', 'String', 'studentStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_student_status', 6, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(80, 13, 'student_birthday', '生日', 'datetime', 'Date', 'studentBirthday', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 7, 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36'),
	(81, 13, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 0, '2023-11-22 21:03:59', 0, '2023-12-04 15:59:36'),
	(82, 13, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 0, '2023-11-22 21:03:59', 0, '2023-12-04 15:59:36'),
	(83, 13, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 10, 0, '2023-11-22 21:03:59', 0, '2023-12-04 15:59:36'),
	(84, 13, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '0', '0', NULL, NULL, 'EQ', 'datetime', '', 11, 0, '2023-11-22 21:03:59', 0, '2023-12-04 15:59:36'),
	(94, 15, 'product_id', '产品id', 'bigint', 'Long', 'productId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(95, 15, 'parent_id', '父产品id', 'bigint', 'Long', 'parentId', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'input', '', 2, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(96, 15, 'product_name', '产品名称', 'varchar(30)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(97, 15, 'order_num', '显示顺序', 'int', 'Long', 'orderNum', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 4, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(98, 15, 'status', '产品状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'sys_student_status', 5, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(99, 15, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 6, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(100, 15, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(101, 15, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 8, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(102, 15, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '0', '0', NULL, NULL, 'EQ', 'datetime', '', 9, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(103, 16, 'customer_id', '客户id', 'bigint', 'Long', 'customerId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(104, 16, 'customer_name', '客户姓名', 'varchar(30)', 'String', 'customerName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(105, 16, 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(106, 16, 'gender', '客户性别', 'varchar(20)', 'String', 'gender', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sys_user_gender', 4, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(107, 16, 'birthday', '客户生日', 'datetime', 'Date', 'birthday', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'datetime', '', 5, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(108, 16, 'remark', '客户描述', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '0', NULL, 'EQ', 'textarea', '', 6, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(109, 16, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(110, 16, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(111, 16, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(112, 16, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(113, 17, 'goods_id', '商品id', 'bigint', 'Long', 'goodsId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(114, 17, 'customer_id', '客户id', 'bigint', 'Long', 'customerId', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 2, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(115, 17, 'name', '商品名称', 'varchar(30)', 'String', 'name', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(116, 17, 'weight', '商品重量', 'int', 'Long', 'weight', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(117, 17, 'price', '商品价格', 'decimal(6,2)', 'BigDecimal', 'price', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(118, 17, 'date', '商品时间', 'datetime', 'Date', 'date', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'datetime', '', 6, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(119, 17, 'type', '商品种类', 'char(1)', 'String', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sys_goods_type', 7, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(120, 17, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(121, 17, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(122, 17, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(123, 17, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30');

drop table if exists mf_student;
create table if not exists mf_student (
  student_id bigint,
  student_name varchar(30) not null,
  student_age integer,
  student_hobby varchar(30) not null,
  student_gender char not null,
  student_status char         default '0'::bpchar,
  student_birthday timestamp, 
  create_by   bigint,
  create_time timestamp,
  update_by   bigint,
  update_time timestamp,
  constraint "mf_student_pk" primary key (student_id)  
);
comment on table mf_student                   is '学生信息单表';
comment on column mf_student.student_id       is '编号';
comment on column mf_student.student_name     is '学生名称';
comment on column mf_student.student_age      is '年龄';
comment on column mf_student.student_hobby    is '爱好（0代码 1音乐 2电影）';
comment on column mf_student.student_gender   is '性别（1男 2女 3未知）';
comment on column mf_student.student_status   is '状态（0正常 1停用）';
comment on column mf_student.student_birthday is '生日';
comment on column mf_student.create_by        is '创建者';
comment on column mf_student.create_time      is '创建时间';
comment on column mf_student.update_by        is '更新者';
comment on column mf_student.update_time      is '更新时间';

drop table if exists mf_product;
create table if not exists mf_product (
  product_id bigint NOT NULL,
  parent_id bigint  NULL DEFAULT 0,
  product_name varchar(30) NOT NULL,
  order_num INTEGER DEFAULT 0,
  status char(1) NULL DEFAULT '0',
  create_by BIGINT NULL DEFAULT NULL,
  create_time TIMESTAMP NULL DEFAULT NULL,
  update_by BIGINT NULL DEFAULT NULL,
  update_time TIMESTAMP NULL DEFAULT NULL,
  constraint "mf_product_pk" PRIMARY KEY (product_id) 
);
comment on table mf_product                   is '产品树表';
comment on column mf_product.product_id       is '产品id';
comment on column mf_product.parent_id        is '父产品id';
comment on column mf_product.product_name     is '产品名称';
comment on column mf_product.order_num        is '显示顺序';
comment on column mf_product.status           is '产品状态（0正常 1停用）';
comment on column mf_product.create_by        is '创建者';
comment on column mf_product.create_time      is '创建时间';
comment on column mf_product.update_by        is '更新者';
comment on column mf_product.update_time      is '更新时间';

drop table if exists mf_customer;
create table if not exists mf_customer (
  customer_id bigint NOT NULL,
  customer_name varchar(30) not null DEFAULT '',
  phonenumber varchar(11) NULL DEFAULT NULL,
  gender char(1)  NULL DEFAULT NULL,
  birthday TIMESTAMP NULL DEFAULT NULL,
  remark varchar(500) NULL DEFAULT NULL,
  create_by BIGINT NULL DEFAULT NULL,
  create_time TIMESTAMP NULL DEFAULT NULL,
  update_by BIGINT NULL DEFAULT NULL,
  update_time TIMESTAMP NULL DEFAULT NULL,
  constraint "mf_customer_pk" PRIMARY KEY (customer_id)   
);
comment on table mf_customer                   is '客户主表';
comment on column mf_customer.customer_id       is '客户id';
comment on column mf_customer.customer_name     is '客户姓名';
comment on column mf_customer.phonenumber     is '手机号码';
comment on column mf_customer.gender         is '客户性别';
comment on column mf_customer.birthday         is '客户生日';
comment on column mf_customer.remark           is '客户描述';
comment on column mf_customer.create_by        is '创建者';
comment on column mf_customer.create_time      is '创建时间';
comment on column mf_customer.update_by        is '更新者';
comment on column mf_customer.update_time      is '更新时间';

DROP TABLE IF EXISTS mf_goods;
CREATE TABLE IF NOT EXISTS mf_goods (
  goods_id bigint NOT NULL,
  customer_id bigint NOT NULL,
  name varchar(30) NULL DEFAULT NULL,
  weight INTEGER NULL DEFAULT 0,
  price decimal(6,2) NULL DEFAULT NULL,
  "date" timestamp NULL DEFAULT NULL,
  "type" char(1) NULL DEFAULT NULL,
  create_by BIGINT NULL DEFAULT NULL,
  create_time TIMESTAMP NULL DEFAULT NULL,
  update_by BIGINT NULL DEFAULT NULL,
  update_time TIMESTAMP NULL DEFAULT NULL,
  constraint "mf_goods_pk" PRIMARY KEY (goods_id)   
);
comment on table mf_goods                   is '商品子表';
comment on column mf_goods.goods_id         is '商品id';
comment on column mf_goods.customer_id      is '客户id';
comment on column mf_goods.name             is '商品名称';
comment on column mf_goods.weight           is '商品重量';
comment on column mf_goods.price            is '商品价格';
comment on column mf_goods."date"           is '商品时间';
comment on column mf_goods."type"           is '商品种类';
comment on column mf_goods.create_by        is '创建者';
comment on column mf_goods.create_time      is '创建时间';
comment on column mf_goods.update_by        is '更新者';
comment on column mf_goods.update_time      is '更新时间';

-- powerjob数据表
drop table if exists pj_app_info;
CREATE TABLE pj_app_info (
    id int8 NOT NULL,
    app_name varchar(255) NULL,
    current_server varchar(255) NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    "password" varchar(255) NULL,
    CONSTRAINT pj_app_info_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_app_info UNIQUE (app_name)
);

INSERT INTO pj_app_info VALUES(1, 'ruoyi-worker', '127.0.0.1:10010', '2023-06-13 16:32:59.263', '2023-07-04 17:25:49.798', '123456');

drop table if exists pj_container_info;
CREATE TABLE pj_container_info (
    id int8 NOT NULL,
    app_id int8 NULL,
    container_name varchar(255) NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    last_deploy_time timestamp NULL,
    source_info varchar(255) NULL,
    source_type int4 NULL,
    status int4 NULL,
    "version" varchar(255) NULL,
    CONSTRAINT pj_container_info_pkey PRIMARY KEY (id)
);
CREATE INDEX idx01_container_info ON pj_container_info USING btree (app_id);

drop table if exists pj_instance_info;
CREATE TABLE pj_instance_info (
    id int8 NOT NULL,
    actual_trigger_time int8 NULL,
    app_id int8 NULL,
    expected_trigger_time int8 NULL,
    finished_time int8 NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    instance_id int8 NULL,
    instance_params oid NULL,
    job_id int8 NULL,
    job_params oid NULL,
    last_report_time int8 NULL,
    "result" oid NULL,
    running_times int8 NULL,
    status int4 NULL,
    task_tracker_address varchar(255) NULL,
    "type" int4 NULL,
    wf_instance_id int8 NULL,
    CONSTRAINT pj_instance_info_pkey PRIMARY KEY (id)
);
CREATE INDEX idx01_instance_info ON pj_instance_info USING btree (job_id, status);
CREATE INDEX idx02_instance_info ON pj_instance_info USING btree (app_id, status);
CREATE INDEX idx03_instance_info ON pj_instance_info USING btree (instance_id, status);

drop table if exists pj_job_info;
CREATE TABLE pj_job_info (
    id int8 NOT NULL,
    alarm_config varchar(255) NULL,
    app_id int8 NULL,
    concurrency int4 NULL,
    designated_workers varchar(255) NULL,
    dispatch_strategy int4 NULL,
    execute_type int4 NULL,
    extra varchar(255) NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    instance_retry_num int4 NULL,
    instance_time_limit int8 NULL,
    job_description varchar(255) NULL,
    job_name varchar(255) NULL,
    job_params oid NULL,
    lifecycle varchar(255) NULL,
    log_config varchar(255) NULL,
    max_instance_num int4 NULL,
    max_worker_count int4 NULL,
    min_cpu_cores float8 NOT NULL,
    min_disk_space float8 NOT NULL,
    min_memory_space float8 NOT NULL,
    next_trigger_time int8 NULL,
    notify_user_ids varchar(255) NULL,
    processor_info varchar(255) NULL,
    processor_type int4 NULL,
    status int4 NULL,
    tag varchar(255) NULL,
    task_retry_num int4 NULL,
    time_expression varchar(255) NULL,
    time_expression_type int4 NULL,
    CONSTRAINT pj_job_info_pkey PRIMARY KEY (id)
);
CREATE INDEX idx01_job_info ON pj_job_info USING btree (app_id, status, time_expression_type, next_trigger_time);

INSERT INTO pj_job_info VALUES(1, '{\"alertThreshold\":0,\"silenceWindowLen\":0,\"statisticWindowLen\":0}', 1, 5, '', 2, 1, NULL, '2023-06-02 15:01:27.717', '2023-07-04 17:22:12.374', 1, 0, '', '单机处理器执行测试', NULL, '{}', '{\"type\":1}', 0, 0, 0.0, 0.0, 0.0, NULL, NULL, 'org.dromara.job.processors.StandaloneProcessorDemo', 1, 2, NULL, 1, '30000', 3);
INSERT INTO pj_job_info VALUES(2, '{\"alertThreshold\":0,\"silenceWindowLen\":0,\"statisticWindowLen\":0}', 1, 5, '', 1, 2, NULL, '2023-06-02 15:04:45.342', '2023-07-04 17:22:12.816', 0, 0, NULL, '广播处理器测试', NULL, '{}', '{\"type\":1}', 0, 0, 0.0, 0.0, 0.0, NULL, NULL, 'org.dromara.job.processors.BroadcastProcessorDemo', 1, 2, NULL, 1, '30000', 3);
INSERT INTO pj_job_info VALUES(3, '{\"alertThreshold\":0,\"silenceWindowLen\":0,\"statisticWindowLen\":0}', 1, 5, '', 1, 4, NULL, '2023-06-02 15:13:23.519', '2023-06-02 16:03:22.421', 0, 0, NULL, 'Map处理器测试', NULL, '{}', '{\"type\":1}', 0, 0, 0.0, 0.0, 0.0, NULL, NULL, 'org.dromara.job.processors.MapProcessorDemo', 1, 2, NULL, 1, '1000', 3);
INSERT INTO pj_job_info VALUES(4, '{\"alertThreshold\":0,\"silenceWindowLen\":0,\"statisticWindowLen\":0}', 1, 5, '', 1, 3, NULL, '2023-06-02 15:45:25.896', '2023-06-02 16:03:23.125', 0, 0, NULL, 'MapReduce处理器测试', NULL, '{}', '{\"type\":1}', 0, 0, 0.0, 0.0, 0.0, NULL, NULL, 'org.dromara.job.processors.MapReduceProcessorDemo', 1, 2, NULL, 1, '1000', 3);

drop table if exists pj_oms_lock;
CREATE TABLE pj_oms_lock (
    id int8 NOT NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    lock_name varchar(255) NULL,
    max_lock_time int8 NULL,
    ownerip varchar(255) NULL,
    CONSTRAINT pj_oms_lock_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_oms_lock UNIQUE (lock_name)
);

drop table if exists pj_server_info;
CREATE TABLE pj_server_info (
    id int8 NOT NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    ip varchar(255) NULL,
    CONSTRAINT pj_server_info_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_server_info UNIQUE (ip)
);
CREATE INDEX idx01_server_info ON pj_server_info USING btree (gmt_modified);

drop table if exists pj_user_info;
CREATE TABLE pj_user_info (
    id int8 NOT NULL,
    email varchar(255) NULL,
    extra varchar(255) NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    "password" varchar(255) NULL,
    phone varchar(255) NULL,
    username varchar(255) NULL,
    web_hook varchar(255) NULL,
    CONSTRAINT pj_user_info_pkey PRIMARY KEY (id)
);
CREATE INDEX uidx01_user_info ON pj_user_info USING btree (username);
CREATE INDEX uidx02_user_info ON pj_user_info USING btree (email);

drop table if exists pj_workflow_info;
CREATE TABLE pj_workflow_info (
    id int8 NOT NULL,
    app_id int8 NULL,
    extra varchar(255) NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    lifecycle varchar(255) NULL,
    max_wf_instance_num int4 NULL,
    next_trigger_time int8 NULL,
    notify_user_ids varchar(255) NULL,
    pedag oid NULL,
    status int4 NULL,
    time_expression varchar(255) NULL,
    time_expression_type int4 NULL,
    wf_description varchar(255) NULL,
    wf_name varchar(255) NULL,
    CONSTRAINT pj_workflow_info_pkey PRIMARY KEY (id)
);
CREATE INDEX idx01_workflow_info ON pj_workflow_info USING btree (app_id, status, time_expression_type, next_trigger_time);

drop table if exists pj_workflow_instance_info;
CREATE TABLE pj_workflow_instance_info (
    id int8 NOT NULL,
    actual_trigger_time int8 NULL,
    app_id int8 NULL,
    dag oid NULL,
    expected_trigger_time int8 NULL,
    finished_time int8 NULL,
    gmt_create timestamp NULL,
    gmt_modified timestamp NULL,
    parent_wf_instance_id int8 NULL,
    "result" oid NULL,
    status int4 NULL,
    wf_context oid NULL,
    wf_init_params oid NULL,
    wf_instance_id int8 NULL,
    workflow_id int8 NULL,
    CONSTRAINT pj_workflow_instance_info_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_wf_instance UNIQUE (wf_instance_id)
);
CREATE INDEX idx01_wf_instance ON pj_workflow_instance_info USING btree (workflow_id, status, app_id, expected_trigger_time);

drop table if exists pj_workflow_node_info;
CREATE TABLE pj_workflow_node_info (
    id int8 NOT NULL,
    app_id int8 NOT NULL,
    "enable" bool NOT NULL,
    extra oid NULL,
    gmt_create timestamp NOT NULL,
    gmt_modified timestamp NOT NULL,
    job_id int8 NULL,
    node_name varchar(255) NULL,
    node_params oid NULL,
    skip_when_failed bool NOT NULL,
    "type" int4 NULL,
    workflow_id int8 NULL,
    CONSTRAINT pj_workflow_node_info_pkey PRIMARY KEY (id)
);
CREATE INDEX idx01_workflow_node_info ON pj_workflow_node_info USING btree (workflow_id, gmt_create);

drop table if exists sys_client;
create table sys_client (
    id                  bigint,
    client_id           varchar(64)   default ''::varchar,
    client_key          varchar(32)   default ''::varchar,
    client_secret       varchar(255)  default ''::varchar,
    grant_type          varchar(255)  default ''::varchar,
    device_type         varchar(32)   default ''::varchar,
    active_timeout      int4          default 1800,
    timeout             int4          default 604800,
    status              char(1)       default '0'::bpchar,
    del_flag            smallint      default 0,    
    create_by           bigint,
    create_time         timestamp,
    update_by           bigint,
    update_time         timestamp,
    constraint sys_client_pk primary key (id)
);

comment on table sys_client                         is '系统授权表';
comment on column sys_client.id                     is '主建';
comment on column sys_client.client_id              is '客户端id';
comment on column sys_client.client_key             is '客户端key';
comment on column sys_client.client_secret          is '客户端秘钥';
comment on column sys_client.grant_type             is '授权类型';
comment on column sys_client.device_type            is '设备类型';
comment on column sys_client.active_timeout         is 'token活跃超时时间';
comment on column sys_client.timeout                is 'token固定超时';
comment on column sys_client.status                 is '状态（0正常 1停用）';
comment on column sys_client.del_flag               is '删除标志（0代表存在 1代表删除）';
comment on column sys_client.create_by              is '创建者';
comment on column sys_client.create_time            is '创建时间';
comment on column sys_client.update_by              is '更新者';
comment on column sys_client.update_time            is '更新时间';

insert into sys_client values (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, 0, 0, 1, now(), 1, now());
insert into sys_client values (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, 0, 0, 1, now(), 1, now());

drop table if exists sys_config;
create table if not exists sys_config
(
    config_id    bigint,    
    config_name  varchar(100) default ''::varchar,
    config_key   varchar(100) default ''::varchar,
    config_value varchar(500) default ''::varchar,
    config_type  char         default 'N'::bpchar,    
    create_by    bigint,
    create_time  timestamp,
    update_by    bigint,
    update_time  timestamp,
    remark       varchar(500) default null::varchar,
    constraint sys_config_pk primary key (config_id)
);

comment on table sys_config                 is '参数配置表';
comment on column sys_config.config_id      is '参数主键';
comment on column sys_config.config_name    is '参数名称';
comment on column sys_config.config_key     is '参数键名';
comment on column sys_config.config_value   is '参数键值';
comment on column sys_config.config_type    is '系统内置（Y是 N否）';
comment on column sys_config.create_by      is '创建者';
comment on column sys_config.create_time    is '创建时间';
comment on column sys_config.update_by      is '更新者';
comment on column sys_config.update_time    is '更新时间';
comment on column sys_config.remark         is '备注';

insert into sys_config values(1, '主框架页-默认皮肤样式名称',     'sys.index.skinName',            'skin-blue',     'Y', 1, now(), null, null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(2, '用户管理-账号初始密码',         'sys.user.initPassword',         '123456',        'Y', 1, now(), null, null, '初始化密码 123456' );
insert into sys_config values(3, '主框架页-侧边栏主题',           'sys.index.sideTheme',           'theme-dark',    'Y', 1, now(), null, null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(5, '账号自助-是否开启用户注册功能',   'sys.account.registerUser',      'false',         'Y', 1, now(), null, null, '是否开启注册用户功能（true开启，false关闭）');
insert into sys_config values(11, 'OSS预览列表资源开关',          'sys.oss.previewListResource',   'true',          'Y', 1, now(), null, null, 'true:开启, false:关闭');

drop table if exists sys_dept;
create table if not exists sys_dept
(
    dept_id     bigint,    
    parent_id   bigint        default 0,
    ancestors   varchar(760) default ''::varchar,
    dept_name   varchar(30) default ''::varchar,
    order_num   int4        default 0,
    leader      varchar(20)  default ''::varchar,
    phone       varchar(11) default null::varchar,
    email       varchar(50) default null::varchar,
    status      char        default '0'::bpchar,
    del_flag    smallint    default 0,    
    create_by   bigint,
    create_time timestamp,
    update_by   bigint,
    update_time timestamp,
    constraint "sys_dept_pk" primary key (dept_id)
);

comment on table sys_dept               is '部门表';
comment on column sys_dept.dept_id      is '部门ID';
comment on column sys_dept.parent_id    is '父部门ID';
comment on column sys_dept.ancestors    is '祖级列表';
comment on column sys_dept.dept_name    is '部门名称';
comment on column sys_dept.order_num    is '显示顺序';
comment on column sys_dept.leader       is '负责人';
comment on column sys_dept.phone        is '联系电话';
comment on column sys_dept.email        is '邮箱';
comment on column sys_dept.status       is '部门状态（0正常 1停用）';
comment on column sys_dept.del_flag     is '删除标志（0代表存在 1代表删除）';
comment on column sys_dept.create_by    is '创建者';
comment on column sys_dept.create_time  is '创建时间';
comment on column sys_dept.update_by    is '更新者';
comment on column sys_dept.update_time  is '更新时间';

INSERT INTO sys_dept VALUES
	(100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, '2023-09-25 20:21:11'),
	(101, 100, '0,100', '深圳分公司', 1, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, '2023-09-02 16:19:08'),
	(102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL),
	(103, 201, '0,100,201', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, '2023-09-25 20:12:00'),
	(104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL),
	(105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL),
	(106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL),
	(107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL),
	(108, 201, '0,100,201', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, '2023-09-25 20:21:11'),
	(109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL),
	(200, 102, '0,100,102', '行政部', 4, NULL, NULL, NULL, '0', 0, 1, '2023-07-13 15:41:50', 1, NULL),
	(201, 100, '0,100', '武汉分公司', 3, NULL, NULL, NULL, '0', 0, 1, '2023-09-02 16:19:34', 1, '2023-09-25 20:21:11'),
	(202, 108, '0,100,201,108', '市场一部', 1, NULL, NULL, NULL, '0', 0, 1, '2023-09-24 20:44:43', 1, '2023-09-25 20:21:11'),
	(203, 108, '0,100,201,108', '市场二部', 2, NULL, NULL, NULL, '0', 0, 1, '2023-09-24 20:57:17', 1, '2023-09-25 20:21:11'),
	(204, 201, '0,100,201', '技术', 0, NULL, NULL, NULL, '0', 1, 1, '2023-09-25 20:22:02', 1, '2023-09-25 20:28:26'),
	(205, 204, '0,100,201,204', '技术一部', 1, NULL, NULL, NULL, '0', 1, 1, '2023-09-25 20:23:07', 1, '2023-09-25 20:27:13'),
	(65929080159150080, 100, '0,100', '山东分公司', 0, NULL, NULL, NULL, '0', 0, 1, '2023-10-01 11:19:38', 1, '2023-10-01 11:19:38'),
	(65929267321577472, 65929080159150080, '0,100,65929080159150080', '研发部', 0, NULL, NULL, NULL, '0', 0, 1, '2023-10-01 11:20:22', 1, '2023-10-01 11:20:22'),
	(65929460884512768, 65929080159150080, '0,100,65929080159150080', '售后部', 1, NULL, NULL, NULL, '0', 0, 1, '2023-10-01 11:21:08', 1, '2023-10-01 11:21:08');

drop table if exists sys_dict_data;
create table if not exists sys_dict_data
(
    dict_code   bigint,    
	dict_sort   int4         default 0,
    dict_label  varchar(100) default ''::varchar,
    dict_value  varchar(100) default ''::varchar,
    dict_type   varchar(100) default ''::varchar,
    css_class   varchar(100) default null::varchar,
    list_class  varchar(100) default null::varchar,
    is_default  char         default 'N'::bpchar,    
    create_by   bigint,
    create_time timestamp,
    update_by   bigint,
    update_time timestamp,
    remark      varchar(500) default null::varchar,
    constraint sys_dict_data_pk primary key (dict_code)
);

comment on table sys_dict_data                  is '字典数据表';
comment on column sys_dict_data.dict_code       is '字典编码';
comment on column sys_dict_data.dict_sort       is '字典排序';
comment on column sys_dict_data.dict_label      is '字典标签';
comment on column sys_dict_data.dict_value      is '字典键值';
comment on column sys_dict_data.dict_type       is '字典类型';
comment on column sys_dict_data.css_class       is '样式属性（其他样式扩展）';
comment on column sys_dict_data.list_class      is '表格回显样式';
comment on column sys_dict_data.is_default      is '是否默认（Y是 N否）';
comment on column sys_dict_data.create_by       is '创建者';
comment on column sys_dict_data.create_time     is '创建时间';
comment on column sys_dict_data.update_by       is '更新者';
comment on column sys_dict_data.update_time     is '更新时间';
comment on column sys_dict_data.remark          is '备注';

INSERT INTO sys_dict_data VALUES
	(1, 1, '男', '0', 'sys_user_gender', '', '', 'Y', 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '性别男'),
	(2, 2, '女', '1', 'sys_user_gender', '', '', 'N', 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '性别女'),
	(3, 3, '未知', '2', 'sys_user_gender', '', '', 'N', 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '性别未知'),
	(4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '显示菜单'),
	(5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '隐藏菜单'),
	(6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
	(7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '停用状态'),
	(8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
	(9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '停用状态'),
	(10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '默认分组'),
	(11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '系统分组'),
	(12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '系统默认是'),
	(13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '系统默认否'),
	(14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '通知'),
	(15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '公告'),
	(16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
	(17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '关闭状态'),
	(18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '其他操作'),
	(19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '新增操作'),
	(20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '修改操作'),
	(21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '删除操作'),
	(22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '授权操作'),
	(23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '导出操作'),
	(24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '导入操作'),
	(25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '强退操作'),
	(26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '生成操作'),
	(27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '清空操作'),
	(28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
	(29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 1, '2023-06-03 21:32:30', 1, NULL, '停用状态'),
	(30, 1, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '密码认证'),
	(31, 2, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '短信认证'),
	(32, 3, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '邮件认证'),
	(33, 4, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '小程序认证'),
	(34, 5, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '三方登录认证'),
	(35, 1, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', 'PC'),
	(36, 2, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', '安卓'),
	(37, 3, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', 'iOS'),
	(38, 4, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', '小程序'),
	(100, 0, '正常', '0', 'sys_student_status', NULL, 'primary', 'N', 1, '2023-06-03 21:53:50', 1, '2023-06-03 21:55:24', NULL),
	(101, 0, '停用', '1', 'sys_student_status', NULL, 'danger', 'N', 1, '2023-06-03 21:54:11', 1, '2023-06-03 21:55:31', NULL),
	(102, 0, '代码', '0', 'sys_student_hobby', NULL, 'primary', 'N', 1, '2023-06-04 16:40:02', 1, NULL, NULL),
	(103, 0, '音乐', '1', 'sys_student_hobby', NULL, 'success', 'N', 1, '2023-06-04 16:40:24', 1, NULL, NULL),
	(104, 0, '电影', '2', 'sys_student_hobby', NULL, 'warning', 'N', 1, '2023-06-04 16:40:40', 1, '2023-06-04 16:40:49', NULL),
	(105, 0, '计算机', '1', 'sys_goods_type', NULL, 'primary', 'N', 1, '2023-06-05 07:23:48', 1, NULL, NULL),
	(106, 0, '打印设备', '2', 'sys_goods_type', NULL, 'success', 'N', 1, '2023-06-05 07:24:14', 1, NULL, NULL),
	(107, 3, '衣服', '3', 'sys_goods_type', NULL, 'info', 'N', 1, '2023-06-05 07:24:35', 1, NULL, NULL),
	(111, 4, '网络设备', '4', 'sys_goods_type', NULL, 'default', NULL, 1, '2023-09-19 17:31:46', 1, '2023-09-19 17:31:46', NULL),
	(65923231885905920, 1, '桌面微机', 'PC', 'sys_app_type', NULL, 'default', 'N', 1, '2023-10-01 10:56:23', 1, '2023-10-01 10:56:23', NULL),
	(65923379802230784, 2, '平板', 'pad', 'sys_app_type', NULL, 'default', 'N', 1, '2023-10-01 10:56:59', 1, '2023-10-01 10:56:59', NULL),
	(65923470604718080, 3, '手机', 'phone', 'sys_app_type', NULL, 'default', 'N', 1, '2023-10-01 10:57:20', 1, '2023-10-01 10:57:20', NULL);

drop table if exists sys_dict_type;
create table if not exists sys_dict_type
(
    dict_id     bigint,    
    dict_name   varchar(100) default ''::varchar,
    dict_type   varchar(100) default ''::varchar,    
    create_by   bigint,
    create_time timestamp,
    update_by   bigint,
    update_time timestamp,
    remark      varchar(500) default null::varchar,
    constraint sys_dict_type_pk primary key (dict_id)
);

create unique index sys_dict_type_index1 ON sys_dict_type (dict_type);

comment on table sys_dict_type                  is '字典类型表';
comment on column sys_dict_type.dict_id         is '字典主键';
comment on column sys_dict_type.dict_name       is '字典名称';
comment on column sys_dict_type.dict_type       is '字典类型';
comment on column sys_dict_type.create_by       is '创建者';
comment on column sys_dict_type.create_time     is '创建时间';
comment on column sys_dict_type.update_by       is '更新者';
comment on column sys_dict_type.update_time     is '更新时间';
comment on column sys_dict_type.remark          is '备注';

INSERT INTO sys_dict_type VALUES
	(1, '用户性别', 'sys_user_gender', 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '用户性别列表'),
	(2, '菜单状态', 'sys_show_hide', 1, '2023-06-03 21:32:30', 1, NULL, '菜单状态列表'),
	(3, '系统开关', 'sys_normal_disable', 1, '2023-06-03 21:32:30', 1, NULL, '系统开关列表'),
	(4, '任务状态', 'sys_job_status', 1, '2023-06-03 21:32:30', 1, NULL, '任务状态列表'),
	(5, '任务分组', 'sys_job_group', 1, '2023-06-03 21:32:30', 1, NULL, '任务分组列表'),
	(6, '系统是否', 'sys_yes_no', 1, '2023-06-03 21:32:30', 1, NULL, '系统是否列表'),
	(7, '通知类型', 'sys_notice_type', 1, '2023-06-03 21:32:30', 1, NULL, '通知类型列表'),
	(8, '通知状态', 'sys_notice_status', 1, '2023-06-03 21:32:30', 1, NULL, '通知状态列表'),
	(9, '操作类型', 'sys_oper_type', 1, '2023-06-03 21:32:30', 1, NULL, '操作类型列表'),
	(10, '系统状态', 'sys_common_status', 1, '2023-06-03 21:32:30', 1, NULL, '登录状态列表'),
	(11, '授权类型', 'sys_grant_type', 1, '2023-10-21 11:06:33', 1, '2023-10-21 11:06:33', '认证授权类型'),
	(12, '设备类型', 'sys_device_type', 1, '2023-10-21 11:38:41', 1, '2023-10-21 11:38:41', '客户端设备类型'),
	(100, '学生状态', 'sys_student_status', 1, '2023-06-03 21:52:47', 1, '2023-06-03 21:53:09', NULL),
	(101, '爱好', 'sys_student_hobby', 1, '2023-06-04 16:39:16', 1, NULL, NULL),
	(102, '商品种类', 'sys_goods_type', 1, '2023-06-05 07:23:20', 1, NULL, NULL),
	(65922863223361536, '系统类型', 'sys_app_type', 1, '2023-10-01 10:54:55', 1, '2023-10-01 10:54:55', '系统类型列表');

drop table if exists sys_logininfor;
create table if not exists sys_logininfor
(
    info_id        bigint,    
    user_name      varchar(50)  default ''::varchar,    
    ipaddr         varchar(128) default ''::varchar,
    login_location varchar(255) default ''::varchar,
    browser        varchar(50)  default ''::varchar,
    os             varchar(50)  default ''::varchar,
    status         char         default '0'::bpchar,
    msg            varchar(255) default ''::varchar,
    login_time     timestamp,
    constraint sys_logininfor_pk primary key (info_id)
);

create index idx_sys_logininfor_s ON sys_logininfor (status);
create index idx_sys_logininfor_lt ON sys_logininfor (login_time);

comment on table sys_logininfor                 is '系统访问记录';
comment on column sys_logininfor.info_id        is '访问ID';
comment on column sys_logininfor.user_name      is '用户账号';
comment on column sys_logininfor.ipaddr         is '登录IP地址';
comment on column sys_logininfor.login_location is '登录地点';
comment on column sys_logininfor.browser        is '浏览器类型';
comment on column sys_logininfor.os             is '操作系统';
comment on column sys_logininfor.status         is '登录状态（0成功 1失败）';
comment on column sys_logininfor.msg            is '提示消息';
comment on column sys_logininfor.login_time     is '访问时间';

drop table if exists sys_menu;
create table if not exists sys_menu
(
    menu_id     bigint,
    menu_name   varchar(50) not null,
    parent_id   bigint         default 0,
    order_num   int4         default 0,
    path        varchar(200) default ''::varchar,
    component   varchar(255) default null::varchar,
    query_param varchar(255) default null::varchar,
    is_frame    char         default '1'::bpchar,
    is_cache    char         default '0'::bpchar,
    menu_type   char         default ''::bpchar,
    visible     char         default '0'::bpchar,
    status      char         default '0'::bpchar,
    perms       varchar(100) default null::varchar,
    icon        varchar(100) default '#'::varchar,    
    create_by   bigint,
    create_time timestamp,
    update_by   bigint,
    update_time timestamp,
    remark      varchar(500) default ''::varchar,
    constraint "sys_menu_pk" primary key (menu_id)
);

comment on table sys_menu               is '菜单权限表';
comment on column sys_menu.menu_id      is '菜单ID';
comment on column sys_menu.menu_name    is '菜单名称';
comment on column sys_menu.parent_id    is '父菜单ID';
comment on column sys_menu.order_num    is '显示顺序';
comment on column sys_menu.path         is '路由地址';
comment on column sys_menu.component    is '组件路径';
comment on column sys_menu.query_param  is '路由参数';
comment on column sys_menu.is_frame     is '是否为外链（0是 1否）';
comment on column sys_menu.is_cache     is '是否缓存（0缓存 1不缓存）';
comment on column sys_menu.menu_type    is '菜单类型（M目录 C菜单 F按钮）';
comment on column sys_menu.visible      is '显示状态（0显示 1隐藏）';
comment on column sys_menu.status       is '菜单状态（0正常 1停用）';
comment on column sys_menu.perms        is '权限标识';
comment on column sys_menu.icon         is '菜单图标';
comment on column sys_menu.create_by    is '创建者';
comment on column sys_menu.create_time  is '创建时间';
comment on column sys_menu.update_by    is '更新者';
comment on column sys_menu.update_time  is '更新时间';
comment on column sys_menu.remark       is '备注';

INSERT INTO sys_menu VALUES
	(1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 1, '2023-06-03 21:32:28', 1, NULL, '系统管理目录'),
	(2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 1, '2023-06-03 21:32:28', 1, NULL, '系统监控目录'),
	(3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 1, '2023-06-03 21:32:28', 1, NULL, '系统工具目录'),
	(4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 1, '2023-06-03 21:32:28', 1, NULL, '若依官网地址'),
	(100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 1, '2023-06-03 21:32:28', 1, NULL, '用户管理菜单'),
	(101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 1, '2023-06-03 21:32:28', 1, NULL, '角色管理菜单'),
	(102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 1, '2023-06-03 21:32:28', 1, NULL, '菜单管理菜单'),
	(103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 1, '2023-06-03 21:32:28', 1, NULL, '部门管理菜单'),
	(104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 1, '2023-06-03 21:32:28', 1, NULL, '岗位管理菜单'),
	(105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 1, '2023-06-03 21:32:28', 1, NULL, '字典管理菜单'),
	(106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 1, '2023-06-03 21:32:28', 1, NULL, '参数设置菜单'),
	(107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 1, '2023-06-03 21:32:28', 1, NULL, '通知公告菜单'),
	(108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 1, '2023-06-03 21:32:28', 1, NULL, '日志管理菜单'),
	(109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 1, '2023-06-03 21:32:28', 1, NULL, '在线用户菜单'),
	(110, '任务调度', 2, 2, 'powerjob', 'monitor/powerjob/index', '', 1, 0, 'C', '0', '0', 'monitor:powerjob:list', 'job', 1, '2023-06-03 21:32:28', 1, NULL, '定时任务菜单'),
	(112, '服务监控', 2, 4, 'admin', 'monitor/admin/index', '', 1, 0, 'C', '0', '0', 'monitor:admin:list', 'server', 1, '2023-06-03 21:32:28', 1, NULL, '服务监控菜单'),
	(113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 1, '2023-06-03 21:32:28', 1, NULL, '缓存监控菜单'),
	(115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 1, '2023-06-03 21:32:28', 1, NULL, '表单构建菜单'),
	(116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 1, '2023-06-03 21:32:28', 1, NULL, '代码生成菜单'),
	(117, '系统接口', 3, 3, 'http://localhost:8080/swagger-ui/index.html', '', '', 0, 0, 'M', '0', '0', 'tool:swagger:list', 'swagger', 1, '2023-06-03 21:32:29', 1, '2023-07-28 21:09:07', '系统接口菜单'),
	(118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', 1, 0, 'C', '0', '0', 'system:oss:list', 'upload', 1, '2023-12-03 08:46:11', 1, '2023-12-03 08:46:11', '文件管理菜单'),
	(500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 1, '2023-06-03 21:32:29', 1, NULL, '操作日志菜单'),
	(501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 1, '2023-06-03 21:32:29', 1, NULL, '登录日志菜单'),
	(1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 1, '2023-06-03 21:32:29', 1, NULL, ''),
	(2018, '演示模块', 0, 99, 'demo', NULL, NULL, 1, 0, 'M', '0', '0', '', 'people', 1, '2023-07-04 11:08:44', 1, '2023-09-02 20:09:55', ''),
	(2050, '学生信息单表(mb)', 2018, 1, 'student', 'demo/student/index', NULL, 1, 0, 'C', '0', '0', 'demo:student:list', 'component', 1, '2023-07-09 12:17:40', 1, '2023-11-17 09:21:30', '学生信息单表(mb)菜单'),
	(2051, '学生信息单表(mb)查询', 2050, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:query', '#', 1, '2023-07-09 12:17:40', 1, NULL, ''),
	(2052, '学生信息单表(mb)新增', 2050, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:add', '#', 1, '2023-07-09 12:17:40', 1, NULL, ''),
	(2053, '学生信息单表(mb)修改', 2050, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:edit', '#', 1, '2023-07-09 12:17:40', 1, NULL, ''),
	(2054, '学生信息单表(mb)删除', 2050, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:remove', '#', 1, '2023-07-09 12:17:40', 1, NULL, ''),
	(2055, '学生信息单表(mb)导出', 2050, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:export', '#', 1, '2023-07-09 12:17:40', 1, NULL, ''),
	(2056, '产品树表（mb）', 2018, 2, 'product', 'demo/product/index', NULL, 1, 0, 'C', '0', '0', 'demo:product:list', '#', 1, '2023-07-09 20:59:25', 1, NULL, '产品树表（mb）菜单'),
	(2057, '产品树表（mb）查询', 2056, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:query', '#', 1, '2023-07-09 20:59:25', 1, NULL, ''),
	(2058, '产品树表（mb）新增', 2056, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:add', '#', 1, '2023-07-09 20:59:25', 1, NULL, ''),
	(2059, '产品树表（mb）修改', 2056, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:edit', '#', 1, '2023-07-09 20:59:25', 1, NULL, ''),
	(2060, '产品树表（mb）删除', 2056, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:remove', '#', 1, '2023-07-09 20:59:25', 1, NULL, ''),
	(2061, '产品树表（mb）导出', 2056, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:export', '#', 1, '2023-07-09 20:59:25', 1, NULL, ''),
	(2062, '客户主表(mb)', 2018, 3, 'customer', 'demo/customer/index', NULL, 1, 0, 'C', '0', '0', 'demo:customer:list', '#', 1, '2023-07-11 16:06:23', 1, NULL, '客户主表(mb)菜单'),
	(2063, '客户主表(mb)查询', 2062, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:query', '#', 1, '2023-07-11 16:06:23', 1, NULL, ''),
	(2064, '客户主表(mb)新增', 2062, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:add', '#', 1, '2023-07-11 16:06:23', 1, NULL, ''),
	(2065, '客户主表(mb)修改', 2062, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:edit', '#', 1, '2023-07-11 16:06:23', 1, NULL, ''),
	(2066, '客户主表(mb)删除', 2062, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:remove', '#', 1, '2023-07-11 16:06:23', 1, NULL, ''),
	(2067, '客户主表(mb)导出', 2062, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:export', '#', 1, '2023-07-11 16:06:23', 1, NULL, ''),
	(2071, '学生信息表', 2018, 4, 'mfstudent', 'mf/student/index', NULL, 1, 0, 'C', '0', '0', 'mf:student:list', '#', 1, '2023-11-22 17:30:46', 1, '2023-12-07 14:35:16', '学生信息表菜单'),
	(2072, '学生信息表查询', 2071, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:query', '#', 1, '2023-11-22 17:30:46', 1, NULL, ''),
	(2073, '学生信息表新增', 2071, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:add', '#', 1, '2023-11-22 17:30:46', 1, NULL, ''),
	(2074, '学生信息表修改', 2071, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:edit', '#', 1, '2023-11-22 17:30:46', 1, NULL, ''),
	(2075, '学生信息表删除', 2071, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:remove', '#', 1, '2023-11-22 17:30:46', 1, NULL, ''),
	(2076, '学生信息表导出', 2071, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:export', '#', 1, '2023-11-22 17:30:46', 1, NULL, ''),
	(2077, '产品树表', 2018, 5, 'mfproduct', 'mf/product/index', NULL, 1, 0, 'C', '0', '0', 'mf:product:list', '#', 1, '2023-11-23 10:53:54', 1, '2023-12-07 14:35:12', '产品树菜单'),
	(2078, '产品树查询', 2077, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:query', '#', 1, '2023-11-23 10:53:54', 1, NULL, ''),
	(2079, '产品树新增', 2077, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:add', '#', 1, '2023-11-23 10:53:54', 1, NULL, ''),
	(2080, '产品树修改', 2077, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:edit', '#', 1, '2023-11-23 10:53:54', 1, NULL, ''),
	(2081, '产品树删除', 2077, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:remove', '#', 1, '2023-11-23 10:53:54', 1, NULL, ''),
	(2082, '产品树导出', 2077, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:export', '#', 1, '2023-11-23 10:53:54', 1, NULL, ''),
	(2023121511351900, '客户主表', 2018, 6, 'mfcustomer', 'mf/customer/index', NULL, 1, 0, 'C', '0', '0', 'mf:customer:list', '#', 1, '2023-12-15 11:36:19', 1, NULL, '客户主表菜单'),
	(2023121511351901, '客户主表查询', 2023121511351900, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:query', '#', 1, '2023-12-15 11:36:19', 1, NULL, ''),
	(2023121511351902, '客户主表新增', 2023121511351900, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:add', '#', 1, '2023-12-15 11:36:19', 1, NULL, ''),
	(2023121511351903, '客户主表修改', 2023121511351900, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:edit', '#', 1, '2023-12-15 11:36:19', 1, NULL, ''),
	(2023121511351904, '客户主表删除', 2023121511351900, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:remove', '#', 1, '2023-12-15 11:36:19', 1, NULL, ''),
	(2023121511351905, '客户主表导出', 2023121511351900, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:export', '#', 1, '2023-12-15 11:36:19', 1, NULL, '');

drop table if exists sys_notice;
create table if not exists sys_notice
(
    notice_id      bigint,    
    notice_title   varchar(50)  not null,
    notice_type    char         not null,
    notice_content text,
    status         char         default '0'::bpchar,    
    create_by      bigint,
    create_time    timestamp,
    update_by      bigint,
    update_time    timestamp,
    remark         varchar(255) default null::varchar,
    constraint sys_notice_pk primary key (notice_id)
);

comment on table sys_notice                 is '通知公告表';
comment on column sys_notice.notice_id      is '公告ID';
comment on column sys_notice.notice_title   is '公告标题';
comment on column sys_notice.notice_type    is '公告类型（1通知 2公告）';
comment on column sys_notice.notice_content is '公告内容';
comment on column sys_notice.status         is '公告状态（0正常 1关闭）';
comment on column sys_notice.create_by      is '创建者';
comment on column sys_notice.create_time    is '创建时间';
comment on column sys_notice.update_by      is '更新者';
comment on column sys_notice.update_time    is '更新时间';
comment on column sys_notice.remark         is '备注';

drop table if exists sys_oper_log;
create table if not exists sys_oper_log
(
    oper_id        bigint,    
    title          varchar(50)   default ''::varchar,
    business_type  int4          default 0,
    method         varchar(100)  default ''::varchar,
    request_method varchar(10)   default ''::varchar,
    operator_type  int4          default 0,
    oper_name      varchar(50)   default ''::varchar,
    dept_name      varchar(50)   default ''::varchar,
    oper_url       varchar(255)  default ''::varchar,
    oper_ip        varchar(128)  default ''::varchar,
    oper_location  varchar(255)  default ''::varchar,
    oper_param     varchar(2000) default ''::varchar,
    json_result    varchar(2000) default ''::varchar,
    status         int4          default 0,
    error_msg      varchar(2000) default ''::varchar,
    oper_time      timestamp,
    cost_time      bigint          default 0,
    constraint sys_oper_log_pk primary key (oper_id)
);

create index idx_sys_oper_log_bt ON sys_oper_log (business_type);
create index idx_sys_oper_log_s ON sys_oper_log (status);
create index idx_sys_oper_log_ot ON sys_oper_log (oper_time);

comment on table sys_oper_log                   is '操作日志记录';
comment on column sys_oper_log.oper_id          is '日志主键';
comment on column sys_oper_log.title            is '模块标题';
comment on column sys_oper_log.business_type    is '业务类型（0其它 1新增 2修改 3删除）';
comment on column sys_oper_log.method           is '方法名称';
comment on column sys_oper_log.request_method   is '请求方式';
comment on column sys_oper_log.operator_type    is '操作类别（0其它 1后台用户 2手机端用户）';
comment on column sys_oper_log.oper_name        is '操作人员';
comment on column sys_oper_log.dept_name        is '部门名称';
comment on column sys_oper_log.oper_url         is '请求URL';
comment on column sys_oper_log.oper_ip          is '主机地址';
comment on column sys_oper_log.oper_location    is '操作地点';
comment on column sys_oper_log.oper_param       is '请求参数';
comment on column sys_oper_log.json_result      is '返回参数';
comment on column sys_oper_log.status           is '操作状态（0正常 1异常）';
comment on column sys_oper_log.error_msg        is '错误消息';
comment on column sys_oper_log.oper_time        is '操作时间';
comment on column sys_oper_log.cost_time        is '消耗时间';

drop table if exists sys_oss;
create table if not exists sys_oss
(
    oss_id        bigint,    
    file_name     varchar(255) default ''::varchar not null,
    original_name varchar(255) default ''::varchar not null,
    file_suffix   varchar(10)  default ''::varchar not null,
    url           varchar(500) default ''::varchar not null,
    service       varchar(20)  default 'minio'::varchar,
    create_by     bigint,
    create_time   timestamp,
    update_by     bigint,
    update_time   timestamp,    
    constraint sys_oss_pk primary key (oss_id)
);

comment on table sys_oss                    is 'OSS对象存储表';
comment on column sys_oss.oss_id            is '对象存储主键';
comment on column sys_oss.file_name         is '文件名';
comment on column sys_oss.original_name     is '原名';
comment on column sys_oss.file_suffix       is '文件后缀名';
comment on column sys_oss.url               is 'URL地址';
comment on column sys_oss.service           is '服务商';
comment on column sys_oss.create_by         is '上传人';
comment on column sys_oss.create_time       is '创建时间';
comment on column sys_oss.update_by         is '更新者';
comment on column sys_oss.update_time       is '更新时间';

drop table if exists sys_oss_config;
create table if not exists sys_oss_config
(
    oss_config_id bigint,    
    config_key    varchar(20)  default ''::varchar not null,
    access_key    varchar(255) default ''::varchar,
    secret_key    varchar(255) default ''::varchar,
    bucket_name   varchar(255) default ''::varchar,
    prefix        varchar(255) default ''::varchar,
    endpoint      varchar(255) default ''::varchar,
    domain        varchar(255) default ''::varchar,
    is_https      char         default 'N'::bpchar,
    region        varchar(255) default ''::varchar,
    access_policy char(1)      default '1'::bpchar not null,
    status        char         default '1'::bpchar,
    ext1          varchar(255) default ''::varchar,    
    create_by     bigint,
    create_time   timestamp,
    update_by     bigint,
    update_time   timestamp,
    remark        varchar(500) default ''::varchar,
    constraint sys_oss_config_pk primary key (oss_config_id)
);

comment on table sys_oss_config                 is '对象存储配置表';
comment on column sys_oss_config.oss_config_id  is '主建';
comment on column sys_oss_config.config_key     is '配置key';
comment on column sys_oss_config.access_key     is 'accessKey';
comment on column sys_oss_config.secret_key     is '秘钥';
comment on column sys_oss_config.bucket_name    is '桶名称';
comment on column sys_oss_config.prefix         is '前缀';
comment on column sys_oss_config.endpoint       is '访问站点';
comment on column sys_oss_config.domain         is '自定义域名';
comment on column sys_oss_config.is_https       is '是否https（Y=是,N=否）';
comment on column sys_oss_config.region         is '域';
comment on column sys_oss_config.access_policy  is '桶权限类型(0=private 1=public 2=custom)';
comment on column sys_oss_config.status         is '是否默认（0=是,1=否）';
comment on column sys_oss_config.ext1           is '扩展字段';
comment on column sys_oss_config.create_by      is '创建者';
comment on column sys_oss_config.create_time    is '创建时间';
comment on column sys_oss_config.update_by      is '更新者';
comment on column sys_oss_config.update_time    is '更新时间';
comment on column sys_oss_config.remark         is '备注';

INSERT INTO sys_oss_config VALUES
	(1, 'minio', 'ruoyi-flex', 'ruoyi-flex@369', 'ruoyi-flex', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', 1, '2023-11-30 11:54:13', 1, '2023-12-03 09:07:42', NULL),
	(2, 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:25:43', NULL),
	(3, 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:25:48', NULL),
	(4, 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 'cos.ap-beijing.myqcloud.com', '', 'N', '', '1', '1', '', 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:26:02', NULL);

drop table if exists sys_post;
create table if not exists sys_post
(
    post_id     bigint,    
    post_code   varchar(64) not null,
    post_name   varchar(50) not null,
    post_sort   int4        not null,
    status      char        not null,    
    create_by   bigint,
    create_time timestamp,
    update_by   bigint,
    update_time timestamp,
    remark      varchar(500) default null::varchar,
    constraint "sys_post_pk" primary key (post_id)
);

comment on table sys_post               is '岗位信息表';
comment on column sys_post.post_id      is '岗位ID';
comment on column sys_post.post_code    is '岗位编码';
comment on column sys_post.post_name    is '岗位名称';
comment on column sys_post.post_sort    is '显示顺序';
comment on column sys_post.status       is '状态（0正常 1停用）';
comment on column sys_post.create_by    is '创建者';
comment on column sys_post.create_time  is '创建时间';
comment on column sys_post.update_by    is '更新者';
comment on column sys_post.update_time  is '更新时间';
comment on column sys_post.remark       is '备注';

INSERT INTO sys_post  VALUES
	(1, 'ceo', '董事长', 1, '0', 1, '2023-06-03 21:32:28', 1, '2023-09-02 15:43:55', ''),
	(2, 'se', '项目经理', 2, '0', 1, '2023-06-03 21:32:28', 1, NULL, ''),
	(3, 'hr', '人力资源', 3, '0', 1, '2023-06-03 21:32:28', 1, NULL, ''),
	(4, 'users', '普通员工', 4, '0', 1, '2023-06-03 21:32:28', 1, '2023-07-13 21:30:24', ''),
	(5, 'deptLeader', '部门管理岗', 5, '0', 1, '2023-10-01 10:33:39', 1, '2023-10-01 10:33:39', '部门负责人岗位');

drop table if exists sys_role;
create table if not exists sys_role
(
    role_id             bigint,    
    role_name           varchar(30)  not null,
    role_key            varchar(100) not null,
    role_sort           int4         not null,
    data_scope          char         default '1'::bpchar,
    menu_check_strictly bool         default true,
    dept_check_strictly bool         default true,
    status              char         not null,
    del_flag            smallint     default 0,    
    create_by           bigint,
    create_time         timestamp,
    update_by           bigint,
    update_time         timestamp,
    remark              varchar(500) default null::varchar,
    constraint "sys_role_pk" primary key (role_id)
);

comment on table sys_role                       is '角色信息表';
comment on column sys_role.role_id              is '角色ID';
comment on column sys_role.role_name            is '角色名称';
comment on column sys_role.role_key             is '角色权限字符串';
comment on column sys_role.role_sort            is '显示顺序';
comment on column sys_role.data_scope           is '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
comment on column sys_role.menu_check_strictly  is '菜单树选择项是否关联显示';
comment on column sys_role.dept_check_strictly  is '部门树选择项是否关联显示';
comment on column sys_role.status               is '角色状态（0正常 1停用）';
comment on column sys_role.del_flag             is '删除标志（0代表存在 1代表删除）';
comment on column sys_role.create_by            is '创建者';
comment on column sys_role.create_time          is '创建时间';
comment on column sys_role.update_by            is '更新者';
comment on column sys_role.update_time          is '更新时间';
comment on column sys_role.remark               is '备注';

INSERT INTO sys_role VALUES
	(1, '超级管理员角色', 'admin', 1, '1', '1', '1', '0', 0, 1, '2023-06-03 21:32:28', 1, NULL, '超级管理员'),
	(2, '普通角色', 'common', 2, '2', '1', '1', '0', 0, 1, '2023-06-03 21:32:28', 2, '2023-12-14 21:23:08', '普通角色'),
	(101, '测试角色名称', 'test', 9, '3', '1', '1', '0', 0, 1, '2023-09-03 11:12:24', 1, '2023-12-14 16:41:05', '备注'),
	(107, '本部门及以下角色', 'deptAdmin', 10, '4', '1', '1', '0', 0, 1, '2023-09-30 10:31:25', 1, '2023-11-21 16:08:09', '部门备注'),
	(15649521177000164, '本部门角色', 'OnlyDept', 13, '3', '1', '1', '0', 0, 1, '2023-09-30 16:06:21', 1, '2023-11-21 09:17:59', '本部门可见'),
	(65643961968087040, '本人角色', 'OnlyMe', 14, '5', '1', '1', '0', 0, 1, '2023-09-30 16:26:40', 1, '2023-10-27 20:08:29', NULL),
	(65652406490345472, '自定义角色', 'customRole', 20, '2', '1', '1', '0', 0, 1, '2023-09-30 17:00:13', 1, '2023-11-21 15:41:54', '自定义');

drop table if exists sys_role_dept;
create table if not exists sys_role_dept
(
    role_id bigint not null,
    dept_id bigint not null,
    constraint sys_role_dept_pk primary key (role_id, dept_id)
);

comment on table sys_role_dept              is '角色和部门关联表';
comment on column sys_role_dept.role_id     is '角色ID';
comment on column sys_role_dept.dept_id     is '部门ID';

INSERT INTO sys_role_dept VALUES
	(2, 100),
	(2, 101),
	(2, 105),
	(65652406490345472, 100),
	(65652406490345472, 103),
	(65652406490345472, 108),
	(65652406490345472, 201),
	(65652406490345472, 202),
	(65652406490345472, 203);

drop table if exists sys_role_menu;
create table if not exists sys_role_menu
(
    role_id bigint not null,
    menu_id bigint not null,
    constraint sys_role_menu_pk primary key (role_id, menu_id)
);

comment on table sys_role_menu              is '角色和菜单关联表';
comment on column sys_role_menu.role_id     is '角色ID';
comment on column sys_role_menu.menu_id     is '菜单ID';

INSERT INTO sys_role_menu VALUES
	(2, 1),
	(2, 100),
	(2, 101),
	(2, 102),
	(2, 103),
	(2, 104),
	(2, 105),
	(2, 106),
	(2, 107),
	(2, 108),
	(2, 118),
	(2, 500),
	(2, 501),
	(2, 1000),
	(2, 1001),
	(2, 1002),
	(2, 1003),
	(2, 1004),
	(2, 1005),
	(2, 1006),
	(2, 1007),
	(2, 1008),
	(2, 1009),
	(2, 1010),
	(2, 1011),
	(2, 1012),
	(2, 1013),
	(2, 1014),
	(2, 1015),
	(2, 1016),
	(2, 1017),
	(2, 1018),
	(2, 1019),
	(2, 1020),
	(2, 1021),
	(2, 1022),
	(2, 1023),
	(2, 1024),
	(2, 1025),
	(2, 1026),
	(2, 1027),
	(2, 1028),
	(2, 1029),
	(2, 1030),
	(2, 1031),
	(2, 1032),
	(2, 1033),
	(2, 1034),
	(2, 1035),
	(2, 1036),
	(2, 1037),
	(2, 1038),
	(2, 1039),
	(2, 1040),
	(2, 1041),
	(2, 1042),
	(2, 1043),
	(2, 1044),
	(2, 1045),
	(2, 2018),
	(2, 2050),
	(2, 2051),
	(2, 2052),
	(2, 2053),
	(2, 2054),
	(2, 2055),
	(2, 2056),
	(2, 2057),
	(2, 2058),
	(2, 2059),
	(2, 2060),
	(2, 2061),
	(2, 2062),
	(2, 2063),
	(2, 2064),
	(2, 2065),
	(2, 2066),
	(2, 2067),
	(2, 2071),
	(2, 2072),
	(2, 2073),
	(2, 2074),
	(2, 2075),
	(2, 2076),
	(2, 2077),
	(2, 2078),
	(2, 2079),
	(2, 2080),
	(2, 2081),
	(2, 2082),
	(2, 2085),
	(2, 2086),
	(2, 2087),
	(2, 2088),
	(2, 2089),
	(2, 2090),
	(101, 4),
	(107, 1),
	(107, 3),
	(107, 100),
	(107, 101),
	(107, 102),
	(107, 103),
	(107, 104),
	(107, 105),
	(107, 106),
	(107, 107),
	(107, 108),
	(107, 115),
	(107, 116),
	(107, 117),
	(107, 500),
	(107, 501),
	(107, 1000),
	(107, 1001),
	(107, 1002),
	(107, 1003),
	(107, 1004),
	(107, 1005),
	(107, 1006),
	(107, 1007),
	(107, 1008),
	(107, 1009),
	(107, 1010),
	(107, 1011),
	(107, 1012),
	(107, 1013),
	(107, 1014),
	(107, 1015),
	(107, 1016),
	(107, 1017),
	(107, 1018),
	(107, 1019),
	(107, 1020),
	(107, 1021),
	(107, 1022),
	(107, 1023),
	(107, 1024),
	(107, 1025),
	(107, 1026),
	(107, 1027),
	(107, 1028),
	(107, 1029),
	(107, 1030),
	(107, 1031),
	(107, 1032),
	(107, 1033),
	(107, 1034),
	(107, 1035),
	(107, 1036),
	(107, 1037),
	(107, 1038),
	(107, 1039),
	(107, 1040),
	(107, 1041),
	(107, 1042),
	(107, 1043),
	(107, 1044),
	(107, 1045),
	(107, 1055),
	(107, 1056),
	(107, 1057),
	(107, 1058),
	(107, 1059),
	(107, 1060),
	(107, 2018),
	(107, 2050),
	(107, 2051),
	(107, 2052),
	(107, 2053),
	(107, 2054),
	(107, 2055),
	(107, 2056),
	(107, 2057),
	(107, 2058),
	(107, 2059),
	(107, 2060),
	(107, 2061),
	(107, 2062),
	(107, 2063),
	(107, 2064),
	(107, 2065),
	(107, 2066),
	(107, 2067),
	(15649521177000164, 1),
	(15649521177000164, 2),
	(15649521177000164, 3),
	(15649521177000164, 4),
	(15649521177000164, 100),
	(15649521177000164, 101),
	(15649521177000164, 102),
	(15649521177000164, 103),
	(15649521177000164, 104),
	(15649521177000164, 105),
	(15649521177000164, 106),
	(15649521177000164, 107),
	(15649521177000164, 108),
	(15649521177000164, 109),
	(15649521177000164, 110),
	(15649521177000164, 112),
	(15649521177000164, 113),
	(15649521177000164, 115),
	(15649521177000164, 116),
	(15649521177000164, 117),
	(15649521177000164, 500),
	(15649521177000164, 501),
	(15649521177000164, 1000),
	(15649521177000164, 1001),
	(15649521177000164, 1002),
	(15649521177000164, 1003),
	(15649521177000164, 1004),
	(15649521177000164, 1005),
	(15649521177000164, 1006),
	(15649521177000164, 1007),
	(15649521177000164, 1008),
	(15649521177000164, 1009),
	(15649521177000164, 1010),
	(15649521177000164, 1011),
	(15649521177000164, 1012),
	(15649521177000164, 1013),
	(15649521177000164, 1014),
	(15649521177000164, 1015),
	(15649521177000164, 1016),
	(15649521177000164, 1017),
	(15649521177000164, 1018),
	(15649521177000164, 1019),
	(15649521177000164, 1020),
	(15649521177000164, 1021),
	(15649521177000164, 1022),
	(15649521177000164, 1023),
	(15649521177000164, 1024),
	(15649521177000164, 1025),
	(15649521177000164, 1026),
	(15649521177000164, 1027),
	(15649521177000164, 1028),
	(15649521177000164, 1029),
	(15649521177000164, 1030),
	(15649521177000164, 1031),
	(15649521177000164, 1032),
	(15649521177000164, 1033),
	(15649521177000164, 1034),
	(15649521177000164, 1035),
	(15649521177000164, 1036),
	(15649521177000164, 1037),
	(15649521177000164, 1038),
	(15649521177000164, 1039),
	(15649521177000164, 1040),
	(15649521177000164, 1041),
	(15649521177000164, 1042),
	(15649521177000164, 1043),
	(15649521177000164, 1044),
	(15649521177000164, 1045),
	(15649521177000164, 1046),
	(15649521177000164, 1047),
	(15649521177000164, 1048),
	(15649521177000164, 1049),
	(15649521177000164, 1050),
	(15649521177000164, 1051),
	(15649521177000164, 1052),
	(15649521177000164, 1053),
	(15649521177000164, 1054),
	(15649521177000164, 1055),
	(15649521177000164, 1056),
	(15649521177000164, 1057),
	(15649521177000164, 1058),
	(15649521177000164, 1059),
	(15649521177000164, 1060),
	(15649521177000164, 2018),
	(15649521177000164, 2050),
	(15649521177000164, 2051),
	(15649521177000164, 2052),
	(15649521177000164, 2053),
	(15649521177000164, 2054),
	(15649521177000164, 2055),
	(15649521177000164, 2056),
	(15649521177000164, 2057),
	(15649521177000164, 2058),
	(15649521177000164, 2059),
	(15649521177000164, 2060),
	(15649521177000164, 2061),
	(15649521177000164, 2062),
	(15649521177000164, 2063),
	(15649521177000164, 2064),
	(15649521177000164, 2065),
	(15649521177000164, 2066),
	(15649521177000164, 2067),
	(65643961968087040, 1),
	(65643961968087040, 100),
	(65643961968087040, 101),
	(65643961968087040, 102),
	(65643961968087040, 103),
	(65643961968087040, 104),
	(65643961968087040, 105),
	(65643961968087040, 106),
	(65643961968087040, 107),
	(65643961968087040, 108),
	(65643961968087040, 500),
	(65643961968087040, 501),
	(65643961968087040, 1000),
	(65643961968087040, 1001),
	(65643961968087040, 1002),
	(65643961968087040, 1003),
	(65643961968087040, 1004),
	(65643961968087040, 1005),
	(65643961968087040, 1006),
	(65643961968087040, 1007),
	(65643961968087040, 1008),
	(65643961968087040, 1009),
	(65643961968087040, 1010),
	(65643961968087040, 1011),
	(65643961968087040, 1012),
	(65643961968087040, 1013),
	(65643961968087040, 1014),
	(65643961968087040, 1015),
	(65643961968087040, 1016),
	(65643961968087040, 1017),
	(65643961968087040, 1018),
	(65643961968087040, 1019),
	(65643961968087040, 1020),
	(65643961968087040, 1021),
	(65643961968087040, 1022),
	(65643961968087040, 1023),
	(65643961968087040, 1024),
	(65643961968087040, 1025),
	(65643961968087040, 1026),
	(65643961968087040, 1027),
	(65643961968087040, 1028),
	(65643961968087040, 1029),
	(65643961968087040, 1030),
	(65643961968087040, 1031),
	(65643961968087040, 1032),
	(65643961968087040, 1033),
	(65643961968087040, 1034),
	(65643961968087040, 1035),
	(65643961968087040, 1036),
	(65643961968087040, 1037),
	(65643961968087040, 1038),
	(65643961968087040, 1039),
	(65643961968087040, 1040),
	(65643961968087040, 1041),
	(65643961968087040, 1042),
	(65643961968087040, 1043),
	(65643961968087040, 1044),
	(65643961968087040, 1045),
	(65643961968087040, 2018),
	(65643961968087040, 2050),
	(65643961968087040, 2051),
	(65643961968087040, 2052),
	(65643961968087040, 2053),
	(65643961968087040, 2054),
	(65643961968087040, 2055),
	(65643961968087040, 2056),
	(65643961968087040, 2057),
	(65643961968087040, 2058),
	(65643961968087040, 2059),
	(65643961968087040, 2060),
	(65643961968087040, 2061),
	(65643961968087040, 2062),
	(65643961968087040, 2063),
	(65643961968087040, 2064),
	(65643961968087040, 2065),
	(65643961968087040, 2066),
	(65643961968087040, 2067),
	(65652406490345472, 1),
	(65652406490345472, 2),
	(65652406490345472, 3),
	(65652406490345472, 4),
	(65652406490345472, 100),
	(65652406490345472, 101),
	(65652406490345472, 102),
	(65652406490345472, 103),
	(65652406490345472, 104),
	(65652406490345472, 105),
	(65652406490345472, 106),
	(65652406490345472, 107),
	(65652406490345472, 108),
	(65652406490345472, 109),
	(65652406490345472, 110),
	(65652406490345472, 112),
	(65652406490345472, 113),
	(65652406490345472, 115),
	(65652406490345472, 116),
	(65652406490345472, 117),
	(65652406490345472, 500),
	(65652406490345472, 501),
	(65652406490345472, 1000),
	(65652406490345472, 1001),
	(65652406490345472, 1002),
	(65652406490345472, 1003),
	(65652406490345472, 1004),
	(65652406490345472, 1005),
	(65652406490345472, 1006),
	(65652406490345472, 1007),
	(65652406490345472, 1008),
	(65652406490345472, 1009),
	(65652406490345472, 1010),
	(65652406490345472, 1011),
	(65652406490345472, 1012),
	(65652406490345472, 1013),
	(65652406490345472, 1014),
	(65652406490345472, 1015),
	(65652406490345472, 1016),
	(65652406490345472, 1017),
	(65652406490345472, 1018),
	(65652406490345472, 1019),
	(65652406490345472, 1020),
	(65652406490345472, 1021),
	(65652406490345472, 1022),
	(65652406490345472, 1023),
	(65652406490345472, 1024),
	(65652406490345472, 1025),
	(65652406490345472, 1026),
	(65652406490345472, 1027),
	(65652406490345472, 1028),
	(65652406490345472, 1029),
	(65652406490345472, 1030),
	(65652406490345472, 1031),
	(65652406490345472, 1032),
	(65652406490345472, 1033),
	(65652406490345472, 1034),
	(65652406490345472, 1035),
	(65652406490345472, 1036),
	(65652406490345472, 1037),
	(65652406490345472, 1038),
	(65652406490345472, 1039),
	(65652406490345472, 1040),
	(65652406490345472, 1041),
	(65652406490345472, 1042),
	(65652406490345472, 1043),
	(65652406490345472, 1044),
	(65652406490345472, 1045),
	(65652406490345472, 1046),
	(65652406490345472, 1047),
	(65652406490345472, 1048),
	(65652406490345472, 1049),
	(65652406490345472, 1050),
	(65652406490345472, 1051),
	(65652406490345472, 1052),
	(65652406490345472, 1053),
	(65652406490345472, 1054),
	(65652406490345472, 1055),
	(65652406490345472, 1056),
	(65652406490345472, 1057),
	(65652406490345472, 1058),
	(65652406490345472, 1059),
	(65652406490345472, 1060),
	(65652406490345472, 2018),
	(65652406490345472, 2050),
	(65652406490345472, 2051),
	(65652406490345472, 2052),
	(65652406490345472, 2053),
	(65652406490345472, 2054),
	(65652406490345472, 2055),
	(65652406490345472, 2056),
	(65652406490345472, 2057),
	(65652406490345472, 2058),
	(65652406490345472, 2059),
	(65652406490345472, 2060),
	(65652406490345472, 2061),
	(65652406490345472, 2062),
	(65652406490345472, 2063),
	(65652406490345472, 2064),
	(65652406490345472, 2065),
	(65652406490345472, 2066),
	(65652406490345472, 2067);
	
drop table if exists sys_tenant;
create table if not exists sys_tenant
(
    id                bigint,
    tenant_id         bigint,
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
    account_count     int4          default -1,
    status            char          default '0'::bpchar,
    del_flag          smallint      default 0,    
    create_by         bigint,
    create_time       timestamp,
    update_by         bigint,
    update_time       timestamp,
    constraint "pk_sys_tenant" primary key (id)
);

comment on table   sys_tenant                    is '租户表';
comment on column  sys_tenant.tenant_id          is '租户编号';
comment on column  sys_tenant.contact_phone      is '联系电话';
comment on column  sys_tenant.company_name       is '企业名称';
comment on column  sys_tenant.company_name       is '联系人';
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

insert into sys_tenant values
(1, 1, '租户管理组', '18888888888', 'XXX有限公司', NULL, NULL, 'RuoYi-Flex多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', 0, 1, '2023-08-13 08:08:08', NULL, NULL);
	
drop table if exists sys_user;
create table if not exists sys_user
(
    user_id     bigint,
    tenant_id   bigint,
    dept_id     bigint,
    user_name   varchar(30)  not null,
    nick_name   varchar(30)  not null,
    user_type   varchar(10)  default 'sys_user'::varchar,
    email       varchar(50)  default ''::varchar,
    phonenumber varchar(11)  default ''::varchar,
    gender      char         default '0'::bpchar,
    avatar      bigint,
    password    varchar(100) default ''::varchar,
    status      char         default '0'::bpchar,
    del_flag    smallint     default 0,
    login_ip    varchar(128) default ''::varchar,
    login_date  timestamp,    
    create_by   bigint,
    create_time timestamp,
    update_by   bigint,
    update_time timestamp,
    remark      varchar(500) default null::varchar,
    constraint "sys_user_pk" primary key (user_id)
);

comment on table sys_user               is '用户信息表';
comment on column sys_user.user_id      is '用户ID';
comment on column sys_user.tenant_id    is '租户编号';
comment on column sys_user.dept_id      is '部门ID';
comment on column sys_user.user_name    is '用户账号';
comment on column sys_user.nick_name    is '用户昵称';
comment on column sys_user.user_type    is '用户类型（sys_user系统用户）';
comment on column sys_user.email        is '用户邮箱';
comment on column sys_user.phonenumber  is '手机号码';
comment on column sys_user.gender       is '用户性别（0男 1女 2未知）';
comment on column sys_user.avatar       is '头像地址';
comment on column sys_user.password     is '密码';
comment on column sys_user.status       is '帐号状态（0正常 1停用）';
comment on column sys_user.del_flag     is '删除标志（0代表存在 1代表删除）';
comment on column sys_user.login_ip     is '最后登陆IP';
comment on column sys_user.login_date   is '最后登陆时间';
comment on column sys_user.create_by    is '创建者';
comment on column sys_user.create_time  is '创建时间';
comment on column sys_user.update_by    is '更新者';
comment on column sys_user.update_time  is '更新时间';
comment on column sys_user.remark       is '备注';

INSERT INTO sys_user  VALUES
	(1, 1, 103, 'admin', '若依', 'sys_user', 'ry@163.com', '15888888888', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', 0, '0:0:0:0:0:0:0:1', '2023-12-18 10:57:01', 1, '2023-06-03 21:32:28', 1, '2023-12-18 10:57:01', '管理员'),
	(2, 1, 65929080159150080, 'ry', 'ruoyi-flex', 'sys_user', 'ry@qq.com', '15666666666', '1', NULL, '$2a$10$LM1zq1y9I7QhvnMOK5NPuOkyr9r7fo8IGm2MGfeD5KKdQAOLcRmEe', '0', 0, '0:0:0:0:0:0:0:1', '2023-12-14 21:22:18', 1, '2023-06-03 21:32:28', 2, '2023-12-14 21:22:18', '测试员'),
	(100, 1, 102, 'flex', 'flex昵称', 'sys_user', 'flex8888@163.com', '18808928888', '0', NULL, '$2a$10$jbN5LcYAQQ2E8g8MT.w7cu1YFNwKa/Nf4.A373DUc9fyRHLl9zwWO', '0', 0, '127.0.0.1', '2023-11-15 16:42:43', 1, '2023-07-06 16:49:17', 100, '2023-11-15 16:45:08', NULL),
	(101, 0, 100, 'vue3', 'vue3用户名', 'sys_user', '', '', '0', NULL, '$2a$10$MEjgdOQgvs7obwu6yoVnLO/K3wGPMlV3CAQMxVIpqwebFZat22NUW', '1', 0, '', NULL, 1, '2023-09-12 11:53:15', 1, '2023-10-16 17:15:32', 'vue3新增测试用户'),
	(71449897878007808, 0, 65929080159150080, 'java', 'java', 'sys_user', 'javaisgood@qq.com', '18966666666', '0', NULL, '$2a$10$fPvJrZBCZojxIauT/VERm.gX6jGVLfJLkKo5j5DGJstT6dO/AX4Dm', '0', 0, '127.0.0.1', '2023-11-21 19:28:48', 1, '2023-10-16 16:57:23', 71449897878007808, '2023-11-21 19:28:48', 'java用户'),
	(71454850805735424, 0, 65929460884512768, 'java2', 'java2', 'sys_user', 'java2@1126.com', '18855556963', '1', NULL, '$2a$10$m2g/pdS9ciOBYfVAEH6FoOsC2.Ls7b86oQ/TM/4WowwvGGE1aSRLS', '0', 1, '', NULL, 1, '2023-10-16 17:17:04', 1, '2023-10-16 17:19:24', NULL),
	(71500938010955776, 0, 65929267321577472, 'javaTest', 'java测试', 'sys_user', 'test@163.com', '13366666666', '0', NULL, '', '0', 0, '127.0.0.1', '2023-10-19 20:49:24', 1, '2023-10-16 20:20:12', 71449897878007808, '2023-11-21 09:35:54', NULL),
	(75077525943939072, 0, 65929460884512768, 'li', 'li', 'sys_user', 'li@qq.com', '13666666666', '0', NULL, '', '0', 0, '', NULL, 1, '2023-10-26 17:12:17', 1, '2023-11-21 16:07:15', NULL),
	(75081100715675648, 0, 203, 'vue3-li', 'vue3-li', 'sys_user', 'vue3-li@qq.com', '13566666666', '1', NULL, '', '0', 0, '127.0.0.1', '2023-10-27 22:33:10', 1, '2023-10-26 17:26:29', 71449897878007808, '2023-11-21 16:26:17', NULL);

drop table if exists sys_user_post;
create table if not exists sys_user_post
(
    user_id bigint not null,
    post_id bigint not null,
    constraint sys_user_post_pk primary key (user_id, post_id)
);

comment on table sys_user_post              is '用户与岗位关联表';
comment on column sys_user_post.user_id     is '用户ID';
comment on column sys_user_post.post_id     is '岗位ID';

INSERT INTO sys_user_post VALUES
	(1, 1),
	(2, 2),
	(100, 4),
	(100, 65917508166729728),
	(101, 3),
	(101, 4),
	(71449897878007808, 4),
	(71449897878007808, 65917508166729728),
	(75081100715675648, 4);

drop table if exists sys_user_role;
create table if not exists sys_user_role
(
    user_id bigint not null,
    role_id bigint not null,
    constraint sys_user_role_pk primary key (user_id, role_id)
);

comment on table sys_user_role              is '用户和角色关联表';
comment on column sys_user_role.user_id     is '用户ID';
comment on column sys_user_role.role_id     is '角色ID';

INSERT INTO sys_user_role  VALUES
	(1, 1),
	(2, 2),
	(2, 101),
	(100, 101),
	(100, 107),
	(100, 15649521177000164),
	(101, 2),
	(101, 101),
	(65714406834679808, 65714406834679809),
	(65714406838874112, 65714406838874113),
	(71449897878007808, 107),
	(71449897878007808, 15649521177000164),
	(71449897878007808, 65652406490345472),
	(71500938010955776, 2),
	(75077525943939072, 2),
	(75081100715675648, 65643961968087040);
	

-- 字符串自动转时间 避免框架时间查询报错问题
create or replace function cast_varchar_to_timestamp(varchar) returns timestamptz as $$
select to_timestamp($1, 'yyyy-mm-dd hh24:mi:ss');
$$ language sql strict ;

create cast (varchar as timestamptz) with function cast_varchar_to_timestamp as IMPLICIT;