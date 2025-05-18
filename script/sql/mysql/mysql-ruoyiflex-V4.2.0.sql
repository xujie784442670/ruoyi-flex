-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.27 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.4.0.6670
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='客户主表';

-- 正在导出表  ruoyi-flex.demo_customer 的数据：~2 rows (大约)
INSERT INTO `demo_customer` (`customer_id`, `customer_name`, `phonenumber`, `sex`, `birthday`, `remark`) VALUES
	(1, '哪吒三太子', '188888888', '0', '2023-07-06 00:00:00', '托塔李天王李靖三子啊'),
	(4, '李天', '1898989898', '1', '2023-07-03 00:00:00', '总裁');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='商品子表';

-- 正在导出表  ruoyi-flex.demo_goods 的数据：~4 rows (大约)
INSERT INTO `demo_goods` (`goods_id`, `customer_id`, `name`, `weight`, `price`, `date`, `type`) VALUES
	(1, 1, '乾坤圈', 22, 8000.00, '2023-07-04 00:00:00', '1'),
	(2, 1, '风火轮', 10, 90.00, '2023-07-10 00:00:00', '2'),
	(4, 4, '华为电脑', 8, 9000.00, '2023-07-03 00:00:00', '1'),
	(5, 1, '红缨枪', 10, 60.50, '2023-09-04 00:00:00', '3');

-- 导出  表 ruoyi-flex.demo_product 结构
DROP TABLE IF EXISTS `demo_product`;
CREATE TABLE IF NOT EXISTS `demo_product` (
  `product_id` bigint NOT NULL AUTO_INCREMENT COMMENT '产品id',
  `parent_id` bigint DEFAULT '0' COMMENT '父产品id',
  `product_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '产品名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '产品状态（0正常 1停用）',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品表';

-- 正在导出表  ruoyi-flex.demo_product 的数据：~7 rows (大约)
INSERT INTO `demo_product` (`product_id`, `parent_id`, `product_name`, `order_num`, `status`) VALUES
	(1, 0, '计算机', 1, '0'),
	(2, 1, '台式机', 1, '0'),
	(3, 1, '笔记本', 2, '0'),
	(5, 0, '图书', 5, '0'),
	(6, 5, '小说', 2, '0'),
	(8, 5, '小人书', 3, '0'),
	(10, 1, '平板电脑', 3, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='学生信息单表';

-- 正在导出表  ruoyi-flex.demo_student 的数据：~3 rows (大约)
INSERT INTO `demo_student` (`student_id`, `student_name`, `student_age`, `student_hobby`, `student_sex`, `student_status`, `student_birthday`) VALUES
	(1, '陈长安', 19, '2', '1', '1', '2023-07-06 00:00:00'),
	(2, '李白', 28, '0', '0', '0', '2023-07-01 00:00:00'),
	(5, '白居易', 0, '2', '0', '0', '2023-09-12 00:00:00'),
	(6, '王五', 65, '1', '0', '0', '1940-12-04 00:00:00');

-- 导出  表 ruoyi-flex.gen_table 结构
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE IF NOT EXISTS `gen_table` (
  `table_id` bigint NOT NULL COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作 sub主子表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其它生成选项',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='代码生成业务表';

-- 正在导出表  ruoyi-flex.gen_table 的数据：~5 rows (大约)
INSERT INTO `gen_table` (`table_id`, `table_name`, `table_comment`, `sub_table_name`, `sub_table_fk_name`, `class_name`, `tpl_category`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `gen_type`, `gen_path`, `options`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(13, 'mf_student', '学生信息单表', NULL, NULL, 'Student', 'crud', 'com.ruoyi.mf', 'mf', 'student', '学生信息表', '数据小王子', '0', '/', '{"parentMenuId":"2018"}', 1, '2023-11-17 14:12:07', 0, '2023-12-04 15:59:36', 'mybatis-flex版本的学生信息单表演示'),
	(15, 'mf_product', '产品树表', '', '', 'MfProduct', 'tree', 'com.ruoyi.mf', 'mf', 'product', '产品树', '数据小王子', '0', '/', '{"treeCode":"product_id","treeName":"product_name","treeParentCode":"parent_id","parentMenuId":"2018"}', 1, '2023-11-22 22:44:33', 0, '2023-11-23 10:57:43', 'mybatis-flex版本的产品树表演示'),
	(16, 'mf_customer', '客户主表', 'mf_goods', 'customer_id', 'Customer', 'sub', 'com.ruoyi.mf', 'mf', 'customer', '客户主表', '数据小王子', '0', '/', '{"parentMenuId":"2018"}', 1, '2023-12-04 22:19:16', 0, '2023-12-05 09:41:57', 'mybatis-flex格式的主子表测试'),
	(17, 'mf_goods', '商品子表', NULL, NULL, 'Goods', 'crud', 'com.ruoyi.demo', 'demo', 'goods', '商品子表', '数据小王子', '0', '/', '{}', 1, '2023-12-04 22:22:22', 0, '2023-12-05 10:50:30', NULL);

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
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='代码生成业务表字段';

-- 正在导出表  ruoyi-flex.gen_table_column 的数据：~48 rows (大约)
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
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

-- 导出  表 ruoyi-flex.mf_customer 结构
DROP TABLE IF EXISTS `mf_customer`;
CREATE TABLE IF NOT EXISTS `mf_customer` (
  `customer_id` bigint NOT NULL COMMENT '客户id',
  `customer_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '客户姓名',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '手机号码',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户性别',
  `birthday` datetime DEFAULT NULL COMMENT '客户生日',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户描述',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='客户主表';

-- 正在导出表  ruoyi-flex.mf_customer 的数据：~2 rows (大约)
INSERT INTO `mf_customer` (`customer_id`, `customer_name`, `phonenumber`, `gender`, `birthday`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(89658722841817088, '杨六郎', '1356667890', '2', '2021-02-10 00:00:00', '杨家将军', 1, '2023-12-05 22:52:45', 1, '2023-12-05 22:59:50'),
	(90186460908589056, '红星公司王总', '16666666666', '0', '2023-12-06 00:00:00', '红星总裁', 1, '2023-12-07 09:49:48', 1, '2023-12-07 09:49:48');

-- 导出  表 ruoyi-flex.mf_goods 结构
DROP TABLE IF EXISTS `mf_goods`;
CREATE TABLE IF NOT EXISTS `mf_goods` (
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `customer_id` bigint NOT NULL COMMENT '客户id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '商品名称',
  `weight` int DEFAULT NULL COMMENT '商品重量',
  `price` decimal(6,2) DEFAULT NULL COMMENT '商品价格',
  `date` datetime DEFAULT NULL COMMENT '商品时间',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '商品种类',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='商品子表';

-- 正在导出表  ruoyi-flex.mf_goods 的数据：~4 rows (大约)
INSERT INTO `mf_goods` (`goods_id`, `customer_id`, `name`, `weight`, `price`, `date`, `type`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(89659653381713920, 89658722841817088, 'mate70', 500, 8900.99, '2023-12-01 00:00:00', '1', 1, '2023-12-05 22:56:27', 1, '2023-12-05 22:56:27'),
	(89659653381713921, 89658722841817088, 'matebook', 1000, 6500.00, '2023-12-20 00:00:00', '4', 1, '2023-12-05 22:56:27', 1, '2023-12-05 22:56:27'),
	(89660505517486080, 89658722841817088, '帽子', 260, 150.50, '2023-11-28 00:00:00', '3', 1, '2023-12-05 22:59:50', 1, '2023-12-05 22:59:50'),
	(90186460988280832, 90186460908589056, '笔记本电脑', 200, 9000.00, '2023-12-05 00:00:00', '1', 1, '2023-12-07 09:49:48', 1, '2023-12-07 09:49:48');

-- 导出  表 ruoyi-flex.mf_product 结构
DROP TABLE IF EXISTS `mf_product`;
CREATE TABLE IF NOT EXISTS `mf_product` (
  `product_id` bigint NOT NULL COMMENT '产品id',
  `parent_id` bigint DEFAULT '0' COMMENT '父产品id',
  `product_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '产品名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '产品状态（0正常 1停用）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品树表';

-- 正在导出表  ruoyi-flex.mf_product 的数据：~7 rows (大约)
INSERT INTO `mf_product` (`product_id`, `parent_id`, `product_name`, `order_num`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(85129367654518784, 0, '电子产品', 1, '0', 1, '2023-11-23 10:54:43', 1, '2023-11-23 10:54:43'),
	(85129420259479552, 85129367654518784, '电视机', 1, '0', 1, '2023-11-23 10:54:55', 1, '2023-11-23 10:54:55'),
	(85129484625268736, 85129420259479552, '液晶电视', 2, '0', 1, '2023-11-23 10:55:11', 1, '2023-11-23 10:55:11'),
	(85129528472522752, 85129420259479552, 'CRT电视', 3, '0', 1, '2023-11-23 10:55:21', 1, '2023-11-23 10:55:21'),
	(85129594927075328, 85129367654518784, '计算机', 2, '0', 1, '2023-11-23 10:55:37', 1, '2023-11-23 10:55:37'),
	(85129658609192960, 85129594927075328, '手机', 3, '1', 1, '2023-11-23 10:55:52', 1, '2023-11-23 10:56:19'),
	(85129753568235520, 85129594927075328, '笔记本', 5, '0', 1, '2023-11-23 10:56:15', 1, '2023-11-23 10:56:15');

-- 导出  表 ruoyi-flex.mf_student 结构
DROP TABLE IF EXISTS `mf_student`;
CREATE TABLE IF NOT EXISTS `mf_student` (
  `student_id` bigint NOT NULL COMMENT '编号',
  `student_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '学生名称',
  `student_age` int DEFAULT NULL COMMENT '年龄',
  `student_hobby` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '爱好（0代码 1音乐 2电影）',
  `student_gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '性别（1男 2女 3未知）',
  `student_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `student_birthday` datetime DEFAULT NULL COMMENT '生日',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='学生信息单表';

-- 正在导出表  ruoyi-flex.mf_student 的数据：~2 rows (大约)
INSERT INTO `mf_student` (`student_id`, `student_name`, `student_age`, `student_hobby`, `student_gender`, `student_status`, `student_birthday`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(84904305550712832, '复制东', 18, '2', '1', '0', '2020-11-08 00:00:00', 1, '2023-11-22 20:00:24', 1, '2023-11-22 20:00:24'),
	(84938319879843840, '王芳', 28, '1', '1', '0', '2021-02-09 00:00:00', 1, '2023-11-22 22:15:34', 1, '2023-11-22 22:15:34');

-- 导出  表 ruoyi-flex.pj_app_info 结构
DROP TABLE IF EXISTS `pj_app_info`;
CREATE TABLE IF NOT EXISTS `pj_app_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `current_server` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uidx01_app_info` (`app_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_app_info 的数据：~0 rows (大约)
INSERT INTO `pj_app_info` (`id`, `app_name`, `current_server`, `gmt_create`, `gmt_modified`, `password`) VALUES
	(1, 'ruoyi-worker', '192.168.8.32:10010', '2023-06-13 16:32:59.263000', '2023-09-01 09:15:38.535000', '123456');

-- 导出  表 ruoyi-flex.pj_container_info 结构
DROP TABLE IF EXISTS `pj_container_info`;
CREATE TABLE IF NOT EXISTS `pj_container_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` bigint DEFAULT NULL,
  `container_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `last_deploy_time` datetime(6) DEFAULT NULL,
  `source_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `source_type` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx01_container_info` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_container_info 的数据：~0 rows (大约)

-- 导出  表 ruoyi-flex.pj_instance_info 结构
DROP TABLE IF EXISTS `pj_instance_info`;
CREATE TABLE IF NOT EXISTS `pj_instance_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actual_trigger_time` bigint DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  `expected_trigger_time` bigint DEFAULT NULL,
  `finished_time` bigint DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `instance_id` bigint DEFAULT NULL,
  `instance_params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `job_id` bigint DEFAULT NULL,
  `job_params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `last_report_time` bigint DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `running_times` bigint DEFAULT NULL,
  `status` int DEFAULT NULL,
  `task_tracker_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `type` int DEFAULT NULL,
  `wf_instance_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx01_instance_info` (`job_id`,`status`) USING BTREE,
  KEY `idx02_instance_info` (`app_id`,`status`) USING BTREE,
  KEY `idx03_instance_info` (`instance_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_instance_info 的数据：~0 rows (大约)

-- 导出  表 ruoyi-flex.pj_job_info 结构
DROP TABLE IF EXISTS `pj_job_info`;
CREATE TABLE IF NOT EXISTS `pj_job_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alarm_config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  `concurrency` int DEFAULT NULL,
  `designated_workers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `dispatch_strategy` int DEFAULT NULL,
  `execute_type` int DEFAULT NULL,
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `instance_retry_num` int DEFAULT NULL,
  `instance_time_limit` bigint DEFAULT NULL,
  `job_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `job_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `job_params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `lifecycle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `log_config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `max_instance_num` int DEFAULT NULL,
  `max_worker_count` int DEFAULT NULL,
  `min_cpu_cores` double NOT NULL,
  `min_disk_space` double NOT NULL,
  `min_memory_space` double NOT NULL,
  `next_trigger_time` bigint DEFAULT NULL,
  `notify_user_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `processor_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `processor_type` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `task_retry_num` int DEFAULT NULL,
  `time_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time_expression_type` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx01_job_info` (`app_id`,`status`,`time_expression_type`,`next_trigger_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_job_info 的数据：~4 rows (大约)
INSERT INTO `pj_job_info` (`id`, `alarm_config`, `app_id`, `concurrency`, `designated_workers`, `dispatch_strategy`, `execute_type`, `extra`, `gmt_create`, `gmt_modified`, `instance_retry_num`, `instance_time_limit`, `job_description`, `job_name`, `job_params`, `lifecycle`, `log_config`, `max_instance_num`, `max_worker_count`, `min_cpu_cores`, `min_disk_space`, `min_memory_space`, `next_trigger_time`, `notify_user_ids`, `processor_info`, `processor_type`, `status`, `tag`, `task_retry_num`, `time_expression`, `time_expression_type`) VALUES
	(1, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 2, 1, NULL, '2023-06-02 15:01:27.717000', '2023-07-04 17:22:12.374000', 1, 0, '', '单机处理器执行测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'org.dromara.job.processors.StandaloneProcessorDemo', 1, 2, NULL, 1, '30000', 3),
	(2, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 2, NULL, '2023-06-02 15:04:45.342000', '2023-07-04 17:22:12.816000', 0, 0, NULL, '广播处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'org.dromara.job.processors.BroadcastProcessorDemo', 1, 2, NULL, 1, '30000', 3),
	(3, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 4, NULL, '2023-06-02 15:13:23.519000', '2023-06-02 16:03:22.421000', 0, 0, NULL, 'Map处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'org.dromara.job.processors.MapProcessorDemo', 1, 2, NULL, 1, '1000', 3),
	(4, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 3, NULL, '2023-06-02 15:45:25.896000', '2023-06-02 16:03:23.125000', 0, 0, NULL, 'MapReduce处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'org.dromara.job.processors.MapReduceProcessorDemo', 1, 2, NULL, 1, '1000', 3);

-- 导出  表 ruoyi-flex.pj_oms_lock 结构
DROP TABLE IF EXISTS `pj_oms_lock`;
CREATE TABLE IF NOT EXISTS `pj_oms_lock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `lock_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `max_lock_time` bigint DEFAULT NULL,
  `ownerip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uidx01_oms_lock` (`lock_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_oms_lock 的数据：~0 rows (大约)

-- 导出  表 ruoyi-flex.pj_server_info 结构
DROP TABLE IF EXISTS `pj_server_info`;
CREATE TABLE IF NOT EXISTS `pj_server_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uidx01_server_info` (`ip`) USING BTREE,
  KEY `idx01_server_info` (`gmt_modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_server_info 的数据：~1 rows (大约)
INSERT INTO `pj_server_info` (`id`, `gmt_create`, `gmt_modified`, `ip`) VALUES
	(2, '2023-08-25 21:36:44.658000', '2023-12-14 15:07:24.714000', '192.168.8.32');

-- 导出  表 ruoyi-flex.pj_user_info 结构
DROP TABLE IF EXISTS `pj_user_info`;
CREATE TABLE IF NOT EXISTS `pj_user_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `web_hook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uidx01_user_info` (`username`) USING BTREE,
  KEY `uidx02_user_info` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_user_info 的数据：~0 rows (大约)

-- 导出  表 ruoyi-flex.pj_workflow_info 结构
DROP TABLE IF EXISTS `pj_workflow_info`;
CREATE TABLE IF NOT EXISTS `pj_workflow_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` bigint DEFAULT NULL,
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `lifecycle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `max_wf_instance_num` int DEFAULT NULL,
  `next_trigger_time` bigint DEFAULT NULL,
  `notify_user_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pedag` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` int DEFAULT NULL,
  `time_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time_expression_type` int DEFAULT NULL,
  `wf_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `wf_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx01_workflow_info` (`app_id`,`status`,`time_expression_type`,`next_trigger_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_workflow_info 的数据：~0 rows (大约)

-- 导出  表 ruoyi-flex.pj_workflow_instance_info 结构
DROP TABLE IF EXISTS `pj_workflow_instance_info`;
CREATE TABLE IF NOT EXISTS `pj_workflow_instance_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actual_trigger_time` bigint DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  `dag` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `expected_trigger_time` bigint DEFAULT NULL,
  `finished_time` bigint DEFAULT NULL,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `parent_wf_instance_id` bigint DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` int DEFAULT NULL,
  `wf_context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `wf_init_params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `wf_instance_id` bigint DEFAULT NULL,
  `workflow_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uidx01_wf_instance` (`wf_instance_id`) USING BTREE,
  KEY `idx01_wf_instance` (`workflow_id`,`status`,`app_id`,`expected_trigger_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_workflow_instance_info 的数据：~0 rows (大约)

-- 导出  表 ruoyi-flex.pj_workflow_node_info 结构
DROP TABLE IF EXISTS `pj_workflow_node_info`;
CREATE TABLE IF NOT EXISTS `pj_workflow_node_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` bigint NOT NULL,
  `enable` bit(1) NOT NULL,
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `gmt_create` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime(6) DEFAULT NULL,
  `job_id` bigint DEFAULT NULL,
  `node_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `node_params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `skip_when_failed` bit(1) NOT NULL,
  `type` int DEFAULT NULL,
  `workflow_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx01_workflow_node_info` (`workflow_id`,`gmt_create`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- 正在导出表  ruoyi-flex.pj_workflow_node_info 的数据：~0 rows (大约)

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
  `del_flag` smallint DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',  
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='系统授权表';

-- 正在导出表  ruoyi-flex.sys_client 的数据：~2 rows (大约)
INSERT INTO `sys_client` (`id`, `client_id`, `client_key`, `client_secret`, `grant_type`, `device_type`, `active_timeout`, `timeout`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', 0, 1, '2023-08-10 17:01:52', 1, '2023-08-10 17:01:52', NULL),
	(2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '0', 0, 1, '2023-08-10 17:01:52', 1, '2023-08-10 17:01:52', NULL);

-- 导出  表 ruoyi-flex.sys_config 结构
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE IF NOT EXISTS `sys_config` (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='参数配置表';

-- 正在导出表  ruoyi-flex.sys_config 的数据：~13 rows (大约)
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '主框架页-默认皮肤样式', 'sys.index.skinName', 'skin-blue', 'Y', 1, '2023-06-03 21:32:30', 1, '2023-09-12 17:56:29', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
	(2, '用户管理-账号初始密码', 'sys.user.initPassword', '12345678', 'Y', 1, '2023-06-03 21:32:30', 1, '2023-10-16 16:42:05', '初始化密码 12345678'),
	(3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '深色主题theme-dark，浅色主题theme-light'),
	(4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 1, '2023-06-03 21:32:30', 1, '2023-09-13 16:49:39', '是否开启验证码功能（true开启，false关闭）'),
	(5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'N', 1, '2023-06-03 21:32:30', 1, '2023-09-13 17:16:25', '是否开启注册用户功能（true开启，false关闭）'),
	(6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 1, '2023-06-03 21:32:30', 1, NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),	
	(11, 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 1, '2023-09-30 21:55:15', 1, '2023-12-10 19:49:53', 'true:开启, false:关闭');
	

-- 导出  表 ruoyi-flex.sys_dept 结构
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE IF NOT EXISTS `sys_dept` (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(760) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='部门表';

-- 正在导出表  ruoyi-flex.sys_dept 的数据：~19 rows (大约)
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, '2023-09-25 20:21:11'),
	(101, 100, '0,100', '深圳分公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, '2023-09-02 16:19:08'),
	(102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, NULL),
	(103, 201, '0,100,201', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, '2023-09-25 20:12:00'),
	(104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, NULL),
	(105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, NULL),
	(106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, NULL),
	(107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, NULL),
	(108, 201, '0,100,201', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, '2023-09-25 20:21:11'),
	(109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 1, '2023-06-03 21:32:28', 1, NULL),
	(200, 102, '0,100,102', '行政部', 4, NULL, NULL, NULL, '0', '0', 1, '2023-07-13 15:41:50', 1, NULL),
	(201, 100, '0,100', '武汉分公司', 3, NULL, NULL, NULL, '0', '0', 1, '2023-09-02 16:19:34', 1, '2023-09-25 20:21:11'),
	(202, 108, '0,100,201,108', '市场一部', 1, NULL, NULL, NULL, '0', '0', 1, '2023-09-24 20:44:43', 1, '2023-09-25 20:21:11'),
	(203, 108, '0,100,201,108', '市场二部', 2, NULL, NULL, NULL, '0', '0', 1, '2023-09-24 20:57:17', 1, '2023-09-25 20:21:11'),
	(204, 201, '0,100,201', '技术', 0, NULL, NULL, NULL, '0', '1', 1, '2023-09-25 20:22:02', 1, '2023-09-25 20:28:26'),
	(205, 204, '0,100,201,204', '技术一部', 1, NULL, NULL, NULL, '0', '1', 1, '2023-09-25 20:23:07', 1, '2023-09-25 20:27:13'),
	(65929080159150080, 100, '0,100', '山东分公司', 0, NULL, NULL, NULL, '0', '0', 1, '2023-10-01 11:19:38', 1, '2023-10-01 11:19:38'),
	(65929267321577472, 65929080159150080, '0,100,65929080159150080', '研发部', 0, NULL, NULL, NULL, '0', '0', 1, '2023-10-01 11:20:22', 1, '2023-10-01 11:20:22'),
	(65929460884512768, 65929080159150080, '0,100,65929080159150080', '售后部', 1, NULL, NULL, NULL, '0', '0', 1, '2023-10-01 11:21:08', 1, '2023-10-01 11:21:08');

-- 导出  表 ruoyi-flex.sys_dict_data 结构
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE IF NOT EXISTS `sys_dict_data` (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='字典数据表';

-- 正在导出表  ruoyi-flex.sys_dict_data 的数据：~50 rows (大约)
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
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

-- 导出  表 ruoyi-flex.sys_dict_type 结构
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE IF NOT EXISTS `sys_dict_type` (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '字典类型',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='字典类型表';

-- 正在导出表  ruoyi-flex.sys_dict_type 的数据：~16 rows (大约)
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
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

-- 导出  表 ruoyi-flex.sys_logininfor 结构
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE IF NOT EXISTS `sys_logininfor` (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '用户账号',
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
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='菜单权限表';

-- 正在导出表  ruoyi-flex.sys_menu 的数据：~121 rows (大约)
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
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

-- 导出  表 ruoyi-flex.sys_notice 结构
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE IF NOT EXISTS `sys_notice` (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='通知公告表';

-- 正在导出表  ruoyi-flex.sys_notice 的数据：~3 rows (大约)
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '温馨提醒：2023-07-04 RuoYi-Flex新版本v4发布啦', '2', _binary 0x3c703e3c7370616e20636c6173733d22716c2d73697a652d6c6172676522207374796c653d22636f6c6f723a20726762283233302c20302c2030293b223e52756f59692d466c65783c2f7370616e3e3c7370616e20636c6173733d22716c2d73697a652d6c61726765223ee696b0e78988e69cace58685e5aeb9e5a682e4b88befbc9a3c2f7370616e3e3c2f703e3c703e3c7370616e20636c6173733d22716c2d73697a652d6c61726765223e2031e38081e59fbae4ba8e52756f59692d5675652d76332e382e36e3808172756f692d7675652d706c7573efbc8ce591bde5908de4b8ba52756f59692d466c6578efbc8ce78988e69cace58fb7e4b8ba3c2f7370616e3e3c7370616e20636c6173733d22716c2d73697a652d6c6172676522207374796c653d22636f6c6f723a2072676228302c203133382c2030293b223e56342e302e303c2f7370616e3e3c2f703e3c703e3c7370616e20636c6173733d22716c2d73697a652d6c61726765223e2032e38081e5bc95e585a56d7962617469732d666c657856312e342e35efbc8ce4b88e6d796261746973e5928ce5b9b3e585b1e5a4843c2f7370616e3e3c2f703e3c703e3c7370616e20636c6173733d22716c2d73697a652d6c61726765223e2033e380816d6176656ee4bb93e5ba93e4bb8ee998bfe9878ce58887e68da2e588b0e58d8ee4b8ba3c2f7370616e3e3c2f703e, '0', 1, '2023-06-03 21:32:31', 1, '2023-09-02 11:00:33', '管理员'),
	(2, '维护通知：2018-07-01 若依系统凌晨维护', '1', _binary 0xe7bbb4e68aa4e58685e5aeb9, '0', 1, '2023-06-03 21:32:31', 1, NULL, '管理员'),
	(65910205589770240, 'ruoyi-flex 4.1.8准备发布了', '2', _binary 0x72756f79692d666c657820342e312e38e58786e5a487e58f91e5b883e4ba86efbc8ce697a5e69c9fe98089e59ca83130e69c88e4bbbd, '0', 1, '2023-10-01 10:04:38', 1, '2023-10-01 10:04:38', NULL);

-- 导出  表 ruoyi-flex.sys_oper_log 结构
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE IF NOT EXISTS `sys_oper_log` (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
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
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'URL地址',
  `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'minio' COMMENT '服务商',
  `create_by` bigint DEFAULT NULL COMMENT '上传人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`oss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='OSS对象存储表';

-- 正在导出表  ruoyi-flex.sys_oss 的数据：~2 rows (大约)
INSERT INTO `sys_oss` (`oss_id`, `file_name`, `original_name`, `file_suffix`, `url`, `service`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(88730743081086976, '2023/12/03/414e8f1ed3d146abb1a669a3a2bd0430.jpeg', 'avator2.jpeg', '.jpeg', 'http://127.0.0.1:9000/ruoyi-flex/2023/12/03/414e8f1ed3d146abb1a669a3a2bd0430.jpeg', 'minio', 1, '2023-12-03 09:25:18', 1, '2023-12-03 09:25:18'),
	(91380978089472000, '2023/12/10/ae432cf738fe4facb11831304ace1867.jpeg', 'avator.jpeg', '.jpeg', 'http://127.0.0.1:9000/ruoyi-flex/2023/12/10/ae432cf738fe4facb11831304ace1867.jpeg', 'minio', 1, '2023-12-10 16:56:23', 1, '2023-12-10 16:56:23');

-- 导出  表 ruoyi-flex.sys_oss_config 结构
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE IF NOT EXISTS `sys_oss_config` (
  `oss_config_id` bigint NOT NULL COMMENT '主建',
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
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='对象存储配置表';

-- 正在导出表  ruoyi-flex.sys_oss_config 的数据：~4 rows (大约)
INSERT INTO `sys_oss_config` (`oss_config_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 'minio', 'ruoyi-flex', 'ruoyi-flex@369', 'ruoyi-flex', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', 1, '2023-11-30 11:54:13', 1, '2023-12-03 09:07:42', NULL),
	(2, 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:25:43', NULL),
	(3, 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:25:48', NULL),
	(4, 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-flex', '', 'cos.ap-beijing.myqcloud.com', '', 'N', '', '1', '1', '', 1, '2023-11-30 11:54:13', 1, '2023-12-01 14:26:02', NULL);

-- 导出  表 ruoyi-flex.sys_post 结构
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE IF NOT EXISTS `sys_post` (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='岗位信息表';

-- 正在导出表  ruoyi-flex.sys_post 的数据：~5 rows (大约)
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 'ceo', '董事长', 1, '0', 1, '2023-06-03 21:32:28', 1, '2023-09-02 15:43:55', ''),
	(2, 'se', '项目经理', 2, '0', 1, '2023-06-03 21:32:28', 1, NULL, ''),
	(3, 'hr', '人力资源', 3, '0', 1, '2023-06-03 21:32:28', 1, NULL, ''),
	(4, 'users', '普通员工', 4, '0', 1, '2023-06-03 21:32:28', 1, '2023-07-13 21:30:24', ''),
	(5, 'deptLeader', '部门管理岗', 5, '0', 1, '2023-10-01 10:33:39', 1, '2023-10-01 10:33:39', '部门负责人岗位');

-- 导出  表 ruoyi-flex.sys_role 结构
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE IF NOT EXISTS `sys_role` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色信息表';

-- 正在导出表  ruoyi-flex.sys_role 的数据：~7 rows (大约)
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '超级管理员角色', 'admin', 1, '1', 1, 1, '0', '0', 1, '2023-06-03 21:32:28', 1, NULL, '超级管理员'),
	(2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 1, '2023-06-03 21:32:28', 2, '2023-12-14 21:23:08', '普通角色'),
	(101, '测试角色名称', 'test', 9, '3', 1, 1, '0', '0', 1, '2023-09-03 11:12:24', 1, '2023-12-14 16:41:05', '备注'),
	(107, '本部门及以下角色', 'deptAdmin', 10, '4', 1, 1, '0', '0', 1, '2023-09-30 10:31:25', 1, '2023-11-21 16:08:09', '部门备注'),
	(15649521177000164, '本部门角色', 'OnlyDept', 13, '3', 1, 1, '0', '0', 1, '2023-09-30 16:06:21', 1, '2023-11-21 09:17:59', '本部门可见'),
	(65643961968087040, '本人角色', 'OnlyMe', 14, '5', 1, 1, '0', '0', 1, '2023-09-30 16:26:40', 1, '2023-10-27 20:08:29', NULL),
	(65652406490345472, '自定义角色', 'customRole', 20, '2', 1, 1, '0', '0', 1, '2023-09-30 17:00:13', 1, '2023-11-21 15:41:54', '自定义');

-- 导出  表 ruoyi-flex.sys_role_dept 结构
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE IF NOT EXISTS `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色和部门关联表';

-- 正在导出表  ruoyi-flex.sys_role_dept 的数据：~9 rows (大约)
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES
	(2, 100),
	(2, 101),
	(2, 105),
	(65652406490345472, 100),
	(65652406490345472, 103),
	(65652406490345472, 108),
	(65652406490345472, 201),
	(65652406490345472, 202),
	(65652406490345472, 203);

-- 导出  表 ruoyi-flex.sys_role_menu 结构
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='角色和菜单关联表';

-- 正在导出表  ruoyi-flex.sys_role_menu 的数据：~465 rows (大约)
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
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

-- 导出  表 ruoyi-flex.sys_tenant 结构
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE IF NOT EXISTS `sys_tenant` (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` bigint NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `package_id` bigint DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `account_count` int DEFAULT '-1' COMMENT '用户数量（-1不限制）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='租户表';

-- 正在导出表  ruoyi-flex.sys_tenant 的数据：~0 rows (大约)
INSERT INTO `sys_tenant` (`id`, `tenant_id`, `contact_user_name`, `contact_phone`, `company_name`, `license_number`, `address`, `intro`, `domain`, `remark`, `package_id`, `expire_time`, `account_count`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(1, 1, '租户管理组', '18888888888', 'XXX有限公司', NULL, NULL, 'RuoYi-Flex多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', '0', 1, '2023-08-13 08:08:08', NULL, NULL);

-- 导出  表 ruoyi-flex.sys_user 结构
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户主键',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户、app_user App用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '手机号码',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` bigint DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户信息表';

-- 正在导出表  ruoyi-flex.sys_user 的数据：~9 rows (大约)
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `gender`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 1, 103, 'admin', '若依', 'sys_user', 'ry@163.com', '15888888888', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2023-12-18 10:57:01', 1, '2023-06-03 21:32:28', 1, '2023-12-18 10:57:01', '管理员'),
	(2, 1, 65929080159150080, 'ry', 'ruoyi-flex', 'sys_user', 'ry@qq.com', '15666666666', '1', NULL, '$2a$10$LM1zq1y9I7QhvnMOK5NPuOkyr9r7fo8IGm2MGfeD5KKdQAOLcRmEe', '0', '0', '0:0:0:0:0:0:0:1', '2023-12-14 21:22:18', 1, '2023-06-03 21:32:28', 2, '2023-12-14 21:22:18', '测试员'),
	(100, 1, 102, 'flex', 'flex昵称', 'sys_user', 'flex8888@163.com', '18808928888', '0', NULL, '$2a$10$jbN5LcYAQQ2E8g8MT.w7cu1YFNwKa/Nf4.A373DUc9fyRHLl9zwWO', '0', '0', '127.0.0.1', '2023-11-15 16:42:43', 1, '2023-07-06 16:49:17', 100, '2023-11-15 16:45:08', NULL),
	(101, 0, 100, 'vue3', 'vue3用户名', 'sys_user', '', '', '0', NULL, '$2a$10$MEjgdOQgvs7obwu6yoVnLO/K3wGPMlV3CAQMxVIpqwebFZat22NUW', '1', '0', '', NULL, 1, '2023-09-12 11:53:15', 1, '2023-10-16 17:15:32', 'vue3新增测试用户'),
	(71449897878007808, 0, 65929080159150080, 'java', 'java', 'sys_user', 'javaisgood@qq.com', '18966666666', '0', NULL, '$2a$10$fPvJrZBCZojxIauT/VERm.gX6jGVLfJLkKo5j5DGJstT6dO/AX4Dm', '0', '0', '127.0.0.1', '2023-11-21 19:28:48', 1, '2023-10-16 16:57:23', 71449897878007808, '2023-11-21 19:28:48', 'java用户'),
	(71454850805735424, 0, 65929460884512768, 'java2', 'java2', 'sys_user', 'java2@1126.com', '18855556963', '1', NULL, '$2a$10$m2g/pdS9ciOBYfVAEH6FoOsC2.Ls7b86oQ/TM/4WowwvGGE1aSRLS', '0', '1', '', NULL, 1, '2023-10-16 17:17:04', 1, '2023-10-16 17:19:24', NULL),
	(71500938010955776, 0, 65929267321577472, 'javaTest', 'java测试', 'sys_user', 'test@163.com', '13366666666', '0', NULL, '', '0', '0', '127.0.0.1', '2023-10-19 20:49:24', 1, '2023-10-16 20:20:12', 71449897878007808, '2023-11-21 09:35:54', NULL),
	(75077525943939072, 0, 65929460884512768, 'li', 'li', 'sys_user', 'li@qq.com', '13666666666', '0', NULL, '', '0', '0', '', NULL, 1, '2023-10-26 17:12:17', 1, '2023-11-21 16:07:15', NULL),
	(75081100715675648, 0, 203, 'vue3-li', 'vue3-li', 'sys_user', 'vue3-li@qq.com', '13566666666', '1', NULL, '', '0', '0', '127.0.0.1', '2023-10-27 22:33:10', 1, '2023-10-26 17:26:29', 71449897878007808, '2023-11-21 16:26:17', NULL);

-- 导出  表 ruoyi-flex.sys_user_post 结构
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE IF NOT EXISTS `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户与岗位关联表';

-- 正在导出表  ruoyi-flex.sys_user_post 的数据：~9 rows (大约)
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES
	(1, 1),
	(2, 2),
	(100, 4),
	(100, 65917508166729728),
	(101, 3),
	(101, 4),
	(71449897878007808, 4),
	(71449897878007808, 65917508166729728),
	(75081100715675648, 4);

-- 导出  表 ruoyi-flex.sys_user_role 结构
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE IF NOT EXISTS `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户和角色关联表';

-- 正在导出表  ruoyi-flex.sys_user_role 的数据：~16 rows (大约)
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES
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

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
