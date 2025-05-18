-- 导出  表 public.pj_app_info 结构
DROP TABLE IF EXISTS "pj_app_info";
CREATE TABLE IF NOT EXISTS "pj_app_info" (
     "id" BIGINT NOT NULL,
     "app_name" VARCHAR(255) NULL DEFAULT NULL,
    "current_server" VARCHAR(255) NULL DEFAULT NULL,
    "gmt_create" TIMESTAMP NULL DEFAULT NULL,
    "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
    "password" VARCHAR(255) NULL DEFAULT NULL,
    CONSTRAINT pj_app_info_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_app_info UNIQUE (app_name)
    );

-- 正在导出表  public.pj_app_info 的数据：1 rows
/*!40000 ALTER TABLE "pj_app_info" DISABLE KEYS */;
INSERT INTO "pj_app_info" ("id", "app_name", "current_server", "gmt_create", "gmt_modified", "password") VALUES
    (1, 'ruoyi-worker', '127.0.0.1:10010', '2023-06-13 16:32:59.263', '2023-07-04 17:25:49.798', '123456');
/*!40000 ALTER TABLE "pj_app_info" ENABLE KEYS */;

-- 导出  表 public.pj_container_info 结构
DROP TABLE IF EXISTS "pj_container_info";
CREATE TABLE IF NOT EXISTS "pj_container_info" (
   "id" BIGINT NOT NULL,
   "app_id" BIGINT NULL DEFAULT NULL,
   "container_name" VARCHAR(255) NULL DEFAULT NULL,
    "gmt_create" TIMESTAMP NULL DEFAULT NULL,
    "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
    "last_deploy_time" TIMESTAMP NULL DEFAULT NULL,
    "source_info" VARCHAR(255) NULL DEFAULT NULL,
    "source_type" INTEGER NULL DEFAULT NULL,
    "status" INTEGER NULL DEFAULT NULL,
    "version" VARCHAR(255) NULL DEFAULT NULL,
    CONSTRAINT pj_container_info_pkey PRIMARY KEY (id)
    );
CREATE INDEX idx01_container_info ON pj_container_info USING btree (app_id);

-- 正在导出表  public.pj_container_info 的数据：0 rows
/*!40000 ALTER TABLE "pj_container_info" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_container_info" ENABLE KEYS */;

-- 导出  表 public.pj_instance_info 结构
DROP TABLE IF EXISTS "pj_instance_info";
CREATE TABLE IF NOT EXISTS "pj_instance_info" (
  "id" BIGINT NOT NULL,
  "actual_trigger_time" BIGINT NULL DEFAULT NULL,
  "app_id" BIGINT NULL DEFAULT NULL,
  "expected_trigger_time" BIGINT NULL DEFAULT NULL,
  "finished_time" BIGINT NULL DEFAULT NULL,
  "gmt_create" TIMESTAMP NULL DEFAULT NULL,
  "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
  "instance_id" BIGINT NULL DEFAULT NULL,
  "instance_params" text NULL DEFAULT NULL,
  "job_id" BIGINT NULL DEFAULT NULL,
  "job_params" text NULL DEFAULT NULL,
  "last_report_time" BIGINT NULL DEFAULT NULL,
  "result" text NULL DEFAULT NULL,
  "running_times" BIGINT NULL DEFAULT NULL,
  "status" INTEGER NULL DEFAULT NULL,
  "task_tracker_address" VARCHAR(255) NULL DEFAULT NULL,
    "type" INTEGER NULL DEFAULT NULL,
    "wf_instance_id" BIGINT NULL DEFAULT NULL,
    CONSTRAINT pj_instance_info_pkey PRIMARY KEY (id)
    );
CREATE INDEX idx01_instance_info ON pj_instance_info USING btree (job_id, status);
CREATE INDEX idx02_instance_info ON pj_instance_info USING btree (app_id, status);
CREATE INDEX idx03_instance_info ON pj_instance_info USING btree (instance_id, status);

-- 正在导出表  public.pj_instance_info 的数据：-1 rows
/*!40000 ALTER TABLE "pj_instance_info" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_instance_info" ENABLE KEYS */;

-- 导出  表 public.pj_job_info 结构
DROP TABLE IF EXISTS "pj_job_info";
CREATE TABLE IF NOT EXISTS "pj_job_info" (
     "id" BIGINT NOT NULL,
     "alarm_config" VARCHAR(255) NULL DEFAULT NULL,
    "app_id" BIGINT NULL DEFAULT NULL,
    "concurrency" INTEGER NULL DEFAULT NULL,
    "designated_workers" VARCHAR(255) NULL DEFAULT NULL,
    "dispatch_strategy" INTEGER NULL DEFAULT NULL,
    "execute_type" INTEGER NULL DEFAULT NULL,
    "extra" VARCHAR(255) NULL DEFAULT NULL,
    "gmt_create" TIMESTAMP NULL DEFAULT NULL,
    "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
    "instance_retry_num" INTEGER NULL DEFAULT NULL,
    "instance_time_limit" BIGINT NULL DEFAULT NULL,
    "job_description" VARCHAR(255) NULL DEFAULT NULL,
    "job_name" VARCHAR(255) NULL DEFAULT NULL,
    "job_params" text NULL DEFAULT NULL,
    "lifecycle" VARCHAR(255) NULL DEFAULT NULL,
    "log_config" VARCHAR(255) NULL DEFAULT NULL,
    "max_instance_num" INTEGER NULL DEFAULT NULL,
    "max_worker_count" INTEGER NULL DEFAULT NULL,
    "min_cpu_cores" DOUBLE PRECISION NOT NULL,
    "min_disk_space" DOUBLE PRECISION NOT NULL,
    "min_memory_space" DOUBLE PRECISION NOT NULL,
    "next_trigger_time" BIGINT NULL DEFAULT NULL,
    "notify_user_ids" VARCHAR(255) NULL DEFAULT NULL,
    "processor_info" VARCHAR(255) NULL DEFAULT NULL,
    "processor_type" INTEGER NULL DEFAULT NULL,
    "status" INTEGER NULL DEFAULT NULL,
    "tag" VARCHAR(255) NULL DEFAULT NULL,
    "task_retry_num" INTEGER NULL DEFAULT NULL,
    "time_expression" VARCHAR(255) NULL DEFAULT NULL,
    "time_expression_type" INTEGER NULL DEFAULT NULL,
    CONSTRAINT pj_job_info_pkey PRIMARY KEY (id)
    );
CREATE INDEX idx01_job_info ON pj_job_info USING btree (app_id, status, time_expression_type, next_trigger_time);


-- 正在导出表  public.pj_job_info 的数据：4 rows
/*!40000 ALTER TABLE "pj_job_info" DISABLE KEYS */;
INSERT INTO "pj_job_info" ("id", "alarm_config", "app_id", "concurrency", "designated_workers", "dispatch_strategy", "execute_type", "extra", "gmt_create", "gmt_modified", "instance_retry_num", "instance_time_limit", "job_description", "job_name", "job_params", "lifecycle", "log_config", "max_instance_num", "max_worker_count", "min_cpu_cores", "min_disk_space", "min_memory_space", "next_trigger_time", "notify_user_ids", "processor_info", "processor_type", "status", "tag", "task_retry_num", "time_expression", "time_expression_type") VALUES
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              (1, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 2, 1, NULL, '2023-06-02 15:01:27.717', '2023-07-04 17:22:12.374', 1, 0, '', '单机处理器执行测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.StandaloneProcessorDemo', 1, 2, NULL, 1, '30000', 3),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              (2, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 2, NULL, '2023-06-02 15:04:45.342', '2023-07-04 17:22:12.816', 0, 0, NULL, '广播处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.BroadcastProcessorDemo', 1, 2, NULL, 1, '30000', 3),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              (3, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 4, NULL, '2023-06-02 15:13:23.519', '2023-06-02 16:03:22.421', 0, 0, NULL, 'Map处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.MapProcessorDemo', 1, 2, NULL, 1, '1000', 3),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              (4, '{"alertThreshold":0,"silenceWindowLen":0,"statisticWindowLen":0}', 1, 5, '', 1, 3, NULL, '2023-06-02 15:45:25.896', '2023-06-02 16:03:23.125', 0, 0, NULL, 'MapReduce处理器测试', NULL, '{}', '{"type":1}', 0, 0, 0, 0, 0, NULL, NULL, 'com.ruoyi.job.processors.MapReduceProcessorDemo', 1, 2, NULL, 1, '1000', 3);
/*!40000 ALTER TABLE "pj_job_info" ENABLE KEYS */;

-- 导出  表 public.pj_oms_lock 结构
DROP TABLE IF EXISTS "pj_oms_lock";
CREATE TABLE IF NOT EXISTS "pj_oms_lock" (
     "id" BIGINT NOT NULL,
     "gmt_create" TIMESTAMP NULL DEFAULT NULL,
     "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
     "lock_name" VARCHAR(255) NULL DEFAULT NULL,
    "max_lock_time" BIGINT NULL DEFAULT NULL,
    "ownerip" VARCHAR(255) NULL DEFAULT NULL,
    CONSTRAINT pj_oms_lock_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_oms_lock UNIQUE (lock_name)
    );

-- 正在导出表  public.pj_oms_lock 的数据：-1 rows
/*!40000 ALTER TABLE "pj_oms_lock" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_oms_lock" ENABLE KEYS */;

-- 导出  表 public.pj_server_info 结构
DROP TABLE IF EXISTS "pj_server_info";
CREATE TABLE IF NOT EXISTS "pj_server_info" (
    "id" BIGINT NOT NULL,
    "gmt_create" TIMESTAMP NULL DEFAULT NULL,
    "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
    "ip" VARCHAR(255) NULL DEFAULT NULL,
    CONSTRAINT pj_server_info_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_server_info UNIQUE (ip)
    );
CREATE INDEX idx01_server_info ON pj_server_info USING btree (gmt_modified);

-- 正在导出表  public.pj_server_info 的数据：-1 rows
/*!40000 ALTER TABLE "pj_server_info" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_server_info" ENABLE KEYS */;

-- 导出  表 public.pj_user_info 结构
DROP TABLE IF EXISTS "pj_user_info";
CREATE TABLE IF NOT EXISTS "pj_user_info" (
  "id" BIGINT NOT NULL,
  "email" VARCHAR(255) NULL DEFAULT NULL,
    "extra" VARCHAR(255) NULL DEFAULT NULL,
    "gmt_create" TIMESTAMP NULL DEFAULT NULL,
    "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
    "password" VARCHAR(255) NULL DEFAULT NULL,
    "phone" VARCHAR(255) NULL DEFAULT NULL,
    "username" VARCHAR(255) NULL DEFAULT NULL,
    "web_hook" VARCHAR(255) NULL DEFAULT NULL,
    CONSTRAINT pj_user_info_pkey PRIMARY KEY (id)
    );
CREATE INDEX uidx01_user_info ON pj_user_info USING btree (username);
CREATE INDEX uidx02_user_info ON pj_user_info USING btree (email);

-- 正在导出表  public.pj_user_info 的数据：-1 rows
/*!40000 ALTER TABLE "pj_user_info" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_user_info" ENABLE KEYS */;

-- 导出  表 public.pj_workflow_info 结构
DROP TABLE IF EXISTS "pj_workflow_info";
CREATE TABLE IF NOT EXISTS "pj_workflow_info" (
      "id" BIGINT NOT NULL,
      "app_id" BIGINT NULL DEFAULT NULL,
      "extra" VARCHAR(255) NULL DEFAULT NULL,
    "gmt_create" TIMESTAMP NULL DEFAULT NULL,
    "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
    "lifecycle" VARCHAR(255) NULL DEFAULT NULL,
    "max_wf_instance_num" INTEGER NULL DEFAULT NULL,
    "next_trigger_time" BIGINT NULL DEFAULT NULL,
    "notify_user_ids" VARCHAR(255) NULL DEFAULT NULL,
    "pedag" TEXT NULL DEFAULT NULL,
    "status" INTEGER NULL DEFAULT NULL,
    "time_expression" VARCHAR(255) NULL DEFAULT NULL,
    "time_expression_type" INTEGER NULL DEFAULT NULL,
    "wf_description" VARCHAR(255) NULL DEFAULT NULL,
    "wf_name" VARCHAR(255) NULL DEFAULT NULL,
    CONSTRAINT pj_workflow_info_pkey PRIMARY KEY (id)
    );
CREATE INDEX idx01_workflow_info ON pj_workflow_info USING btree (app_id, status, time_expression_type, next_trigger_time);


-- 正在导出表  public.pj_workflow_info 的数据：-1 rows
/*!40000 ALTER TABLE "pj_workflow_info" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_workflow_info" ENABLE KEYS */;

-- 导出  表 public.pj_workflow_instance_info 结构
DROP TABLE IF EXISTS "pj_workflow_instance_info";
CREATE TABLE IF NOT EXISTS "pj_workflow_instance_info" (
   "id" BIGINT NOT NULL,
   "actual_trigger_time" BIGINT NULL DEFAULT NULL,
   "app_id" BIGINT NULL DEFAULT NULL,
   "dag" TEXT NULL DEFAULT NULL,
   "expected_trigger_time" BIGINT NULL DEFAULT NULL,
   "finished_time" BIGINT NULL DEFAULT NULL,
   "gmt_create" TIMESTAMP NULL DEFAULT NULL,
   "gmt_modified" TIMESTAMP NULL DEFAULT NULL,
   "parent_wf_instance_id" BIGINT NULL DEFAULT NULL,
   "result" TEXT NULL DEFAULT NULL,
   "status" INTEGER NULL DEFAULT NULL,
   "wf_context" TEXT NULL DEFAULT NULL,
   "wf_init_params" TEXT NULL DEFAULT NULL,
   "wf_instance_id" BIGINT NULL DEFAULT NULL,
   "workflow_id" BIGINT NULL DEFAULT NULL,
   CONSTRAINT pj_workflow_instance_info_pkey PRIMARY KEY (id),
    CONSTRAINT uidx01_wf_instance UNIQUE (wf_instance_id)
    );
CREATE INDEX idx01_wf_instance ON pj_workflow_instance_info USING btree (workflow_id, status, app_id, expected_trigger_time);


-- 正在导出表  public.pj_workflow_instance_info 的数据：-1 rows
/*!40000 ALTER TABLE "pj_workflow_instance_info" DISABLE KEYS */;
/*!40000 ALTER TABLE "pj_workflow_instance_info" ENABLE KEYS */;

-- 导出  表 public.pj_workflow_node_info 结构
DROP TABLE IF EXISTS "pj_workflow_node_info";
CREATE TABLE IF NOT EXISTS "pj_workflow_node_info" (
   "id" BIGINT NOT NULL,
   "app_id" BIGINT NOT NULL,
   "enable" BOOLEAN NOT NULL,
   "extra" TEXT NULL DEFAULT NULL,
   "gmt_create" TIMESTAMP NOT NULL,
   "gmt_modified" TIMESTAMP NOT NULL,
   "job_id" BIGINT NULL DEFAULT NULL,
   "node_name" VARCHAR(255) NULL DEFAULT NULL,
    "node_params" TEXT NULL DEFAULT NULL,
    "skip_when_failed" BOOLEAN NOT NULL,
    "type" INTEGER NULL DEFAULT NULL,
    "workflow_id" BIGINT NULL DEFAULT NULL,
    CONSTRAINT pj_workflow_node_info_pkey PRIMARY KEY (id)
    );
CREATE INDEX idx01_workflow_node_info ON pj_workflow_node_info USING btree (workflow_id, gmt_create);
