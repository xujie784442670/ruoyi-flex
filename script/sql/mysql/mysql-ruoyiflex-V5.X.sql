-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.27 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 导出  表 ruoyi-flex.demo_customer 结构
DROP TABLE IF EXISTS `demo_customer`;
CREATE TABLE IF NOT EXISTS `demo_customer` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `customer_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '客户姓名',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '手机号码',
  `sex` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户性别',
  `birthday` datetime DEFAULT NULL COMMENT '客户生日',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户描述',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='客户主表';

-- 导出  表 ruoyi-flex.demo_goods 结构
DROP TABLE IF EXISTS `demo_goods`;
CREATE TABLE IF NOT EXISTS `demo_goods` (
  `goods_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `customer_id` bigint NOT NULL COMMENT '客户id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '商品名称',
  `weight` int DEFAULT NULL COMMENT '商品重量',
  `price` decimal(6,2) DEFAULT NULL COMMENT '商品价格',
  `date` datetime DEFAULT NULL COMMENT '商品时间',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '商品种类',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='商品子表';

-- 导出  表 ruoyi-flex.demo_product 结构
DROP TABLE IF EXISTS `demo_product`;
CREATE TABLE IF NOT EXISTS `demo_product` (
  `product_id` bigint NOT NULL AUTO_INCREMENT COMMENT '产品id',
  `parent_id` bigint DEFAULT '0' COMMENT '父产品id',
  `product_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '产品名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '产品状态（0正常 1停用）',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品表';

-- 导出  表 ruoyi-flex.demo_student 结构
DROP TABLE IF EXISTS `demo_student`;
CREATE TABLE IF NOT EXISTS `demo_student` (
  `student_id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `student_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '学生名称',
  `student_age` int DEFAULT NULL COMMENT '年龄',
  `student_hobby` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '爱好（0代码 1音乐 2电影）',
  `student_sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '性别（1男 2女 3未知）',
  `student_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `student_birthday` datetime DEFAULT NULL COMMENT '生日',
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='学生信息单表';

-- 导出  表 ruoyi-flex.gen_table 结构
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE IF NOT EXISTS `gen_table` (
  `table_id` bigint NOT NULL COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其它生成选项',
  `version` int DEFAULT '0' COMMENT '乐观锁',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='代码生成业务表';

-- 正在导出表  ruoyi-flex.gen_table 的数据：~4 rows (大约)
INSERT INTO `gen_table` (`table_id`, `table_name`, `table_comment`, `sub_table_name`, `sub_table_fk_name`, `class_name`, `tpl_category`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `gen_type`, `gen_path`, `options`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(13, 'mf_student', '学生信息单表', NULL, NULL, 'Student', 'crud', 'com.ruoyi.mf', 'mf', 'student', '学生信息表', '数据小王子', '0', '/', '{"parentMenuId":"2018"}', 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55', 'mybatis-flex版本的学生信息单表演示'),
	(15, 'mf_product', '产品树表', '', '', 'MfProduct', 'tree', 'com.ruoyi.mf', 'mf', 'product', '产品树', '数据小王子', '0', '/', '{"treeCode":"product_id","treeName":"product_name","treeParentCode":"parent_id","parentMenuId":"2018"}', 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43', 'mybatis-flex版本的产品树表演示'),
	(16, 'mf_customer', '客户主表', 'mf_goods', 'customer_id', 'Customer', 'sub', 'com.ruoyi.mf', 'mf', 'customer', '客户主表', '数据小王子', '0', '/', '{"parentMenuId":"2018"}', 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57', 'mybatis-flex格式的主子表测试'),
	(17, 'mf_goods', '商品子表', NULL, NULL, 'Goods', 'crud', 'com.ruoyi.demo', 'demo', 'goods', '商品子表', '数据小王子', '0', '/', '{}', 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30', NULL);

-- 导出  表 ruoyi-flex.gen_table_column 结构
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE IF NOT EXISTS `gen_table_column` (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint NOT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `version` int DEFAULT '0' COMMENT '乐观锁',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='代码生成业务表字段';

-- 正在导出表  ruoyi-flex.gen_table_column 的数据：~41 rows (大约)
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `version`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(74, 13, 'student_id', '编号', 'bigint', 'Long', 'studentId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(75, 13, 'student_name', '学生名称', 'varchar(30)', 'String', 'studentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(76, 13, 'student_age', '年龄', 'int', 'Long', 'studentAge', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 3, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(77, 13, 'student_hobby', '爱好（0代码 1音乐 2电影）', 'varchar(30)', 'String', 'studentHobby', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'select', 'sys_student_hobby', 4, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(78, 13, 'student_gender', '性别（1男 2女 3未知）', 'char(1)', 'String', 'studentGender', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'radio', 'sys_user_gender', 5, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(79, 13, 'student_status', '状态（0正常 1停用）', 'char(1)', 'String', 'studentStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_student_status', 6, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(80, 13, 'student_birthday', '生日', 'datetime', 'Date', 'studentBirthday', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 7, 0, 1, '2023-11-17 14:12:07', 1, '2023-12-24 20:47:55'),
	(81, 13, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 0, 0, '2023-11-22 21:03:59', 1, '2023-12-24 20:47:55'),
	(82, 13, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 0, 0, '2023-11-22 21:03:59', 1, '2023-12-24 20:47:55'),
	(83, 13, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 10, 0, 0, '2023-11-22 21:03:59', 1, '2023-12-24 20:47:55'),
	(84, 13, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '0', '0', NULL, NULL, 'EQ', 'datetime', '', 11, 0, 0, '2023-11-22 21:03:59', 1, '2023-12-24 20:47:55'),
	(94, 15, 'product_id', '产品id', 'bigint', 'Long', 'productId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(95, 15, 'parent_id', '父产品id', 'bigint', 'Long', 'parentId', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'input', '', 2, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(96, 15, 'product_name', '产品名称', 'varchar(30)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(97, 15, 'order_num', '显示顺序', 'int', 'Long', 'orderNum', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 4, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(98, 15, 'status', '产品状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'sys_student_status', 5, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(99, 15, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 6, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(100, 15, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(101, 15, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 8, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(102, 15, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '0', '0', NULL, NULL, 'EQ', 'datetime', '', 9, 0, 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43'),
	(103, 16, 'customer_id', '客户id', 'bigint', 'Long', 'customerId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(104, 16, 'customer_name', '客户姓名', 'varchar(30)', 'String', 'customerName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(105, 16, 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(106, 16, 'gender', '客户性别', 'varchar(20)', 'String', 'gender', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sys_user_gender', 4, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(107, 16, 'birthday', '客户生日', 'datetime', 'Date', 'birthday', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'datetime', '', 5, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(108, 16, 'remark', '客户描述', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '0', NULL, 'EQ', 'textarea', '', 6, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(109, 16, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(110, 16, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(111, 16, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(112, 16, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 0, 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57'),
	(113, 17, 'goods_id', '商品id', 'bigint', 'Long', 'goodsId', '1', '0', NULL, NULL, '1', NULL, NULL, 'EQ', 'input', '', 1, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(114, 17, 'customer_id', '客户id', 'bigint', 'Long', 'customerId', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 2, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(115, 17, 'name', '商品名称', 'varchar(30)', 'String', 'name', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(116, 17, 'weight', '商品重量', 'int', 'Long', 'weight', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(117, 17, 'price', '商品价格', 'decimal(6,2)', 'BigDecimal', 'price', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(118, 17, 'date', '商品时间', 'datetime', 'Date', 'date', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'datetime', '', 6, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(119, 17, 'type', '商品种类', 'char(1)', 'String', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sys_goods_type', 7, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(120, 17, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(121, 17, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(122, 17, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30'),
	(123, 17, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 0, 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30');


-- 导出  表 ruoyi-flex.mf_customer 结构
DROP TABLE IF EXISTS `mf_customer`;
CREATE TABLE IF NOT EXISTS `mf_customer` (
     `customer_id` bigint NOT NULL COMMENT '客户id',
     `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
     `customer_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '客户姓名',
     `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '手机号码',
     `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户性别',
     `birthday` datetime DEFAULT NULL COMMENT '客户生日',
     `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户描述',
     `version` int DEFAULT '0' COMMENT '乐观锁',
     `del_flag` smallint DEFAULT '0' COMMENT '逻辑删除标志（0代表存在 1代表删除）',
     `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
     `create_time` datetime DEFAULT NULL COMMENT '创建时间',
     `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
     `update_time` datetime DEFAULT NULL COMMENT '更新时间',
     PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='客户主表';

-- 导出  表 ruoyi-flex.mf_goods 结构
DROP TABLE IF EXISTS `mf_goods`;
CREATE TABLE IF NOT EXISTS `mf_goods` (
      `goods_id` bigint NOT NULL COMMENT '商品id',
      `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
      `customer_id` bigint NOT NULL COMMENT '客户id',
      `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '商品名称',
      `weight` int DEFAULT NULL COMMENT '商品重量',
      `price` decimal(6,2) DEFAULT NULL COMMENT '商品价格',
      `date` datetime DEFAULT NULL COMMENT '商品时间',
      `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '商品种类',
      `version` int DEFAULT '0' COMMENT '乐观锁',
      `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
      `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
      PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='商品子表';

-- 导出  表 ruoyi-flex.mf_product 结构
DROP TABLE IF EXISTS `mf_product`;
CREATE TABLE IF NOT EXISTS `mf_product` (
        `product_id` bigint NOT NULL COMMENT '产品id',
        `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
        `parent_id` bigint DEFAULT '0' COMMENT '父产品id',
        `product_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '产品名称',
        `order_num` int DEFAULT '0' COMMENT '显示顺序',
        `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '产品状态（0正常 1停用）',
        `version` int DEFAULT '0' COMMENT '乐观锁',
        `del_flag` smallint DEFAULT '0' COMMENT '逻辑删除标志（0代表存在 1代表删除）',
        `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
        `create_time` datetime DEFAULT NULL COMMENT '创建时间',
        `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        PRIMARY KEY (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品树表';

-- 导出  表 ruoyi-flex.mf_student 结构
DROP TABLE IF EXISTS `mf_student`;
CREATE TABLE IF NOT EXISTS `mf_student` (
        `student_id` bigint NOT NULL COMMENT '编号',
        `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
        `student_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '学生名称',
        `student_age` int DEFAULT NULL COMMENT '年龄',
        `student_hobby` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '爱好（0代码 1音乐 2电影）',
        `student_gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '性别（1男 2女 3未知）',
        `student_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
        `student_birthday` datetime DEFAULT NULL COMMENT '生日',
        `version` int DEFAULT '0' COMMENT '乐观锁',
        `del_flag` smallint DEFAULT '0' COMMENT '逻辑删除标志（0代表存在 1代表删除）',
        `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
        `create_time` datetime DEFAULT NULL COMMENT '创建时间',
        `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        PRIMARY KEY (`student_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='学生信息单表';

-- 导出  表 ruoyi-flex.sys_client 结构
DROP TABLE IF EXISTS `sys_client`;
CREATE TABLE IF NOT EXISTS `sys_client` (
    `id` bigint NOT NULL COMMENT 'id',
    `client_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户端id',
    `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户端key',
    `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户端秘钥',
    `grant_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '授权类型',
    `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '设备类型',
    `active_timeout` int DEFAULT '1800' COMMENT 'token活跃超时时间',
    `timeout` int DEFAULT '604800' COMMENT 'token固定超时',
    `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `version` int DEFAULT '0' COMMENT '乐观锁',
    `del_flag` smallint DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
    `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
    `create_by` bigint DEFAULT NULL COMMENT '创建者',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_by` bigint DEFAULT NULL COMMENT '更新者',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='系统授权表';

-- 正在导出表  ruoyi-flex.sys_client 的数据：~2 rows (大约)
INSERT INTO `sys_client` (`id`, `client_id`, `client_key`, `client_secret`, `grant_type`, `device_type`, `active_timeout`, `timeout`, `status`, `version`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
                                                                                                                                                                                                                                                            (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', 2, 0, 103, 1, '2023-08-10 17:01:52', 1, '2024-01-07 19:02:50', NULL),
                                                                                                                                                                                                                                                            (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '1', 1, 0, 103, 1, '2023-08-10 17:01:52', 1, '2024-01-07 19:36:27', NULL);

-- 导出  表 ruoyi-flex.sys_config 结构
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE IF NOT EXISTS `sys_config` (
    `config_id` bigint NOT NULL COMMENT '参数主键',
    `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
    `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '参数名称',
    `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '参数键名',
    `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '参数键值',
    `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
    `version` int DEFAULT '0' COMMENT '乐观锁',
    `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='参数配置表';

-- 正在导出表  ruoyi-flex.sys_config 的数据：~24 rows (大约)
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
                                                                                                                                                                                                 (1, 1, '主框架页-默认皮肤样式', 'sys.index.skinName', 'skin-blue', 'Y', 0, 1, '2023-06-03 21:32:30', 1, '2023-09-12 17:56:29', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
                                                                                                                                                                                                 (2, 1, '用户管理-账号初始密码', 'sys.user.initPassword', '12345678', 'Y', 0, 1, '2023-06-03 21:32:30', 1, '2023-10-16 16:42:05', '初始化密码 12345678'),
                                                                                                                                                                                                 (3, 1, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '深色主题theme-dark，浅色主题theme-light'),
                                                                                                                                                                                                 (5, 1, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'N', 0, 1, '2023-06-03 21:32:30', 1, '2023-09-13 17:16:25', '是否开启注册用户功能（true开启，false关闭）'),
                                                                                                                                                                                                 (6, 1, 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 0, 1, '2023-09-30 21:55:15', 1, '2023-12-10 19:49:53', 'true:开启, false:关闭');

-- 导出  表 ruoyi-flex.sys_dept 结构
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE IF NOT EXISTS `sys_dept` (
      `dept_id` bigint NOT NULL COMMENT '部门id',
      `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
      `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
      `ancestors` varchar(760) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '祖级列表',
      `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '部门名称',
      `order_num` int DEFAULT '0' COMMENT '显示顺序',
      `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '负责人',
      `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系电话',
      `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
      `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
      `version` int DEFAULT '0' COMMENT '乐观锁',
      `del_flag` smallint DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
      `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
      `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
      PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='部门表';

-- 正在导出表  ruoyi-flex.sys_dept 的数据：~24 rows (大约)
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `version`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
    (1, 1, 0, '0', 'Ruoyi-Flex公司', 0, 'ruoyi-flex', '18888888888', 'dataprince@foxmail.com', '0', 0, 0, 1, '2023-06-03 21:32:28', 1, '2024-01-07 21:44:45');

-- 导出  表 ruoyi-flex.sys_dict_data 结构
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE IF NOT EXISTS `sys_dict_data` (
       `dict_code` bigint NOT NULL COMMENT '字典编码',
       `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
       `dict_sort` int DEFAULT '0' COMMENT '字典排序',
       `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典标签',
       `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典键值',
       `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典类型',
       `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
       `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '表格回显样式',
       `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
       `version` int DEFAULT '0' COMMENT '乐观锁',
       `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
       `create_time` datetime DEFAULT NULL COMMENT '创建时间',
       `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
       `update_time` datetime DEFAULT NULL COMMENT '更新时间',
       `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
       PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='字典数据表';

-- 正在导出表  ruoyi-flex.sys_dict_data 的数据：~100 rows (大约)
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
       (1, 1, 1, '男', '0', 'sys_user_gender', '', '', 'Y', 0, 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '性别男'),
       (2, 1, 2, '女', '1', 'sys_user_gender', '', '', 'N', 0, 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '性别女'),
       (3, 1, 3, '未知', '2', 'sys_user_gender', '', '', 'N', 0, 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '性别未知'),
       (4, 1, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '显示菜单'),
       (5, 1, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '隐藏菜单'),
       (6, 1, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
       (7, 1, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '停用状态'),
       (8, 1, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
       (9, 1, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '停用状态'),
       (10, 1, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '默认分组'),
       (11, 1, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '系统分组'),
       (12, 1, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '系统默认是'),
       (13, 1, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '系统默认否'),
       (14, 1, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '通知'),
       (15, 1, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '公告'),
       (16, 1, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 0, 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
       (17, 1, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '关闭状态'),
       (18, 1, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '其他操作'),
       (19, 1, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '新增操作'),
       (20, 1, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '修改操作'),
       (21, 1, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '删除操作'),
       (22, 1, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '授权操作'),
       (23, 1, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '导出操作'),
       (24, 1, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '导入操作'),
       (25, 1, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '强退操作'),
       (26, 1, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '生成操作'),
       (27, 1, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '清空操作'),
       (28, 1, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '正常状态'),
       (29, 1, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 0, 1, '2023-06-03 21:32:30', 1, NULL, '停用状态'),
       (30, 1, 1, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 0, 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '密码认证'),
       (31, 1, 2, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 0, 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '短信认证'),
       (32, 1, 3, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 0, 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '邮件认证'),
       (33, 1, 4, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 0, 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '小程序认证'),
       (34, 1, 5, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 0, 1, '2023-10-21 11:10:51', 1, '2023-10-21 11:10:51', '三方登录认证'),
       (35, 1, 1, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 0, 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', 'PC'),
       (36, 1, 2, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 0, 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', '安卓'),
       (37, 1, 3, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 0, 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', 'iOS'),
       (38, 1, 4, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 0, 1, '2023-10-21 11:41:10', 1, '2023-10-21 11:41:10', '小程序'),
       (100, 1, 0, '正常', '0', 'sys_student_status', NULL, 'primary', 'N', 0, 1, '2023-06-03 21:53:50', 1, '2023-06-03 21:55:24', NULL),
       (101, 1, 0, '停用', '1', 'sys_student_status', NULL, 'danger', 'N', 0, 1, '2023-06-03 21:54:11', 1, '2023-06-03 21:55:31', NULL),
       (102, 1, 0, '代码', '0', 'sys_student_hobby', NULL, 'primary', 'N', 0, 1, '2023-06-04 16:40:02', 1, NULL, NULL),
       (103, 1, 0, '音乐', '1', 'sys_student_hobby', NULL, 'success', 'N', 0, 1, '2023-06-04 16:40:24', 1, NULL, NULL),
       (104, 1, 0, '电影', '2', 'sys_student_hobby', NULL, 'warning', 'N', 0, 1, '2023-06-04 16:40:40', 1, '2023-06-04 16:40:49', NULL),
       (105, 1, 0, '计算机', '1', 'sys_goods_type', NULL, 'primary', 'N', 0, 1, '2023-06-05 07:23:48', 1, NULL, NULL),
       (106, 1, 0, '打印设备', '2', 'sys_goods_type', NULL, 'success', 'N', 0, 1, '2023-06-05 07:24:14', 1, NULL, NULL),
       (107, 1, 3, '衣服', '3', 'sys_goods_type', NULL, 'info', 'N', 0, 1, '2023-06-05 07:24:35', 1, NULL, NULL),
       (111, 1, 4, '网络设备', '4', 'sys_goods_type', NULL, 'default', NULL, 0, 1, '2023-09-19 17:31:46', 1, '2023-09-19 17:31:46', NULL),
       (65923231885905920, 1, 1, '桌面微机', 'PC', 'sys_app_type', NULL, 'default', 'N', 4, 1, '2023-10-01 10:56:23', 1, '2024-01-07 20:11:33', ''),
       (65923379802230784, 1, 2, '平板', 'pad', 'sys_app_type', NULL, 'default', 'N', 0, 1, '2023-10-01 10:56:59', 1, '2023-10-01 10:56:59', NULL),
       (65923470604718080, 1, 3, '手机', 'phone', 'sys_app_type', NULL, 'default', 'N', 0, 1, '2023-10-01 10:57:20', 1, '2023-10-01 10:57:20', NULL)
;

-- 导出  表 ruoyi-flex.sys_dict_type 结构
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE IF NOT EXISTS `sys_dict_type` (
       `dict_id` bigint NOT NULL COMMENT '字典主键',
       `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
       `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典名称',
       `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典类型',
       `version` int DEFAULT '0' COMMENT '乐观锁',
       `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
       `create_time` datetime DEFAULT NULL COMMENT '创建时间',
       `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
       `update_time` datetime DEFAULT NULL COMMENT '更新时间',
       `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
       PRIMARY KEY (`dict_id`),
       UNIQUE KEY `dict_type_unq_idx` (`tenant_id`,`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='字典类型表';

-- 正在导出表  ruoyi-flex.sys_dict_type 的数据：~32 rows (大约)
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
        (1, 1, '用户性别', 'sys_user_gender', 0, 1, '2023-06-03 21:32:30', 1, '2023-09-20 09:53:27', '用户性别列表'),
        (2, 1, '菜单状态', 'sys_show_hide', 0, 1, '2023-06-03 21:32:30', 1, NULL, '菜单状态列表'),
        (3, 1, '系统开关', 'sys_normal_disable', 0, 1, '2023-06-03 21:32:30', 1, NULL, '系统开关列表'),
        (4, 1, '任务状态', 'sys_job_status', 0, 1, '2023-06-03 21:32:30', 1, NULL, '任务状态列表'),
        (5, 1, '任务分组', 'sys_job_group', 0, 1, '2023-06-03 21:32:30', 1, NULL, '任务分组列表'),
        (6, 1, '系统是否', 'sys_yes_no', 0, 1, '2023-06-03 21:32:30', 1, NULL, '系统是否列表'),
        (7, 1, '通知类型', 'sys_notice_type', 0, 1, '2023-06-03 21:32:30', 1, NULL, '通知类型列表'),
        (8, 1, '通知状态', 'sys_notice_status', 0, 1, '2023-06-03 21:32:30', 1, NULL, '通知状态列表'),
        (9, 1, '操作类型', 'sys_oper_type', 0, 1, '2023-06-03 21:32:30', 1, NULL, '操作类型列表'),
        (10, 1, '系统状态', 'sys_common_status', 0, 1, '2023-06-03 21:32:30', 1, NULL, '登录状态列表'),
        (11, 1, '授权类型', 'sys_grant_type', 0, 1, '2023-10-21 11:06:33', 1, '2023-10-21 11:06:33', '认证授权类型'),
        (12, 1, '设备类型', 'sys_device_type', 0, 1, '2023-10-21 11:38:41', 1, '2023-10-21 11:38:41', '客户端设备类型'),
        (100, 1, '学生状态', 'sys_student_status', 0, 1, '2023-06-03 21:52:47', 1, '2023-06-03 21:53:09', NULL),
        (101, 1, '爱好', 'sys_student_hobby', 0, 1, '2023-06-04 16:39:16', 1, NULL, NULL),
        (102, 1, '商品种类', 'sys_goods_type', 0, 1, '2023-06-05 07:23:20', 1, NULL, NULL),
        (65922863223361536, 1, '系统类型', 'sys_app_type', 4, 1, '2023-10-01 10:54:55', 1, '2024-01-07 20:12:00', '系统类型列表');

-- 导出  表 ruoyi-flex.sys_logininfor 结构
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE IF NOT EXISTS `sys_logininfor` (
        `info_id` bigint NOT NULL COMMENT '访问ID',
        `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
        `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '用户账号',
        `client_key` varchar(32) COLLATE utf8mb4_bin DEFAULT '' COMMENT '客户端',
        `device_type` varchar(32) COLLATE utf8mb4_bin DEFAULT '' COMMENT '设备类型',
        `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '登录IP地址',
        `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '登录地点',
        `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '浏览器类型',
        `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '操作系统',
        `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
        `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '提示消息',
        `login_time` datetime DEFAULT NULL COMMENT '访问时间',
        PRIMARY KEY (`info_id`),
        KEY `idx_sys_logininfor_s` (`status`),
        KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='系统访问记录';

-- 导出  表 ruoyi-flex.sys_menu 结构
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE IF NOT EXISTS `sys_menu` (
      `menu_id` bigint NOT NULL COMMENT '菜单ID',
      `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
      `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
      `order_num` int DEFAULT '0' COMMENT '显示顺序',
      `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '路由地址',
      `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '组件路径',
      `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '路由参数',
      `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
      `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
      `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
      `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
      `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
      `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限标识',
      `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '#' COMMENT '菜单图标',
      `version` int DEFAULT '0' COMMENT '乐观锁',
      `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
      `update_by` bigint DEFAULT '0' COMMENT '更新者',
      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
      `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
      PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='菜单权限表';

-- 正在导出表  ruoyi-flex.sys_menu 的数据：~148 rows (大约)
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
      (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 0, 1, '2023-06-03 21:32:28', 1, NULL, '系统管理目录'),
      (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 0, 1, '2023-06-03 21:32:28', 1, NULL, '系统监控目录'),
      (3, '系统工具', 0, 4, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 1, 1, '2023-06-03 21:32:28', 1, '2024-01-07 21:47:00', '系统工具目录'),
      (4, '官方网站', 0, 99, 'https://gitee.com/dataprince/ruoyi-flex', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 1, 1, '2023-06-03 21:32:28', 1, '2024-01-07 21:47:26', '若依官网地址'),
      (6, '租户管理', 0, 3, 'tenant', NULL, '', 1, 0, 'M', '0', '0', '', 'chart', 1, 1, '2024-01-03 20:11:18', 1, '2024-01-07 21:45:55', '租户管理目录'),
      (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 0, 1, '2023-06-03 21:32:28', 1, NULL, '用户管理菜单'),
      (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 0, 1, '2023-06-03 21:32:28', 1, NULL, '角色管理菜单'),
      (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 0, 1, '2023-06-03 21:32:28', 1, NULL, '菜单管理菜单'),
      (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 0, 1, '2023-06-03 21:32:28', 1, NULL, '部门管理菜单'),
      (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 0, 1, '2023-06-03 21:32:28', 1, NULL, '岗位管理菜单'),
      (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 0, 1, '2023-06-03 21:32:28', 1, NULL, '字典管理菜单'),
      (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 0, 1, '2023-06-03 21:32:28', 1, NULL, '参数设置菜单'),
      (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 0, 1, '2023-06-03 21:32:28', 1, NULL, '通知公告菜单'),
      (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 0, 1, '2023-06-03 21:32:28', 1, NULL, '日志管理菜单'),
      (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 0, 1, '2023-06-03 21:32:28', 1, NULL, '在线用户菜单'),
      (110, '任务调度', 2, 2, 'powerjob', 'monitor/powerjob/index', '', 1, 0, 'C', '0', '0', 'monitor:powerjob:list', 'job', 0, 1, '2023-06-03 21:32:28', 1, NULL, '定时任务菜单'),
      (112, '服务监控', 2, 4, 'admin', 'monitor/admin/index', '', 1, 0, 'C', '0', '0', 'monitor:admin:list', 'server', 0, 1, '2023-06-03 21:32:28', 1, NULL, '服务监控菜单'),
      (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 0, 1, '2023-06-03 21:32:28', 1, NULL, '缓存监控菜单'),
      (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 0, 1, '2023-06-03 21:32:28', 1, NULL, '表单构建菜单'),
      (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 0, 1, '2023-06-03 21:32:28', 1, NULL, '代码生成菜单'),
      (117, '系统接口', 3, 3, 'http://localhost:8080/swagger-ui/index.html', '', '', 0, 0, 'M', '0', '0', 'tool:swagger:list', 'swagger', 0, 1, '2023-06-03 21:32:29', 1, '2023-07-28 21:09:07', '系统接口菜单'),
      (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', 1, 0, 'C', '0', '0', 'system:oss:list', 'upload', 0, 1, '2023-12-03 08:46:11', 1, '2023-12-03 08:46:11', '文件管理菜单'),
      (121, '租户管理', 6, 1, 'tenantMenu', 'system/tenant/index', '', 1, 0, 'C', '0', '0', 'system:tenant:list', 'list', 0, 1, '2024-01-03 20:11:18', NULL, NULL, '租户管理菜单'),
      (122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', '', 1, 0, 'C', '0', '0', 'system:tenantPackage:list', 'form', 0, 1, '2024-01-03 20:11:18', NULL, NULL, '租户套餐管理菜单'),
      (123, '客户端管理', 1, 11, 'client', 'system/client/index', '', 1, 0, 'C', '0', '0', 'system:client:list', 'international', 0, 1, '2024-01-03 21:29:43', NULL, NULL, '客户端管理菜单'),
      (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 0, 1, '2023-06-03 21:32:29', 1, NULL, '操作日志菜单'),
      (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 0, 1, '2023-06-03 21:32:29', 1, NULL, '登录日志菜单'),
      (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 0, 1, '2023-06-03 21:32:29', 1, NULL, ''),
      (1061, '客户端管理查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:query', '#', 0, 1, '2024-01-03 21:29:43', NULL, NULL, ''),
      (1062, '客户端管理新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:add', '#', 0, 1, '2024-01-03 21:29:43', NULL, NULL, ''),
      (1063, '客户端管理修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:edit', '#', 0, 1, '2024-01-03 21:29:43', NULL, NULL, ''),
      (1064, '客户端管理删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:remove', '#', 0, 1, '2024-01-03 21:29:43', NULL, NULL, ''),
      (1065, '客户端管理导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:export', '#', 0, 1, '2024-01-03 21:29:43', NULL, NULL, ''),
      (1600, '文件查询', 118, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:query', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1601, '文件上传', 118, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:upload', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1602, '文件下载', 118, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:download', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1603, '文件删除', 118, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:remove', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1606, '租户查询', 121, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:query', '#', 0, 1, '2024-01-03 20:11:18', NULL, NULL, ''),
      (1607, '租户新增', 121, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:add', '#', 0, 1, '2024-01-03 20:11:18', NULL, NULL, ''),
      (1608, '租户修改', 121, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:edit', '#', 0, 1, '2024-01-03 20:11:18', NULL, NULL, ''),
      (1609, '租户删除', 121, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:remove', '#', 0, 1, '2024-01-03 20:11:18', NULL, NULL, ''),
      (1610, '租户导出', 121, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:export', '#', 0, 1, '2024-01-03 20:11:18', NULL, NULL, ''),
      (1611, '租户套餐查询', 122, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:query', '#', 0, 1, '2024-01-03 20:11:19', NULL, NULL, ''),
      (1612, '租户套餐新增', 122, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:add', '#', 0, 1, '2024-01-03 20:11:19', NULL, NULL, ''),
      (1613, '租户套餐修改', 122, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:edit', '#', 0, 1, '2024-01-03 20:11:19', NULL, NULL, ''),
      (1614, '租户套餐删除', 122, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:remove', '#', 0, 1, '2024-01-03 20:11:19', NULL, NULL, ''),
      (1615, '租户套餐导出', 122, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:export', '#', 0, 1, '2024-01-03 20:11:19', NULL, NULL, ''),
      (1620, '配置列表', 118, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:list', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1621, '配置添加', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:add', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1622, '配置编辑', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:edit', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (1623, '配置删除', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:remove', '#', 0, 1, '2023-12-25 15:15:25', NULL, NULL, ''),
      (2018, '演示模块', 0, 20, 'demo', NULL, NULL, 1, 0, 'M', '0', '0', '', 'people', 1, 1, '2023-07-04 11:08:44', 1, '2024-01-07 21:47:44', ''),
      (2050, '学生信息单表(mb)', 2018, 1, 'student', 'demo/student/index', NULL, 1, 0, 'C', '0', '0', 'demo:student:list', 'component', 0, 1, '2023-07-09 12:17:40', 1, '2023-11-17 09:21:30', '学生信息单表(mb)菜单'),
      (2051, '学生信息单表(mb)查询', 2050, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:query', '#', 0, 1, '2023-07-09 12:17:40', 1, NULL, ''),
      (2052, '学生信息单表(mb)新增', 2050, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:add', '#', 0, 1, '2023-07-09 12:17:40', 1, NULL, ''),
      (2053, '学生信息单表(mb)修改', 2050, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:edit', '#', 0, 1, '2023-07-09 12:17:40', 1, NULL, ''),
      (2054, '学生信息单表(mb)删除', 2050, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:remove', '#', 0, 1, '2023-07-09 12:17:40', 1, NULL, ''),
      (2055, '学生信息单表(mb)导出', 2050, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:student:export', '#', 0, 1, '2023-07-09 12:17:40', 1, NULL, ''),
      (2056, '产品树表（mb）', 2018, 1, 'product', 'demo/product/index', NULL, 1, 0, 'C', '0', '0', 'demo:product:list', '#', 0, 1, '2023-07-09 20:59:25', 1, NULL, '产品树表（mb）菜单'),
      (2057, '产品树表（mb）查询', 2056, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:query', '#', 0, 1, '2023-07-09 20:59:25', 1, NULL, ''),
      (2058, '产品树表（mb）新增', 2056, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:add', '#', 0, 1, '2023-07-09 20:59:25', 1, NULL, ''),
      (2059, '产品树表（mb）修改', 2056, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:edit', '#', 0, 1, '2023-07-09 20:59:25', 1, NULL, ''),
      (2060, '产品树表（mb）删除', 2056, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:remove', '#', 0, 1, '2023-07-09 20:59:25', 1, NULL, ''),
      (2061, '产品树表（mb）导出', 2056, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:product:export', '#', 0, 1, '2023-07-09 20:59:25', 1, NULL, ''),
      (2062, '客户主表(mb)', 2018, 1, 'customer', 'demo/customer/index', NULL, 1, 0, 'C', '0', '0', 'demo:customer:list', '#', 0, 1, '2023-07-11 16:06:23', 1, NULL, '客户主表(mb)菜单'),
      (2063, '客户主表(mb)查询', 2062, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:query', '#', 0, 1, '2023-07-11 16:06:23', 1, NULL, ''),
      (2064, '客户主表(mb)新增', 2062, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:add', '#', 0, 1, '2023-07-11 16:06:23', 1, NULL, ''),
      (2065, '客户主表(mb)修改', 2062, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:edit', '#', 0, 1, '2023-07-11 16:06:23', 1, NULL, ''),
      (2066, '客户主表(mb)删除', 2062, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:remove', '#', 0, 1, '2023-07-11 16:06:23', 1, NULL, ''),
      (2067, '客户主表(mb)导出', 2062, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:customer:export', '#', 0, 1, '2023-07-11 16:06:23', 1, NULL, ''),
      (2071, '学生信息表', 2018, 1, 'mfstudent', 'mf/student/index', NULL, 1, 0, 'C', '0', '0', 'mf:student:list', '#', 0, 1, '2023-11-22 17:30:46', 1, '2023-12-07 14:35:16', '学生信息表菜单'),
      (2072, '学生信息表查询', 2071, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:query', '#', 0, 1, '2023-11-22 17:30:46', 1, NULL, ''),
      (2073, '学生信息表新增', 2071, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:add', '#', 0, 1, '2023-11-22 17:30:46', 1, NULL, ''),
      (2074, '学生信息表修改', 2071, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:edit', '#', 0, 1, '2023-11-22 17:30:46', 1, NULL, ''),
      (2075, '学生信息表删除', 2071, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:remove', '#', 0, 1, '2023-11-22 17:30:46', 1, NULL, ''),
      (2076, '学生信息表导出', 2071, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:student:export', '#', 0, 1, '2023-11-22 17:30:46', 1, NULL, ''),
      (2077, '产品树表', 2018, 1, 'mfproduct', 'mf/product/index', NULL, 1, 0, 'C', '0', '0', 'mf:product:list', '#', 0, 1, '2023-11-23 10:53:54', 1, '2023-12-07 14:35:12', '产品树菜单'),
      (2078, '产品树查询', 2077, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:query', '#', 0, 1, '2023-11-23 10:53:54', 1, NULL, ''),
      (2079, '产品树新增', 2077, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:add', '#', 0, 1, '2023-11-23 10:53:54', 1, NULL, ''),
      (2080, '产品树修改', 2077, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:edit', '#', 0, 1, '2023-11-23 10:53:54', 1, NULL, ''),
      (2081, '产品树删除', 2077, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:remove', '#', 0, 1, '2023-11-23 10:53:54', 1, NULL, ''),
      (2082, '产品树导出', 2077, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:product:export', '#', 0, 1, '2023-11-23 10:53:54', 1, NULL, ''),
      (2023121511351900, '客户主表', 2018, 1, 'mfcustomer', 'mf/customer/index', NULL, 1, 0, 'C', '0', '0', 'mf:customer:list', '#', 0, 1, '2023-12-15 11:36:19', 1, '2024-01-04 10:05:51', '客户主表菜单'),
      (2023121511351901, '客户主表查询', 2023121511351900, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:query', '#', 0, 1, '2023-12-15 11:36:19', 1, NULL, ''),
      (2023121511351902, '客户主表新增', 2023121511351900, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:add', '#', 0, 1, '2023-12-15 11:36:19', 1, NULL, ''),
      (2023121511351903, '客户主表修改', 2023121511351900, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:edit', '#', 0, 1, '2023-12-15 11:36:19', 1, NULL, ''),
      (2023121511351904, '客户主表删除', 2023121511351900, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:remove', '#', 0, 1, '2023-12-15 11:36:19', 1, NULL, ''),
      (2023121511351905, '客户主表导出', 2023121511351900, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'mf:customer:export', '#', 0, 1, '2023-12-15 11:36:19', 1, NULL, '');

-- 导出  表 ruoyi-flex.sys_notice 结构
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE IF NOT EXISTS `sys_notice` (
    `notice_id` bigint NOT NULL COMMENT '公告ID',
    `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
    `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告标题',
    `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告类型（1通知 2公告）',
    `notice_content` longblob COMMENT '公告内容',
    `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
    `version` int DEFAULT '0' COMMENT '乐观锁',
    `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='通知公告表';

-- 导出  表 ruoyi-flex.sys_oper_log 结构
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE IF NOT EXISTS `sys_oper_log` (
      `oper_id` bigint NOT NULL COMMENT '日志主键',
      `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
      `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '模块标题',
      `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
      `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '方法名称',
      `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '请求方式',
      `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
      `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '操作人员',
      `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '部门名称',
      `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '请求URL',
      `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '主机地址',
      `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '操作地点',
      `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '请求参数',
      `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '返回参数',
      `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
      `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '错误消息',
      `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
      `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
      PRIMARY KEY (`oper_id`),
      KEY `idx_sys_oper_log_bt` (`business_type`),
      KEY `idx_sys_oper_log_s` (`status`),
      KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='操作日志记录';

-- 导出  表 ruoyi-flex.sys_oss 结构
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE IF NOT EXISTS `sys_oss` (
     `oss_id` bigint NOT NULL COMMENT '对象存储主键',
     `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
     `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '文件名',
     `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '原名',
     `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '文件后缀名',
     `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'URL地址',
     `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'minio' COMMENT '服务商',
     `version` int DEFAULT '0' COMMENT '乐观锁',
     `create_by` bigint DEFAULT NULL COMMENT '上传人',
     `create_time` datetime DEFAULT NULL COMMENT '创建时间',
     `update_by` bigint DEFAULT NULL COMMENT '更新人',
     `update_time` datetime DEFAULT NULL COMMENT '更新时间',
     PRIMARY KEY (`oss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='OSS对象存储表';

-- 导出  表 ruoyi-flex.sys_oss_config 结构
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE IF NOT EXISTS `sys_oss_config` (
        `oss_config_id` bigint NOT NULL COMMENT '主建',
        `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
        `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '配置key',
        `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT 'accessKey',
        `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '秘钥',
        `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '桶名称',
        `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '前缀',
        `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '访问站点',
        `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '自定义域名',
        `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
        `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '域',
        `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
        `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
        `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '扩展字段',
        `version` int DEFAULT '0' COMMENT '乐观锁',
        `create_by` bigint DEFAULT NULL COMMENT '创建者',
        `create_time` datetime DEFAULT NULL COMMENT '创建时间',
        `update_by` bigint DEFAULT NULL COMMENT '更新者',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
        PRIMARY KEY (`oss_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='对象存储配置表';

-- 正在导出表  ruoyi-flex.sys_oss_config 的数据：~8 rows (大约)
INSERT INTO `sys_oss_config` (`oss_config_id`, `tenant_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
                                                                                                                                                                                                                                                                                               (1, 1, 'minio', 'ruoyi-flex', 'ruoyi-flex@369', 'ruoyi-flex', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', 4, 1, '2023-11-30 11:54:13', 1, '2024-01-07 19:53:44', ''),
                                                                                                                                                                                                                                                                                               (2, 1, 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 0, 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:25:43', NULL),
                                                                                                                                                                                                                                                                                               (3, 1, 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 0, 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:25:48', NULL),
                                                                                                                                                                                                                                                                                               (4, 1, 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 'cos.ap-beijing.myqcloud.com', '', 'N', '', '1', '1', '', 0, 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:26:02', NULL);


-- 导出  表 ruoyi-flex.sys_post 结构
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE IF NOT EXISTS `sys_post` (
      `post_id` bigint NOT NULL COMMENT '岗位ID',
      `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
      `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位编码',
      `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位名称',
      `post_sort` int NOT NULL COMMENT '显示顺序',
      `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态（0正常 1停用）',
      `version` int DEFAULT '0' COMMENT '乐观锁',
      `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
      `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
      `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
      PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='岗位信息表';

-- 正在导出表  ruoyi-flex.sys_post 的数据：~5 rows (大约)
INSERT INTO `sys_post` (`post_id`, `tenant_id`, `post_code`, `post_name`, `post_sort`, `status`, `version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
      (1, 1, 'ceo', '董事长', 1, '0', 0, 1, '2023-06-03 21:32:28', 1, '2023-09-02 15:43:55', ''),
      (2, 1, 'se', '项目经理', 2, '0', 0, 1, '2023-06-03 21:32:28', 1, NULL, ''),
      (3, 1, 'hr', '人力资源', 3, '0', 0, 1, '2023-06-03 21:32:28', 1, NULL, ''),
      (4, 1, 'users', '普通员工', 4, '0', 0, 1, '2023-06-03 21:32:28', 1, '2023-07-13 21:30:24', ''),
      (65917508166729728, 1, 'deptLeader', '部门管理岗', 6, '0', 1, 1, '2023-10-01 10:33:39', 1, '2024-01-07 21:42:57', '部门负责人岗位');

-- 导出  表 ruoyi-flex.sys_role 结构
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE IF NOT EXISTS `sys_role` (
      `role_id` bigint NOT NULL COMMENT '角色ID',
      `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户编号',
      `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
      `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色权限字符串',
      `role_sort` int NOT NULL COMMENT '显示顺序',
      `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
      `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
      `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
      `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
      `version` int DEFAULT '0' COMMENT '乐观锁',
      `del_flag` smallint DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
      `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
      `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
      `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
      PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色信息表';

-- 正在导出表  ruoyi-flex.sys_role 的数据：~10 rows (大约)
INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `version`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
    (1, 1, '超级管理员角色', 'SuperAdminRole', 1, '1', 1, 1, '0', 0, 0, 1, '2023-06-03 21:32:28', 1, NULL, '超级管理员');

-- 导出  表 ruoyi-flex.sys_role_dept 结构
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE IF NOT EXISTS `sys_role_dept` (
   `role_id` bigint NOT NULL COMMENT '角色ID',
   `dept_id` bigint NOT NULL COMMENT '部门ID',
   PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色和部门关联表';

-- 导出  表 ruoyi-flex.sys_role_menu 结构
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
                                               `role_id` bigint NOT NULL COMMENT '角色ID',
                                               `menu_id` bigint NOT NULL COMMENT '菜单ID',
                                               PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色和菜单关联表';

-- ----------------------------
-- 第三方平台授权表
-- ----------------------------
drop table if exists sys_social;
create table sys_social
(
    social_id          bigint           not null        comment '主键',
    user_id            bigint           not null        comment '用户ID',
    tenant_id          varchar(20)      DEFAULT '1'    comment '租户id',
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
    id_token           varchar(2000)     default null    comment 'id token，部分平台可能没有',
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

-- 导出  表 ruoyi-flex.sys_tenant 结构
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE IF NOT EXISTS `sys_tenant` (
    `tenant_id` bigint NOT NULL COMMENT '租户编号',
    `contact_user_name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系人',
    `contact_phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系电话',
    `company_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业名称',
    `license_number` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '统一社会信用代码',
    `address` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '地址',
    `intro` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业简介',
    `domain` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '域名',
    `remark` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
    `package_id` bigint DEFAULT NULL COMMENT '租户套餐编号',
    `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
    `account_count` int DEFAULT '-1' COMMENT '用户数量（-1不限制）',
    `version` int DEFAULT '0' COMMENT '乐观锁',
    `status` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
    `del_flag` smallint DEFAULT NULL COMMENT '删除标志（0代表存在 1代表删除）',
    `create_by` bigint DEFAULT NULL COMMENT '创建者',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_by` bigint DEFAULT NULL COMMENT '更新者',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='租户表';

-- 正在导出表  ruoyi-flex.sys_tenant 的数据：~2 rows (大约)
INSERT INTO `sys_tenant` (`tenant_id`, `contact_user_name`, `contact_phone`, `company_name`, `license_number`, `address`, `intro`, `domain`, `remark`, `package_id`, `expire_time`, `account_count`, `version`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
    (1, '联系人', '16888888888', 'Ruoyi-Flex公司', NULL, NULL, 'RuoYi-Flex多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, 0, '0', 0, 1, '2024-01-03 20:08:03', NULL, NULL);


-- 导出  表 ruoyi-flex.sys_tenant_package 结构
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE IF NOT EXISTS `sys_tenant_package` (
    `package_id` bigint NOT NULL COMMENT '租户套餐id',
    `package_name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '套餐名称',
    `menu_ids` varchar(3000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '关联菜单id',
    `remark` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
    `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
    `status` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `version` int DEFAULT '0' COMMENT '乐观锁',
    `del_flag` smallint DEFAULT NULL COMMENT '删除标志（0代表存在 1代表删除）',
    `create_by` bigint DEFAULT NULL COMMENT '创建者',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_by` bigint DEFAULT NULL COMMENT '更新者',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='租户套餐表';

-- 导出  表 ruoyi-flex.sys_user 结构
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE IF NOT EXISTS `sys_user` (
      `user_id` bigint NOT NULL COMMENT '用户ID',
      `tenant_id` bigint NOT NULL DEFAULT '1' COMMENT '租户主键',
      `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
      `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
      `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
      `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户、app_user App用户）',
      `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户邮箱',
      `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '手机号码',
      `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
      `avatar` bigint DEFAULT NULL COMMENT '头像地址',
      `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '密码',
      `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
      `version` int DEFAULT '0' COMMENT '乐观锁',
      `del_flag` smallint DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
      `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '最后登录IP',
      `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
      `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
      `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
      `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
      PRIMARY KEY (`user_id`),
      UNIQUE KEY `sys_user_unqindex_tenant_username` (`tenant_id`,`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户信息表';

-- 正在导出表  ruoyi-flex.sys_user 的数据：~13 rows (大约)
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `gender`, `avatar`, `password`, `status`, `version`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
    (1, 1, 1, 'superadmin', '超级管理员', 'sys_user', 'ry@163.com', '15888888888', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', 8, 0, '0:0:0:0:0:0:0:1', '2024-01-08 10:51:57', 1, '2023-06-03 21:32:28', 1, '2024-01-08 10:51:57', '管理员');

-- 导出  表 ruoyi-flex.sys_user_post 结构
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE IF NOT EXISTS `sys_user_post` (
                                               `user_id` bigint NOT NULL COMMENT '用户ID',
                                               `post_id` bigint NOT NULL COMMENT '岗位ID',
                                               PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户与岗位关联表';

-- 导出  表 ruoyi-flex.sys_user_role 结构
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE IF NOT EXISTS `sys_user_role` (
                                               `user_id` bigint NOT NULL COMMENT '用户ID',
                                               `role_id` bigint NOT NULL COMMENT '角色ID',
                                               PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户和角色关联表';

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
