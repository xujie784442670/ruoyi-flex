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
    (1, 'ruoyi-worker', '127.0.0.1:10010', '2023-06-13 16:32:59.263000', '2023-09-01 09:15:38.535000', '123456');

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
      (1, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 2, 1, NULL, '2023-06-02 15:01:27.717000', '2023-07-04 17:22:12.374000', 1, 0, '', '单机处理器执行测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.StandaloneProcessorDemo', 1, 2, NULL, 1, '30000', 3),
      (2, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 2, NULL, '2023-06-02 15:04:45.342000', '2023-07-04 17:22:12.816000', 0, 0, NULL, '广播处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.BroadcastProcessorDemo', 1, 2, NULL, 1, '30000', 3),
      (3, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 4, NULL, '2023-06-02 15:13:23.519000', '2023-06-02 16:03:22.421000', 0, 0, NULL, 'Map处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.MapProcessorDemo', 1, 2, NULL, 1, '1000', 3),
      (4, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 3, NULL, '2023-06-02 15:45:25.896000', '2023-06-02 16:03:23.125000', 0, 0, NULL, 'MapReduce处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.MapReduceProcessorDemo', 1, 2, NULL, 1, '1000', 3);

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


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
