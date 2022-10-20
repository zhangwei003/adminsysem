-- MySQL dump 10.13  Distrib 5.6.51, for Linux (x86_64)
--
-- Host: localhost    Database: www_zf_com
-- ------------------------------------------------------
-- Server version	5.6.51-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cm_action_log`
--

DROP TABLE IF EXISTS `cm_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_action_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '执行会员id',
  `module` varchar(30) NOT NULL DEFAULT 'admin' COMMENT '模块',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '行为',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '执行的URL',
  `ip` char(30) NOT NULL DEFAULT '' COMMENT '执行行为者ip',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18044 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='行为日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_action_log`
--

LOCK TABLES `cm_action_log` WRITE;
/*!40000 ALTER TABLE `cm_action_log` DISABLE KEYS */;
INSERT INTO `cm_action_log` VALUES (18041,1,'admin','登录','管理员admin登录成功','/admin/login/login.html','203.91.85.26',1,1665644312,1665644312),(18042,1,'admin','删除','删除菜单,where:id=91','/admin/menu/menuDel?id=91','97.74.89.67',1,1665644984,1665644984),(18043,1,'admin','编辑','编辑菜单,name =>商户密钥','/admin/menu/menuEdit','97.74.89.67',1,1665645046,1665645046);
/*!40000 ALTER TABLE `cm_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_admin`
--

DROP TABLE IF EXISTS `cm_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_admin` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `leader_id` mediumint(8) NOT NULL DEFAULT '1',
  `username` varchar(20) DEFAULT '0',
  `nickname` varchar(40) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `google_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'googleç¶æ1 ç»å® 0æªç»å®',
  `google_secret_key` varchar(100) NOT NULL DEFAULT '' COMMENT 'ç®¡çågoogleç§é¥',
  `tg_id` varchar(50) DEFAULT '' COMMENT 'TG 得chat_id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_admin`
--

LOCK TABLES `cm_admin` WRITE;
/*!40000 ALTER TABLE `cm_admin` DISABLE KEYS */;
INSERT INTO `cm_admin` VALUES (1,0,'admin','admin','465dc3c3c43e4452824744afad1fe97b','13333333333','12345@qq.com',1,1552016220,1665644312,0,'4MRCDQIMODKDQMPY','');
/*!40000 ALTER TABLE `cm_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_api`
--

DROP TABLE IF EXISTS `cm_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_api` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL COMMENT '商户id',
  `key` varchar(32) DEFAULT NULL COMMENT 'API验证KEY',
  `sitename` varchar(30) NOT NULL,
  `domain` varchar(100) NOT NULL COMMENT '商户验证域名',
  `daily` decimal(12,3) NOT NULL DEFAULT '20000.000' COMMENT '日限访问（超过就锁）',
  `secretkey` text NOT NULL COMMENT '商户请求RSA私钥',
  `auth_ips` text NOT NULL,
  `role` int(4) NOT NULL COMMENT '角色1-普通商户,角色2-特约商户',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商户API状态,0-禁用,1-锁,2-正常',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_verify_sign` int(11) DEFAULT '1' COMMENT '是否验证sign 1 验证 0 不验证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_domain_unique` (`id`,`domain`,`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_api`
--

LOCK TABLES `cm_api` WRITE;
/*!40000 ALTER TABLE `cm_api` DISABLE KEYS */;
INSERT INTO `cm_api` VALUES (1,100001,'772ae1d32322f49508307b2f31a0107f','小红帽','https://www.redcap.cnfsa',20000.000,'MIIEowIBAAKCAQEAtJKWdvG8MDILqwcoR721+pTT8ClC+5vq60pfXQAFsoIt8E6oQsDgMIdvp6FP2YjCeTJrr9MjQoC7t8yXO+liau70bMNbds/wg8arh+8jIHYDNIu4nFHlDTdk9y72xWAQixnGT3F/zSoLWv8LvrmfOHDSByD+/RPeiS04/GwVr/SLlbxSp+Rf7ano//5CD9XjD6jVz7IwBcurmqrqenRujNBDAZOncKbKhWfs3AdWhj4iQZeptYtHo3NXc+s3ehdqgEt6qukAENBApx1ROYAyZG6O2b4okzWW+rrJeDWdNKeixyw4nQjtINR/t82cH8xMTSky41N3N7L2eB0tAc/PhQIDAQABAoIBAAZjtX1J+n2+F5marDs1pE3UnFdALoWWs85VmGBDEvCJGLULI3sRNh2hfTryQ1AQPclqFlNnZjUBNyM+0w8kp/3erLl4hDEFFJ6lFga+WIDajCx80TB+2VsJXcI9YDAFwTAa3mCLRJlu5m323mSGTvMBUv07lqo/3Lz/46dS78WFE3uCmaRn8JOAz8wLGWTO1YtEd8yxQR035L9/+eDhi9HuibqBWInRKn8EkljsvlDFzeZM/fqNwO/DDVlAp1zELon+729w5cfHTnpIjlPo8mOIGOHpCrxYMvUKMlY3eStlDYhxpShfny81Sm4dI6kE3V6SIRgAfL/GDOKaCkUaXhUCgYEA4bP46VUHX7QgdinjrsVOlKiS8oDCm/+62bE47ukbqy4s7pGSkyOyqiSKVWCe3pq4cZ7yDSgYeFtYpKoZWLvWn5Rz0MtL5lATHZXLfaNH6a1PwbzQv2cP70ukSJjHJUspflfHFHzlQhB+a+81I1KoLuFlr7b2M+JoYl9I6pyJMxcCgYEAzM/CnzHKrX3v+FEXqCphElaGexSIRbQLFVF3IR3wlfIVLpFx5UFlIjwY8Ulj6nNKqo1aZ0h7lkMjS/q5L0iDxGN0mA8LsHlqbL6hyyVCE3QO+CpLEAsJXHr3OIUmx/YNjM+/fG/6NaADw7RUt0QWDV2wV1VBeLv6eKXO+YVUY8MCgYEAqvAmTXmzev0uNLAnG3+dsyM1H+r6+TEmb6c0amUsKmpvZ0PjUgMQVqIUDvN9fzSJCqyJwAMk/UqZiSS2y6h/tR621GSUGFt/DsIbew0F8unq5N0+8Cd7Pw3332+uLAWP6HtMcKzi6TUaul5RzW3VqKPW4szcDJGl4xMtY1qo4oMCgYARgPwQIPBCbY3xufR8ocqUB6MMp8+RrXZ5BvJYeTeTiRH4XePPBQzApUQ4ct5ALkRGWThNtWsih3Bf0Pi8qsTgJuPTDw4fsfC/hHdNZkzEXtncqbiqkVbmeXfhc7fBxSyZSTQDTYqjxJ4tvp6y3vXHhKdKf3XN/LrGTt1mg9eXgwKBgAtkhdV7pGBJFwdcGuBetkI/bDD+HkdUZLQNYUeUihb5RdhpSYR/GWkjjNbKPvtYnBJ41KlVw/Adi+vkNvE7csSzwtq8aBOQrRkCsjrtNt2bdq0UACO4ze4F+bTiJBI5uOrCqi5HzGHjlxjo6h23iWN52/ddMfbFHVLbK6CG3Hua','192.168.31.239,127.0.0.1,47.107.247.7,180.191.159.114',2,1,1541787044,1576316770,1);
/*!40000 ALTER TABLE `cm_api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_article`
--

DROP TABLE IF EXISTS `cm_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_article` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `author` char(20) NOT NULL DEFAULT 'admin' COMMENT '作者',
  `title` char(40) NOT NULL DEFAULT '' COMMENT '文章名称',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `content` text NOT NULL COMMENT '文章内容',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面图片id',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件id',
  `img_ids` varchar(200) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_index` (`id`,`title`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_article`
--

LOCK TABLES `cm_article` WRITE;
/*!40000 ALTER TABLE `cm_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_auth_group`
--

DROP TABLE IF EXISTS `cm_auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_auth_group` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `describe` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='权限组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_auth_group`
--

LOCK TABLES `cm_auth_group` WRITE;
/*!40000 ALTER TABLE `cm_auth_group` DISABLE KEYS */;
INSERT INTO `cm_auth_group` VALUES (1,1,'','超级管理员','拥有至高无上的权利',1,'超级权限',1541001599,1538323200),(2,2,'','管理员','主要管理者，事情很多，权力很大',1,'1,2,3,4,5,9,10,11,15,16,32,41,42,17,18,19,43,44,45,20,21,22,23,24,25,26,27,28,29',1544365067,1538323200),(3,0,'','编辑','负责编辑文章和站点公告',1,'1,15,16,17,32',1544360098,1540381656);
/*!40000 ALTER TABLE `cm_auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_auth_group_access`
--

DROP TABLE IF EXISTS `cm_auth_group_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户组id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_auth_group_access`
--

LOCK TABLES `cm_auth_group_access` WRITE;
/*!40000 ALTER TABLE `cm_auth_group_access` DISABLE KEYS */;
INSERT INTO `cm_auth_group_access` VALUES (3,3,1,1540800597,1540800597),(2,2,1,1567687331,1567687331);
/*!40000 ALTER TABLE `cm_auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_balance`
--

DROP TABLE IF EXISTS `cm_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_balance` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `enable` decimal(12,3) unsigned DEFAULT '0.000' COMMENT '可用余额(已结算金额)',
  `disable` decimal(12,3) unsigned DEFAULT '0.000' COMMENT '冻结金额(待结算金额)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态 1正常 0禁止操作',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_index` (`id`,`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COMMENT='商户资产表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_balance`
--

LOCK TABLES `cm_balance` WRITE;
/*!40000 ALTER TABLE `cm_balance` DISABLE KEYS */;
INSERT INTO `cm_balance` VALUES (1,100001,216.000,0.000,1,1541787044,1542617892);
/*!40000 ALTER TABLE `cm_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_balance_cash`
--

DROP TABLE IF EXISTS `cm_balance_cash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_balance_cash` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `cash_no` varchar(80) NOT NULL COMMENT '取现记录单号',
  `amount` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '取现金额',
  `account` int(2) NOT NULL DEFAULT '0' COMMENT '取现账户（关联商户结算账户表）',
  `remarks` varchar(255) NOT NULL COMMENT '取现说明',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '取现状态',
  `create_time` int(10) unsigned NOT NULL COMMENT '申请时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '处理时间',
  `commission` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT 'æç°æç»­è´¹',
  `audit_remarks` varchar(255) DEFAULT NULL COMMENT 'å®¡æ ¸å¤æ³¨',
  `bank_name` varchar(32) DEFAULT NULL COMMENT '开户行',
  `bank_number` varchar(32) DEFAULT NULL COMMENT '卡号',
  `bank_realname` varchar(32) DEFAULT NULL COMMENT '姓名',
  `voucher` varchar(255) DEFAULT NULL COMMENT '跑分平台凭证',
  `voucher_time` int(11) DEFAULT '0' COMMENT '凭证上传时间',
  `channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '渠道编号 ',
  `cash_file` varchar(255) NOT NULL DEFAULT '' COMMENT 'è½¬æ¬¾å­è¯',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提现方式  0:银行卡  1:usdt',
  `withdraw_usdt_address` varchar(255) NOT NULL DEFAULT '' COMMENT 'usdt提款地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_index` (`id`,`uid`,`cash_no`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36862 DEFAULT CHARSET=utf8mb4 COMMENT='商户账户取现记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_balance_cash`
--

LOCK TABLES `cm_balance_cash` WRITE;
/*!40000 ALTER TABLE `cm_balance_cash` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_balance_cash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_balance_change`
--

DROP TABLE IF EXISTS `cm_balance_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_balance_change` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `type` varchar(20) NOT NULL DEFAULT 'enable' COMMENT '资金类型',
  `preinc` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动前金额',
  `increase` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '增加金额',
  `reduce` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '减少金额',
  `suffixred` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动后金额',
  `remarks` varchar(255) NOT NULL COMMENT '资金变动说明',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_flat_op` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'æ¯å¦åå°äººå·¥è´¦å',
  PRIMARY KEY (`id`),
  UNIQUE KEY `change_index` (`id`,`uid`,`type`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1228988 DEFAULT CHARSET=utf8mb4 COMMENT='商户资产变动记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_balance_change`
--

LOCK TABLES `cm_balance_change` WRITE;
/*!40000 ALTER TABLE `cm_balance_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_balance_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_bank`
--

DROP TABLE IF EXISTS `cm_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_bank` (
  `bank_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(50) NOT NULL DEFAULT '' COMMENT '银行名称',
  `bank_color` varchar(200) NOT NULL DEFAULT '' COMMENT '银行App展示渐变色',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT '银行网银地址',
  `logo` varchar(100) NOT NULL DEFAULT '' COMMENT '银行logo',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '银行状态0为启用，1为禁用',
  `create_user` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_user` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `is_maintain` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否维护',
  `maintain_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '维护开始时间',
  `maintain_end` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '维护结束时间',
  PRIMARY KEY (`bank_id`) USING BTREE,
  KEY `status` (`is_del`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='接受的在线提现银行表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_bank`
--

LOCK TABLES `cm_bank` WRITE;
/*!40000 ALTER TABLE `cm_bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_banker`
--

DROP TABLE IF EXISTS `cm_banker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_banker` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '银行ID',
  `name` varchar(80) NOT NULL COMMENT '银行名称',
  `remarks` varchar(140) NOT NULL COMMENT '备注',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认账户,0-不默认,1-默认',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '银行可用性',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `bank_code` varchar(32) DEFAULT NULL COMMENT '银行编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='系统支持银行列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_banker`
--

LOCK TABLES `cm_banker` WRITE;
/*!40000 ALTER TABLE `cm_banker` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_banker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_config`
--

DROP TABLE IF EXISTS `cm_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置标题',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `value` text NOT NULL COMMENT '配置值',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置选项',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '配置说明',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `conf_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=1115 DEFAULT CHARSET=utf8 COMMENT='基本配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_config`
--

LOCK TABLES `cm_config` WRITE;
/*!40000 ALTER TABLE `cm_config` DISABLE KEYS */;
INSERT INTO `cm_config` VALUES (1,'seo_title','网站标题',1,1,0,'亚虎支付','','',1,1378898976,1585677353),(8,'email_port','SMTP端口号',1,8,1,'2','1:25,2:465','如：一般为 25 或 465',1,1378898976,1545131349),(2,'seo_description','网站描述',2,3,0,'','','网站搜索引擎描述，优先级低于SEO模块',1,1378898976,1585677353),(3,'seo_keywords','网站关键字',2,4,0,'亚虎支付','','网站搜索引擎关键字，优先级低于SEO模块',1,1378898976,1585677353),(4,'app_index_title','首页标题',1,2,0,'亚虎支付','','',1,1378898976,1585677353),(5,'app_domain','网站域名',1,5,0,'','','网站域名',1,1378898976,1585677353),(6,'app_copyright','版权信息',2,6,0,'亚虎支付','','版权信息',1,1378898976,1585677353),(7,'email_host','SMTP服务器',3,7,1,'2','1:smtp.163.com,2:smtp.aliyun.com,3:smtp.qq.com','如：smtp.163.com',1,1378898976,1569507595),(9,'send_email','发件人邮箱',1,9,1,'12345@qq.com','','',1,1378898976,1569507595),(10,'send_nickname','发件人昵称',1,10,1,'','','',1,1378898976,1569507595),(11,'email_password','邮箱密码',1,11,1,'xxxxxx','','',1,1378898976,1569507595),(16,'logo','ç«ç¹LOGO',4,6,0,'','','ä¸ä¼ ç«ç¹logo',1,1378898976,1576391324),(14,'withdraw_fee','提现手续费',1,6,0,'0','','提现手续费',1,1378898976,1585677353),(19,'four_noticy_time','四方通知时间',1,8,0,'200','','四方码商回调通知时间(单位分钟)',1,1378898976,1585677353),(20,'max_withdraw_limit','提现最大金额',0,0,0,'2000000','','',1,0,1585677353),(21,'min_withdraw_limit','提现最小金额',0,0,0,'1','','',1,0,1585677353),(22,'balance_cash_type','提现申请类型',3,0,0,'1','1:选择账号,2:手动填写账号','',1,0,1585677353),(23,'request_pay_type','发起支付订单类型',3,0,0,'2','1:平台订单号,2:下游订单号','',1,0,1584606747),(24,'notify_ip','回调ip',0,54,0,'97.74.80.194','','',1,0,1585677353),(25,'is_single_handling_charge','是否开启单笔手续费',3,51,0,'0','1:开启,0:不开启','',1,0,1585677353),(26,'whether_open_daifu','是否开启代付',3,50,0,'2','1:开启,2:不开启','',1,0,1585677353),(27,'index_view_path','前台模板',3,0,0,'view','view:默认,baisha:白沙,view1:版本2','',1,0,1585833746),(28,'is_open_channel_fund','渠道资金是否开启',3,0,0,'1','0:关闭,1:开启','',1,0,0),(29,'is_paid_select_channel','提现审核选择渠道',3,0,0,'0','0:不选择,1:选择','',1,0,0),(32,'daifu_notify_ip','代付回调ip白名单',0,0,3,'127.0.0.1','','',1,0,0),(33,'daifu_host','代付接口地址',0,0,3,'http://xxpay.byfbqgi.cn//api/transfer/create','','',1,0,0),(34,'daifu_key','跑分密钥',0,0,3,'3e9c1885afa5920909f9b9aa2907cf19','','',1,0,0),(35,'daifu_notify_url','回调地址',0,0,3,'http://www.zhongtongpay.com//api/dfPay/notify','','',1,0,0),(36,'transfer_ip_list','中转ip白名单',2,0,0,'127.0.0.1','','多个使用逗号隔开',1,0,0),(37,'proxy_debug','是否开启中转回调',3,0,0,'1','1:开启,0:不开启','',1,0,0),(38,'orginal_host','中转回调地址',0,0,0,'http://103.210.239.133/zz.php','','',1,0,0),(39,'daifu_admin_id','代付admin_id',0,0,3,'5','','',1,0,0),(40,'is_channel_statistics','是否开启渠道统计',3,0,0,'1','1:开启,0:不开启','',1,0,0),(41,'admin_view_path','后台模板',3,0,0,'view','view:默认,baisha:白沙','',1,0,1585833746),(42,'index_domain_white_list','前台域名白名单',1,0,0,'','','如https://www.baidu.com/ 请输入www.baidu.com',1,0,0),(43,'pay_domain_white_list','下单域名白名单',0,0,0,'','','如https://www.baidu.com/ 请输入www.baidu.com',1,0,0),(44,'admin_domain_white_list','后台域名白名单',0,0,0,'','','如https://www.baidu.com/ 请输入www.baidu.com',1,0,0),(1111,'global_tgbot_token','全 局机器人token唯一标识',1,0,0,'5047416312:AAGJmiLb1A5JByQmRddFa6V9hK4f38g4RPg','','',1,0,0),(1112,'tg_order_warning_robot_token','订单报警机器人token',0,0,0,'5279869581:AAG413o3UYm9w3Fd27VDCJzTr1gl84ZPbo8','','',1,0,0),(1113,'tg_order_warning_rebot_in_chat','订单机器人所在群组',0,0,0,'-1001684190419','','',1,0,0),(1114,'tg_channel_help','电报渠道群组帮助',2,0,0,'','','',1,0,0);
/*!40000 ALTER TABLE `cm_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_dafiu_account`
--

DROP TABLE IF EXISTS `cm_dafiu_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_dafiu_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_name` varchar(45) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `controller` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_dafiu_account`
--

LOCK TABLES `cm_dafiu_account` WRITE;
/*!40000 ALTER TABLE `cm_dafiu_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_dafiu_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_daifu_orders`
--

DROP TABLE IF EXISTS `cm_daifu_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_daifu_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `notify_url` varchar(500) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `bank_number` varchar(45) DEFAULT NULL,
  `bank_owner` varchar(45) DEFAULT NULL,
  `bank_id` int(10) DEFAULT NULL,
  `bank_name` varchar(45) DEFAULT NULL,
  `out_trade_no` varchar(45) DEFAULT NULL,
  `trade_no` varchar(45) DEFAULT NULL,
  `body` varchar(45) DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  `service_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  `single_service_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔手续费',
  `notify_result` text COMMENT '回调返回内容 SUCCESS为成功 其他为失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_daifu_orders`
--

LOCK TABLES `cm_daifu_orders` WRITE;
/*!40000 ALTER TABLE `cm_daifu_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_daifu_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_deposite_card`
--

DROP TABLE IF EXISTS `cm_deposite_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_deposite_card` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1表示可使用状态，0表示禁止状态',
  `bank_id` int(10) NOT NULL DEFAULT '0' COMMENT '银行卡ID',
  `bank_account_username` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡用户名',
  `bank_account_number` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡账号',
  `bank_account_address` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡地址',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值卡信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_deposite_card`
--

LOCK TABLES `cm_deposite_card` WRITE;
/*!40000 ALTER TABLE `cm_deposite_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_deposite_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_deposite_orders`
--

DROP TABLE IF EXISTS `cm_deposite_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_deposite_orders` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `p_admin_id` mediumint(8) DEFAULT NULL COMMENT '跑分平台管理员id',
  `trade_no` varchar(255) NOT NULL DEFAULT '' COMMENT '申请充值订单号',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示正在申请 1成功 2表示失败',
  `bank_id` int(10) NOT NULL DEFAULT '0' COMMENT '银行卡ID',
  `bank_account_username` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡用户名',
  `bank_account_number` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡账号',
  `bank_account_address` varchar(255) NOT NULL DEFAULT '' COMMENT '银行卡地址',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `recharge_account` varchar(64) DEFAULT NULL COMMENT '充值账号',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `card_id` int(11) DEFAULT NULL COMMENT '充值银行卡id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请充值信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_deposite_orders`
--

LOCK TABLES `cm_deposite_orders` WRITE;
/*!40000 ALTER TABLE `cm_deposite_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_deposite_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_gemapay_code`
--

DROP TABLE IF EXISTS `cm_gemapay_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_gemapay_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '属于哪个用户',
  `type` int(1) DEFAULT NULL COMMENT '1表示微信，２表示支付宝，３表示云散付，４表示百付通',
  `qr_image` varchar(255) DEFAULT NULL COMMENT '二维码地址',
  `last_used_time` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '是否正常使用　０表示正常，１表示禁用',
  `last_online_time` int(11) DEFAULT NULL COMMENT '最后一次在线的时间',
  `pay_status` int(11) DEFAULT NULL COMMENT '０表示未使用，１表示使用占用中',
  `limit_money` decimal(10,2) DEFAULT NULL,
  `paying_num` int(10) DEFAULT NULL COMMENT '正在支付的数量',
  `user_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_gemapay_code`
--

LOCK TABLES `cm_gemapay_code` WRITE;
/*!40000 ALTER TABLE `cm_gemapay_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_gemapay_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_gemapay_code_money_paying`
--

DROP TABLE IF EXISTS `cm_gemapay_code_money_paying`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_gemapay_code_money_paying` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) DEFAULT NULL COMMENT '哪个账户',
  `money` decimal(10,2) DEFAULT NULL COMMENT '实际所需要支付的价格',
  `paying_num` int(11) DEFAULT NULL COMMENT '正在支付的个数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_gemapay_code_money_paying`
--

LOCK TABLES `cm_gemapay_code_money_paying` WRITE;
/*!40000 ALTER TABLE `cm_gemapay_code_money_paying` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_gemapay_code_money_paying` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_gemapay_collect_order`
--

DROP TABLE IF EXISTS `cm_gemapay_collect_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_gemapay_collect_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(200) NOT NULL COMMENT '订单号',
  `code_id` int(11) DEFAULT NULL COMMENT '哪个账户生成的',
  `order_paytime` int(11) NOT NULL COMMENT '订单支付时间',
  `order_payprice` varchar(45) DEFAULT NULL COMMENT '订单价格',
  `create_time` varchar(45) NOT NULL COMMENT '创建时间',
  `pay_order_no` varchar(200) DEFAULT NULL COMMENT '支付的订单号',
  `status` int(10) NOT NULL COMMENT '状态１表示成功匹配完成订单,2 表示没匹配到订单导致订单丢失',
  `error_possible_pay_no` varchar(300) DEFAULT NULL COMMENT '如果出现一笔没匹配到的订单，最有可能是哪笔订单',
  PRIMARY KEY (`id`),
  KEY `order_no` (`order_no`,`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_gemapay_collect_order`
--

LOCK TABLES `cm_gemapay_collect_order` WRITE;
/*!40000 ALTER TABLE `cm_gemapay_collect_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_gemapay_collect_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_gemapay_order`
--

DROP TABLE IF EXISTS `cm_gemapay_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_gemapay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `add_time` int(10) DEFAULT NULL,
  `order_no` varchar(100) DEFAULT NULL COMMENT '订单号',
  `order_price` decimal(10,2) DEFAULT NULL COMMENT '订单价格',
  `status` int(11) DEFAULT '0',
  `gema_userid` int(11) DEFAULT '0' COMMENT '所属用户',
  `qr_image` varchar(100) DEFAULT NULL,
  `pay_time` int(10) DEFAULT NULL COMMENT '支付时间',
  `code_id` int(10) DEFAULT NULL,
  `order_pay_price` decimal(10,2) DEFAULT NULL COMMENT '实际支付价格',
  `gema_username` varchar(45) DEFAULT NULL COMMENT '个码用户名',
  `note` varchar(45) DEFAULT NULL,
  `out_trade_no` varchar(200) DEFAULT NULL,
  `code_type` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `orderNum_UNIQUE` (`order_no`),
  KEY `addtime` (`add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_gemapay_order`
--

LOCK TABLES `cm_gemapay_order` WRITE;
/*!40000 ALTER TABLE `cm_gemapay_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_gemapay_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_gemapay_user`
--

DROP TABLE IF EXISTS `cm_gemapay_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_gemapay_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `password` varchar(45) DEFAULT NULL,
  `token` varchar(45) DEFAULT NULL,
  `desposit` decimal(10,2) DEFAULT NULL,
  `telphone` varchar(45) DEFAULT NULL,
  `last_onlie_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `telphone_UNIQUE` (`telphone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_gemapay_user`
--

LOCK TABLES `cm_gemapay_user` WRITE;
/*!40000 ALTER TABLE `cm_gemapay_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_gemapay_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_jobs`
--

DROP TABLE IF EXISTS `cm_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_jobs` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_jobs`
--

LOCK TABLES `cm_jobs` WRITE;
/*!40000 ALTER TABLE `cm_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_menu`
--

DROP TABLE IF EXISTS `cm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_menu` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(100) NOT NULL DEFAULT '100' COMMENT '排序',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '模块',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `is_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `icon` char(30) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COMMENT='基本菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_menu`
--

LOCK TABLES `cm_menu` WRITE;
/*!40000 ALTER TABLE `cm_menu` DISABLE KEYS */;
INSERT INTO `cm_menu` VALUES (1,0,100,'控制台','admin','/',0,'console',1,1544365211,1539583897),(2,0,100,'系统设置','admin','System',0,'set',1,1540800845,1539583897),(3,2,100,'基本设置','admin','System',0,'set-fill',1,1539584897,1539583897),(4,3,100,'网站设置','admin','System/website',0,'',1,1539584897,1539583897),(5,3,100,'邮件服务','admin','System/email',0,'',1,1539584897,1539583897),(6,3,100,'行为日志','admin','Log/index',0,'flag',1,1540563678,1540563678),(7,6,100,'获取日志列表','admin','Log/getList',1,'',1,1540566783,1540566783),(8,6,100,'删除日志','admin','Log/logDel',1,'',1,1540566819,1540566819),(9,6,100,'清空日志','admin','Log/logClean',1,'',1,1540566849,1540566849),(10,2,100,'权限设置','admin','Admin',0,'set-sm',1,1539584897,1539583897),(11,10,100,'管理员设置','admin','Admin/index',0,'',1,1539584897,1539583897),(12,11,100,'获取管理员列表','admin','Admin/userList',1,'user',1,1540485169,1540484869),(13,11,100,'新增管理员','admin','Admin/userAdd',1,'user',1,1540485182,1540485125),(14,11,100,'编辑管理员','admin','Admin/userEdit',1,'user',1,1540485199,1540485155),(15,11,100,'删除管理员','admin','AdminuserDel',1,'user',1,1540485310,1540485310),(16,10,100,'角色管理','admin','Admin/group',0,'',1,1539584897,1539583897),(17,16,100,'获取角色列表','admin','Admin/groupList',1,'',1,1540485432,1540485432),(18,16,100,'新增权限组','admin','Admin/groupAdd',1,'',1,1540485531,1540485488),(19,16,100,'编辑权限组','admin','Admin/groupEdit',1,'',1,1540485515,1540485515),(20,16,100,'删除权限组','admin','Admin/groupDel',1,'',1,1540485570,1540485570),(21,10,100,'菜单管理','admin','Menu/index',0,'',1,1539584897,1539583897),(22,21,100,'获取菜单列表','admin','Menu/getList',1,'',1,1540485652,1540485632),(23,21,100,'新增菜单','admin','Menu/menuAdd',1,'',1,1540534094,1540534094),(24,21,100,'编辑菜单','admin','Menu/menuEdit',1,'',1,1540534133,1540534133),(25,21,100,'删除菜单','admin','Menu/menuDel',1,'',1,1540534133,1540534133),(26,2,100,'我的设置','admin','Admin/profile',0,'',1,1540486245,1539583897),(27,26,100,'基本资料','admin','System/profile',0,'',1,1540557980,1539583897),(28,26,100,'修改密码','admin','System/changePwd',0,'',1,1540557985,1539583897),(29,0,100,'支付渠道','admin','Pay',0,'senior',1,1665637039,1539583897),(30,29,100,'支付编码','admin','Pay/index',0,'',1,1665637053,1539583897),(31,30,100,'获取支付产品列表','admin','Pay/getCodeList',1,'',1,1545461560,1545458869),(32,30,100,'新增支付产品','admin','Pay/addCode',1,'',1,1545461705,1545458888),(33,30,100,'编辑支付产品','admin','Pay/editCode',1,'',1,1545461713,1545458915),(34,30,100,'删除产品','admin','Pay/delCode',1,'',1,1545461745,1545458935),(35,29,100,'支付列表','admin','Pay/channel',0,'',1,1665637099,1539583897),(36,35,100,'获取渠道列表','admin','Pay/getChannelList',1,'',1,1545461798,1545458953),(37,35,100,'新增渠道','admin','Pay/addChannel',1,'',1,1545461856,1545458977),(38,35,100,'编辑渠道','admin','Pay/editChannel',1,'',1,1545461863,1545458992),(39,35,100,'删除渠道','admin','Pay/delChannel',1,'',1,1545461870,1545459004),(40,29,100,'渠道账户','admin','Pay/account',0,'',1,1578931745,1545459058),(41,40,100,'获取渠道账户列表','admin','Pay/getAccountList',1,'',1,1545462265,1545459152),(42,40,100,'新增账户','admin','Pay/addAccount',1,'',1,1545462273,1545459180),(43,40,100,'编辑账户','admin','Pay/editAccount',1,'',1,1545462279,1545459194),(44,40,100,'删除账户','admin','Pay/delAccount',1,'',1,1545462286,1545459205),(45,29,100,'银行管理','admin','Pay/bank',0,'',-1,1665635140,1540822549),(46,45,100,'获取银行列表','admin','Pay/getBankList',1,'',1,1545462167,1545459107),(47,45,100,'新增银行','admin','Pay/addBank',1,'',1,1545462178,1545459243),(48,45,100,'编辑银行','admin','Pay/editBank',1,'',1,1545462220,1545459262),(49,45,100,'删除银行','admin','Pay/delBank',1,'',1,1545462230,1545459277),(50,0,100,'内容管理','admin','Article',0,'template',-1,1665634839,1539583897),(51,50,100,'文章管理','admin','Article/index',0,'',-1,1665634919,1539583897),(52,51,100,'获取文章列表','admin','Article/getList',1,'lis',-1,1665634976,1540484939),(53,51,100,'新增文章','admin','Article/add',1,'',-1,1665634980,1540486058),(54,51,100,'编辑文章','admin','Article/edit',1,'',-1,1665634987,1540486097),(55,51,100,'删除文章','admin','Article/del',1,'',-1,1665634989,1545459431),(56,50,100,'公告管理','admin','Article/notice',0,'',-1,1665634924,1539583897),(57,56,100,'获取公告列表','admin','Article/getNoticeList',1,'',-1,1665634999,1545459334),(58,56,100,'新增公告','admin','Article/addNotice',1,'',-1,1665635003,1545459346),(59,56,100,'编辑公告','admin','Article/editNotice',1,'',-1,1665635013,1545459368),(60,56,100,'删除公告','admin','Article/delNotice',1,'',-1,1665635018,1545459385),(61,0,100,'商户管理','admin','User',0,'user',1,1539584897,1539583897),(62,61,100,'商户列表','admin','User/index',0,'',1,1539584897,1539583897),(63,62,100,'获取商户列表','admin','User/getList',1,'',1,1540486400,1540486400),(64,62,100,'新增商户','admin','User/add',1,'',1,1540533973,1540533973),(65,62,100,'商户修改','admin','User/edit',1,'',1,1540533993,1540533993),(66,62,100,'删除商户','admin','User/del',1,'',1,1545462902,1545459408),(67,61,100,'提现记录','admin','Balance/paid',0,'',1,1539584897,1539583897),(68,67,100,'获取提现记录','admin','Balance/paidList',1,'',1,1545462677,1545458822),(69,67,100,'提现编辑','admin','Balance/editPaid',1,'',1,1545462708,1545458822),(70,67,100,'提现删除','admin','Balance/delPaid',1,'',1,1545462715,1545458822),(71,61,100,'商户账户','admin','Account/index',0,'',-1,1665635260,1539583897),(80,71,100,'商户账户列表','admin','Account/getList',1,'',1,1545462747,1545459501),(81,71,100,'新增商户账户','admin','Account/add',1,'',1,1545462827,1545459501),(82,71,100,'编辑商户账户','admin','Account/edit',1,'',1,1545462815,1545459501),(83,71,100,'删除商户账户','admin','Account/del',1,'',1,1545462874,1545459501),(84,61,100,'商户资金','admin','Balance/index',0,'',1,1539584897,1539583897),(85,84,100,'商户资金列表','admin','Balance/getList',1,'',1,1545462951,1545459501),(86,84,100,'商户资金明细','admin','Balance/details',1,'',1,1545462997,1545459501),(87,84,100,'获取商户资金明细','admin','Balance/getDetails',1,'',1,1545462997,1545459501),(88,61,100,'商户密钥','admin','Api/index',0,'',1,1665645046,1539583897),(89,87,100,'商户API列表','admin','Api/getList',1,'',1,1545463054,1545459501),(90,87,100,'编辑商户API','admin','Api/edit',1,'',1,1545463065,1545459501),(91,61,100,'商户认证','admin','User/auth',0,'',-1,1665644984,1542882201),(92,90,100,'商户认证列表','admin','getlist',1,'',1,1545459501,1545459501),(93,90,100,'编辑商户认证','admin','getlist',1,'',1,1545459501,1545459501),(94,0,100,'订单管理','admin','Orders',0,'form',1,1539584897,1539583897),(95,94,100,'交易列表','admin','Orders/index',0,'',1,1539584897,1539583897),(96,95,100,'获取交易列表','admin','Orders/getList',1,'',1,1545463214,1539583897),(97,94,100,'交易详情','admin','Orders/details',1,'',1,1545463268,1545459549),(98,94,100,'退款列表','admin','Orders/refund',0,'',-1,1665635068,1539583897),(99,94,100,'商户统计','admin','Orders/user',0,'',1,1539584897,1539583897),(100,99,100,'获取商户统计','admin','Orders/userList',1,'',1,1539584897,1539583897),(101,94,100,'渠道统计','admin','Orders/channel',0,'',1,1544362599,1539583897),(102,101,100,'获取渠道统计','admin','Orders/channelList',1,'',1,1544362599,1539583897),(103,61,100,'每日统计','admin','User/cal',0,'',1,1581949633,1581872080),(104,61,100,'商户资金记录','admin','Balance/change',0,'',1,1583999358,1583999358),(105,0,100,'代付订单管理','admin','DaifuOrders',0,'form',-1,1665634913,1581082458),(111,105,100,'订单列表','admin','DaifuOrders/index',0,'',1,1581082501,1581082501),(113,105,100,'充值银行卡','admin','daifu_orders/depositecard',0,'',1,1585315652,1585315597),(114,105,100,'充值列表','admin','deposite_order/index',0,'',1,1585329481,1585329451),(115,94,100,'渠道资金','admin','Channel/fundIndex',0,'',1,1587199882,1587199882),(116,2,100,'代付设置','admin','daifu_orders/setting',0,'',1,1588083379,1588083251),(117,94,100,'渠道明细','admin','Orders/channelV2',0,'',1,1544362599,1539583897),(118,94,100,'金额统计','admin','Orders/amountCalulate',0,'',-1,1665634982,1539583897);
/*!40000 ALTER TABLE `cm_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_ms`
--

DROP TABLE IF EXISTS `cm_ms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_ms` (
  `userid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL COMMENT '上级ID',
  `account` char(20) NOT NULL DEFAULT '0' COMMENT '用户账号',
  `mobile` char(20) NOT NULL COMMENT '用户手机号',
  `u_yqm` varchar(225) NOT NULL COMMENT '邀请码',
  `username` varchar(255) NOT NULL DEFAULT '',
  `login_pwd` varchar(225) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `login_salt` char(5) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户余额',
  `reg_date` int(11) NOT NULL COMMENT '注册时间',
  `reg_ip` varchar(20) NOT NULL COMMENT '注册IP',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户锁定  1 不锁  0拉黑  -1 删除',
  `activate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否激活 1-已激活 0-未激活',
  `use_grade` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户等级',
  `tg_num` int(11) NOT NULL COMMENT '总推人数',
  `rz_st` int(1) NOT NULL DEFAULT '0' COMMENT '资料完善状态，1OK2no',
  `zsy` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '总收益',
  `add_admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '添加该用户的管理元id',
  `work_status` int(1) NOT NULL DEFAULT '0',
  `security_salt` varchar(225) NOT NULL,
  `security_pwd` varchar(225) NOT NULL,
  `token` varchar(45) DEFAULT NULL,
  `is_allow_work` tinyint(1) DEFAULT '0' COMMENT '是否被禁止工作',
  `last_online_time` int(11) DEFAULT NULL,
  `tg_level` tinyint(1) DEFAULT NULL COMMENT 'ç¨·ä»£çç­çº§,ç³»ç»ç»éè¯·ç æ³¨åçç¨·ä¸º1,çº§ä¾æ¬¡ç±»æ¨',
  `updatetime` int(11) DEFAULT NULL COMMENT 'ä¿®æ¹æ¶é´',
  `google_status` int(11) DEFAULT '0' COMMENT 'googleå¯é¥ç¶æ',
  `google_secretkey` varchar(100) DEFAULT NULL COMMENT 'å¯é¥',
  `auth_ips` varchar(255) DEFAULT '' COMMENT 'ç¨·è®¿é®ç½åå',
  `blocking_reason` varchar(100) DEFAULT NULL COMMENT 'å»ç»ååå ',
  `cash_pledge` decimal(10,2) NOT NULL COMMENT '押金',
  `payment_amount_limit` decimal(10,2) NOT NULL COMMENT '可完成金额上线',
  `bank_rate` float(4,2) unsigned NOT NULL DEFAULT '1.00' COMMENT '银行卡费率',
  PRIMARY KEY (`userid`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  UNIQUE KEY `account` (`account`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_ms`
--

LOCK TABLES `cm_ms` WRITE;
/*!40000 ALTER TABLE `cm_ms` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_ms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_ms_white_ip`
--

DROP TABLE IF EXISTS `cm_ms_white_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_ms_white_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ms_id` int(11) NOT NULL COMMENT '码商的id',
  `md5_ip` varchar(50) NOT NULL COMMENT '码商ip白名单MD5值',
  PRIMARY KEY (`id`),
  KEY `ms_id` (`ms_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_ms_white_ip`
--

LOCK TABLES `cm_ms_white_ip` WRITE;
/*!40000 ALTER TABLE `cm_ms_white_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_ms_white_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_notice`
--

DROP TABLE IF EXISTS `cm_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_notice` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `author` varchar(30) DEFAULT NULL COMMENT '作者',
  `content` text NOT NULL COMMENT '公告内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公告状态,0-不展示,1-展示',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_notice`
--

LOCK TABLES `cm_notice` WRITE;
/*!40000 ALTER TABLE `cm_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_orders`
--

DROP TABLE IF EXISTS `cm_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_orders` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `puid` mediumint(8) NOT NULL DEFAULT '0' COMMENT '代理ID',
  `uid` mediumint(8) NOT NULL COMMENT '商户id',
  `trade_no` varchar(100) NOT NULL COMMENT '交易订单号',
  `out_trade_no` varchar(100) NOT NULL COMMENT '商户订单号',
  `subject` varchar(64) NOT NULL COMMENT '商品标题',
  `body` varchar(256) NOT NULL COMMENT '商品描述信息',
  `channel` varchar(30) NOT NULL COMMENT '交易方式(wx_native)',
  `cnl_id` int(3) NOT NULL COMMENT '支付通道ID',
  `extra` text COMMENT '特定渠道发起时额外参数',
  `amount` decimal(12,3) unsigned NOT NULL COMMENT '订单金额,单位是元,12-9保留3位小数',
  `income` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '实付金额',
  `user_in` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '商户收入',
  `agent_in` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '代理收入',
  `platform_in` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '平台收入',
  `currency` varchar(3) NOT NULL DEFAULT 'CNY' COMMENT '三位货币代码,人民币:CNY',
  `client_ip` varchar(32) NOT NULL COMMENT '客户端IP',
  `return_url` varchar(128) NOT NULL COMMENT '同步通知地址',
  `notify_url` varchar(128) NOT NULL COMMENT '异步通知地址',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单状态:0-已取消-1-待付款，2-已付款',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `bd_remarks` varchar(455) NOT NULL,
  `visite_time` int(10) NOT NULL DEFAULT '0' COMMENT 'è®¿é®æ¶é´',
  `real_need_amount` decimal(12,3) NOT NULL COMMENT 'éè¦ç¨·æ¯ä»éé¢',
  `image_url` varchar(445) NOT NULL COMMENT 'éè¦ç¨·æ¯ä»éé¢',
  `request_log` varchar(445) NOT NULL COMMENT 'log',
  `visite_show_time` int(10) NOT NULL DEFAULT '0' COMMENT 'å è½½å®æ¶é´',
  `request_elapsed_time` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '请求时间',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no_index` (`out_trade_no`,`trade_no`,`uid`,`channel`) USING BTREE,
  UNIQUE KEY `trade_no_index` (`trade_no`) USING BTREE,
  KEY `stat` (`cnl_id`,`create_time`) USING BTREE,
  KEY `stat1` (`cnl_id`,`status`,`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COMMENT='交易订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_orders`
--

LOCK TABLES `cm_orders` WRITE;
/*!40000 ALTER TABLE `cm_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_orders_notify`
--

DROP TABLE IF EXISTS `cm_orders_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_orders_notify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `is_status` int(3) unsigned NOT NULL DEFAULT '404',
  `result` varchar(300) NOT NULL DEFAULT '' COMMENT '请求相响应',
  `times` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '请求次数',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=937144 DEFAULT CHARSET=utf8mb4 COMMENT='交易订单通知表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_orders_notify`
--

LOCK TABLES `cm_orders_notify` WRITE;
/*!40000 ALTER TABLE `cm_orders_notify` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_orders_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_ownpay_order`
--

DROP TABLE IF EXISTS `cm_ownpay_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_ownpay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addTime` int(10) DEFAULT NULL,
  `orderNum` varchar(100) DEFAULT NULL,
  `username` varchar(500) DEFAULT NULL,
  `orderPrice` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `apply_pay_time` int(10) DEFAULT NULL,
  `userid` int(11) DEFAULT '0' COMMENT '上传者用户ｉｄ',
  `storeid` int(10) DEFAULT NULL,
  `storeName` varchar(45) DEFAULT NULL,
  `payTime` int(10) DEFAULT NULL,
  `order_type` int(1) DEFAULT NULL,
  `out_trade_no` varchar(100) DEFAULT NULL,
  `reset_info` varchar(300) DEFAULT NULL,
  `error_times` int(11) DEFAULT '0',
  `pay_type` int(1) DEFAULT NULL COMMENT '支持的支付类型1表示支付宝，２表示微信，３表示支付宝和微信',
  `zfb_qr_image` varchar(100) DEFAULT NULL,
  `zfb_qr_url` varchar(1000) DEFAULT NULL,
  `vx_qr_image` varchar(100) DEFAULT NULL,
  `vx_qr_url` varchar(200) DEFAULT NULL,
  `update_vx_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `orderNum_UNIQUE` (`orderNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_ownpay_order`
--

LOCK TABLES `cm_ownpay_order` WRITE;
/*!40000 ALTER TABLE `cm_ownpay_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_ownpay_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_pay_account`
--

DROP TABLE IF EXISTS `cm_pay_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pay_account` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '账号ID',
  `cnl_id` bigint(10) NOT NULL COMMENT '所属渠道ID',
  `co_id` text NOT NULL COMMENT '支持的方式(有多个)',
  `name` varchar(30) NOT NULL COMMENT '渠道账户名称',
  `rate` decimal(4,3) NOT NULL COMMENT '渠道账户费率',
  `urate` decimal(4,3) NOT NULL DEFAULT '0.998',
  `grate` decimal(4,3) NOT NULL DEFAULT '0.998',
  `daily` decimal(12,3) NOT NULL COMMENT '当日限额',
  `single` decimal(12,3) NOT NULL COMMENT '单笔限额',
  `timeslot` text NOT NULL COMMENT '交易时间段',
  `param` text NOT NULL COMMENT '账户配置参数,json字符串',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `max_deposit_money` decimal(12,3) NOT NULL,
  `min_deposit_money` decimal(12,3) NOT NULL,
  `pay_param` varchar(30) DEFAULT '' COMMENT '支付参数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_pay_account`
--

LOCK TABLES `cm_pay_account` WRITE;
/*!40000 ALTER TABLE `cm_pay_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_pay_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_pay_channel`
--

DROP TABLE IF EXISTS `cm_pay_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pay_channel` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `name` varchar(30) NOT NULL COMMENT '支付渠道名称',
  `action` varchar(30) NOT NULL COMMENT '控制器名称,如:Wxpay用于分发处理支付请求',
  `urate` decimal(4,3) NOT NULL DEFAULT '0.998' COMMENT '默认商户分成',
  `grate` decimal(4,3) NOT NULL DEFAULT '0.998' COMMENT '默认代理分成',
  `timeslot` text NOT NULL COMMENT '交易时间段',
  `return_url` varchar(255) NOT NULL COMMENT '同步地址',
  `notify_url` varchar(255) NOT NULL COMMENT '异步地址',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '渠道状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `notify_ips` varchar(445) NOT NULL,
  `ia_allow_notify` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'æ¸ éæ¯å¦åè®¸åè°',
  `channel_fund` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '渠道资金',
  `wirhdraw_charge` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '提现手续费',
  `tg_group_id` varchar(50) NOT NULL DEFAULT '' COMMENT '当前渠tg群id',
  `channel_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '渠道密钥',
  `limit_moneys` varchar(255) NOT NULL DEFAULT '' COMMENT '固定金额 不填写默认不限制',
  `pay_address` varchar(100) NOT NULL DEFAULT '' COMMENT '下单地址',
  `pay_secret` text NOT NULL COMMENT '支付密钥',
  `pay_merchant` varchar(50) NOT NULL DEFAULT '' COMMENT '支付商户号',
  `deposit_status` tinyint(1) DEFAULT '0' COMMENT '押金状态 0关闭 1开启',
  `deposit` decimal(11,2) DEFAULT '0.00' COMMENT '押金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_pay_channel`
--

LOCK TABLES `cm_pay_channel` WRITE;
/*!40000 ALTER TABLE `cm_pay_channel` DISABLE KEYS */;
INSERT INTO `cm_pay_channel` VALUES (153,'测试渠道','XianglongPay',1.000,0.998,'{\"start\":\"0:0\",\"end\":\"0:0\"}','http://68.178.164.187/api/notify/notify/channel/XianglongPay','http://68.178.164.187/api/notify/notify/channel/XianglongPay','1',1,1663955021,1665169614,'35.220.207.13',1,0.000,0.000,'','5d73f669cca4e10253b1abefb4ffd423','','https://api.ddhhpay.com/trade/pay','9E1D65AE91C448BA967B72A98D','22091',0,200000.00);
/*!40000 ALTER TABLE `cm_pay_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_pay_channel_change`
--

DROP TABLE IF EXISTS `cm_pay_channel_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pay_channel_change` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` mediumint(8) NOT NULL COMMENT '渠道ID',
  `preinc` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动前金额',
  `increase` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '增加金额',
  `reduce` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '减少金额',
  `suffixred` decimal(12,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '变动后金额',
  `remarks` varchar(255) NOT NULL COMMENT '资金变动说明',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_flat_op` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否后台人工账变',
  `status` varchar(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='渠道资金变动记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_pay_channel_change`
--

LOCK TABLES `cm_pay_channel_change` WRITE;
/*!40000 ALTER TABLE `cm_pay_channel_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_pay_channel_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_pay_channel_price_weight`
--

DROP TABLE IF EXISTS `cm_pay_channel_price_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pay_channel_price_weight` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `pay_code_id` bigint(10) NOT NULL DEFAULT '0' COMMENT '支付产品id',
  `cnl_id` bigint(10) NOT NULL DEFAULT '0' COMMENT '支付渠道id',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `cnl_weight` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '渠道权重值',
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=500192 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='支付产品下列渠道在固定金额下的权重';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_pay_channel_price_weight`
--

LOCK TABLES `cm_pay_channel_price_weight` WRITE;
/*!40000 ALTER TABLE `cm_pay_channel_price_weight` DISABLE KEYS */;
INSERT INTO `cm_pay_channel_price_weight` VALUES (17,13,8,1622884026,1622884026,40,30.00),(18,13,8,1622884026,1622884026,0,50.00),(19,13,8,1622884026,1622884026,0,100.00),(20,13,8,1622884026,1622884026,0,200.00),(163193,22,54,1642428209,1642428209,100,30.00),(163194,22,54,1642428209,1642428209,100,50.00),(163195,22,54,1642428209,1642428209,100,100.00),(163196,22,54,1642428209,1642428209,100,200.00),(417552,19,10,1653023475,1653023475,0,30.00),(417553,19,10,1653023475,1653023475,0,50.00),(417554,19,10,1653023475,1653023475,0,100.00),(417555,19,10,1653023475,1653023475,0,200.00),(417556,19,10,1653023475,1653023475,0,9999.00),(417557,19,51,1653023475,1653023475,0,30.00),(417558,19,51,1653023475,1653023475,20,50.00),(417559,19,51,1653023475,1653023475,20,100.00),(417560,19,51,1653023475,1653023475,20,200.00),(417561,19,51,1653023475,1653023475,0,9999.00),(417562,19,87,1653023475,1653023475,20,30.00),(417563,19,87,1653023475,1653023475,20,50.00),(417564,19,87,1653023475,1653023475,20,100.00),(417565,19,87,1653023475,1653023475,20,200.00),(417566,19,87,1653023475,1653023475,0,9999.00),(427697,23,10,1653402836,1653402836,20,30.00),(427698,23,10,1653402836,1653402836,20,50.00),(427699,23,10,1653402836,1653402836,0,100.00),(427700,23,10,1653402836,1653402836,0,200.00),(427701,23,10,1653402836,1653402836,0,9999.00),(427702,23,73,1653402836,1653402836,0,30.00),(427703,23,73,1653402836,1653402836,0,50.00),(427704,23,73,1653402836,1653402836,20,100.00),(427705,23,73,1653402836,1653402836,20,200.00),(427706,23,73,1653402836,1653402836,20,9999.00),(499327,33,54,1656061797,1656061797,0,30.00),(499328,33,54,1656061797,1656061797,0,50.00),(499329,33,54,1656061797,1656061797,0,100.00),(499330,33,54,1656061797,1656061797,0,200.00),(499331,33,54,1656061797,1656061797,0,9999.00),(499332,33,101,1656061797,1656061797,0,30.00),(499333,33,101,1656061797,1656061797,0,50.00),(499334,33,101,1656061797,1656061797,0,100.00),(499335,33,101,1656061797,1656061797,0,200.00),(499336,33,101,1656061797,1656061797,0,9999.00),(499337,33,109,1656061797,1656061797,0,30.00),(499338,33,109,1656061797,1656061797,0,50.00),(499339,33,109,1656061797,1656061797,0,100.00),(499340,33,109,1656061797,1656061797,0,200.00),(499341,33,109,1656061797,1656061797,20,9999.00),(499342,33,132,1656061797,1656061797,20,30.00),(499343,33,132,1656061797,1656061797,20,50.00),(499344,33,132,1656061797,1656061797,20,100.00),(499345,33,132,1656061797,1656061797,20,200.00),(499346,33,132,1656061797,1656061797,0,9999.00),(500052,34,101,1656132893,1656132893,0,30.00),(500053,34,101,1656132893,1656132893,0,50.00),(500054,34,101,1656132893,1656132893,0,100.00),(500055,34,101,1656132893,1656132893,20,200.00),(500056,34,101,1656132893,1656132893,0,9999.00),(500057,34,130,1656132893,1656132893,5,30.00),(500058,34,130,1656132893,1656132893,5,50.00),(500059,34,130,1656132893,1656132893,5,100.00),(500060,34,130,1656132893,1656132893,5,200.00),(500061,34,130,1656132893,1656132893,0,9999.00),(500062,34,132,1656132893,1656132893,20,30.00),(500063,34,132,1656132893,1656132893,20,50.00),(500064,34,132,1656132893,1656132893,10,100.00),(500065,34,132,1656132893,1656132893,10,200.00),(500066,34,132,1656132893,1656132893,0,9999.00),(500067,12,44,1656134039,1656134039,0,30.00),(500068,12,44,1656134039,1656134039,0,50.00),(500069,12,44,1656134039,1656134039,0,100.00),(500070,12,44,1656134039,1656134039,0,200.00),(500071,12,44,1656134039,1656134039,0,9999.00),(500072,12,66,1656134039,1656134039,0,30.00),(500073,12,66,1656134039,1656134039,0,50.00),(500074,12,66,1656134039,1656134039,0,100.00),(500075,12,66,1656134039,1656134039,0,200.00),(500076,12,66,1656134039,1656134039,0,9999.00),(500077,12,73,1656134039,1656134039,0,30.00),(500078,12,73,1656134039,1656134039,0,50.00),(500079,12,73,1656134039,1656134039,0,100.00),(500080,12,73,1656134039,1656134039,0,200.00),(500081,12,73,1656134039,1656134039,0,9999.00),(500082,12,76,1656134039,1656134039,20,30.00),(500083,12,76,1656134039,1656134039,20,50.00),(500084,12,76,1656134039,1656134039,20,100.00),(500085,12,76,1656134039,1656134039,20,200.00),(500086,12,76,1656134039,1656134039,0,9999.00),(500087,12,109,1656134039,1656134039,0,30.00),(500088,12,109,1656134039,1656134039,0,50.00),(500089,12,109,1656134039,1656134039,0,100.00),(500090,12,109,1656134039,1656134039,0,200.00),(500091,12,109,1656134039,1656134039,0,9999.00),(500092,12,124,1656134039,1656134039,0,30.00),(500093,12,124,1656134039,1656134039,0,50.00),(500094,12,124,1656134039,1656134039,0,100.00),(500095,12,124,1656134039,1656134039,0,200.00),(500096,12,124,1656134039,1656134039,10,9999.00),(500097,12,130,1656134039,1656134039,0,30.00),(500098,12,130,1656134039,1656134039,0,50.00),(500099,12,130,1656134039,1656134039,0,100.00),(500100,12,130,1656134039,1656134039,0,200.00),(500101,12,130,1656134039,1656134039,0,9999.00),(500102,14,10,1656135618,1656135618,0,30.00),(500103,14,10,1656135618,1656135618,0,50.00),(500104,14,10,1656135618,1656135618,0,100.00),(500105,14,10,1656135618,1656135618,0,200.00),(500106,14,10,1656135618,1656135618,0,9999.00),(500107,14,13,1656135618,1656135618,0,30.00),(500108,14,13,1656135618,1656135618,0,50.00),(500109,14,13,1656135618,1656135618,0,100.00),(500110,14,13,1656135618,1656135618,0,200.00),(500111,14,13,1656135618,1656135618,0,9999.00),(500112,14,54,1656135618,1656135618,0,30.00),(500113,14,54,1656135618,1656135618,0,50.00),(500114,14,54,1656135618,1656135618,0,100.00),(500115,14,54,1656135618,1656135618,0,200.00),(500116,14,54,1656135618,1656135618,0,9999.00),(500117,14,66,1656135618,1656135618,0,30.00),(500118,14,66,1656135618,1656135618,0,50.00),(500119,14,66,1656135618,1656135618,0,100.00),(500120,14,66,1656135618,1656135618,0,200.00),(500121,14,66,1656135618,1656135618,0,9999.00),(500122,14,76,1656135618,1656135618,0,30.00),(500123,14,76,1656135618,1656135618,0,50.00),(500124,14,76,1656135618,1656135618,0,100.00),(500125,14,76,1656135618,1656135618,0,200.00),(500126,14,76,1656135618,1656135618,0,9999.00),(500127,14,101,1656135618,1656135618,20,30.00),(500128,14,101,1656135618,1656135618,20,50.00),(500129,14,101,1656135618,1656135618,20,100.00),(500130,14,101,1656135618,1656135618,20,200.00),(500131,14,101,1656135618,1656135618,0,9999.00),(500132,14,121,1656135618,1656135618,0,30.00),(500133,14,121,1656135618,1656135618,0,50.00),(500134,14,121,1656135618,1656135618,0,100.00),(500135,14,121,1656135618,1656135618,0,200.00),(500136,14,121,1656135618,1656135618,0,9999.00),(500137,14,126,1656135618,1656135618,0,30.00),(500138,14,126,1656135618,1656135618,0,50.00),(500139,14,126,1656135618,1656135618,0,100.00),(500140,14,126,1656135618,1656135618,0,200.00),(500141,14,126,1656135618,1656135618,0,9999.00),(500142,14,130,1656135618,1656135618,0,30.00),(500143,14,130,1656135618,1656135618,0,50.00),(500144,14,130,1656135618,1656135618,0,100.00),(500145,14,130,1656135618,1656135618,0,200.00),(500146,14,130,1656135618,1656135618,0,9999.00),(500147,14,132,1656135618,1656135618,20,30.00),(500148,14,132,1656135618,1656135618,20,50.00),(500149,14,132,1656135618,1656135618,20,100.00),(500150,14,132,1656135618,1656135618,20,200.00),(500151,14,132,1656135618,1656135618,0,9999.00),(500182,36,144,1661097314,1661097314,0,30.00),(500183,36,144,1661097314,1661097314,10,50.00),(500184,36,144,1661097314,1661097314,0,100.00),(500185,36,144,1661097314,1661097314,0,200.00),(500186,36,144,1661097314,1661097314,0,9999.00),(500187,36,147,1661097314,1661097314,0,30.00),(500188,36,147,1661097314,1661097314,255,50.00),(500189,36,147,1661097314,1661097314,0,100.00),(500190,36,147,1661097314,1661097314,0,200.00),(500191,36,147,1661097314,1661097314,0,9999.00);
/*!40000 ALTER TABLE `cm_pay_channel_price_weight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_pay_code`
--

DROP TABLE IF EXISTS `cm_pay_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pay_code` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `cnl_id` text,
  `name` varchar(30) NOT NULL COMMENT '支付方式名称',
  `code` varchar(30) NOT NULL COMMENT '支付方式代码,如:wx_native,qq_native,ali_qr;',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '方式状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `cnl_weight` varchar(255) NOT NULL COMMENT 'å½åpaycodeå¯¹åºæ¸ éæé',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='交易方式表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_pay_code`
--

LOCK TABLES `cm_pay_code` WRITE;
/*!40000 ALTER TABLE `cm_pay_code` DISABLE KEYS */;
INSERT INTO `cm_pay_code` VALUES (13,'154','test','test','test',1,1616603188,1665501502,'{\"5\":\"0\"}'),(14,'152','微信H5','h5_vx','微信H5',1,1618246298,1664524982,'{\"144\":\"1\",\"145\":\"6\"}'),(36,'153','WAP支付宝','wap_zfb','WAP支付宝',1,1657640966,1664375586,'{\"144\":\"4\",\"147\":\"1\"}'),(37,'','H5支付宝','h5_zfb','H5支付宝',1,1657641868,1665157192,'{\"151\":\"1\",\"153\":\"5\"}'),(38,'140','微信小程序','vx_xcx','微信小程序',1,1657642583,1657642583,''),(39,'142','支付宝银盛原生','zfbys','支付宝银盛原生',1,1657790961,1657790961,''),(40,'','支付宝赚钱吧','zfb_zqb','支付宝赚钱吧',-1,1658238784,1661333178,'{\"147\":\"1\"}'),(41,'142','原生话费支付宝','zfb_yshf','原生话费支付宝',1,1659109237,1661342548,'{\"142\":\"1\",\"144\":\"1\"}'),(42,'142','微信扫码','sm_vx','微信扫码',1,1659329796,1659761485,'{\"144\":\"1\"}'),(43,'146','微信WAP','wechat','微信WAP',1,1660034190,1661510129,'null'),(44,'','天然气','5008','星光',-1,1665291272,1665291605,''),(45,'154','加油中石化云闪付','8001099','加油中石化云闪付',-1,1665563067,1665564871,''),(46,'154','加油中石化（云闪付）','ysf_sh','石化',1,1665565492,1665565492,''),(47,'154','中油好客（支付宝）','zfb_sy','石油',1,1665567197,1665567197,'');
/*!40000 ALTER TABLE `cm_pay_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_shop`
--

DROP TABLE IF EXISTS `cm_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT '店铺名称',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '店铺类型',
  `onlinedate` int(11) DEFAULT NULL COMMENT '最后在线时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1在线，2不在线，3停止健康，4停用',
  `password` varchar(45) DEFAULT NULL,
  `token` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_shop`
--

LOCK TABLES `cm_shop` WRITE;
/*!40000 ALTER TABLE `cm_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_transaction`
--

DROP TABLE IF EXISTS `cm_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_transaction` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL COMMENT '商户id',
  `order_no` varchar(80) DEFAULT NULL COMMENT '交易订单号',
  `amount` decimal(12,3) DEFAULT NULL COMMENT '交易金额',
  `platform` tinyint(1) DEFAULT NULL COMMENT '交易平台:1-支付宝,2-微信',
  `platform_number` varchar(200) DEFAULT NULL COMMENT '交易平台交易流水号',
  `status` tinyint(1) DEFAULT NULL COMMENT '交易状态',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_index` (`order_no`,`platform`,`uid`,`amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易流水表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_transaction`
--

LOCK TABLES `cm_transaction` WRITE;
/*!40000 ALTER TABLE `cm_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user`
--

DROP TABLE IF EXISTS `cm_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user` (
  `uid` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '商户uid',
  `puid` mediumint(8) NOT NULL DEFAULT '0',
  `account` varchar(50) NOT NULL COMMENT '商户邮件',
  `username` varchar(30) NOT NULL COMMENT '商户名称',
  `auth_code` varchar(32) DEFAULT NULL COMMENT '8位安全码，注册时发送跟随邮件',
  `password` varchar(50) NOT NULL COMMENT '商户登录密码',
  `phone` varchar(250) NOT NULL COMMENT '手机号',
  `qq` varchar(250) NOT NULL COMMENT 'QQ',
  `is_agent` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '代理商',
  `is_verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '验证账号',
  `is_verify_phone` tinyint(1) NOT NULL DEFAULT '0' COMMENT '验证手机',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商户状态,0-未激活,1-使用中,2-禁用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `is_need_google_verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'æ¯å¦éè¦googleéªè¯ 0 ä¸éè¦  1 éè¦',
  `google_account` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'æ¯å¦éè¦googleéªè¯ 0 ä¸éè¦  1 éè¦',
  `auth_login_ips` varchar(255) NOT NULL DEFAULT '' COMMENT 'ç»å½é´æip',
  `is_verify_bankaccount` enum('1','0') NOT NULL DEFAULT '0' COMMENT '是否审核银行卡账户',
  `google_secret_key` varchar(100) NOT NULL DEFAULT '0' COMMENT 'googleç§é¥',
  `last_online_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后在线时间',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '·æåç»å½æ¶é´',
  `pao_ms_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '如果跑分出码对于码商的ids,逗号拼接',
  `is_can_df_from_index` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许前端发起代付0=》不允许 1=》允许',
  `mch_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '商户tg密钥',
  `tg_group_id` varchar(50) NOT NULL DEFAULT '' COMMENT '商户群组id',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_name_unique` (`account`,`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100004 DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user`
--

LOCK TABLES `cm_user` WRITE;
/*!40000 ALTER TABLE `cm_user` DISABLE KEYS */;
INSERT INTO `cm_user` VALUES (100001,0,'nouser@iredcap.cn','97139218','d31f4b567830340af5ec399e4e4da8d6','17cf2f98e09fa2af801de5b6ee9e1a58','18078687485','702154416',1,1,1,1,1541787044,1644595369,0,0,'','0','',1644595378,1644595369,'',0,'e2a6a1ace352668000aed191a817d143','-1001732937258');
/*!40000 ALTER TABLE `cm_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_account`
--

DROP TABLE IF EXISTS `cm_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_account` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `bank_id` mediumint(8) NOT NULL DEFAULT '1' COMMENT '开户行(关联银行表)',
  `account` varchar(250) NOT NULL COMMENT '开户号',
  `address` varchar(250) NOT NULL COMMENT '开户所在地',
  `remarks` varchar(250) NOT NULL COMMENT '备注',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认账户,0-不默认,1-默认',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `account_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COMMENT='商户结算账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_account`
--

LOCK TABLES `cm_user_account` WRITE;
/*!40000 ALTER TABLE `cm_user_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_auth`
--

DROP TABLE IF EXISTS `cm_user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_auth` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `realname` varchar(30) NOT NULL DEFAULT '1' COMMENT '开户行(关联银行表)',
  `sfznum` varchar(18) NOT NULL COMMENT '开户号',
  `card` text NOT NULL COMMENT '认证详情',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='商户认证信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_auth`
--

LOCK TABLES `cm_user_auth` WRITE;
/*!40000 ALTER TABLE `cm_user_auth` DISABLE KEYS */;
INSERT INTO `cm_user_auth` VALUES (1,100001,'马大哈','554612198802051515','[\"\\/uploads\\/userauth\\/100001\\/20181122\\/22203963968.jpg\",\"\\/uploads\\/userauth\\/100001\\/20181122\\/22204161001.jpg\"]',2,1542896443,1544365792);
/*!40000 ALTER TABLE `cm_user_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_daifuprofit`
--

DROP TABLE IF EXISTS `cm_user_daifuprofit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_daifuprofit` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `service_rate` decimal(4,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '费率',
  `service_charge` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔手续费',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户代付费率表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_daifuprofit`
--

LOCK TABLES `cm_user_daifuprofit` WRITE;
/*!40000 ALTER TABLE `cm_user_daifuprofit` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_user_daifuprofit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_padmin`
--

DROP TABLE IF EXISTS `cm_user_padmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_padmin` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '·ID',
  `p_admin_id` mediumint(8) NOT NULL COMMENT 'è·å¹³å°ç®¡çåid',
  `p_admin_appkey` varchar(255) NOT NULL DEFAULT '' COMMENT 'è·å¹³å°çç®¡çåappkeyç§é¥',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1æ­£å¸¸ 0ç¦æ­¢æä½',
  `create_time` int(10) unsigned NOT NULL COMMENT 'å»ºæ¶é´',
  `update_time` int(10) unsigned NOT NULL COMMENT 'æ´æ°æ¶é´',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_padmin`
--

LOCK TABLES `cm_user_padmin` WRITE;
/*!40000 ALTER TABLE `cm_user_padmin` DISABLE KEYS */;
INSERT INTO `cm_user_padmin` VALUES (1,100059,1,'',1,1622193100,1622193100),(2,100089,1,'',1,1647798311,1647798311);
/*!40000 ALTER TABLE `cm_user_padmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_pay_code`
--

DROP TABLE IF EXISTS `cm_user_pay_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_pay_code` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '·ID',
  `co_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'æ¯ä»pay_codeä¸»é®ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:å¼å¯ 0:å³é­',
  `create_time` int(10) unsigned NOT NULL COMMENT 'å»ºæ¶é´',
  `update_time` int(10) unsigned NOT NULL COMMENT 'æ´æ°æ¶é´',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6096 DEFAULT CHARSET=utf8 COMMENT='·æ¯ä»æ¸ éè¡¨å³èpay_code';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_pay_code`
--

LOCK TABLES `cm_user_pay_code` WRITE;
/*!40000 ALTER TABLE `cm_user_pay_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_user_pay_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_pay_code_appoint`
--

DROP TABLE IF EXISTS `cm_user_pay_code_appoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_pay_code_appoint` (
  `appoint_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) NOT NULL COMMENT '用户',
  `pay_code_id` int(11) NOT NULL COMMENT '支付代码',
  `cnl_id` int(11) NOT NULL COMMENT '指定渠道',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`appoint_id`),
  KEY `where` (`pay_code_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_pay_code_appoint`
--

LOCK TABLES `cm_user_pay_code_appoint` WRITE;
/*!40000 ALTER TABLE `cm_user_pay_code_appoint` DISABLE KEYS */;
INSERT INTO `cm_user_pay_code_appoint` VALUES (1,100027,28,47,1591188236),(5,100001,14,6,1625243891),(13,100057,12,15,1625771867),(86,100068,12,4,1640315155),(126,100081,12,4,1642057255),(129,100083,14,71,1642404837),(157,100067,12,17,1646211652),(215,100091,14,126,1652192562),(228,100092,12,93,1652256112),(262,100086,14,101,1653584467),(265,100093,14,130,1653927207),(267,100086,19,101,1654097333),(275,100055,12,79,1654791253),(277,100077,14,101,1654796362),(280,100102,12,124,1655556061),(288,100107,13,142,1657789257);
/*!40000 ALTER TABLE `cm_user_pay_code_appoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_user_profit`
--

DROP TABLE IF EXISTS `cm_user_profit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_user_profit` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `cnl_id` int(10) unsigned NOT NULL,
  `urate` decimal(4,3) unsigned NOT NULL DEFAULT '0.000',
  `grate` decimal(4,3) unsigned NOT NULL DEFAULT '0.000',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `single_handling_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔手续费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10394 DEFAULT CHARSET=utf8mb4 COMMENT='商户分润表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_user_profit`
--

LOCK TABLES `cm_user_profit` WRITE;
/*!40000 ALTER TABLE `cm_user_profit` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_user_profit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-13 15:33:13
