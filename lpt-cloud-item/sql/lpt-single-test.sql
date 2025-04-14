/*
 Navicat Premium Data Transfer

 Source Server         : 令牌通单体项目测试
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : 113.45.31.128:3306
 Source Schema         : lpt-single-test

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 28/03/2025 00:09:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-03-16 16:18:03', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-03-16 16:18:03', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-03-16 16:18:03', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-03-16 16:18:03', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-03-16 16:18:03', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-03-16 16:18:03', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-03-16 16:18:03', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1977 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-16 16:19:35');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-16 16:19:57');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-16 16:20:01');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-16 16:20:57');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2025-03-16 16:21:28');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-16 16:21:33');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-16 16:21:54');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-16 16:27:00');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-16 16:27:04');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-16 16:27:13');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-16 16:27:17');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-16 16:27:30');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-16 16:31:11');
INSERT INTO `sys_logininfor` VALUES (113, 'admine', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:08:21');
INSERT INTO `sys_logininfor` VALUES (114, 'admine', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:08:27');
INSERT INTO `sys_logininfor` VALUES (115, 'admine', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:08:28');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:08:32');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:08:35');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:08:40');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:08:47');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:09:01');
INSERT INTO `sys_logininfor` VALUES (121, 'admin3', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:12:28');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:13:00');
INSERT INTO `sys_logininfor` VALUES (123, 'admind', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:13:06');
INSERT INTO `sys_logininfor` VALUES (124, 'admin2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:13:45');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:13:49');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:13:51');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:14:06');
INSERT INTO `sys_logininfor` VALUES (128, 'admin2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:14:11');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:14:14');
INSERT INTO `sys_logininfor` VALUES (130, 'admin3', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-17 09:15:11');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:15:14');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:15:16');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:22:17');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:23:10');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:23:36');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:25:16');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:27:08');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:28:24');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 09:28:41');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:18:56');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:18:56');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:19:35');
INSERT INTO `sys_logininfor` VALUES (143, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:19:35');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:19:48');
INSERT INTO `sys_logininfor` VALUES (145, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:19:48');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:21:36');
INSERT INTO `sys_logininfor` VALUES (147, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:21:36');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:22:08');
INSERT INTO `sys_logininfor` VALUES (149, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:22:08');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:22:30');
INSERT INTO `sys_logininfor` VALUES (151, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:22:30');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:23:46');
INSERT INTO `sys_logininfor` VALUES (153, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:23:46');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:24:06');
INSERT INTO `sys_logininfor` VALUES (155, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:24:06');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:24:18');
INSERT INTO `sys_logininfor` VALUES (157, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:24:18');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:25:26');
INSERT INTO `sys_logininfor` VALUES (159, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:25:27');
INSERT INTO `sys_logininfor` VALUES (160, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:28');
INSERT INTO `sys_logininfor` VALUES (161, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:28');
INSERT INTO `sys_logininfor` VALUES (162, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:28');
INSERT INTO `sys_logininfor` VALUES (163, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:28');
INSERT INTO `sys_logininfor` VALUES (164, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (165, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (166, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (167, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (168, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (169, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (170, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (171, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (172, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (173, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (174, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (175, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (176, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (177, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (178, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (179, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (180, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (181, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (182, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (183, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (184, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (185, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (186, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (187, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (188, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (189, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (190, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (191, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (192, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (193, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (194, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (195, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (196, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (197, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (198, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (199, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (200, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:29');
INSERT INTO `sys_logininfor` VALUES (201, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (202, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (203, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (204, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (205, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (206, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (207, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (208, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (209, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (210, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (211, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (212, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (213, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (214, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (215, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (216, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (217, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (218, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (219, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (220, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (221, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (222, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (223, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (224, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (225, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (226, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (227, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (228, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (229, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (230, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (231, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (232, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (233, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (234, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (235, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (236, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (237, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (238, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (239, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (240, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (241, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (242, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (243, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (244, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:30');
INSERT INTO `sys_logininfor` VALUES (245, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (246, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (247, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (248, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (249, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (250, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (251, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (252, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (253, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (254, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (255, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (256, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (257, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (258, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (259, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (260, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (261, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (262, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (263, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:31');
INSERT INTO `sys_logininfor` VALUES (264, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (265, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (266, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (267, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (268, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (269, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (270, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (271, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (272, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (273, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (274, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (275, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (276, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (277, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (278, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (279, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (280, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (281, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (282, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (283, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (284, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (285, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (286, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (287, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (288, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (289, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (290, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (291, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (292, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (293, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (294, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:38');
INSERT INTO `sys_logininfor` VALUES (295, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (296, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (297, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (298, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (299, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (300, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (301, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (302, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (303, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (304, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (305, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (306, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (307, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (308, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (309, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (310, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (311, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (312, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (313, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (314, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (315, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (316, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (317, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (318, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (319, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (320, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (321, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (322, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (323, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (324, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (325, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (326, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (327, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (328, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (329, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (330, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (331, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (332, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (333, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (334, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (335, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (336, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (337, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (338, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (339, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (340, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (341, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (342, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (343, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (344, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (345, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (346, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (347, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (348, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (349, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (350, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (351, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (352, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (353, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (354, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (355, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (356, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (357, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (358, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (359, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (360, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (361, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (362, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (363, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (364, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (365, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (366, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (367, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:39');
INSERT INTO `sys_logininfor` VALUES (368, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (369, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (370, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (371, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (372, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (373, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (374, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (375, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (376, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (377, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (378, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (379, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (380, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (381, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (382, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (383, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (384, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (385, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (386, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (387, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (388, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (389, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (390, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (391, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (392, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (393, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (394, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (395, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (396, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (397, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (398, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (399, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (400, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (401, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (402, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (403, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (404, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (405, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (406, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (407, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (408, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (409, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (410, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (411, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (412, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (413, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (414, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (415, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (416, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (417, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (418, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (419, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (420, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (421, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (422, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (423, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (424, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (425, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (426, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (427, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (428, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (429, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (430, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (431, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (432, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (433, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (434, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (435, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (436, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (437, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:41');
INSERT INTO `sys_logininfor` VALUES (438, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (439, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (440, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (441, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (442, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (443, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (444, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (445, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (446, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (447, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (448, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (449, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (450, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (451, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (452, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (453, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (454, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (455, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (456, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (457, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (458, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (459, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (460, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (461, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (462, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (463, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (464, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (465, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (466, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (467, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (468, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (469, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (470, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (471, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:27:42');
INSERT INTO `sys_logininfor` VALUES (472, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:28:00');
INSERT INTO `sys_logininfor` VALUES (473, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:28:46');
INSERT INTO `sys_logininfor` VALUES (474, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (475, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (476, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (477, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (478, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (479, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (480, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (481, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (482, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (483, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (484, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (485, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (486, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (487, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (488, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (489, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (490, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (491, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (492, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (493, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (494, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (495, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (496, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (497, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (498, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (499, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (500, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (501, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (502, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (503, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (504, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (505, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (506, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (507, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (508, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (509, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (510, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (511, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (512, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (513, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (514, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (515, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (516, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (517, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (518, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (519, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (520, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (521, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (522, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (523, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (524, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (525, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (526, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (527, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (528, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (529, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (530, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (531, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (532, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (533, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (534, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (535, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (536, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (537, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (538, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (539, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:05');
INSERT INTO `sys_logininfor` VALUES (540, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (541, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (542, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (543, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (544, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (545, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (546, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (547, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (548, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (549, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (550, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (551, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (552, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (553, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (554, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (555, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (556, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (557, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (558, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (559, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (560, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (561, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (562, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (563, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (564, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (565, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (566, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (567, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (568, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (569, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (570, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (571, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (572, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (573, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (574, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (575, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (576, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (577, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:06');
INSERT INTO `sys_logininfor` VALUES (578, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:53');
INSERT INTO `sys_logininfor` VALUES (579, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:53');
INSERT INTO `sys_logininfor` VALUES (580, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:53');
INSERT INTO `sys_logininfor` VALUES (581, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:53');
INSERT INTO `sys_logininfor` VALUES (582, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:53');
INSERT INTO `sys_logininfor` VALUES (583, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:53');
INSERT INTO `sys_logininfor` VALUES (584, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (585, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (586, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (587, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (588, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (589, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (590, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (591, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (592, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (593, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (594, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (595, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (596, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (597, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (598, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (599, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (600, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (601, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (602, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (603, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (604, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (605, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (606, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (607, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (608, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (609, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (610, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (611, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (612, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (613, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (614, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (615, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (616, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (617, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (618, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (619, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (620, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (621, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (622, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (623, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (624, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (625, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (626, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (627, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (628, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (629, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (630, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (631, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (632, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (633, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (634, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (635, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (636, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (637, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (638, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (639, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (640, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (641, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (642, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (643, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (644, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (645, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (646, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (647, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (648, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (649, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (650, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (651, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (652, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (653, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (654, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (655, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (656, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (657, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (658, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (659, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (660, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (661, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (662, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (663, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (664, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (665, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (666, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (667, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (668, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (669, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (670, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (671, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (672, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (673, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (674, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (675, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (676, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (677, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (678, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (679, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (680, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (681, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:54');
INSERT INTO `sys_logininfor` VALUES (682, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:55');
INSERT INTO `sys_logininfor` VALUES (683, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (684, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (685, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (686, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (687, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (688, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (689, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (690, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (691, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (692, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (693, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (694, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (695, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (696, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (697, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (698, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (699, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (700, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (701, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (702, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (703, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (704, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (705, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (706, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (707, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (708, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (709, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (710, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (711, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (712, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (713, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (714, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (715, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (716, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (717, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (718, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (719, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (720, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (721, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (722, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (723, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (724, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (725, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (726, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (727, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (728, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (729, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (730, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (731, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (732, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (733, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (734, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (735, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (736, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (737, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (738, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (739, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (740, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (741, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (742, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (743, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (744, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (745, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (746, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (747, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (748, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (749, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (750, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (751, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (752, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (753, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (754, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (755, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (756, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (757, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (758, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (759, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (760, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (761, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (762, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (763, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (764, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (765, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (766, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (767, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (768, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (769, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (770, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (771, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (772, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (773, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (774, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (775, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (776, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (777, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (778, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (779, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (780, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (781, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (782, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (783, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (784, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (785, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:56');
INSERT INTO `sys_logininfor` VALUES (786, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (787, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (788, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (789, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (790, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (791, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (792, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (793, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (794, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (795, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (796, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (797, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (798, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (799, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (800, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (801, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (802, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (803, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (804, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (805, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (806, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (807, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (808, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (809, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (810, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (811, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (812, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (813, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (814, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (815, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (816, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (817, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (818, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (819, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (820, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (821, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (822, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (823, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (824, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (825, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (826, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (827, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (828, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (829, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (830, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (831, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (832, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (833, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:58');
INSERT INTO `sys_logininfor` VALUES (834, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (835, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (836, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (837, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (838, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (839, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (840, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (841, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (842, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (843, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (844, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (845, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (846, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (847, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (848, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (849, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (850, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (851, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (852, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (853, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (854, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (855, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (856, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (857, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (858, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (859, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (860, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (861, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (862, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (863, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (864, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (865, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (866, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (867, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (868, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (869, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (870, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (871, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (872, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (873, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (874, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (875, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (876, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (877, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (878, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (879, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (880, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (881, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (882, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (883, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (884, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (885, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (886, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (887, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (888, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (889, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:29:59');
INSERT INTO `sys_logininfor` VALUES (890, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (891, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (892, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (893, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (894, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (895, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (896, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (897, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (898, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (899, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (900, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (901, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (902, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (903, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (904, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (905, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (906, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (907, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (908, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (909, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (910, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (911, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (912, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (913, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (914, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (915, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (916, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (917, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (918, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (919, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (920, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (921, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (922, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (923, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (924, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (925, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (926, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (927, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (928, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (929, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (930, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (931, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:01');
INSERT INTO `sys_logininfor` VALUES (932, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (933, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (934, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (935, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (936, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (937, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (938, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (939, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (940, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (941, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (942, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (943, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (944, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (945, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (946, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (947, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (948, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (949, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (950, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (951, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (952, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (953, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (954, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (955, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (956, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (957, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (958, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (959, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (960, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (961, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (962, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (963, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (964, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (965, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (966, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (967, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (968, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (969, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (970, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (971, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (972, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (973, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (974, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (975, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (976, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (977, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (978, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (979, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (980, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (981, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (982, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (983, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (984, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (985, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (986, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (987, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (988, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (989, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (990, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (991, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (992, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (993, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:02');
INSERT INTO `sys_logininfor` VALUES (994, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (995, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (996, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (997, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (998, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (999, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1000, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1001, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1002, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1003, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1004, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1005, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1006, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1007, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1008, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1009, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1010, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1011, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:20');
INSERT INTO `sys_logininfor` VALUES (1012, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1013, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1014, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1015, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1016, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1017, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1018, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1019, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1020, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1021, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1022, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1023, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1024, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1025, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1026, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1027, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1028, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1029, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1030, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1031, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1032, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1033, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1034, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1035, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1036, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1037, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1038, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1039, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1040, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1041, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1042, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1043, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1044, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1045, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1046, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1047, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1048, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1049, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1050, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1051, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1052, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1053, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1054, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1055, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1056, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1057, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1058, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1059, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1060, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1061, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1062, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1063, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1064, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1065, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1066, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1067, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1068, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1069, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1070, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1071, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1072, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1073, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1074, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1075, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1076, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1077, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1078, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1079, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1080, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1081, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1082, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1083, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1084, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1085, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1086, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1087, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1088, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1089, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1090, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1091, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1092, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1093, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1094, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1095, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1096, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1097, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:30:21');
INSERT INTO `sys_logininfor` VALUES (1098, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:30:27');
INSERT INTO `sys_logininfor` VALUES (1099, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:30:30');
INSERT INTO `sys_logininfor` VALUES (1100, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1101, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1102, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1103, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1104, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1105, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1106, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1107, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1108, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1109, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1110, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1111, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1112, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1113, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1114, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1115, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1116, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1117, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1118, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1119, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1120, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1121, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1122, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1123, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1124, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1125, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1126, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1127, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1128, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1129, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1130, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1131, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1132, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1133, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1134, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1135, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1136, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1137, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1138, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1139, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1140, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1141, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1142, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1143, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1144, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1145, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1146, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1147, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1148, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1149, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1150, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1151, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1152, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1153, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1154, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1155, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1156, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1157, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1158, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1159, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1160, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1161, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1162, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1163, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1164, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1165, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1166, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1167, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1168, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1169, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1170, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1171, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1172, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1173, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1174, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1175, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1176, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1177, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1178, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1179, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1180, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1181, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1182, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1183, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1184, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1185, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1186, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1187, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1188, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1189, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1190, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:11');
INSERT INTO `sys_logininfor` VALUES (1191, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1192, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1193, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1194, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1195, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1196, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1197, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1198, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1199, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1200, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1201, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1202, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1203, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 10:31:12');
INSERT INTO `sys_logininfor` VALUES (1204, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:34:11');
INSERT INTO `sys_logininfor` VALUES (1205, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:34:15');
INSERT INTO `sys_logininfor` VALUES (1206, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:34:20');
INSERT INTO `sys_logininfor` VALUES (1207, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:57:48');
INSERT INTO `sys_logininfor` VALUES (1208, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 10:57:59');
INSERT INTO `sys_logininfor` VALUES (1209, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 11:51:47');
INSERT INTO `sys_logininfor` VALUES (1210, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 11:55:04');
INSERT INTO `sys_logininfor` VALUES (1211, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 11:56:00');
INSERT INTO `sys_logininfor` VALUES (1212, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 11:59:40');
INSERT INTO `sys_logininfor` VALUES (1213, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 11:59:56');
INSERT INTO `sys_logininfor` VALUES (1214, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 14:41:03');
INSERT INTO `sys_logininfor` VALUES (1215, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 14:41:14');
INSERT INTO `sys_logininfor` VALUES (1216, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 14:41:29');
INSERT INTO `sys_logininfor` VALUES (1217, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 14:43:17');
INSERT INTO `sys_logininfor` VALUES (1218, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:08:17');
INSERT INTO `sys_logininfor` VALUES (1219, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:09:16');
INSERT INTO `sys_logininfor` VALUES (1220, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:16:57');
INSERT INTO `sys_logininfor` VALUES (1221, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:24:08');
INSERT INTO `sys_logininfor` VALUES (1222, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:24:19');
INSERT INTO `sys_logininfor` VALUES (1223, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:39:22');
INSERT INTO `sys_logininfor` VALUES (1224, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:39:34');
INSERT INTO `sys_logininfor` VALUES (1225, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:40:32');
INSERT INTO `sys_logininfor` VALUES (1226, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:41:08');
INSERT INTO `sys_logininfor` VALUES (1227, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:41:19');
INSERT INTO `sys_logininfor` VALUES (1228, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:42:24');
INSERT INTO `sys_logininfor` VALUES (1229, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:43:54');
INSERT INTO `sys_logininfor` VALUES (1230, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:45:55');
INSERT INTO `sys_logininfor` VALUES (1231, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:47');
INSERT INTO `sys_logininfor` VALUES (1232, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:47');
INSERT INTO `sys_logininfor` VALUES (1233, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:47');
INSERT INTO `sys_logininfor` VALUES (1234, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:47');
INSERT INTO `sys_logininfor` VALUES (1235, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:47');
INSERT INTO `sys_logininfor` VALUES (1236, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:47');
INSERT INTO `sys_logininfor` VALUES (1237, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1238, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1239, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1240, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1241, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1242, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1243, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1244, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1245, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1246, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1247, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:48');
INSERT INTO `sys_logininfor` VALUES (1248, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1249, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1250, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1251, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1252, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1253, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1254, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1255, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1256, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1257, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1258, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1259, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1260, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1261, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1262, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1263, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:49');
INSERT INTO `sys_logininfor` VALUES (1264, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:50');
INSERT INTO `sys_logininfor` VALUES (1265, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:50');
INSERT INTO `sys_logininfor` VALUES (1266, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:50');
INSERT INTO `sys_logininfor` VALUES (1267, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:50');
INSERT INTO `sys_logininfor` VALUES (1268, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:50');
INSERT INTO `sys_logininfor` VALUES (1269, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 15:46:51');
INSERT INTO `sys_logininfor` VALUES (1270, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:50:20');
INSERT INTO `sys_logininfor` VALUES (1271, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:51:22');
INSERT INTO `sys_logininfor` VALUES (1272, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:51:50');
INSERT INTO `sys_logininfor` VALUES (1273, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:55:00');
INSERT INTO `sys_logininfor` VALUES (1274, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:55:42');
INSERT INTO `sys_logininfor` VALUES (1275, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 15:55:54');
INSERT INTO `sys_logininfor` VALUES (1276, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:02:16');
INSERT INTO `sys_logininfor` VALUES (1277, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:02:17');
INSERT INTO `sys_logininfor` VALUES (1278, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:06:36');
INSERT INTO `sys_logininfor` VALUES (1279, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:06:50');
INSERT INTO `sys_logininfor` VALUES (1280, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:09:15');
INSERT INTO `sys_logininfor` VALUES (1281, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 16:09:15');
INSERT INTO `sys_logininfor` VALUES (1282, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:09:17');
INSERT INTO `sys_logininfor` VALUES (1283, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 16:09:17');
INSERT INTO `sys_logininfor` VALUES (1284, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:09:30');
INSERT INTO `sys_logininfor` VALUES (1285, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 16:09:30');
INSERT INTO `sys_logininfor` VALUES (1286, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:13:29');
INSERT INTO `sys_logininfor` VALUES (1287, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:13:37');
INSERT INTO `sys_logininfor` VALUES (1288, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:14:11');
INSERT INTO `sys_logininfor` VALUES (1289, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 16:15:14');
INSERT INTO `sys_logininfor` VALUES (1290, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:20:13');
INSERT INTO `sys_logininfor` VALUES (1291, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:20:15');
INSERT INTO `sys_logininfor` VALUES (1292, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:21:48');
INSERT INTO `sys_logininfor` VALUES (1293, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:22:45');
INSERT INTO `sys_logininfor` VALUES (1294, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:24:38');
INSERT INTO `sys_logininfor` VALUES (1295, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:30:35');
INSERT INTO `sys_logininfor` VALUES (1296, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:30:49');
INSERT INTO `sys_logininfor` VALUES (1297, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:30:54');
INSERT INTO `sys_logininfor` VALUES (1298, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:32:22');
INSERT INTO `sys_logininfor` VALUES (1299, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:34:50');
INSERT INTO `sys_logininfor` VALUES (1300, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:35:25');
INSERT INTO `sys_logininfor` VALUES (1301, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:37:47');
INSERT INTO `sys_logininfor` VALUES (1302, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:38:08');
INSERT INTO `sys_logininfor` VALUES (1303, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:38:33');
INSERT INTO `sys_logininfor` VALUES (1304, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:40:19');
INSERT INTO `sys_logininfor` VALUES (1305, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:41:22');
INSERT INTO `sys_logininfor` VALUES (1306, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:42:00');
INSERT INTO `sys_logininfor` VALUES (1307, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:42:47');
INSERT INTO `sys_logininfor` VALUES (1308, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:43:36');
INSERT INTO `sys_logininfor` VALUES (1309, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 17:44:59');
INSERT INTO `sys_logininfor` VALUES (1310, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:18:05');
INSERT INTO `sys_logininfor` VALUES (1311, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:18:34');
INSERT INTO `sys_logininfor` VALUES (1312, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:19:36');
INSERT INTO `sys_logininfor` VALUES (1313, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:20:30');
INSERT INTO `sys_logininfor` VALUES (1314, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:21:12');
INSERT INTO `sys_logininfor` VALUES (1315, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:23:12');
INSERT INTO `sys_logininfor` VALUES (1316, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:23:34');
INSERT INTO `sys_logininfor` VALUES (1317, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:25:03');
INSERT INTO `sys_logininfor` VALUES (1318, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:25:13');
INSERT INTO `sys_logininfor` VALUES (1319, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:53:08');
INSERT INTO `sys_logininfor` VALUES (1320, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:53:13');
INSERT INTO `sys_logininfor` VALUES (1321, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:53:16');
INSERT INTO `sys_logininfor` VALUES (1322, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:54:35');
INSERT INTO `sys_logininfor` VALUES (1323, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:56:49');
INSERT INTO `sys_logininfor` VALUES (1324, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 18:57:07');
INSERT INTO `sys_logininfor` VALUES (1325, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:00:04');
INSERT INTO `sys_logininfor` VALUES (1326, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:09:45');
INSERT INTO `sys_logininfor` VALUES (1327, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:09:49');
INSERT INTO `sys_logininfor` VALUES (1328, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:09:51');
INSERT INTO `sys_logininfor` VALUES (1329, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:11:09');
INSERT INTO `sys_logininfor` VALUES (1330, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:12:34');
INSERT INTO `sys_logininfor` VALUES (1331, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:13:37');
INSERT INTO `sys_logininfor` VALUES (1332, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:16:36');
INSERT INTO `sys_logininfor` VALUES (1333, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:16:43');
INSERT INTO `sys_logininfor` VALUES (1334, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:16:48');
INSERT INTO `sys_logininfor` VALUES (1335, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:16:51');
INSERT INTO `sys_logininfor` VALUES (1336, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:17:45');
INSERT INTO `sys_logininfor` VALUES (1337, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:20:22');
INSERT INTO `sys_logininfor` VALUES (1338, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:20:51');
INSERT INTO `sys_logininfor` VALUES (1339, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:21:43');
INSERT INTO `sys_logininfor` VALUES (1340, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:29:33');
INSERT INTO `sys_logininfor` VALUES (1341, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:29:37');
INSERT INTO `sys_logininfor` VALUES (1342, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:29:44');
INSERT INTO `sys_logininfor` VALUES (1343, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:37:52');
INSERT INTO `sys_logininfor` VALUES (1344, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:38:06');
INSERT INTO `sys_logininfor` VALUES (1345, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:38:07');
INSERT INTO `sys_logininfor` VALUES (1346, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:39:07');
INSERT INTO `sys_logininfor` VALUES (1347, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:39:26');
INSERT INTO `sys_logininfor` VALUES (1348, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:40:21');
INSERT INTO `sys_logininfor` VALUES (1349, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:44:37');
INSERT INTO `sys_logininfor` VALUES (1350, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:44:42');
INSERT INTO `sys_logininfor` VALUES (1351, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:45:15');
INSERT INTO `sys_logininfor` VALUES (1352, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:47:40');
INSERT INTO `sys_logininfor` VALUES (1353, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:49:38');
INSERT INTO `sys_logininfor` VALUES (1354, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:50:41');
INSERT INTO `sys_logininfor` VALUES (1355, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:51:37');
INSERT INTO `sys_logininfor` VALUES (1356, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:51:40');
INSERT INTO `sys_logininfor` VALUES (1357, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 19:51:42');
INSERT INTO `sys_logininfor` VALUES (1358, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:32:03');
INSERT INTO `sys_logininfor` VALUES (1359, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:32:09');
INSERT INTO `sys_logininfor` VALUES (1360, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:32:16');
INSERT INTO `sys_logininfor` VALUES (1361, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:32:23');
INSERT INTO `sys_logininfor` VALUES (1362, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:32:44');
INSERT INTO `sys_logininfor` VALUES (1363, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:32:50');
INSERT INTO `sys_logininfor` VALUES (1364, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:34:37');
INSERT INTO `sys_logininfor` VALUES (1365, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:36:11');
INSERT INTO `sys_logininfor` VALUES (1366, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:37:03');
INSERT INTO `sys_logininfor` VALUES (1367, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:37:12');
INSERT INTO `sys_logininfor` VALUES (1368, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:37:48');
INSERT INTO `sys_logininfor` VALUES (1369, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 20:38:14');
INSERT INTO `sys_logininfor` VALUES (1370, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:38:18');
INSERT INTO `sys_logininfor` VALUES (1371, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 20:38:18');
INSERT INTO `sys_logininfor` VALUES (1372, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:43:30');
INSERT INTO `sys_logininfor` VALUES (1373, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:44:59');
INSERT INTO `sys_logininfor` VALUES (1374, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:51:25');
INSERT INTO `sys_logininfor` VALUES (1375, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:52:50');
INSERT INTO `sys_logininfor` VALUES (1376, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:53:04');
INSERT INTO `sys_logininfor` VALUES (1377, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 20:54:33');
INSERT INTO `sys_logininfor` VALUES (1378, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 20:54:43');
INSERT INTO `sys_logininfor` VALUES (1379, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 20:54:46');
INSERT INTO `sys_logininfor` VALUES (1380, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 20:54:52');
INSERT INTO `sys_logininfor` VALUES (1381, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-17 20:54:57');
INSERT INTO `sys_logininfor` VALUES (1382, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:03:09');
INSERT INTO `sys_logininfor` VALUES (1383, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:04:15');
INSERT INTO `sys_logininfor` VALUES (1384, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:06:05');
INSERT INTO `sys_logininfor` VALUES (1385, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:07:29');
INSERT INTO `sys_logininfor` VALUES (1386, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:09:56');
INSERT INTO `sys_logininfor` VALUES (1387, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:10:39');
INSERT INTO `sys_logininfor` VALUES (1388, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:12:22');
INSERT INTO `sys_logininfor` VALUES (1389, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:15:53');
INSERT INTO `sys_logininfor` VALUES (1390, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:19:08');
INSERT INTO `sys_logininfor` VALUES (1391, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:20:47');
INSERT INTO `sys_logininfor` VALUES (1392, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:21:12');
INSERT INTO `sys_logininfor` VALUES (1393, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:21:52');
INSERT INTO `sys_logininfor` VALUES (1394, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:24:56');
INSERT INTO `sys_logininfor` VALUES (1395, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:25:13');
INSERT INTO `sys_logininfor` VALUES (1396, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:36:27');
INSERT INTO `sys_logininfor` VALUES (1397, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:40:29');
INSERT INTO `sys_logininfor` VALUES (1398, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:43:51');
INSERT INTO `sys_logininfor` VALUES (1399, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 21:57:29');
INSERT INTO `sys_logininfor` VALUES (1400, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:01:29');
INSERT INTO `sys_logininfor` VALUES (1401, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:01:36');
INSERT INTO `sys_logininfor` VALUES (1402, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:03:36');
INSERT INTO `sys_logininfor` VALUES (1403, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:15:52');
INSERT INTO `sys_logininfor` VALUES (1404, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:16:00');
INSERT INTO `sys_logininfor` VALUES (1405, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:16:05');
INSERT INTO `sys_logininfor` VALUES (1406, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:21:41');
INSERT INTO `sys_logininfor` VALUES (1407, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:21:49');
INSERT INTO `sys_logininfor` VALUES (1408, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:21:52');
INSERT INTO `sys_logininfor` VALUES (1409, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:21:57');
INSERT INTO `sys_logininfor` VALUES (1410, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:24:09');
INSERT INTO `sys_logininfor` VALUES (1411, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:25:09');
INSERT INTO `sys_logininfor` VALUES (1412, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:25:25');
INSERT INTO `sys_logininfor` VALUES (1413, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:26:44');
INSERT INTO `sys_logininfor` VALUES (1414, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:26:47');
INSERT INTO `sys_logininfor` VALUES (1415, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:26:49');
INSERT INTO `sys_logininfor` VALUES (1416, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:28:31');
INSERT INTO `sys_logininfor` VALUES (1417, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 22:29:21');
INSERT INTO `sys_logininfor` VALUES (1418, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:07:13');
INSERT INTO `sys_logininfor` VALUES (1419, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:11:05');
INSERT INTO `sys_logininfor` VALUES (1420, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:11:22');
INSERT INTO `sys_logininfor` VALUES (1421, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:11:29');
INSERT INTO `sys_logininfor` VALUES (1422, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:11:57');
INSERT INTO `sys_logininfor` VALUES (1423, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:12:37');
INSERT INTO `sys_logininfor` VALUES (1424, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:12:44');
INSERT INTO `sys_logininfor` VALUES (1425, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:14:01');
INSERT INTO `sys_logininfor` VALUES (1426, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:14:11');
INSERT INTO `sys_logininfor` VALUES (1427, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:14:26');
INSERT INTO `sys_logininfor` VALUES (1428, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:14:42');
INSERT INTO `sys_logininfor` VALUES (1429, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:15:37');
INSERT INTO `sys_logininfor` VALUES (1430, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:15:50');
INSERT INTO `sys_logininfor` VALUES (1431, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:17:59');
INSERT INTO `sys_logininfor` VALUES (1432, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:24:24');
INSERT INTO `sys_logininfor` VALUES (1433, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:24:30');
INSERT INTO `sys_logininfor` VALUES (1434, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:26:20');
INSERT INTO `sys_logininfor` VALUES (1435, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:28:23');
INSERT INTO `sys_logininfor` VALUES (1436, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:51:00');
INSERT INTO `sys_logininfor` VALUES (1437, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-17 23:51:19');
INSERT INTO `sys_logininfor` VALUES (1438, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:11:23');
INSERT INTO `sys_logininfor` VALUES (1439, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:20:01');
INSERT INTO `sys_logininfor` VALUES (1440, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:20:59');
INSERT INTO `sys_logininfor` VALUES (1441, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:21:06');
INSERT INTO `sys_logininfor` VALUES (1442, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:21:11');
INSERT INTO `sys_logininfor` VALUES (1443, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:21:16');
INSERT INTO `sys_logininfor` VALUES (1444, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:26:18');
INSERT INTO `sys_logininfor` VALUES (1445, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:26:55');
INSERT INTO `sys_logininfor` VALUES (1446, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:27:03');
INSERT INTO `sys_logininfor` VALUES (1447, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:34:54');
INSERT INTO `sys_logininfor` VALUES (1448, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:35:39');
INSERT INTO `sys_logininfor` VALUES (1449, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 00:35:48');
INSERT INTO `sys_logininfor` VALUES (1450, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:45:22');
INSERT INTO `sys_logininfor` VALUES (1451, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:45:25');
INSERT INTO `sys_logininfor` VALUES (1452, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:45:48');
INSERT INTO `sys_logininfor` VALUES (1453, 'admin', '117.140.89.149', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 00:46:01');
INSERT INTO `sys_logininfor` VALUES (1454, 'admin', '111.55.13.175', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 07:54:02');
INSERT INTO `sys_logininfor` VALUES (1455, 'admin', '111.55.13.175', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 07:54:08');
INSERT INTO `sys_logininfor` VALUES (1456, 'admin', '111.55.13.175', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 08:02:40');
INSERT INTO `sys_logininfor` VALUES (1457, 'admin', '111.55.13.175', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 08:02:47');
INSERT INTO `sys_logininfor` VALUES (1458, 'admin', '171.108.100.83', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 08:03:04');
INSERT INTO `sys_logininfor` VALUES (1459, 'admin', '111.55.13.175', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-18 08:04:49');
INSERT INTO `sys_logininfor` VALUES (1460, 'admin', '171.108.100.83', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-18 09:53:22');
INSERT INTO `sys_logininfor` VALUES (1461, 'admin', '171.108.100.83', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-18 09:54:54');
INSERT INTO `sys_logininfor` VALUES (1462, 'admin', '171.108.100.83', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-18 09:55:09');
INSERT INTO `sys_logininfor` VALUES (1463, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:13:52');
INSERT INTO `sys_logininfor` VALUES (1464, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:14:01');
INSERT INTO `sys_logininfor` VALUES (1465, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:14:07');
INSERT INTO `sys_logininfor` VALUES (1466, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:16:13');
INSERT INTO `sys_logininfor` VALUES (1467, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:17:16');
INSERT INTO `sys_logininfor` VALUES (1468, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:30:33');
INSERT INTO `sys_logininfor` VALUES (1469, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:30:40');
INSERT INTO `sys_logininfor` VALUES (1470, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:30:48');
INSERT INTO `sys_logininfor` VALUES (1471, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:33:39');
INSERT INTO `sys_logininfor` VALUES (1472, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 16:35:14');
INSERT INTO `sys_logininfor` VALUES (1473, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:38:57');
INSERT INTO `sys_logininfor` VALUES (1474, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:39:01');
INSERT INTO `sys_logininfor` VALUES (1475, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:39:39');
INSERT INTO `sys_logininfor` VALUES (1476, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:40:52');
INSERT INTO `sys_logininfor` VALUES (1477, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:40:56');
INSERT INTO `sys_logininfor` VALUES (1478, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:42:10');
INSERT INTO `sys_logininfor` VALUES (1479, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:42:14');
INSERT INTO `sys_logininfor` VALUES (1480, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:42:30');
INSERT INTO `sys_logininfor` VALUES (1481, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:42:30');
INSERT INTO `sys_logininfor` VALUES (1482, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:43:03');
INSERT INTO `sys_logininfor` VALUES (1483, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:43:35');
INSERT INTO `sys_logininfor` VALUES (1484, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:43:38');
INSERT INTO `sys_logininfor` VALUES (1485, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:43:51');
INSERT INTO `sys_logininfor` VALUES (1486, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:43:53');
INSERT INTO `sys_logininfor` VALUES (1487, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:44:49');
INSERT INTO `sys_logininfor` VALUES (1488, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:44:54');
INSERT INTO `sys_logininfor` VALUES (1489, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:45:17');
INSERT INTO `sys_logininfor` VALUES (1490, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:46:33');
INSERT INTO `sys_logininfor` VALUES (1491, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:46:36');
INSERT INTO `sys_logininfor` VALUES (1492, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:48:50');
INSERT INTO `sys_logininfor` VALUES (1493, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:48:53');
INSERT INTO `sys_logininfor` VALUES (1494, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:49:14');
INSERT INTO `sys_logininfor` VALUES (1495, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:55:33');
INSERT INTO `sys_logininfor` VALUES (1496, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:55:35');
INSERT INTO `sys_logininfor` VALUES (1497, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:56:18');
INSERT INTO `sys_logininfor` VALUES (1498, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:56:20');
INSERT INTO `sys_logininfor` VALUES (1499, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:57:57');
INSERT INTO `sys_logininfor` VALUES (1500, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:58:16');
INSERT INTO `sys_logininfor` VALUES (1501, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 16:58:25');
INSERT INTO `sys_logininfor` VALUES (1502, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:00:28');
INSERT INTO `sys_logininfor` VALUES (1503, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:03:01');
INSERT INTO `sys_logininfor` VALUES (1504, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:03:04');
INSERT INTO `sys_logininfor` VALUES (1505, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:03:59');
INSERT INTO `sys_logininfor` VALUES (1506, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:04:02');
INSERT INTO `sys_logininfor` VALUES (1507, NULL, '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:04:17');
INSERT INTO `sys_logininfor` VALUES (1508, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:06:06');
INSERT INTO `sys_logininfor` VALUES (1509, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:10:28');
INSERT INTO `sys_logininfor` VALUES (1510, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:10:29');
INSERT INTO `sys_logininfor` VALUES (1511, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:10:40');
INSERT INTO `sys_logininfor` VALUES (1512, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:16:16');
INSERT INTO `sys_logininfor` VALUES (1513, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-18 17:33:26');
INSERT INTO `sys_logininfor` VALUES (1514, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:35:55');
INSERT INTO `sys_logininfor` VALUES (1515, 'admin', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:37:34');
INSERT INTO `sys_logininfor` VALUES (1516, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:47:18');
INSERT INTO `sys_logininfor` VALUES (1517, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:47:33');
INSERT INTO `sys_logininfor` VALUES (1518, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:50:31');
INSERT INTO `sys_logininfor` VALUES (1519, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 17:58:58');
INSERT INTO `sys_logininfor` VALUES (1520, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 18:05:27');
INSERT INTO `sys_logininfor` VALUES (1521, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 18:05:34');
INSERT INTO `sys_logininfor` VALUES (1522, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-18 18:15:59');
INSERT INTO `sys_logininfor` VALUES (1523, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 18:56:50');
INSERT INTO `sys_logininfor` VALUES (1524, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2025-03-18 18:57:02');
INSERT INTO `sys_logininfor` VALUES (1525, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 18:57:05');
INSERT INTO `sys_logininfor` VALUES (1526, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-18 18:58:50');
INSERT INTO `sys_logininfor` VALUES (1527, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-18 18:58:52');
INSERT INTO `sys_logininfor` VALUES (1528, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-18 18:58:53');
INSERT INTO `sys_logininfor` VALUES (1529, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-18 18:59:00');
INSERT INTO `sys_logininfor` VALUES (1530, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-18 18:59:03');
INSERT INTO `sys_logininfor` VALUES (1531, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2025-03-18 18:59:13');
INSERT INTO `sys_logininfor` VALUES (1532, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 18:59:14');
INSERT INTO `sys_logininfor` VALUES (1533, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-18 18:59:18');
INSERT INTO `sys_logininfor` VALUES (1534, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-18 18:59:21');
INSERT INTO `sys_logininfor` VALUES (1535, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-18 19:02:40');
INSERT INTO `sys_logininfor` VALUES (1536, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:01:30');
INSERT INTO `sys_logininfor` VALUES (1537, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:01:30');
INSERT INTO `sys_logininfor` VALUES (1538, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:05:07');
INSERT INTO `sys_logininfor` VALUES (1539, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:06:56');
INSERT INTO `sys_logininfor` VALUES (1540, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:08:47');
INSERT INTO `sys_logininfor` VALUES (1541, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:12:19');
INSERT INTO `sys_logininfor` VALUES (1542, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-19 00:13:07');
INSERT INTO `sys_logininfor` VALUES (1543, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:22:25');
INSERT INTO `sys_logininfor` VALUES (1544, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:25:51');
INSERT INTO `sys_logininfor` VALUES (1545, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:28:42');
INSERT INTO `sys_logininfor` VALUES (1546, 'xingyi2', '117.140.89.149', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-19 00:33:17');
INSERT INTO `sys_logininfor` VALUES (1547, 'xingyi3', '223.104.93.185', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '注册成功', '2025-03-19 10:21:40');
INSERT INTO `sys_logininfor` VALUES (1548, 'xingyi3', '223.104.93.185', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-19 10:21:45');
INSERT INTO `sys_logininfor` VALUES (1549, 'xingyi3', '223.104.93.185', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '退出成功', '2025-03-19 10:23:22');
INSERT INTO `sys_logininfor` VALUES (1550, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:22:16');
INSERT INTO `sys_logininfor` VALUES (1551, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:24:17');
INSERT INTO `sys_logininfor` VALUES (1552, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:25:59');
INSERT INTO `sys_logininfor` VALUES (1553, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:27:38');
INSERT INTO `sys_logininfor` VALUES (1554, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:28:58');
INSERT INTO `sys_logininfor` VALUES (1555, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 17:30:20');
INSERT INTO `sys_logininfor` VALUES (1556, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:31:07');
INSERT INTO `sys_logininfor` VALUES (1557, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 17:46:30');
INSERT INTO `sys_logininfor` VALUES (1558, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:46:43');
INSERT INTO `sys_logininfor` VALUES (1559, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 17:50:09');
INSERT INTO `sys_logininfor` VALUES (1560, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 17:50:24');
INSERT INTO `sys_logininfor` VALUES (1561, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 21:01:01');
INSERT INTO `sys_logininfor` VALUES (1562, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:27:51');
INSERT INTO `sys_logininfor` VALUES (1563, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:28:08');
INSERT INTO `sys_logininfor` VALUES (1564, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:28:26');
INSERT INTO `sys_logininfor` VALUES (1565, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:28:39');
INSERT INTO `sys_logininfor` VALUES (1566, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:29:24');
INSERT INTO `sys_logininfor` VALUES (1567, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:30:26');
INSERT INTO `sys_logininfor` VALUES (1568, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:31:51');
INSERT INTO `sys_logininfor` VALUES (1569, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:32:05');
INSERT INTO `sys_logininfor` VALUES (1570, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:33:15');
INSERT INTO `sys_logininfor` VALUES (1571, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:34:19');
INSERT INTO `sys_logininfor` VALUES (1572, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:34:37');
INSERT INTO `sys_logininfor` VALUES (1573, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:36:09');
INSERT INTO `sys_logininfor` VALUES (1574, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 21:36:23');
INSERT INTO `sys_logininfor` VALUES (1575, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:02:37');
INSERT INTO `sys_logininfor` VALUES (1576, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:03:47');
INSERT INTO `sys_logininfor` VALUES (1577, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:04:51');
INSERT INTO `sys_logininfor` VALUES (1578, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:04:57');
INSERT INTO `sys_logininfor` VALUES (1579, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:07:16');
INSERT INTO `sys_logininfor` VALUES (1580, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:07:24');
INSERT INTO `sys_logininfor` VALUES (1581, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:14:17');
INSERT INTO `sys_logininfor` VALUES (1582, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:14:29');
INSERT INTO `sys_logininfor` VALUES (1583, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:15:53');
INSERT INTO `sys_logininfor` VALUES (1584, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:16:10');
INSERT INTO `sys_logininfor` VALUES (1585, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:18:16');
INSERT INTO `sys_logininfor` VALUES (1586, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:20:01');
INSERT INTO `sys_logininfor` VALUES (1587, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:20:07');
INSERT INTO `sys_logininfor` VALUES (1588, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:21:48');
INSERT INTO `sys_logininfor` VALUES (1589, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:21:53');
INSERT INTO `sys_logininfor` VALUES (1590, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-20 22:24:02');
INSERT INTO `sys_logininfor` VALUES (1591, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:24:11');
INSERT INTO `sys_logininfor` VALUES (1592, 'xingyi2', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:29:21');
INSERT INTO `sys_logininfor` VALUES (1593, 'xingyi2', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:30:16');
INSERT INTO `sys_logininfor` VALUES (1594, 'xingyi2', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-20 22:30:27');
INSERT INTO `sys_logininfor` VALUES (1595, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-21 00:15:11');
INSERT INTO `sys_logininfor` VALUES (1596, 'xingyi2', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 00:15:15');
INSERT INTO `sys_logininfor` VALUES (1597, '3123', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-21 00:17:28');
INSERT INTO `sys_logininfor` VALUES (1598, 'xingyi2', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 00:17:37');
INSERT INTO `sys_logininfor` VALUES (1599, 'xingyi2', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 00:19:53');
INSERT INTO `sys_logininfor` VALUES (1600, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '注册成功', '2025-03-21 00:21:21');
INSERT INTO `sys_logininfor` VALUES (1601, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 00:21:24');
INSERT INTO `sys_logininfor` VALUES (1602, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 00:21:28');
INSERT INTO `sys_logininfor` VALUES (1603, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 00:22:30');
INSERT INTO `sys_logininfor` VALUES (1604, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '退出成功', '2025-03-21 00:23:33');
INSERT INTO `sys_logininfor` VALUES (1605, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 00:23:40');
INSERT INTO `sys_logininfor` VALUES (1606, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 00:32:28');
INSERT INTO `sys_logininfor` VALUES (1607, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 00:32:30');
INSERT INTO `sys_logininfor` VALUES (1608, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 00:37:37');
INSERT INTO `sys_logininfor` VALUES (1609, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '退出成功', '2025-03-21 00:45:45');
INSERT INTO `sys_logininfor` VALUES (1610, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 00:45:53');
INSERT INTO `sys_logininfor` VALUES (1611, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '退出成功', '2025-03-21 00:47:29');
INSERT INTO `sys_logininfor` VALUES (1612, 'xingyi2', '39.144.135.202', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-21 08:56:28');
INSERT INTO `sys_logininfor` VALUES (1613, 'admin', '210.36.69.250', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-21 08:57:55');
INSERT INTO `sys_logininfor` VALUES (1614, 'xingyi6', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 11:08:11');
INSERT INTO `sys_logininfor` VALUES (1615, 'xingyi6', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 11:08:35');
INSERT INTO `sys_logininfor` VALUES (1616, 'xingyi6', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-21 11:13:59');
INSERT INTO `sys_logininfor` VALUES (1617, '68', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-21 11:14:08');
INSERT INTO `sys_logininfor` VALUES (1618, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-21 11:19:14');
INSERT INTO `sys_logininfor` VALUES (1619, 'xingyi6', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 11:19:28');
INSERT INTO `sys_logininfor` VALUES (1620, 'xingyi6', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-21 11:25:47');
INSERT INTO `sys_logininfor` VALUES (1621, 'xingyi2', '210.36.64.251', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-21 15:02:48');
INSERT INTO `sys_logininfor` VALUES (1622, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-23 17:06:17');
INSERT INTO `sys_logininfor` VALUES (1623, '23432', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-23 17:06:20');
INSERT INTO `sys_logininfor` VALUES (1624, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-23 17:06:32');
INSERT INTO `sys_logininfor` VALUES (1625, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2025-03-23 17:08:17');
INSERT INTO `sys_logininfor` VALUES (1626, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:08:20');
INSERT INTO `sys_logininfor` VALUES (1627, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:08:40');
INSERT INTO `sys_logininfor` VALUES (1628, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:18:05');
INSERT INTO `sys_logininfor` VALUES (1629, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:18:12');
INSERT INTO `sys_logininfor` VALUES (1630, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:18:27');
INSERT INTO `sys_logininfor` VALUES (1631, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:18:31');
INSERT INTO `sys_logininfor` VALUES (1632, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:19:24');
INSERT INTO `sys_logininfor` VALUES (1633, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:20:52');
INSERT INTO `sys_logininfor` VALUES (1634, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:35:33');
INSERT INTO `sys_logininfor` VALUES (1635, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:35:38');
INSERT INTO `sys_logininfor` VALUES (1636, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:36:23');
INSERT INTO `sys_logininfor` VALUES (1637, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:36:26');
INSERT INTO `sys_logininfor` VALUES (1638, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:36:36');
INSERT INTO `sys_logininfor` VALUES (1639, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:36:46');
INSERT INTO `sys_logininfor` VALUES (1640, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:36:53');
INSERT INTO `sys_logininfor` VALUES (1641, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:36:54');
INSERT INTO `sys_logininfor` VALUES (1642, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:36:57');
INSERT INTO `sys_logininfor` VALUES (1643, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:37:00');
INSERT INTO `sys_logininfor` VALUES (1644, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:37:25');
INSERT INTO `sys_logininfor` VALUES (1645, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:37:41');
INSERT INTO `sys_logininfor` VALUES (1646, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:37:59');
INSERT INTO `sys_logininfor` VALUES (1647, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:38:05');
INSERT INTO `sys_logininfor` VALUES (1648, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:38:54');
INSERT INTO `sys_logininfor` VALUES (1649, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:38:56');
INSERT INTO `sys_logininfor` VALUES (1650, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:39:22');
INSERT INTO `sys_logininfor` VALUES (1651, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:04');
INSERT INTO `sys_logininfor` VALUES (1652, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:40:12');
INSERT INTO `sys_logininfor` VALUES (1653, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:15');
INSERT INTO `sys_logininfor` VALUES (1654, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:16');
INSERT INTO `sys_logininfor` VALUES (1655, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:40:20');
INSERT INTO `sys_logininfor` VALUES (1656, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:22');
INSERT INTO `sys_logininfor` VALUES (1657, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:24');
INSERT INTO `sys_logininfor` VALUES (1658, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:40:27');
INSERT INTO `sys_logininfor` VALUES (1659, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:29');
INSERT INTO `sys_logininfor` VALUES (1660, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '* 必须填写', '2025-03-23 17:40:31');
INSERT INTO `sys_logininfor` VALUES (1661, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:41:48');
INSERT INTO `sys_logininfor` VALUES (1662, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:43:51');
INSERT INTO `sys_logininfor` VALUES (1663, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:44:15');
INSERT INTO `sys_logininfor` VALUES (1664, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:44:32');
INSERT INTO `sys_logininfor` VALUES (1665, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:45:09');
INSERT INTO `sys_logininfor` VALUES (1666, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:47:07');
INSERT INTO `sys_logininfor` VALUES (1667, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:48:00');
INSERT INTO `sys_logininfor` VALUES (1668, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:48:19');
INSERT INTO `sys_logininfor` VALUES (1669, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:48:27');
INSERT INTO `sys_logininfor` VALUES (1670, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:48:55');
INSERT INTO `sys_logininfor` VALUES (1671, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:49:17');
INSERT INTO `sys_logininfor` VALUES (1672, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:50:44');
INSERT INTO `sys_logininfor` VALUES (1673, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:51:17');
INSERT INTO `sys_logininfor` VALUES (1674, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:53:43');
INSERT INTO `sys_logininfor` VALUES (1675, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:54:03');
INSERT INTO `sys_logininfor` VALUES (1676, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:57:12');
INSERT INTO `sys_logininfor` VALUES (1677, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:57:25');
INSERT INTO `sys_logininfor` VALUES (1678, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:58:26');
INSERT INTO `sys_logininfor` VALUES (1679, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 17:58:50');
INSERT INTO `sys_logininfor` VALUES (1680, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:05:34');
INSERT INTO `sys_logininfor` VALUES (1681, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:05:38');
INSERT INTO `sys_logininfor` VALUES (1682, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:06:32');
INSERT INTO `sys_logininfor` VALUES (1683, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:09:28');
INSERT INTO `sys_logininfor` VALUES (1684, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:09:33');
INSERT INTO `sys_logininfor` VALUES (1685, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:09:40');
INSERT INTO `sys_logininfor` VALUES (1686, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:11:00');
INSERT INTO `sys_logininfor` VALUES (1687, 'eqw', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-23 18:11:07');
INSERT INTO `sys_logininfor` VALUES (1688, 'eqw', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-23 18:11:08');
INSERT INTO `sys_logininfor` VALUES (1689, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:11:15');
INSERT INTO `sys_logininfor` VALUES (1690, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:11:32');
INSERT INTO `sys_logininfor` VALUES (1691, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:15:15');
INSERT INTO `sys_logininfor` VALUES (1692, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:15:21');
INSERT INTO `sys_logininfor` VALUES (1693, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:16:46');
INSERT INTO `sys_logininfor` VALUES (1694, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:17:00');
INSERT INTO `sys_logininfor` VALUES (1695, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:29:20');
INSERT INTO `sys_logininfor` VALUES (1696, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 18:29:39');
INSERT INTO `sys_logininfor` VALUES (1697, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:31:01');
INSERT INTO `sys_logininfor` VALUES (1698, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:31:09');
INSERT INTO `sys_logininfor` VALUES (1699, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:31:24');
INSERT INTO `sys_logininfor` VALUES (1700, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:31:41');
INSERT INTO `sys_logininfor` VALUES (1701, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:33:54');
INSERT INTO `sys_logininfor` VALUES (1702, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:34:00');
INSERT INTO `sys_logininfor` VALUES (1703, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:34:23');
INSERT INTO `sys_logininfor` VALUES (1704, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:34:28');
INSERT INTO `sys_logininfor` VALUES (1705, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:34:42');
INSERT INTO `sys_logininfor` VALUES (1706, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:34:47');
INSERT INTO `sys_logininfor` VALUES (1707, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:36:16');
INSERT INTO `sys_logininfor` VALUES (1708, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:36:20');
INSERT INTO `sys_logininfor` VALUES (1709, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:37:09');
INSERT INTO `sys_logininfor` VALUES (1710, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:37:14');
INSERT INTO `sys_logininfor` VALUES (1711, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:37:23');
INSERT INTO `sys_logininfor` VALUES (1712, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:37:27');
INSERT INTO `sys_logininfor` VALUES (1713, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:38:04');
INSERT INTO `sys_logininfor` VALUES (1714, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:38:26');
INSERT INTO `sys_logininfor` VALUES (1715, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:38:45');
INSERT INTO `sys_logininfor` VALUES (1716, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:38:51');
INSERT INTO `sys_logininfor` VALUES (1717, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:39:59');
INSERT INTO `sys_logininfor` VALUES (1718, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:40:03');
INSERT INTO `sys_logininfor` VALUES (1719, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:40:05');
INSERT INTO `sys_logininfor` VALUES (1720, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:40:55');
INSERT INTO `sys_logininfor` VALUES (1721, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:40:59');
INSERT INTO `sys_logininfor` VALUES (1722, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:41:04');
INSERT INTO `sys_logininfor` VALUES (1723, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:41:43');
INSERT INTO `sys_logininfor` VALUES (1724, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:42:34');
INSERT INTO `sys_logininfor` VALUES (1725, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:43:14');
INSERT INTO `sys_logininfor` VALUES (1726, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:43:45');
INSERT INTO `sys_logininfor` VALUES (1727, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:44:17');
INSERT INTO `sys_logininfor` VALUES (1728, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:45:01');
INSERT INTO `sys_logininfor` VALUES (1729, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:46:34');
INSERT INTO `sys_logininfor` VALUES (1730, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:47:13');
INSERT INTO `sys_logininfor` VALUES (1731, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:52:54');
INSERT INTO `sys_logininfor` VALUES (1732, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:54:23');
INSERT INTO `sys_logininfor` VALUES (1733, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:54:36');
INSERT INTO `sys_logininfor` VALUES (1734, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:56:04');
INSERT INTO `sys_logininfor` VALUES (1735, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:58:03');
INSERT INTO `sys_logininfor` VALUES (1736, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:58:40');
INSERT INTO `sys_logininfor` VALUES (1737, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 18:59:56');
INSERT INTO `sys_logininfor` VALUES (1738, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 19:00:14');
INSERT INTO `sys_logininfor` VALUES (1739, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:00:58');
INSERT INTO `sys_logininfor` VALUES (1740, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 19:01:14');
INSERT INTO `sys_logininfor` VALUES (1741, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:01:19');
INSERT INTO `sys_logininfor` VALUES (1742, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 19:02:10');
INSERT INTO `sys_logininfor` VALUES (1743, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:02:15');
INSERT INTO `sys_logininfor` VALUES (1744, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:05:27');
INSERT INTO `sys_logininfor` VALUES (1745, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 19:05:51');
INSERT INTO `sys_logininfor` VALUES (1746, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:06:29');
INSERT INTO `sys_logininfor` VALUES (1747, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:22:44');
INSERT INTO `sys_logininfor` VALUES (1748, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:23:11');
INSERT INTO `sys_logininfor` VALUES (1749, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:24:18');
INSERT INTO `sys_logininfor` VALUES (1750, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:25:30');
INSERT INTO `sys_logininfor` VALUES (1751, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:25:42');
INSERT INTO `sys_logininfor` VALUES (1752, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:26:03');
INSERT INTO `sys_logininfor` VALUES (1753, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:26:47');
INSERT INTO `sys_logininfor` VALUES (1754, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:35:10');
INSERT INTO `sys_logininfor` VALUES (1755, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:35:37');
INSERT INTO `sys_logininfor` VALUES (1756, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:36:03');
INSERT INTO `sys_logininfor` VALUES (1757, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 19:36:30');
INSERT INTO `sys_logininfor` VALUES (1758, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 19:36:58');
INSERT INTO `sys_logininfor` VALUES (1759, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 20:01:39');
INSERT INTO `sys_logininfor` VALUES (1760, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 20:25:29');
INSERT INTO `sys_logininfor` VALUES (1761, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 20:43:35');
INSERT INTO `sys_logininfor` VALUES (1762, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 20:47:14');
INSERT INTO `sys_logininfor` VALUES (1763, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 20:50:17');
INSERT INTO `sys_logininfor` VALUES (1764, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-23 20:50:28');
INSERT INTO `sys_logininfor` VALUES (1765, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 21:02:15');
INSERT INTO `sys_logininfor` VALUES (1766, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 21:02:24');
INSERT INTO `sys_logininfor` VALUES (1767, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 21:11:13');
INSERT INTO `sys_logininfor` VALUES (1768, 'admin', '43.250.244.50', 'XX XX', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-23 21:17:31');
INSERT INTO `sys_logininfor` VALUES (1769, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 21:42:06');
INSERT INTO `sys_logininfor` VALUES (1770, 'xingyi2', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2025-03-23 21:42:13');
INSERT INTO `sys_logininfor` VALUES (1771, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 21:46:15');
INSERT INTO `sys_logininfor` VALUES (1772, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:01:11');
INSERT INTO `sys_logininfor` VALUES (1773, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:02:13');
INSERT INTO `sys_logininfor` VALUES (1774, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:02:15');
INSERT INTO `sys_logininfor` VALUES (1775, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:24:16');
INSERT INTO `sys_logininfor` VALUES (1776, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:24:23');
INSERT INTO `sys_logininfor` VALUES (1777, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:25:22');
INSERT INTO `sys_logininfor` VALUES (1778, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:25:23');
INSERT INTO `sys_logininfor` VALUES (1779, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:25:41');
INSERT INTO `sys_logininfor` VALUES (1780, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:25:42');
INSERT INTO `sys_logininfor` VALUES (1781, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:25:46');
INSERT INTO `sys_logininfor` VALUES (1782, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:25:48');
INSERT INTO `sys_logininfor` VALUES (1783, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:25:56');
INSERT INTO `sys_logininfor` VALUES (1784, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:25:57');
INSERT INTO `sys_logininfor` VALUES (1785, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:27:38');
INSERT INTO `sys_logininfor` VALUES (1786, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:27:43');
INSERT INTO `sys_logininfor` VALUES (1787, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:27:54');
INSERT INTO `sys_logininfor` VALUES (1788, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:29:20');
INSERT INTO `sys_logininfor` VALUES (1789, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:30:42');
INSERT INTO `sys_logininfor` VALUES (1790, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:31:12');
INSERT INTO `sys_logininfor` VALUES (1791, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:32:03');
INSERT INTO `sys_logininfor` VALUES (1792, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:32:11');
INSERT INTO `sys_logininfor` VALUES (1793, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:32:28');
INSERT INTO `sys_logininfor` VALUES (1794, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-23 22:32:50');
INSERT INTO `sys_logininfor` VALUES (1795, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-23 22:33:03');
INSERT INTO `sys_logininfor` VALUES (1796, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:34:43');
INSERT INTO `sys_logininfor` VALUES (1797, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:35:53');
INSERT INTO `sys_logininfor` VALUES (1798, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:35:55');
INSERT INTO `sys_logininfor` VALUES (1799, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-23 22:36:14');
INSERT INTO `sys_logininfor` VALUES (1800, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:36:55');
INSERT INTO `sys_logininfor` VALUES (1801, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:37:55');
INSERT INTO `sys_logininfor` VALUES (1802, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:38:47');
INSERT INTO `sys_logininfor` VALUES (1803, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:40:03');
INSERT INTO `sys_logininfor` VALUES (1804, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:40:28');
INSERT INTO `sys_logininfor` VALUES (1805, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:41:49');
INSERT INTO `sys_logininfor` VALUES (1806, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:42:09');
INSERT INTO `sys_logininfor` VALUES (1807, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:42:32');
INSERT INTO `sys_logininfor` VALUES (1808, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:43:10');
INSERT INTO `sys_logininfor` VALUES (1809, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:43:28');
INSERT INTO `sys_logininfor` VALUES (1810, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:43:46');
INSERT INTO `sys_logininfor` VALUES (1811, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:44:22');
INSERT INTO `sys_logininfor` VALUES (1812, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:45:32');
INSERT INTO `sys_logininfor` VALUES (1813, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-23 22:45:55');
INSERT INTO `sys_logininfor` VALUES (1814, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-23 22:46:32');
INSERT INTO `sys_logininfor` VALUES (1815, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:47:17');
INSERT INTO `sys_logininfor` VALUES (1816, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-23 22:48:12');
INSERT INTO `sys_logininfor` VALUES (1817, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:48:27');
INSERT INTO `sys_logininfor` VALUES (1818, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:49:02');
INSERT INTO `sys_logininfor` VALUES (1819, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:49:48');
INSERT INTO `sys_logininfor` VALUES (1820, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:49:56');
INSERT INTO `sys_logininfor` VALUES (1821, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:50:00');
INSERT INTO `sys_logininfor` VALUES (1822, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:50:29');
INSERT INTO `sys_logininfor` VALUES (1823, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:50:37');
INSERT INTO `sys_logininfor` VALUES (1824, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:50:38');
INSERT INTO `sys_logininfor` VALUES (1825, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-23 22:54:11');
INSERT INTO `sys_logininfor` VALUES (1826, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:54:12');
INSERT INTO `sys_logininfor` VALUES (1827, 'xingyi', '111.55.13.173', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 22:55:53');
INSERT INTO `sys_logininfor` VALUES (1828, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:28:40');
INSERT INTO `sys_logininfor` VALUES (1829, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:28:52');
INSERT INTO `sys_logininfor` VALUES (1830, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:28:55');
INSERT INTO `sys_logininfor` VALUES (1831, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:32:13');
INSERT INTO `sys_logininfor` VALUES (1832, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:34:34');
INSERT INTO `sys_logininfor` VALUES (1833, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:34:50');
INSERT INTO `sys_logininfor` VALUES (1834, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:37:50');
INSERT INTO `sys_logininfor` VALUES (1835, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:39:54');
INSERT INTO `sys_logininfor` VALUES (1836, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:43:35');
INSERT INTO `sys_logininfor` VALUES (1837, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:44:53');
INSERT INTO `sys_logininfor` VALUES (1838, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:44:55');
INSERT INTO `sys_logininfor` VALUES (1839, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:45:09');
INSERT INTO `sys_logininfor` VALUES (1840, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:46:11');
INSERT INTO `sys_logininfor` VALUES (1841, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:47:38');
INSERT INTO `sys_logininfor` VALUES (1842, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:50:52');
INSERT INTO `sys_logininfor` VALUES (1843, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:50:56');
INSERT INTO `sys_logininfor` VALUES (1844, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:50:59');
INSERT INTO `sys_logininfor` VALUES (1845, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:51:06');
INSERT INTO `sys_logininfor` VALUES (1846, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:53:31');
INSERT INTO `sys_logininfor` VALUES (1847, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-23 23:54:47');
INSERT INTO `sys_logininfor` VALUES (1848, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:05:23');
INSERT INTO `sys_logininfor` VALUES (1849, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 00:17:11');
INSERT INTO `sys_logininfor` VALUES (1850, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:17:49');
INSERT INTO `sys_logininfor` VALUES (1851, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:18:23');
INSERT INTO `sys_logininfor` VALUES (1852, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 00:18:25');
INSERT INTO `sys_logininfor` VALUES (1853, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:19:38');
INSERT INTO `sys_logininfor` VALUES (1854, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 00:20:28');
INSERT INTO `sys_logininfor` VALUES (1855, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:21:04');
INSERT INTO `sys_logininfor` VALUES (1856, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 00:21:20');
INSERT INTO `sys_logininfor` VALUES (1857, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:21:51');
INSERT INTO `sys_logininfor` VALUES (1858, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 00:22:01');
INSERT INTO `sys_logininfor` VALUES (1859, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:22:40');
INSERT INTO `sys_logininfor` VALUES (1860, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:22:54');
INSERT INTO `sys_logininfor` VALUES (1861, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:22:57');
INSERT INTO `sys_logininfor` VALUES (1862, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 00:23:14');
INSERT INTO `sys_logininfor` VALUES (1863, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:23:53');
INSERT INTO `sys_logininfor` VALUES (1864, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 00:24:11');
INSERT INTO `sys_logininfor` VALUES (1865, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 00:24:38');
INSERT INTO `sys_logininfor` VALUES (1866, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:25:19');
INSERT INTO `sys_logininfor` VALUES (1867, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:25:46');
INSERT INTO `sys_logininfor` VALUES (1868, 'xingyi', '111.55.13.144', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 00:25:59');
INSERT INTO `sys_logininfor` VALUES (1869, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 08:22:22');
INSERT INTO `sys_logininfor` VALUES (1870, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 08:22:27');
INSERT INTO `sys_logininfor` VALUES (1871, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 12:30:31');
INSERT INTO `sys_logininfor` VALUES (1872, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 12:30:35');
INSERT INTO `sys_logininfor` VALUES (1873, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 12:31:00');
INSERT INTO `sys_logininfor` VALUES (1874, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:03:22');
INSERT INTO `sys_logininfor` VALUES (1875, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:03:29');
INSERT INTO `sys_logininfor` VALUES (1876, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:05:49');
INSERT INTO `sys_logininfor` VALUES (1877, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:06:17');
INSERT INTO `sys_logininfor` VALUES (1878, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:06:53');
INSERT INTO `sys_logininfor` VALUES (1879, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:10:19');
INSERT INTO `sys_logininfor` VALUES (1880, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:10:41');
INSERT INTO `sys_logininfor` VALUES (1881, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:10:50');
INSERT INTO `sys_logininfor` VALUES (1882, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 13:12:54');
INSERT INTO `sys_logininfor` VALUES (1883, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 17:44:12');
INSERT INTO `sys_logininfor` VALUES (1884, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 17:44:16');
INSERT INTO `sys_logininfor` VALUES (1885, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 17:44:18');
INSERT INTO `sys_logininfor` VALUES (1886, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 17:44:21');
INSERT INTO `sys_logininfor` VALUES (1887, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:40:29');
INSERT INTO `sys_logininfor` VALUES (1888, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 19:46:29');
INSERT INTO `sys_logininfor` VALUES (1889, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:46:30');
INSERT INTO `sys_logininfor` VALUES (1890, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 19:48:06');
INSERT INTO `sys_logininfor` VALUES (1891, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 19:48:52');
INSERT INTO `sys_logininfor` VALUES (1892, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 19:49:10');
INSERT INTO `sys_logininfor` VALUES (1893, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2025-03-24 19:49:37');
INSERT INTO `sys_logininfor` VALUES (1894, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 19:50:39');
INSERT INTO `sys_logininfor` VALUES (1895, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:53:16');
INSERT INTO `sys_logininfor` VALUES (1896, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 19:54:15');
INSERT INTO `sys_logininfor` VALUES (1897, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:54:16');
INSERT INTO `sys_logininfor` VALUES (1898, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:54:27');
INSERT INTO `sys_logininfor` VALUES (1899, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:54:53');
INSERT INTO `sys_logininfor` VALUES (1900, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 19:59:28');
INSERT INTO `sys_logininfor` VALUES (1901, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 19:59:29');
INSERT INTO `sys_logininfor` VALUES (1902, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 20:03:21');
INSERT INTO `sys_logininfor` VALUES (1903, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:03:44');
INSERT INTO `sys_logininfor` VALUES (1904, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:03:45');
INSERT INTO `sys_logininfor` VALUES (1905, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:04:47');
INSERT INTO `sys_logininfor` VALUES (1906, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:04:47');
INSERT INTO `sys_logininfor` VALUES (1907, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:05:30');
INSERT INTO `sys_logininfor` VALUES (1908, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:05:42');
INSERT INTO `sys_logininfor` VALUES (1909, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:05:44');
INSERT INTO `sys_logininfor` VALUES (1910, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:05:53');
INSERT INTO `sys_logininfor` VALUES (1911, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 20:09:22');
INSERT INTO `sys_logininfor` VALUES (1912, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:10:13');
INSERT INTO `sys_logininfor` VALUES (1913, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:10:22');
INSERT INTO `sys_logininfor` VALUES (1914, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 20:10:25');
INSERT INTO `sys_logininfor` VALUES (1915, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:11:37');
INSERT INTO `sys_logininfor` VALUES (1916, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:13:23');
INSERT INTO `sys_logininfor` VALUES (1917, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:13:46');
INSERT INTO `sys_logininfor` VALUES (1918, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 20:13:53');
INSERT INTO `sys_logininfor` VALUES (1919, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 20:14:50');
INSERT INTO `sys_logininfor` VALUES (1920, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 20:15:11');
INSERT INTO `sys_logininfor` VALUES (1921, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 20:15:39');
INSERT INTO `sys_logininfor` VALUES (1922, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 20:15:47');
INSERT INTO `sys_logininfor` VALUES (1923, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:16:59');
INSERT INTO `sys_logininfor` VALUES (1924, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:17:39');
INSERT INTO `sys_logininfor` VALUES (1925, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 20:17:42');
INSERT INTO `sys_logininfor` VALUES (1926, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:18:59');
INSERT INTO `sys_logininfor` VALUES (1927, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:19:24');
INSERT INTO `sys_logininfor` VALUES (1928, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-03-24 20:19:34');
INSERT INTO `sys_logininfor` VALUES (1929, 'xingyi', '117.140.89.158', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-03-24 20:19:58');
INSERT INTO `sys_logininfor` VALUES (1930, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:20:19');
INSERT INTO `sys_logininfor` VALUES (1931, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:21:40');
INSERT INTO `sys_logininfor` VALUES (1932, 'xingyi2', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2025-03-24 20:21:44');
INSERT INTO `sys_logininfor` VALUES (1933, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:21:57');
INSERT INTO `sys_logininfor` VALUES (1934, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:22:04');
INSERT INTO `sys_logininfor` VALUES (1935, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:22:08');
INSERT INTO `sys_logininfor` VALUES (1936, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-24 20:22:52');
INSERT INTO `sys_logininfor` VALUES (1937, 'xingyi', '111.55.166.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-24 20:27:21');
INSERT INTO `sys_logininfor` VALUES (1938, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:52:34');
INSERT INTO `sys_logininfor` VALUES (1939, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:52:42');
INSERT INTO `sys_logininfor` VALUES (1940, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:52:50');
INSERT INTO `sys_logininfor` VALUES (1941, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:53:06');
INSERT INTO `sys_logininfor` VALUES (1942, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:53:16');
INSERT INTO `sys_logininfor` VALUES (1943, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:53:33');
INSERT INTO `sys_logininfor` VALUES (1944, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:53:57');
INSERT INTO `sys_logininfor` VALUES (1945, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:54:10');
INSERT INTO `sys_logininfor` VALUES (1946, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:55:36');
INSERT INTO `sys_logininfor` VALUES (1947, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:56:03');
INSERT INTO `sys_logininfor` VALUES (1948, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 22:56:13');
INSERT INTO `sys_logininfor` VALUES (1949, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:01:17');
INSERT INTO `sys_logininfor` VALUES (1950, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:01:22');
INSERT INTO `sys_logininfor` VALUES (1951, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:18:50');
INSERT INTO `sys_logininfor` VALUES (1952, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:18:57');
INSERT INTO `sys_logininfor` VALUES (1953, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:21:39');
INSERT INTO `sys_logininfor` VALUES (1954, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:22:18');
INSERT INTO `sys_logininfor` VALUES (1955, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:22:40');
INSERT INTO `sys_logininfor` VALUES (1956, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:25:40');
INSERT INTO `sys_logininfor` VALUES (1957, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:25:57');
INSERT INTO `sys_logininfor` VALUES (1958, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:42:56');
INSERT INTO `sys_logininfor` VALUES (1959, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:43:00');
INSERT INTO `sys_logininfor` VALUES (1960, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:43:09');
INSERT INTO `sys_logininfor` VALUES (1961, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:43:28');
INSERT INTO `sys_logininfor` VALUES (1962, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:44:38');
INSERT INTO `sys_logininfor` VALUES (1963, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:44:47');
INSERT INTO `sys_logininfor` VALUES (1964, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:44:55');
INSERT INTO `sys_logininfor` VALUES (1965, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:45:36');
INSERT INTO `sys_logininfor` VALUES (1966, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:45:43');
INSERT INTO `sys_logininfor` VALUES (1967, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:46:38');
INSERT INTO `sys_logininfor` VALUES (1968, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:47:33');
INSERT INTO `sys_logininfor` VALUES (1969, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:48:04');
INSERT INTO `sys_logininfor` VALUES (1970, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:50:21');
INSERT INTO `sys_logininfor` VALUES (1971, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-27 23:52:01');
INSERT INTO `sys_logininfor` VALUES (1972, 'xingyi', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2025-03-27 23:52:49');
INSERT INTO `sys_logininfor` VALUES (1973, 'xingyi3', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2025-03-28 00:03:41');
INSERT INTO `sys_logininfor` VALUES (1974, 'xingyi3', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-28 00:03:55');
INSERT INTO `sys_logininfor` VALUES (1975, 'xingyi3', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-28 00:03:59');
INSERT INTO `sys_logininfor` VALUES (1976, 'xingyi3', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2025-03-28 00:05:28');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'SettingOutlined', 'admin', '2025-03-16 16:18:03', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'DashboardOutlined', 'admin', '2025-03-16 16:18:03', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'ToolOutlined', 'admin', '2025-03-16 16:18:03', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'LinkOutlined', 'admin', '2025-03-16 16:18:03', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (5, '控制台', 0, 0, 'dashboard', NULL, '', '', 1, 0, 'M', '1', '0', '', 'AppstoreOutlined', 'admin', '2025-03-16 16:18:03', '', NULL, '控制台');
INSERT INTO `sys_menu` VALUES (6, '个人', 0, 0, 'account', NULL, '', '', 1, 0, 'M', '1', '0', '', 'ProfileOutlined', 'admin', '2025-03-16 16:18:03', '', NULL, '个人');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-03-16 16:18:03', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-03-16 16:18:03', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-03-16 16:18:03', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-03-16 16:18:03', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-03-16 16:18:03', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-03-16 16:18:03', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-03-16 16:18:03', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-03-16 16:18:03', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-03-16 16:18:03', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-03-16 16:18:03', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-03-16 16:18:03', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-03-16 16:18:03', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-03-16 16:18:03', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-03-16 16:18:03', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-03-16 16:18:03', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-03-16 16:18:03', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-03-16 16:18:03', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-03-16 16:18:03', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-03-16 16:18:03', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-03-16 16:18:03', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-03-16 16:18:03', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-03-16 16:18:03', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-03-16 16:18:03', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 156 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/18/blob_20250318180733A001.png\",\"code\":200}', 0, NULL, '2025-03-18 18:07:33', 174);
INSERT INTO `sys_oper_log` VALUES (101, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"/profile/avatar/2025/03/18/blob_20250318180733A001.png\",\"createBy\":\"admin\",\"createTime\":\"2025-03-16 16:18:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"2416820386@qq.com\",\"loginDate\":\"2025-03-18 18:05:15\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-18 18:07:50', 134);
INSERT INTO `sys_oper_log` VALUES (102, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"2416820386@qq.com\",\"loginDate\":\"2025-03-18 18:59:15\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"xingyi2\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"\",\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"xingyi2\"}', '{\"msg\":\"修改用户\'xingyi2\'失败，邮箱账号已存在\",\"code\":500}', 0, NULL, '2025-03-18 19:02:32', 35);
INSERT INTO `sys_oper_log` VALUES (103, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'xingyi2', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/20/blob_20250320174615A001.png\",\"code\":200}', 0, NULL, '2025-03-20 17:46:34', 19360);
INSERT INTO `sys_oper_log` VALUES (104, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'xingyi2', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"code\":200}', 0, NULL, '2025-03-20 17:46:39', 19300);
INSERT INTO `sys_oper_log` VALUES (105, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"/profile/avatar/2025/03/18/blob_20250318180733A001.png\",\"createBy\":\"admin\",\"createTime\":\"2025-03-16 16:18:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginDate\":\"2025-03-18 18:56:51\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 17:47:57', 107);
INSERT INTO `sys_oper_log` VALUES (106, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":100,\"email\":\"\",\"nickName\":\"xingyi\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[4],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"xingyi\"}', '{\"msg\":\"新增用户\'xingyi\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-03-20 17:48:57', 35);
INSERT INTO `sys_oper_log` VALUES (107, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":100,\"email\":\"\",\"nickName\":\"xingyi\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[4],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"xingyi\"}', '{\"msg\":\"新增用户\'xingyi\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-03-20 17:49:11', 27);
INSERT INTO `sys_oper_log` VALUES (108, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-03-20 17:31:07\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"xingyi2\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"11\",\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"xingyi2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 17:51:46', 94);
INSERT INTO `sys_oper_log` VALUES (109, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAcFBQYFBAcGBQYIBwcIChELCgkJChUPEAwRGBUaGRgVGBcbHichGx0lHRcYIi4iJSgpKywrGiAvMy8qMicqKyr/2wBDAQcICAoJChQLCxQqHBgcKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKir/wAARCAG0AXoDASIAAhEBAxEB/8QAHAAAAQUBAQEAAAAAAAAAAAAAAwECBAUGAAcI/8QAQBAAAQMDAwIEBAQFAgUEAgMAAQACAwQRIQUSMUFRBhMiYRRxgZEHMkKhFSNSscEzYiRDctHhNFPw8SWiFoKS/8QAGgEAAwEBAQEAAAAAAAAAAAAAAAECAwQFBv/EACURAQEBAQACAwACAwADAQAAAAABEQIDIQQSMTJBEyJRFDNhQv/aAAwDAQACEQMRAD8API8C+UEOuU1zHk2RGQvstNRggtbKX02TfJek2vHTCNPHOAthN2jsnFpshkOF8JzpNjnsFuyFs+iVzyEwSXdhVKmwTb0Xbcdkm7C7db6J/ZP1MczFkBzM4H3RXSDITNwunOiwIssE3blFJz3TXKpSsM2pwZdIDnCIw2sn9iw5sTQE8MHZcHYSggZRox3li2bWSFg7IrXtsmu5RpYF5aYWWwjH24Q3WunCwwYKWy4DHKUWsmHBoXEBLfCY5PSdtFkhZ9E5vCcEEEWIRZlSyAhuATNHDP2Tg23RPtnsuDfskCsJZkCykR1bmYUY3B6pL4Qa2j1Ei2bKXHqZH6ln+mMJzZHDqgsaiPUvdS4q8G1yse2oc08qTDWOAsSUsJsmVgxlFFULcrJsrz3UhuoYGVOG0nxXuE01Q7rOnUul0w6lwL2+qMJqGVF+CpEbwRysvT6mMZVnT1odaxRgi6CWyjQ1AIypAcL+6k8LtXfZOwuuEaMef/qRmYCgsqGnqFIbMAOQuR6GJVxZDcbXQDOBjhI6YW5QBS+yE6SxQnTi3so8k+E9LBnyNskYATcYUPzS52D9lIhePZOVOJBGMWQnWvnhP3iyHI4J6MNcGgrgG26Ie8Xt2XbhblOVOHOaOiA8W62SvftvlCdJlPR9RGDNrpdp6FCa5PDrlPS+p24txyu803THOwm7gnpfUdrzbK7eW9UDfZL5mcpzovqIZumUm/HKC4jphNuL5NlU6TYk7/ddvUbdYYKTzLKp0m8pfmd1wcFGEht7pPMKf2L6pW7snt5UZj0drrW7BOdCwQggJpwl8wWTHOybJypx1uy5MD8pd2UaeOvn5JFxKRIHfsuH0Tb26j7pNyNGHkLt1ky5PCUA+6NGH+YfklEj7YKZZODTbASGF3P75TST7p2QPkmk4zynKWHRzOY7lWVNXbQM2+qpyuDyw3CYbCm1EWAurKKuBGDdYWKsew5NlPg1Ej9Smw22jqgeqP5zbcrJwalx6rKWNSFhlTgeaR6lIDkkBS26k+35v3VME4OI6rldq5GpPve6X+JOtgqm3OSte4cFBLX+IPJymPrioHmFKLuIvwjDToqol1lYRyHCrIIrZGFaQsOwBOEeZ7Y4QZKn3T5G2CgzGxVDBPigDyniqHdVZd6yOye3hIJz5r9UPzbFBAPRNewjuEBLbMOE/wA4WVU5zm8JPiHDFyloWjpcLhKO9lWioPdcZyHXHKektN4Sb7FVoqnA2RPiLjlPRiaX5wmF3b7KK2YXwU/zR3RqcG34tlcXqNvHuEoenp4kCS3Fku8W5UcOXbyEaWJLZLG3+UdsmOVX7ynNkIKeleVh5mFxlFuyiCY2C4vKr7I+iRvSiS3', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 18:10:50', 148);
INSERT INTO `sys_oper_log` VALUES (110, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAA9AAAALiCAYAAAAxaz76AAAMKGlDQ1BpY2MAAEiJlVcHVFP3Gv/uSEJCEkYgAjLCXqIMgQCyZwQB2eAiJIEEQggZqLippRWsAxUHjopWRay2WgEpKqIWB0VwW8dDLSpKLWpxofJOBmjree+d951z7/2db/6+79z7P/cD0EvkSqViVB+gUKKQJUWHsTIys1ikXkDAFMjgCw5cnlwampgYBwAw8vy7vLwKiOp5yU2V63P7fxUDvkDOA0ASASCHL+cVAiA/AeA+PKlMAUDoBwDb2QqpAoCoDwBGsozMLACinQrnaTBbhXM0OE7tk5IUDkDMBtChcrmyPAC6iherhJenAKAvBwB3CV8kAaC3AEAQT8jlA9DfAcC4wsIiPoCeEwA45XySJ+9vOXNGc3K5eaNY04tadCJEcqmYO/f/HMf/lkKxcqSGLQBQhbKYJFXPqrkVFMWqMBUAOSPJiU8AAEMA5LKIr/ZX4QdCZUyq1v81Tx6eBQBMAJTK50bEAoA5AGojEcfHafVBuaIoDgDoA6ApIgUnRROL8mVFSdr86ByBPDJ5BHNl6loqnwplQWqoNudWoYAzkrO5VJiSruGJdpWI0uIBgA6A3pIXJMdqfR6XCsPjR3xkyiQVZzsADHJlUUkaH8yuUD7SF+YvFHHitThOIUyJ0cRiM3lcNTcTACxfIM+IG+HJF0REavrCygSSVC1/rEqqCEvS+u+UihO1/liLQByt0tsAYJ3ykuSR2AGFLEU7fxykisQUDTfcKJ87OVHDAXeBOAiHCGCBEliQA0WQD6LO/sZ+YGktUcAFGeSBANy0mpGIdLVFAlxIhlL4AyQgAPloXJjaKoASkMD7Ua3m7ga5amuJOqIAHoAMCiEWxCAApTpKMlotDX4HGYg+q86DIhBDkdr2mY6lN6IjRhIjiDHEKKIzboYH4QF4HB6Eh+BBuCfOxv1GeH30JzwgdBPuEa4Qegg3ZonKZP9gzoIp0ANK7VQEkPNpd7gD7ol742F4IB6kyo0zcTNwwyfibDwUD8YDcG/c729claMdf5ylNhfZnYySx5BDyE7/ZEB3oXuPZlFN6tNZaHjljE4rfNTyzz7CP5kfH4og9p+e2NfYIawdO4GdxVqwRmBhx7EmrAM7qsKj78bv6ndjpFqSmk8BiEH0WT2utqZqanL3evc+93daGygEcxSqjyW8SDpXJsoTKlihUqlYwOJIeOPHsTzdPT0AVGe/5mh5wVSf6Qjz3EddcSuAXwUAkvdRx7UFOPIAgPHyo872OQB1FcDRLp5SVqLR4aobASigB0ZgCpZgC07gBp7gAwEQApEwGRIgBTJhJvBACIUgg9kwH5ZAOVTCKlgHm2Ab7IA98D0chEZogRPwC5yHLrgCN6EHeuEJDMBLGEIQhITQEAZiilgh9ogr4omwkSAkEolDkpBMJBvJQySIEpmPfIFUIlXIJmQ7Uof8iBxBTiBnkW7kBnIX6UOeI29RDKWiRqgF6oBOQNloKBqLpqAz0Dy0GC1Fl6Ir0A1oLboPbUBPoOfRK2gP+gQdxADTxZiYNeaGsbFwLAHLwnIxGbYQq8CqsVpsP9aMtWOXsB6sH3uDE3EGzsLd8AA8Bk/FeXgxvhBfjm/C9+AN+Cn8En4XH8A/EGgEc4IrwZ/AIWQQ8gizCeWEasIuwmHCacIVQi/hJZFIZBIdib7EGGImMZ84j7icuIV4gNhK7CbeJw6SSCRTkispkJRA4pIUpHLSRtI+0nHSRVIv6bWOro6VjqdOlE6WjkSnTKdaZ6/OMZ2LOg91hsj6', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\r\n### The error may exist in file [D:\\workspacemy\\lptGit\\lpt-single-item\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,     avatar = ?,     password = ?,     status = ?,     login_ip = ?,     login_date = ?,              faceBase64 = ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\n; Data truncation: Data too long for column \'faceBase64\' at row 1', '2025-03-20 18:11:57', 685);
INSERT INTO `sys_oper_log` VALUES (111, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAA9AAAALiCAYAAAAxaz76AAAMKGlDQ1BpY2MAAEiJlVcHVFP3Gv/uSEJCEkYgAjLCXqIMgQCyZwQB2eAiJIEEQggZqLippRWsAxUHjopWRay2WgEpKqIWB0VwW8dDLSpKLWpxofJOBmjree+d951z7/2db/6+79z7P/cD0EvkSqViVB+gUKKQJUWHsTIys1ikXkDAFMjgCw5cnlwampgYBwAw8vy7vLwKiOp5yU2V63P7fxUDvkDOA0ASASCHL+cVAiA/AeA+PKlMAUDoBwDb2QqpAoCoDwBGsozMLACinQrnaTBbhXM0OE7tk5IUDkDMBtChcrmyPAC6iherhJenAKAvBwB3CV8kAaC3AEAQT8jlA9DfAcC4wsIiPoCeEwA45XySJ+9vOXNGc3K5eaNY04tadCJEcqmYO/f/HMf/lkKxcqSGLQBQhbKYJFXPqrkVFMWqMBUAOSPJiU8AAEMA5LKIr/ZX4QdCZUyq1v81Tx6eBQBMAJTK50bEAoA5AGojEcfHafVBuaIoDgDoA6ApIgUnRROL8mVFSdr86ByBPDJ5BHNl6loqnwplQWqoNudWoYAzkrO5VJiSruGJdpWI0uIBgA6A3pIXJMdqfR6XCsPjR3xkyiQVZzsADHJlUUkaH8yuUD7SF+YvFHHitThOIUyJ0cRiM3lcNTcTACxfIM+IG+HJF0REavrCygSSVC1/rEqqCEvS+u+UihO1/liLQByt0tsAYJ3ykuSR2AGFLEU7fxykisQUDTfcKJ87OVHDAXeBOAiHCGCBEliQA0WQD6LO/sZ+YGktUcAFGeSBANy0mpGIdLVFAlxIhlL4AyQgAPloXJjaKoASkMD7Ua3m7ga5amuJOqIAHoAMCiEWxCAApTpKMlotDX4HGYg+q86DIhBDkdr2mY6lN6IjRhIjiDHEKKIzboYH4QF4HB6Eh+BBuCfOxv1GeH30JzwgdBPuEa4Qegg3ZonKZP9gzoIp0ANK7VQEkPNpd7gD7ol742F4IB6kyo0zcTNwwyfibDwUD8YDcG/c729claMdf5ylNhfZnYySx5BDyE7/ZEB3oXuPZlFN6tNZaHjljE4rfNTyzz7CP5kfH4og9p+e2NfYIawdO4GdxVqwRmBhx7EmrAM7qsKj78bv6ndjpFqSmk8BiEH0WT2utqZqanL3evc+93daGygEcxSqjyW8SDpXJsoTKlihUqlYwOJIeOPHsTzdPT0AVGe/5mh5wVSf6Qjz3EddcSuAXwUAkvdRx7UFOPIAgPHyo872OQB1FcDRLp5SVqLR4aobASigB0ZgCpZgC07gBp7gAwEQApEwGRIgBTJhJvBACIUgg9kwH5ZAOVTCKlgHm2Ab7IA98D0chEZogRPwC5yHLrgCN6EHeuEJDMBLGEIQhITQEAZiilgh9ogr4omwkSAkEolDkpBMJBvJQySIEpmPfIFUIlXIJmQ7Uof8iBxBTiBnkW7kBnIX6UOeI29RDKWiRqgF6oBOQNloKBqLpqAz0Dy0GC1Fl6Ir0A1oLboPbUBPoOfRK2gP+gQdxADTxZiYNeaGsbFwLAHLwnIxGbYQq8CqsVpsP9aMtWOXsB6sH3uDE3EGzsLd8AA8Bk/FeXgxvhBfjm/C9+AN+Cn8En4XH8A/EGgEc4IrwZ/AIWQQ8gizCeWEasIuwmHCacIVQi/hJZFIZBIdib7EGGImMZ84j7icuIV4gNhK7CbeJw6SSCRTkispkJRA4pIUpHLSRtI+0nHSRVIv6bWOro6VjqdOlE6WjkSnTKdaZ6/OMZ2LOg91hsj6', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\r\n### The error may exist in file [D:\\workspacemy\\lptGit\\lpt-single-item\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,     avatar = ?,     password = ?,     status = ?,     login_ip = ?,     login_date = ?,              faceBase64 = ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\n; Data truncation: Data too long for column \'faceBase64\' at row 1', '2025-03-20 18:12:10', 492);
INSERT INTO `sys_oper_log` VALUES (112, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAA9AAAALiCAYAAAAxaz76AAAMKGlDQ1BpY2MAAEiJlVcHVFP3Gv/uSEJCEkYgAjLCXqIMgQCyZwQB2eAiJIEEQggZqLippRWsAxUHjopWRay2WgEpKqIWB0VwW8dDLSpKLWpxofJOBmjree+d951z7/2db/6+79z7P/cD0EvkSqViVB+gUKKQJUWHsTIys1ikXkDAFMjgCw5cnlwampgYBwAw8vy7vLwKiOp5yU2V63P7fxUDvkDOA0ASASCHL+cVAiA/AeA+PKlMAUDoBwDb2QqpAoCoDwBGsozMLACinQrnaTBbhXM0OE7tk5IUDkDMBtChcrmyPAC6iherhJenAKAvBwB3CV8kAaC3AEAQT8jlA9DfAcC4wsIiPoCeEwA45XySJ+9vOXNGc3K5eaNY04tadCJEcqmYO/f/HMf/lkKxcqSGLQBQhbKYJFXPqrkVFMWqMBUAOSPJiU8AAEMA5LKIr/ZX4QdCZUyq1v81Tx6eBQBMAJTK50bEAoA5AGojEcfHafVBuaIoDgDoA6ApIgUnRROL8mVFSdr86ByBPDJ5BHNl6loqnwplQWqoNudWoYAzkrO5VJiSruGJdpWI0uIBgA6A3pIXJMdqfR6XCsPjR3xkyiQVZzsADHJlUUkaH8yuUD7SF+YvFHHitThOIUyJ0cRiM3lcNTcTACxfIM+IG+HJF0REavrCygSSVC1/rEqqCEvS+u+UihO1/liLQByt0tsAYJ3ykuSR2AGFLEU7fxykisQUDTfcKJ87OVHDAXeBOAiHCGCBEliQA0WQD6LO/sZ+YGktUcAFGeSBANy0mpGIdLVFAlxIhlL4AyQgAPloXJjaKoASkMD7Ua3m7ga5amuJOqIAHoAMCiEWxCAApTpKMlotDX4HGYg+q86DIhBDkdr2mY6lN6IjRhIjiDHEKKIzboYH4QF4HB6Eh+BBuCfOxv1GeH30JzwgdBPuEa4Qegg3ZonKZP9gzoIp0ANK7VQEkPNpd7gD7ol742F4IB6kyo0zcTNwwyfibDwUD8YDcG/c729claMdf5ylNhfZnYySx5BDyE7/ZEB3oXuPZlFN6tNZaHjljE4rfNTyzz7CP5kfH4og9p+e2NfYIawdO4GdxVqwRmBhx7EmrAM7qsKj78bv6ndjpFqSmk8BiEH0WT2utqZqanL3evc+93daGygEcxSqjyW8SDpXJsoTKlihUqlYwOJIeOPHsTzdPT0AVGe/5mh5wVSf6Qjz3EddcSuAXwUAkvdRx7UFOPIAgPHyo872OQB1FcDRLp5SVqLR4aobASigB0ZgCpZgC07gBp7gAwEQApEwGRIgBTJhJvBACIUgg9kwH5ZAOVTCKlgHm2Ab7IA98D0chEZogRPwC5yHLrgCN6EHeuEJDMBLGEIQhITQEAZiilgh9ogr4omwkSAkEolDkpBMJBvJQySIEpmPfIFUIlXIJmQ7Uof8iBxBTiBnkW7kBnIX6UOeI29RDKWiRqgF6oBOQNloKBqLpqAz0Dy0GC1Fl6Ir0A1oLboPbUBPoOfRK2gP+gQdxADTxZiYNeaGsbFwLAHLwnIxGbYQq8CqsVpsP9aMtWOXsB6sH3uDE3EGzsLd8AA8Bk/FeXgxvhBfjm/C9+AN+Cn8En4XH8A/EGgEc4IrwZ/AIWQQ8gizCeWEasIuwmHCacIVQi/hJZFIZBIdib7EGGImMZ84j7icuIV4gNhK7CbeJw6SSCRTkispkJRA4pIUpHLSRtI+0nHSRVIv6bWOro6VjqdOlE6WjkSnTKdaZ6/OMZ2LOg91hsj6', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\r\n### The error may exist in file [D:\\workspacemy\\lptGit\\lpt-single-item\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,     avatar = ?,     password = ?,     status = ?,     login_ip = ?,     login_date = ?,              faceBase64 = ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\n; Data truncation: Data too long for column \'faceBase64\' at row 1', '2025-03-20 18:13:08', 741);
INSERT INTO `sys_oper_log` VALUES (113, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAA9AAAALiCAYAAAAxaz76AAAMKGlDQ1BpY2MAAEiJlVcHVFP3Gv/uSEJCEkYgAjLCXqIMgQCyZwQB2eAiJIEEQggZqLippRWsAxUHjopWRay2WgEpKqIWB0VwW8dDLSpKLWpxofJOBmjree+d951z7/2db/6+79z7P/cD0EvkSqViVB+gUKKQJUWHsTIys1ikXkDAFMjgCw5cnlwampgYBwAw8vy7vLwKiOp5yU2V63P7fxUDvkDOA0ASASCHL+cVAiA/AeA+PKlMAUDoBwDb2QqpAoCoDwBGsozMLACinQrnaTBbhXM0OE7tk5IUDkDMBtChcrmyPAC6iherhJenAKAvBwB3CV8kAaC3AEAQT8jlA9DfAcC4wsIiPoCeEwA45XySJ+9vOXNGc3K5eaNY04tadCJEcqmYO/f/HMf/lkKxcqSGLQBQhbKYJFXPqrkVFMWqMBUAOSPJiU8AAEMA5LKIr/ZX4QdCZUyq1v81Tx6eBQBMAJTK50bEAoA5AGojEcfHafVBuaIoDgDoA6ApIgUnRROL8mVFSdr86ByBPDJ5BHNl6loqnwplQWqoNudWoYAzkrO5VJiSruGJdpWI0uIBgA6A3pIXJMdqfR6XCsPjR3xkyiQVZzsADHJlUUkaH8yuUD7SF+YvFHHitThOIUyJ0cRiM3lcNTcTACxfIM+IG+HJF0REavrCygSSVC1/rEqqCEvS+u+UihO1/liLQByt0tsAYJ3ykuSR2AGFLEU7fxykisQUDTfcKJ87OVHDAXeBOAiHCGCBEliQA0WQD6LO/sZ+YGktUcAFGeSBANy0mpGIdLVFAlxIhlL4AyQgAPloXJjaKoASkMD7Ua3m7ga5amuJOqIAHoAMCiEWxCAApTpKMlotDX4HGYg+q86DIhBDkdr2mY6lN6IjRhIjiDHEKKIzboYH4QF4HB6Eh+BBuCfOxv1GeH30JzwgdBPuEa4Qegg3ZonKZP9gzoIp0ANK7VQEkPNpd7gD7ol742F4IB6kyo0zcTNwwyfibDwUD8YDcG/c729claMdf5ylNhfZnYySx5BDyE7/ZEB3oXuPZlFN6tNZaHjljE4rfNTyzz7CP5kfH4og9p+e2NfYIawdO4GdxVqwRmBhx7EmrAM7qsKj78bv6ndjpFqSmk8BiEH0WT2utqZqanL3evc+93daGygEcxSqjyW8SDpXJsoTKlihUqlYwOJIeOPHsTzdPT0AVGe/5mh5wVSf6Qjz3EddcSuAXwUAkvdRx7UFOPIAgPHyo872OQB1FcDRLp5SVqLR4aobASigB0ZgCpZgC07gBp7gAwEQApEwGRIgBTJhJvBACIUgg9kwH5ZAOVTCKlgHm2Ab7IA98D0chEZogRPwC5yHLrgCN6EHeuEJDMBLGEIQhITQEAZiilgh9ogr4omwkSAkEolDkpBMJBvJQySIEpmPfIFUIlXIJmQ7Uof8iBxBTiBnkW7kBnIX6UOeI29RDKWiRqgF6oBOQNloKBqLpqAz0Dy0GC1Fl6Ir0A1oLboPbUBPoOfRK2gP+gQdxADTxZiYNeaGsbFwLAHLwnIxGbYQq8CqsVpsP9aMtWOXsB6sH3uDE3EGzsLd8AA8Bk/FeXgxvhBfjm/C9+AN+Cn8En4XH8A/EGgEc4IrwZ/AIWQQ8gizCeWEasIuwmHCacIVQi/hJZFIZBIdib7EGGImMZ84j7icuIV4gNhK7CbeJw6SSCRTkispkJRA4pIUpHLSRtI+0nHSRVIv6bWOro6VjqdOlE6WjkSnTKdaZ6/OMZ2LOg91hsj6', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\r\n### The error may exist in file [D:\\workspacemy\\lptGit\\lpt-single-item\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,     avatar = ?,     password = ?,     status = ?,     login_ip = ?,     login_date = ?,              faceBase64 = ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'faceBase64\' at row 1\n; Data truncation: Data too long for column \'faceBase64\' at row 1', '2025-03-20 18:14:32', 49903);
INSERT INTO `sys_oper_log` VALUES (114, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAfoDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAAAAQIDBAUGBwj/xAA9EAACAQMDAgMFCAEDBAICAwAAAQIDBBEFEiExQQYTURQiMmFxBxUjM0JSgZGhFlOxJDRD0XLBNWJjc+H/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAwACAwEBAQAAAAAAAQIRAyESMUEEEyIyUWEUcf/aAAwDAQACEQMRAD8A+zAAAAAAAAAAEX1JEH8QWJDEMIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAMQnJR6shKvBdXx69hoWgVwr06nwyTx1WehJzUevT1GhIBZABgIYAAAAu4xdxgAAAAAAAAAAAAAAAAAAAAAAACAAABDEAAAFUAAADIkhBSAAKAAAAYhsQCAYFARJCAQwAAAAAQABQg6AV187HgDYAAc2QAAAAAAIj+okQfxFixMYl0GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIjOahFyfRAOUtqb9Dk6nr9tp1vGvOacXPb1xyeN8WfaHG2m6VhcJVaVRwq0pLrE+Zatr13fzlF1H5bk2opvBrqe10+l+JPtFjR9yzecPEk370X/B5Kr4/wBRqyco1ksrDxlZPFucpNt5ywi03y8DyvxXsf8AW+q7lNV3uj+pcN/+zs2H2mXsabheJT4xmK6/U+dxjJ/C8k4uS4aJ5UfS7f7VatCbjVt1VpZ4a4aR0qH2pUJNJUk0u0nh4Pkb5JRXzwy+X+mn3/S/Gek6nGDp14wcuNs3hp/M7lO4jPPvLh44Z+Zo150qm+L', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 18:15:43', 14439);
INSERT INTO `sys_oper_log` VALUES (115, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAADAAECBAUGBwj/xABDEAACAQMCBAUCBAUCBAQFBQAAAQIDBBEhMQUSIkETMlFhcQYjFIGRoTNCUrHBFfAkNNHhB0Ni8RZjcpKygoSiwuL/xAAZAQADAQEBAAAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAQEBAQAAAAAAAQIRAzESIQRBEyIyQlEUYf/aAAwDAQACEQMRAD8A1YXcG90HjVi9mcLT4tWpvqjIvW/HcvDbXycNjtjsYyT7k0c3Q43BrzF6lxaEmuoRtjIilG/pv+YNG5hJaMQHyTTAxqRfcnF57jIVMjPYSYmAZV+tGc3eR6n8nUXscxZzd5Hrfyc3K6+FmzQCa0ZYktwFTZnK64pzWpDAWe5Bas1nRISjoClAtuOgOcRzIVk3lMx6scTaOgvIaGHcLEz0uC+nm/KnvauIdjYOlwFkWR0hYAjB6PlAhaOrwAXbRrnNql/DMO3WKqNyg8wRNUzrlYqE7fdCvFiqNbvVDDuPou48K8a9T0CVVSX5Hmf0vPlvo6nosHmC+DPXtUvph3tNfiZNoCqa9C9dw+89APISNgqOCaRPkwJRAzx3CIikSQEIhyKJADoklkikFhEASgTUAkYBFHAwHGGC3brAJILTWGEF6aVrLUvxZmWzxI0Is1lZ6KT1I5GnIg5GkqRMj5BKWe5NMLRpPInJIi2RbItVIU6mujIc79SLWWSUCaYU22gEo5eS66WmwOVPBNVCot8pOccxZGmsPAVrKIUybmm1LICC1L9zBFLHLIYHgkWKTwVYzSRPxuXTJORxcbygFWCl', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 18:16:20', 14140);
INSERT INTO `sys_oper_log` VALUES (116, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAbQBegMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAACAAEDBAUGB//EAD0QAAEEAQIEBAQEBAUEAgMAAAEAAgMRIQQxBRJBUQYTYXEigZGhFDKxwQcjQlIVM2LR4SVT8PEWQyQ0ov/EABkBAAMBAQEAAAAAAAAAAAAAAAABAgMEBf/EACIRAQEBAQADAAIDAQEBAAAAAAABEQIDITESQQQyURMUYf/aAAwDAQACEQMRAD8Ale4C8qMGyhLXE0jbG6lepwYqsp/hpD5bk1OHTCNPCIFYTUOyIg0gIcLwnKmwnNFdlHy/JOXEIQ+zhOUrB10SrHZNeErr5J/kn8QluKURbnA+qMvGQhsWiUYAtoIaypCc90LlUpWBpEG2mBzhG01SNLDiNoCINHZIHCcEDKNGFyCs1SYtHZSNc2kJ3RowHIhLawpD6bIDVpwsCMFPSQGN04qkwQASICV4QlPSKhSRb8k7dk4SAC1RluVYICAgJhEG/ZOBXRFWeyQH0SB2ktyBSlZqHNwoTYPVNeEG0Gawis0p2a4j+pZPTGEQe4dUFjbZrfVWI9WDVlc8JnA7qaPUkCiSjA6NupGMoxOK3WC3VnupRq8DKnA2fP8AUJjOO6xzreloTrdhdfNGBuNmvYqZjgRusOHXDGVdh1INUUYI0gnpQxzAjKlBF+qQw9JfRPhKwjRjk/6lI3AVVszT1ClEgA3C53XixYpATVqIygY2TGQVugJC6lGX0UBlFeihfLhPRiRzxSTQCbGFW8wk4P0U0bh6JypxKRjFIHVedkXMKQPIRowxDQUgBXRBzC67JcwrdOUsOQOiicK60nc6rygL8p6ME0Zq09Ho', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 20:59:04', 2454);
INSERT INTO `sys_oper_log` VALUES (117, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJmyuLiAJSN4gqwuZYygXnPShdcDpPLSFXCB8hKBDk4c0AQldUkmAgNjhAEAoDl0jMDCgLY+oo+ZsEgJ52CsBJyFQrZm4TkgWCAie00oKyZsmEhB0+E33AQEAfcfKjJCjmunCgBCCOnkCnkOFkt0Zi0KBg1s3RIaLxlKDb5RIc4IIGTcJWxzlWNMZQgeEDS09JSbmFASbIEc', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 20:59:14', 126);
INSERT INTO `sys_oper_log` VALUES (118, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJmyuLiAJSN4gqwuZYygXnPShdcDpPLSFXCB8hKBDk4c0AQldUkmAgNjhAEAoDl0jMDCgLY+oo+ZsEgJ52CsBJyFQrZm4TkgWCAie00oKyZsmEhB0+E33AQEAfcfKjJCjmunCgBCCOnkCnkOFkt0Zi0KBg1s3RIaLxlKDb5RIc4IIGTcJWxzlWNMZQgeEDS09JSbmFASbIEc', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 20:59:18', 112);
INSERT INTO `sys_oper_log` VALUES (119, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAh4C8gMBIgACEQEDEQH/xAAbAAEBAQADAQEAAAAAAAAAAAAAAQIDBAUGB//EAD0QAAICAQIEBAQEBQMDBQADAAABAhEDBCEFEjFBIlFhcQYTgZEyQrHBFFKh0eEjYvAkM3IVJUOC8WNzkv/EABoBAQEBAQEBAQAAAAAAAAAAAAACAQMEBQb/xAAjEQEBAAIDAAIDAQEBAQAAAAAAAQIRAyExEkEEIlEyE2Fx/9oADAMBAAIRAxEAPwD4+hRaFFIEVBBAUFAFoUKFAUApQgBokAAAotAtAAUAQoKBllKA1KKUgTVKQoalCy2KAAUKAUKFCgAKAICgCUaa2KSgM0KFCgBQaCWAUBu0oUKFA9AUBqELQAyDQAyDQAyQ0ZZQjAKAIUlEiAACEotAoShRQBEEaQAhDRAMsjNMjAyyM0yMCENEAjDDDAyilAGCGzLVAQAAZBQBkhoywIQ0QDINGQBDRDPWpQANHcABLBIoABBGkEBQAUBSFAoKCRCgoAFAEoUWhQBFQRUUAoookEgkGhQAFAEoUDS6AZKaozTAhRTNUABQEoCgAAAMtCi0KKUAoJSgKAMshshSgAADJoEjFCjZGBmhRQBKJRolBLINSiiUFIKKAlihRogEojRp7EoKZBaKkAAAEQKgwMkNEAyQPqChGRmmRgZAAANWABGRlZGBkFAagAAhDRAxmiGmZewEZlm2QDIAAAADthBBEipFSCZpMCJUUAoEVFQJCgkUqAgKACQoItACkooChRRQCi0AABQANNWDIF5RRpAJSigUGAADQAAAAFABShAUEidB1HUdAFCigCAAoBQAAjKAIUAAGASIBQoAAChKM0aoUSMtEo00', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 22:04:45', 147);
INSERT INTO `sys_oper_log` VALUES (120, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi2', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/20/blob_20250320174620A002.png\",\"createBy\":\"\",\"createTime\":\"2025-03-18 18:59:12\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEh', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-20 22:06:14', 131);
INSERT INTO `sys_oper_log` VALUES (121, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '117.140.89.158', 'XX XX', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAMgAlgDASIAAhEBAxEB/8QAGwAAAwEBAQEBAAAAAAAAAAAAAAECAwQFBgf/xABAEAACAgEDAgUCBAMECwABBQAAAQIRAwQhMRJBBRNRYXEigQYUMpFCobEVI1LBJDNDU2JygpLR4fA0B1RjwvH/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAjEQEBAQEAAgICAwEBAQAAAAAAARECAxIhMRNBBDJRYSJC/9oADAMBAAIRAxEAPwD5cpfJKKXodHGGNbEjsKq9x2R3sYRdi5FYWQUgsmx9wKsBILAq9wtE2FgaJ7DM0y7NCkykyENMiKv3BMkaZBVgSFlDsTYmwKVQWyd6C7DKkwsn+Qwp2F0KwIHaGSntQ72KHYhBZA/uKxXuFlDbFf8A8wFYZPb2CxJhYU0wsQr2CqsCWwbKG3sS2DZNhD7gmKwAbYcolgiKNrH2EK+wFXuFiAqG2KwYdyNCyW+42SwHYu2wWJsKLoXIg+5Q2FisAG2S2D7ksiH3C9uBC29wh2+4rAT4Kpeor3GxBFWF+ouwvTciqAV7AFaLkrsSikRTCxWJAUuATEMIoBcdwRBS4GiR/ADDuLcAHYMQFDRa7maLQF2MkLAqwFYWEUmAkK9wpisBFRQr3CwtETDsLFYrKKugslsAK7jsnsADtALYAGKwsVgOwXuIO4Q7RNjvYlsCrE3QgYDsCfQChvkQX2FYUwsViTCHYPgVhZFOxCbQAO/cLJHZQ/YBARTsljJbAYmw+4mwor1E2CdiCGD9hWDZQCYWHwQISBhwA2u5MlTK5EwqQB/IFQVsJjsHyQHo/QAoCK0sd7EWNEVVhYhlDXIyUymAx2SMiGO9ybCyirGShhTQMQABUWSEWEaDslDAYCsEwKsLJCwKsViugsBhYhWEVYgCwCx2SH2KKsLFYBDCxWIB8DJABthYhX7gVYr3FYWQO6E2Jh3AdisQFDvYQCsBiEBQ+wNisCBiYWKwKEIAGOyb9wsKdoQCvcBiYXsJvY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-21 00:23:28', 35);
INSERT INTO `sys_oper_log` VALUES (122, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '117.140.89.158', 'XX XX', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAMgAlgDASIAAhEBAxEB/8QAGwAAAgMBAQEAAAAAAAAAAAAAAQIAAwQFBgf/xAA7EAACAgIBAwIFAgUDAgYCAwAAAQIRAyExBBJBUWEFEyJxgTKRBhRCobEjM8EV0UNSYnLh8AeCFiSS/8QAGQEBAQEBAQEAAAAAAAAAAAAAAQACAwQF/8QAIhEBAQEBAAMBAQEBAQADAAAAAAERAgMSMSFBE1EEFCIy/9oADAMBAAIRAxEAPwD5ly/AXp6A2rf2sF7MJGrZPGx1HV0ydv1AVKi1KyRX1Xz6lslsXzZtzovb5A1UkS/sRvuGBL3yFMX3CjRhm/yI+OePULYL8ASPXC8EvWyOu4l+hplAS5JoEl6EkSsMppR4JqN+xVJ2AK3b4CTtI9HOrArXL/Ir1dBfAoRG75VwDuuttNehFP1A3FrhA6UkvX3F36jSurAlYsh52RIKX+A1oVob9xkrRCyMSBO3VvRZji6vlfcaEK/Jdign5/BYxqYoN268o0xXbG62LFJcBlzVhjUpu647KMsr1bHm+3V2UN+TNVJK/Lsrk9Vr8hnJXyVSfOzUEgN+rBaa9xb2EWx3dgIQEnuT77AESKdaDaYvuNYJPyxlKTVXoXyNsAeKdlvc0nbbbKofuWKVc/3MUBFU74Ll2+Xsq8uh4pMefqn1HV6Fl+9BkkmB7XJ0roSSROaaCwVowhTfkO/UXt9xqNxuJquA2Be5PFrYUpvl/wBgXfD0RLe+APk5sVObtJ/dWTT5JrZDUZMSX1RVAjTdehE3fGiaG24NW9C3w1/YP/if2IluUW9eAZqXsNukCPH2Cv8ABKDph3X6nG/CrYrb4REn5B0h+PUlpe4LrTFb2TpKL234ZAeVtJ+5BOtPbVr00GkuNja1foTXodHnBMNolgBaj2K0GyN6NMA0vUD50LuvyTd8Goh8kXqRL8B+yEI9gd3tr8B8bFeuQWhXkX3GF2xiQDdBFa/+sTgSbbF4GfNIXlmaBsVuw+4pzJZegOAy5EbJYP', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-21 00:45:38', 32);
INSERT INTO `sys_oper_log` VALUES (123, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '117.140.89.158', 'XX XX', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAJYAyADASIAAhEBAxEB/8QAHAAAAwEBAQEBAQAAAAAAAAAAAAECAwQFBgcI/8QAOBAAAgICAgEDAwMCBAQGAwAAAAECEQMhBDFBBRJhUXGBBhMiMpEUI0KhM1Kx8BVigpLB4SRy0f/EABgBAQEBAQEAAAAAAAAAAAAAAAEAAgME/8QAGhEBAQEBAQEBAAAAAAAAAAAAAAERAjEDEv/aAAwDAQACEQMRAD8A/OF1/wDJpEzX/wCt/kpHje9fxRSjb7JT+llJ/BmstYJJGiSMoNGqBLizSLt9Gcds0itgWyNIsyjryaR7ok6Is0T0ZR6LRFtHo2i9GGP+k1jpgm0XstGcTRADCgRSFkgHQhBMhoslgmbIl0aSM2RZNGE1s6H2YyQwMJIxmtnRJGM0bjLkyr8HNkX0O3Ijlyo3BXLJHPkWno6pIwyI3GK4pmDOmaMJLZuMVIWIa2LDWDTRTVmKbTNoO0QCbTK8iaBMiGZyi0aA6aEsFoOypRpk3ZIDixAQbQkdnD5mTh545cUmmjz4ujaE0CfqX6e/UMOZiipSqVbVn1WLOpxTs/D+FzMvCzLJjlWz9E9A/UEOZjjGUv5LtGLC+xTKTObDlU42mbJmC1sLM7HZJomMzTKsksaI9xSZJSKRKKTFKoKBMaJGkWiUUiS0UiEWiRopEopClIYkMkaKQkNEjGAEgyWwbJbBBshsbZDZINkSkKUjOUiRTkYTmOcjnyToCnJOjizZdF5sp5+fN3siz5Gak9nh8/me2L2dPN5Sins+Y9S5jk2kxLj5vIebJv6nNYW27EwJN/3FYNisG5TIkURLsmtL+xJTRIxm01YPoBmkyfySOfYhR9Et2/A6E1RMtk9DT39iEyji6a2T12UvsZx0uy1ugOtIv6GqkYLRcX8A03h5NYswgzWLAtU2aRbsyjsuIB0QejVGMWaRYJvjZsuzCDNUyOtomiZimaRZBohkotECAYiAaJZRLJIkjKRqzOQpi7IZrLszf2IMpIwmtnQzGZ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-21 00:47:23', 29);
INSERT INTO `sys_oper_log` VALUES (124, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqOzIe/B7TpenhNPpBc7ixWfGV7zNVvaK1qUVdTSMdiVlS70Ka2VOdOGyHHJBg71L2KHcDgsM8CQ6fQaitNQ6Whl/emeMHzMo0tDr6lO3Tstu7j28zTtbT7lJ/9Q+JzXTKV0mLdGnq+o2M+FM2dJS1K3W3vut75/wBomkaumDYDKc8zXpJIAMx6bAltdajCouTNfTfZ+ZqItSC9ijZzgQt4ye', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-21 11:10:04', 119);
INSERT INTO `sys_oper_log` VALUES (125, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqOzIe/B7TpenhNPpBc7ixWfGV7zNVvaK1qUVdTSMdiVlS70Ka2VOdOGyHHJBg71L2KHcDgsM8CQ6fQaitNQ6Whl/emeMHzMo0tDr6lO3Tstu7j28zTtbT7lJ/9Q+JzXTKV0mLdGnq+o2M+FM2dJS1K3W3vut75/wBomkaumDYDKc8zXpJIAMx6bAltdajCouTNfTfZ+ZqItSC9ijZzgQt4ye', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-21 11:10:22', 89);
INSERT INTO `sys_oper_log` VALUES (126, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqOzIe/B7TpenhNPpBc7ixWfGV7zNVvaK1qUVdTSMdiVlS70Ka2VOdOGyHHJBg71L2KHcDgsM8CQ6fQaitNQ6Whl/emeMHzMo0tDr6lO3Tstu7j28zTtbT7lJ/9Q+JzXTKV0mLdGnq+o2M+FM2dJS1K3W3vut75/wBomkaumDYDKc8zXpJIAMx6bAltdajCouTNfTfZ+ZqItSC9ijZzgQt4ye', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-21 11:10:40', 86);
INSERT INTO `sys_oper_log` VALUES (127, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi6', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-21 00:21:21\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqOzIe/B7TpenhNPpBc7ixWfGV7zNVvaK1qUVdTSMdiVlS70Ka2VOdOGyHHJBg71L2KHcDgsM8CQ6fQaitNQ6Whl/emeMHzMo0tDr6lO3Tstu7j28zTtbT7lJ/9Q+JzXTKV0mLdGnq+o2M+FM2dJS1K3W3vut75/wBomkaumDYDKc8zXpJIAMx6bAltdajCouTNfTfZ+ZqItSC9ijZzgQt4ye', '{\"msg\":\"您删除的人脸有误，请重新上传人脸\",\"code\":500}', 0, NULL, '2025-03-21 11:11:46', 614);
INSERT INTO `sys_oper_log` VALUES (128, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqOzIe/B7TpenhNPpBc7ixWfGV7zNVvaK1qUVdTSMdiVlS70Ka2VOdOGyHHJBg71L2KHcDgsM8CQ6fQaitNQ6Whl/emeMHzMo0tDr6lO3Tstu7j28zTtbT7lJ/9Q+JzXTKV0mLdGnq+o2M+FM2dJS1K3W3vut75/wBomkaumDYDKc8zXpJIAMx6bAltdajCouTNfTfZ+ZqItSC9ijZzgQt4ye', '{\"msg\":\"您上传的人脸有误，请重新上传人脸\",\"code\":500}', 0, NULL, '2025-03-23 21:11:55', 382);
INSERT INTO `sys_oper_log` VALUES (129, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqOzIe/B7TpenhNPpBc7ixWfGV7zNVvaK1qUVdTSMdiVlS70Ka2VOdOGyHHJBg71L2KHcDgsM8CQ6fQaitNQ6Whl/emeMHzMo0tDr6lO3Tstu7j28zTtbT7lJ/9Q+JzXTKV0mLdGnq+o2M+FM2dJS1K3W3vut75/wBomkaumDYDKc8zXpJIAMx6bAltdajCouTNfTfZ+ZqItSC9ijZzgQt4ye', '{\"msg\":\"您上传的人脸有误，请重新上传人脸\",\"code\":500}', 0, NULL, '2025-03-23 21:12:08', 2125);
INSERT INTO `sys_oper_log` VALUES (130, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAaoCgAMBIgACEQEDEQH/xAAcAAADAAMBAQEAAAAAAAAAAAAAAQIDBAUGBwj/xAA7EAEAAQMDAwMDAQcEAQMEAwABAAIDEQQhMQVBUQYSYRNxgZEHFCIyQqGxFSPB0TMkU+ElUvDxQ2Ky/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAIBAwQF/8QAIxEBAQEAAwEAAwEBAAMBAAAAAAERAgMhMRJBURMEFDJhcf/aAAwDAQACEQMRAD8A+jQhzCUCEUDmZA4QxHKClYihAIo4oFEUUMwCEITBWIoziKAmEcUAp5jilEBkmPMUAhCE0EIRpAMZk4lEUB4hiKEAhCEwEI8QxACGIYjIBiOEMTUiErEMQJCViMI8QIx5gkvEMQpGCPEqLZMnEKQkMS/bD2zEoxBI3bmPECMRJKxDE1KPbtEkvESQpjaZPtmRJOJiU+2LEuGJohIklMlIE4gkpk9oCiSNiYUnGYmmX/TIZgXth7YQmtLEUITGEwSDHCWOJzLSJ3gRE0ykksBSZUlgL+qH9UcTzNHa9scIMxRRkUDmaHKJMcAhCEAijigEIEcBQjhMCjhCA2TKZMBwhGQwoQhAIQhNaqGIRwkoYjigTKxCEAxDEcJitLEI8QxAWIwgSiaEEeIwjKYSXtjxH7YlBDu8TFDEftlG8CoXAzUpTBmHtmK9qrdhPqIZTBNHX9b0lissNzCma/IfB5/xCm/7xorrM44PmK2hp6FRcGceZ53V+stDbS1ZuUNYBQZzlfH2P7zl3PW2gs6dMt6u24t0G/veMvkP8zFPb+8yUZMvYibwV4HLPM6Xrluza9+uvFtTNz31mTbOM+e78bQ6Z6it6lr1V3/Zs14NPb2XH/3vy9jxM0enB5d3/Epxmcr/AF/S11/TtPvrxnbfby+CM6', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:13:14', 709);
INSERT INTO `sys_oper_log` VALUES (131, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAfoDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAAAAQIDBAUGBwj/xAA9EAACAQMDAgMFCAEDBAICAwAAAQIDBBEFEiExQQYTURQiMmFxBxUjM0JSgZGhFlOxJDRD0XLBNWJjc+H/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAwACAwEBAQAAAAAAAQIRAyESMUEEEyIyUWEUcf/aAAwDAQACEQMRAD8A+zAAAAAAAAAAEX1JEH8QWJDEMIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAMQnJR6shKvBdXx69hoWgVwr06nwyTx1WehJzUevT1GhIBZABgIYAAAAu4xdxgAAAAAAAAAAAAAAAAAAAAAAACAAABDEAAAFUAAADIkhBSAAKAAAAYhsQCAYFARJCAQwAAAAAQABQg6AV187HgDYAAc2QAAAAAAIj+okQfxFixMYl0GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIjOahFyfRAOUtqb9Dk6nr9tp1vGvOacXPb1xyeN8WfaHG2m6VhcJVaVRwq0pLrE+Zatr13fzlF1H5bk2opvBrqe10+l+JPtFjR9yzecPEk370X/B5Kr4/wBRqyco1ksrDxlZPFucpNt5ywi03y8DyvxXsf8AW+q7lNV3uj+pcN/+zs2H2mXsabheJT4xmK6/U+dxjJ/C8k4uS4aJ5UfS7f7VatCbjVt1VpZ4a4aR0qH2pUJNJUk0u0nh4Pkb5JRXzwy+X+mn3/S/Gek6nGDp14wcuNs3hp/M7lO4jPPvLh44Z+Zo150qm+LcWu6Z6fRvH2o6fXxWqOtRkkpKT5+v1L', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:13:43', 7483);
INSERT INTO `sys_oper_log` VALUES (132, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAfoDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAAAAQIDBAUGBwj/xAA9EAACAQMDAgMFCAEDBAICAwAAAQIDBBEFEiExQQYTURQiMmFxBxUjM0JSgZGhFlOxJDRD0XLBNWJjc+H/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAwACAwEBAQAAAAAAAQIRAyESMUEEEyIyUWEUcf/aAAwDAQACEQMRAD8A+zAAAAAAAAAAEX1JEH8QWJDEMIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAMQnJR6shKvBdXx69hoWgVwr06nwyTx1WehJzUevT1GhIBZABgIYAAAAu4xdxgAAAAAAAAAAAAAAAAAAAAAAACAAABDEAAAFUAAADIkhBSAAKAAAAYhsQCAYFARJCAQwAAAAAQABQg6AV187HgDYAAc2QAAAAAAIj+okQfxFixMYl0GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIjOahFyfRAOUtqb9Dk6nr9tp1vGvOacXPb1xyeN8WfaHG2m6VhcJVaVRwq0pLrE+Zatr13fzlF1H5bk2opvBrqe10+l+JPtFjR9yzecPEk370X/B5Kr4/wBRqyco1ksrDxlZPFucpNt5ywi03y8DyvxXsf8AW+q7lNV3uj+pcN/+zs2H2mXsabheJT4xmK6/U+dxjJ/C8k4uS4aJ5UfS7f7VatCbjVt1VpZ4a4aR0qH2pUJNJUk0u0nh4Pkb5JRXzwy+X+mn3/S/Gek6nGDp14wcuNs3hp/M7lO4jPPvLh44Z+Zo150qm+LcWu6Z6fRvH2o6fXxWqOtRkkpKT5+v1L', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:14:35', 36059);
INSERT INTO `sys_oper_log` VALUES (133, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAEAQIDBQYABwj/xAA+EAABBAIBAwMDAgUCBQIGAwEBAAIDEQQhMQUSQSJRYQYTcTKBFCNCkaGxwRUzUtHwJGIHFnKiwuE0Q/Fj/8QAGgEAAwEBAQEAAAAAAAAAAAAAAAECAwQFBv/EACURAQEAAgMAAwACAgMBAAAAAAABAhEDITEEEkEiMhNRBUJhFP/aAAwDAQACEQMRAD8Az4dZTqTQyglWeocriwE0o3RhWuBgulYXuHPFqDPgGPlGOqBAIWf270v6quSEc0gsqH0mh4Vz2X4QmXGQCq2JNMxI2nkKMt1SLzGFslkKIgFvCuFVdO2nqDyi8ttVaErapBQlSBKgOXLlyAc1TwH1hDNO1PGacEU4sW2Qh5BUiIYdBRTCnfukaTH4/dbfoz+7HbZ2sPAfVS13QH90VE7Cmhc5A7oiq4aKtXC4jrwqsiiUluspbtMNhKLKAfylXAJ4al+kaAl7U4NTg1BmdqXt14Ugb8J7WX4QETWEqQRlStZtP7AiBCI0v275Cn7QuoJFUTYx5CkEfsE4aTwgjBH+yliJaKXAWlA2ql1S9Sd/unRN7nCgo6RWEKd+6v7bLSzxARVhGlnwo8ZgIFoss0nKVivlFIHKAq/dWWQ3RpV0wuwStpludoUmS23KNgDUZlR1dIRc96rWeCYXUEZAb5KAjO6R+P40tcLtGUGRMs6RLY9bCjgFEIocLaMkJbSY4UpnBQvO+EjMpSNCjF2p4xaRU8NS9uk8NSO0FcqSUKUEzqYpSdIaV4NhKnFfkP5Ve95JNlG5LdFAPaRvwuTPe3Rj4YpGJgG1IxZNEzQl7Usak7FpimmxgdysMNznmhaDDKKsenNHdS0nqMlhHA', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:19:48', 780);
INSERT INTO `sys_oper_log` VALUES (134, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJmyuLiAJSN4gqwuZYygXnPShdcDpPLSFXCB8hKBDk4c0AQldUkmAgNjhAEAoDl0jMDCgLY+oo+ZsEgJ52CsBJyFQrZm4TkgWCAie00oKyZsmEhB0+E33AQEAfcfKjJCjmunCgBCCOnkCnkOFkt0Zi0KBg1s3RIaLxlKDb5RIc4IIGTcJWxzlWNMZQgeEDS09JSbmFASbIEcXflAZJQ7wibKE2QEfhQkSg11keMiZCASCUYlRvcqYNkEPtuBKhJMSi', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:20:30', 656);
INSERT INTO `sys_oper_log` VALUES (135, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:22:00', 739);
INSERT INTO `sys_oper_log` VALUES (136, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:22:08', 613);
INSERT INTO `sys_oper_log` VALUES (137, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:22:12', 597);
INSERT INTO `sys_oper_log` VALUES (138, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:22:17', 581);
INSERT INTO `sys_oper_log` VALUES (139, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:25:41', 1454);
INSERT INTO `sys_oper_log` VALUES (140, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:26:20', 26893);
INSERT INTO `sys_oper_log` VALUES (141, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:28:38', 831);
INSERT INTO `sys_oper_log` VALUES (142, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:29:42', 37928);
INSERT INTO `sys_oper_log` VALUES (143, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:29:48', 3772);
INSERT INTO `sys_oper_log` VALUES (144, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAhUDIAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQIDBAUGB//EADsQAAEDAwMDAwMDBAAGAQQDAAEAAhEDITEEEkEFUWEicYEGE5EyobEUI0LBFTNS0eHw8QcWJEM0YnL/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgMAAwEBAAAAAAAAAQIRITEDEkETMlEiYf/aAAwDAQACEQMRAD8A1fW31vrNX1Ct07p2odQ0tFxY51MwahGb9l4hzi8kuJJPJQ4lzi5xkkyUTbKoXEAwnCX8pmfwgUi/8ojBCLIPjCAGYR3RJ+Ev4QE3CcRhLjKL9kDOQhE4sgx8IAWRYI/hBFoKA/8AfZEcD8oEfhB+UBBQTdBBSgxAFkDKUzn4RkXRdA91oSuMmyfE4SF/eEEj5SdEIHp8pYGUADPKZtJKUWnsgz+UDERdExi4R/KUcFAAiU4tdIBPGeUBHkeyUnunF7IBgZmOEALi5RE5/lKb2F+yJjIQO+OFH3TJtlFuUAJwnNszdAykYm2ECx83TvlE3nKDOScoEI7zKIvlOSUTbuUAMz3TMgYUU4kIAke6MYQSLeEGQEAJyiexRMY+UsFBIIsB5KUyg9kDQQBm/lICUyD3FkBz5QfylbCW8RM4QSm0JZuk14JsoVqoZUA4yUFvOURx/tZf6ppY53mFGprGs9QNh5woNZuYSLgCZ4XOdr4ktOUHWCfUTACDol4a0lPe2bkQuM/XS2bySoO1rjF+IQdt1RjRci10CoyP1XIkLgf1Tr7jMqbNU7bmO0oO59wRdMug/C5NPWiA0k3yrW6kuaHT+kwg6VvKUkEhV06m4NkqbnjbI5VEovkItyoggBMEHsgeLwgG/ZEwIugygcxcJXIunY', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:31:49', 15118);
INSERT INTO `sys_oper_log` VALUES (145, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJmyuLiAJSN4gqwuZYygXnPShdcDpPLSFXCB8hKBDk4c0AQldUkmAgNjhAEAoDl0jMDCgLY+oo+ZsEgJ52CsBJyFQrZm4TkgWCAie00oKyZsmEhB0+E33AQEAfcfKjJCjmunCgBCCOnkCnkOFkt0Zi0KBg1s3RIaLxlKDb5RIc4IIGTcJWxzlWNMZQgeEDS09JSbmFASbIEcXflAZJQ7wibKE2QEfhQkSg11keMiZCASCUYlRvcqYNkEPtuBKhJMSi', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:35:58', 42703);
INSERT INTO `sys_oper_log` VALUES (146, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"2416820386@qq.com\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJmyuLiAJSN4gqwuZYygXnPShdcDpPLSFXCB8hKBDk4c0AQldUkmAgNjhAEAoDl0jMDCgLY+oo+ZsEgJ52CsBJyFQrZm4TkgWCAie00oKyZsmEhB0+E33AQEAfcfKjJCjmunCgBCCOnkCnkOFkt0Zi0KBg1s3RIaLxlKDb5RIc4IIGTcJWxzlWNMZQgeEDS09JSbmFASbIEcXflAZJQ7wibKE2QEfhQkSg11keMiZCASCUYlR', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:41:09', 995);
INSERT INTO `sys_oper_log` VALUES (147, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'xingyi', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/23/blob_20250323214147A001.png\",\"code\":200}', 0, NULL, '2025-03-23 21:41:46', 164);
INSERT INTO `sys_oper_log` VALUES (148, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/23/blob_20250323214147A001.png\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"email\":\"2416820386@qq.com\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJmyuLiAJSN4gqwuZYygXnPShdcDpPLSFXCB8hKBDk4c0AQldUkmAgNjhAEAoDl0jMDCgLY+oo+ZsEgJ52CsBJyFQrZm4TkgWCAie00oKyZsmEhB0+E33AQEAfcfKjJCjmunCgBCCOnkCnkOFkt0Zi0KBg1s3RIaLxlKDb5RIc4IIGTcJWxzlWNMZQg', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 21:42:00', 739);
INSERT INTO `sys_oper_log` VALUES (149, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'xingyi', NULL, '/system/user/profile/avatar', '111.55.13.173', 'XX XX', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/23/blob_20250323220146A001.png\",\"code\":200}', 0, NULL, '2025-03-23 22:01:46', 184);
INSERT INTO `sys_oper_log` VALUES (150, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'xingyi', '研发部门', '/system/user/profile/avatar', '117.140.89.158', 'XX XX', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/23/blob_20250323222553A001.png\",\"code\":200}', 0, NULL, '2025-03-23 22:25:53', 163);
INSERT INTO `sys_oper_log` VALUES (151, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', '研发部门', '/system/user/profile', '111.55.13.173', 'XX XX', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/03/23/blob_20250323222553A001.png\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"2416820386@qq.com\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAlwDIAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAABAgADBAUGBwj/xABAEAABAwMEAQMDAgMGBQMEAwEBAAIRAyExBAUSQVEGImETMnEUgQdCkRUjUqGxwSQzYtHhFiXwQ3KC8URjc5L/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/xAAkEQEBAAICAgIDAAMBAAAAAAAAAQIRAyESMQRBIjJREyNCcf/aAAwDAQACEQMRAD8A8cCYgIcSBe6YQTZQSiqjmycXaZRLGgSFAZtCIAxCUwFCfCAmbhFAuMEKNN4KLTcyFBBMIFObKEuIRIAdAKLvtygrh5PStY4gAFU35ALQG2yoA66rJ6Vjiq3REoI1wwQoXnCDTKhQAycKXAgqXUMwgA+5B7YMhFsyiXHwgh5FTifKkSYKJbGBKBeN0vGCjGcqBqCC5Rj5RAHSjrdICGjtFzZ+0qNIcL5RIEZQIRxHylLr3COMKQcwoBaZhTjJRNwhBNoQFwaBj+igA4qBpAuECUBiUAAEeknaBvbNwj7PCWCVOKCH4UnpANHKES2O0CObJR4woR2j0gWCSjEBAG6JJQLyurQTF0hB6CYcuP2oBCGExnsIHCCAzhFAWTC4QKDdQi0qTHSh92UCtJ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-23 22:54:00', 660);
INSERT INTO `sys_oper_log` VALUES (152, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'xingyi', '研发部门', '/system/user/profile/avatar', '117.140.89.158', 'XX XX', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/03/24/blob_20250324195023A001.png\",\"code\":200}', 0, NULL, '2025-03-24 19:50:23', 159);
INSERT INTO `sys_oper_log` VALUES (153, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', '研发部门', '/system/user/profile', '111.55.166.162', 'XX XX', '{\"admin\":false,\"avatar\":\"/favicon.ico\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"2416820386@qq.com\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAWgCWAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xAA7EAACAgEDAwMDAwMDAwMDBQABAgADEQQSIQUxQRMiUQYyYRRCcSOBoQdSkRWxwTNi0SQ0QyVTcvDx/8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECAwQF/8QAHBEBAQEBAAMBAQAAAAAAAAAAAAERAgMhMRJB/9oADAMBAAIRAxEAPwC9qPxIdPca7M5mzb0uxuQJWbo9n3BZ5srrrR0OvYqATNWrW+3kzn6NHdV+2XV3gYIm5rNbA1QbyJMnvE59msB4zNfp1zOgDd5uMrjUKw7SvZpsHgTSVMrGZPxLiayW0+ecQP03PaappGYvRHxJi6q6WgL3EuqMCJV2+IU1ENI3ksBxKK1vaU7KWczR2Z7iGtC8HEmCDRacockTURcDECuvbJpYGMDMMyJpQWYDGDuxAdwOSYBkwCwlazUhc8ynbq2PAMzejF27UisHLShZ1Os5BaVLtVtBLHMw9frAhJU8zF7akamv6oET2vOB+o+tW3Ma1sOO2JJ1Lqz8rOW1epD3Au3JMkuliVTlAzHkniStZhBjk+ZFXWzhD45kN1zDOOJoiY2kxKUwWYE47Sgbz6e7PPxC091hO0cn4jF1uabcqhwAVc4HzNvpekFuSCMqeM9zMHSGlyqO', '{\"msg\":\"您上传的人脸有误，请重新上传人脸\",\"code\":500}', 0, NULL, '2025-03-24 20:21:25', 340);
INSERT INTO `sys_oper_log` VALUES (154, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi', '研发部门', '/system/user/profile', '111.55.166.162', 'XX XX', '{\"admin\":false,\"avatar\":\"/favicon.ico\",\"createBy\":\"\",\"createTime\":\"2025-03-23 17:08:17\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"2416820386@qq.com\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAcYBTQMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAACAwABBAUGB//EAD4QAAIBAwMCBAQEAwcEAgMBAAECAAMEERIhMQVBBiJRYRNxgZEyQqGxFFLRBxUjM3LB4SRDYvCCkhZT8cL/xAAaAQEBAQEBAQEAAAAAAAAAAAAAAQIDBAUG/8QAIxEBAQACAgIDAAMBAQAAAAAAAAECESExAxIEQVETMmEiBf/aAAwDAQACEQMRAD8A8zVeIwLLVdoQGeJ1YnagIYWWF2hhYNqCwgssLDC7wBAhBZYWGBChAhASwsICQCBCCywIQEAQssLDAkxAHTLxCxL0wA0y8QtMmIA4kxD0ytMAdMmIWmTTADTKxGYlaYAESsRmJREBZWUVjNMoiAkiQiMKyisBREErGESEQEkQSsaVglZQorAKxxEBlgJIgMseVi2EBBWLKzIZYthASRAI3jmEHEzUZyrDAlqIQWVN7QLCCywsILKRQWGFlgQgsjQQsMLLCwgsAQsILCAlhYFASwIWJYWAIWEBLCwsTKbABJpjNMmmFBiTGIemTTNAMSYh4k0zIDTJiHpk0zSbL0yYjNMmmQ2Xj2laYzTKxBsvEoiGRIRKpZWCRGEQSICysEiOIgEQFEQSI4rAKwFEQSI4iARASVgMNo5lgssox2EBlj2WLYQEMsErvxGssEqM', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-24 20:21:32', 461);
INSERT INTO `sys_oper_log` VALUES (155, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'xingyi3', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-03-28 00:03:41\",\"delFlag\":\"0\",\"email\":\"\",\"faceBase64\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMACgcHCAcGCggICAsKCgsOGBAODQ0OHRUWERgjHyUkIh8iISYrNy8mKTQpISIwQTE0OTs+Pj4lLkRJQzxINz0+O//bAEMBCgsLDg0OHBAQHDsoIig7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O//AABEIAcYBTQMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAACAwABBAUGB//EAD4QAAIBAwMCBAQEAwcEAgMBAAECAAMEERIhMQVBBiJRYRNxgZEyQqGxFFLRBxUjM3LB4SRDYvCCkhZT8cL/xAAaAQEBAQEBAQEAAAAAAAAAAAAAAQIDBAUG/8QAIxEBAQACAgIDAAMBAQAAAAAAAAECESExAxIEQVETMmEiBf/aAAwDAQACEQMRAD8A8zVeIwLLVdoQGeJ1YnagIYWWF2hhYNqCwgssLDC7wBAhBZYWGBChAhASwsICQCBCCywIQEAQssLDAkxAHTLxCxL0wA0y8QtMmIA4kxD0ytMAdMmIWmTTADTKxGYlaYAESsRmJREBZWUVjNMoiAkiQiMKyisBREErGESEQEkQSsaVglZQorAKxxEBlgJIgMseVi2EBBWLKzIZYthASRAI3jmEHEzUZyrDAlqIQWVN7QLCCywsILKRQWGFlgQgsjQQsMLLCwgsAQsILCAlhYFASwIWJYWAIWEBLCwsTKbABJpjNMmmFBiTGIemTTNAMSYh4k0zIDTJiHpk0zSbL0yYjNMmmQ2Xj2laYzTKxBsvEoiGRIRKpZWCRGEQSICysEiOIgEQFEQSI4rAKwFEQSI4iARASVgMNo5lgssox2EBlj2WLYQEMsErvxGssEqM7wlZyrGBZFXiGFhmIFhBZAIYWRYgEsCEBLAhpAJYWEBLAgUFlhYQEILMgQssLCxCAlAAS9MPTIFlQOJYELT7S9MASsmmHiTEACsmmHiVp3gBjeXiGVlAbQAxKxGaZRWAGJRWMxK0wFlZREZiVpgKIlERhWCRMqWRBIjSIJE0FEQSI0rKIgJKwSsaRBIgJIgMI4iARKFMsWwj2EWwgIIgFc', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-28 00:06:04', 1166);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-03-16 16:18:03', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-03-16 16:18:03', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-03-16 16:18:03', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `faceBase64` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '人脸base64',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', '', '15888888888', '0', '/favicon.ico', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '43.250.244.50', '2025-03-23 21:17:31', 'admin', '2025-03-16 16:18:03', '', '2025-03-23 21:17:31', '管理员', NULL);
INSERT INTO `sys_user` VALUES (104, 103, 'xingyi', 'xingyi', '00', '2416820386@qq.com', '15077165682', '0', '/favicon.ico', '$2a$10$oSBwqHM1rJZEjwWb7dQ6o.eWXfAVNCXD5wrlZvBbTkoSY4y52rXJ2', '0', '0', '127.0.0.1', '2025-03-27 23:52:03', '', '2025-03-23 17:08:17', '', '2025-03-27 23:52:01', NULL, 'data:image/jpeg;base64,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');
INSERT INTO `sys_user` VALUES (106, NULL, 'xingyi2', 'xingyi2', '00', '', '', '0', '/favicon.ico', '$2a$10$uaTKWtInVOKKHT.f5rUi5OgLvVVd1Yyy.DwTXaaAfQDWNp88dbLRa', '0', '0', '', NULL, '', '2025-03-24 20:21:44', '', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (107, NULL, 'xingyi3', 'xingyi3', '00', '', '', '0', '', '$2a$10$20bZOJ0cij5SQL2vUgXGhOuKxE7FondxItjSdKFjR5WKCg4EwF1US', '0', '0', '127.0.0.1', '2025-03-28 00:04:01', '', '2025-03-28 00:03:41', '', '2025-03-28 00:06:04', NULL, 'data:image/jpeg;base64,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');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
