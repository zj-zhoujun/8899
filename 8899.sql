/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : 8899

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2021-01-13 11:47:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wym_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `wym_admin_user`;
CREATE TABLE `wym_admin_user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of wym_admin_user
-- ----------------------------
INSERT INTO `wym_admin_user` VALUES ('1', 'admin', 'd97986b84950f0213ebc5c4e2bca288a', '1', '2016-10-18 15:28:37', '2021-01-13 09:48:37', '127.0.0.1');

-- ----------------------------
-- Table structure for wym_article
-- ----------------------------
DROP TABLE IF EXISTS `wym_article`;
CREATE TABLE `wym_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `cid` smallint(5) unsigned NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `introduction` varchar(255) DEFAULT '' COMMENT '简介',
  `content` longtext COMMENT '内容',
  `author` varchar(20) DEFAULT '' COMMENT '作者',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0 待审核  1 审核',
  `reading` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '阅读量',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `photo` text COMMENT '图集',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶  0 不置顶  1 置顶',
  `is_recommend` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐  0 不推荐  1 推荐',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of wym_article
-- ----------------------------

-- ----------------------------
-- Table structure for wym_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `wym_auth_group`;
CREATE TABLE `wym_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL COMMENT '权限规则ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='权限组表';

-- ----------------------------
-- Records of wym_auth_group
-- ----------------------------
INSERT INTO `wym_auth_group` VALUES ('1', '超级管理组', '1', '1,2,3,74,5,6,7,8,9,10,11,14,13,22,24,15,27,29,30,16,18,49,50,51,52,53,19,31,32,33,34,35,36,37,54,55,60,62,56,65,67,82,87,95,96,109,115,88,89,90,91,114,116,111,117,118,119,120,123,124,125,121,122,126');

-- ----------------------------
-- Table structure for wym_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `wym_auth_group_access`;
CREATE TABLE `wym_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限组规则表';

-- ----------------------------
-- Records of wym_auth_group_access
-- ----------------------------
INSERT INTO `wym_auth_group_access` VALUES ('1', '1');
INSERT INTO `wym_auth_group_access` VALUES ('5', '1');

-- ----------------------------
-- Table structure for wym_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `wym_auth_rule`;
CREATE TABLE `wym_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(20) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `pid` smallint(5) unsigned NOT NULL COMMENT '父级ID',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `sort` tinyint(4) unsigned NOT NULL COMMENT '排序',
  `condition` char(100) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of wym_auth_rule
-- ----------------------------
INSERT INTO `wym_auth_rule` VALUES ('1', 'admin/System/default', '系统配置', '1', '1', '0', 'fa fa-gears', '99', '');
INSERT INTO `wym_auth_rule` VALUES ('2', 'admin/System/siteConfig', '站点配置', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('3', 'admin/System/updateSiteConfig', '更新配置', '1', '0', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('5', 'admin/Menu/default', '菜单管理', '1', '1', '0', 'fa fa-bars', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('6', 'admin/Menu/index', '后台菜单', '1', '1', '5', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('7', 'admin/Menu/add', '添加菜单', '1', '0', '6', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('8', 'admin/Menu/save', '保存菜单', '1', '0', '6', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('9', 'admin/Menu/edit', '编辑菜单', '1', '0', '6', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('10', 'admin/Menu/update', '更新菜单', '1', '0', '6', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('11', 'admin/Menu/delete', '删除菜单', '1', '0', '6', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('13', 'admin/Article/cate_index', '栏目管理', '1', '1', '14', 'fa fa-sitemap', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('14', 'admin/Content/default', '内容管理', '1', '1', '0', 'fa fa-file-text', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('15', 'admin/Article/index', '文章管理', '1', '1', '14', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('16', 'admin/User/default', '用户管理', '1', '1', '0', 'fa fa-users', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('17', 'admin/User/index', '会员列表', '1', '1', '16', '', '90', '');
INSERT INTO `wym_auth_rule` VALUES ('18', 'admin/Admin/index', '管理员', '1', '1', '16', '', '99', '');
INSERT INTO `wym_auth_rule` VALUES ('19', 'admin/AuthGroup/index', '权限组', '1', '1', '16', '', '98', '');
INSERT INTO `wym_auth_rule` VALUES ('22', 'admin/Article/cate_edit', '编辑栏目', '1', '0', '13', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('24', 'admin/Article/cate_delete', '删除栏目', '1', '0', '13', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('27', 'admin/Article/edit', '编辑文章', '1', '0', '15', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('29', 'admin/Article/delete', '删除文章', '1', '0', '15', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('30', 'admin/Article/toggle', '文章审核', '1', '0', '15', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('31', 'admin/AuthGroup/add', '添加权限组', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('32', 'admin/AuthGroup/save', '保存权限组', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('33', 'admin/AuthGroup/edit', '编辑权限组', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('34', 'admin/AuthGroup/update', '更新权限组', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('35', 'admin/AuthGroup/delete', '删除权限组', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('36', 'admin/AuthGroup/auth', '授权', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('37', 'admin/AuthGroup/updateAuthGroupRule', '更新权限组规则', '1', '0', '19', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('44', 'admin/User/add', '添加用户', '1', '0', '17', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('45', 'admin/User/save', '保存用户', '1', '0', '17', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('46', 'admin/User/edit', '编辑用户', '1', '1', '17', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('47', 'admin/User/update', '更新用户', '1', '1', '17', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('49', 'admin/Admin/add', '添加管理员', '1', '0', '18', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('50', 'admin/Admin/save', '保存管理员', '1', '0', '18', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('51', 'admin/Admin/edit', '编辑管理员', '1', '0', '18', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('52', 'admin/Admin/update', '更新管理员', '1', '0', '18', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('53', 'admin/Admin/delete', '删除管理员', '1', '0', '18', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('54', 'admin/Slide/default', '扩展管理', '1', '1', '0', 'fa fa-wrench', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('55', 'admin/Slide/cate_index', '轮播分类', '1', '1', '54', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('56', 'admin/Slide/index', '轮播图管理', '1', '1', '54', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('60', 'admin/Slide/cate_edit', '编辑分类', '1', '0', '55', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('62', 'admin/Slide/cate_delete', '删除分类', '1', '0', '55', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('65', 'admin/Slide/edit', '编辑轮播', '1', '1', '56', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('67', 'admin/Slide/delete', '删除轮播', '1', '0', '56', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('74', 'admin/Admin/updatePassword', '修改密码', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('75', 'admin/user/tj_net', '会员推荐图', '1', '1', '16', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('76', 'admin/user/jd_net', '节点图', '1', '1', '16', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('82', 'admin/wealth/default', '财富管理', '1', '1', '0', 'fa fa-money', '9', '');
INSERT INTO `wym_auth_rule` VALUES ('87', 'admin/Wealth/setWealth', '充值扣款', '1', '1', '82', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('88', 'admin/Shop/default', '商城管理', '1', '0', '0', 'fa fa-home', '90', '');
INSERT INTO `wym_auth_rule` VALUES ('89', 'admin/Shop/index', '商品列表', '1', '1', '88', 'fa fa-home', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('90', 'admin/Shop/cate', '商品分类', '1', '1', '88', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('91', 'admin/Shop/order', '订单列表', '1', '1', '88', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('93', 'admin/System/baseConfig', '参数配置', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('95', 'admin/Shop/withdraw', '提现管理', '1', '1', '82', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('96', 'admin/Wealth/index', '全部记录', '1', '1', '82', '', '20', '');
INSERT INTO `wym_auth_rule` VALUES ('104', 'admin/System/marketConfig', '团队奖励', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('105', 'admin/System/userLevel', '会员级别', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('106', 'admin/System/videoUpload', '新闻公告', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('129', 'admin/system/smsConfig', '短信开关', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('109', 'admin/Wealth/applyRecharge', '充值列表', '1', '1', '82', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('110', 'admin/User/identityAuth', '实名管理', '1', '1', '16', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('111', 'admin/Task/taskConfig', '宠物列表', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('112', 'admin/System/personsConfig', '团队人数配置', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('113', 'admin/Wealth/editRecharge', '平台二维码', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('114', 'admin/Shop/zcConfig', '众筹管理', '1', '1', '88', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('115', 'admin/Wealth/tradeList', '交易管理', '1', '0', '82', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('116', 's', '宠物管理', '1', '1', '0', 'fa fa-bars', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('117', 'admin/Task/nowGame', '今日出售', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('118', 'admin/Task/yuyue', '预约列表', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('119', 'admin/Task/pigOrder', '交易管理', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('120', 'admin/Task/shensu', '申诉管理', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('121', '11', '统计报表', '1', '1', '0', 'fa fa-home', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('122', 'admin/Tongji/user', '会员统计', '1', '1', '121', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('123', 'admin/Task/userPigs', '领养会员列表', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('124', 'admin/Task/destoryPigs', '销毁的宠物', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('125', 'admin/Task/deletePigs', '删除的宠物', '1', '1', '116', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('126', 'admin/Tongji/pet', '矿产统计', '1', '1', '121', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('127', 'admin/Question/index', '工单管理', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('128', 'admin/Task/pigsadd', '生成宠物', '1', '1', '116', 'fa fa-add', '1', '');
INSERT INTO `wym_auth_rule` VALUES ('130', 'admin/Dog/category', '宠物设置', '1', '1', '1', '', '0', '');
INSERT INTO `wym_auth_rule` VALUES ('131', 'admin/Shop/dogsell', '狗狗币卖出列表', '1', '1', '82', '', '0', '');

-- ----------------------------
-- Table structure for wym_bank
-- ----------------------------
DROP TABLE IF EXISTS `wym_bank`;
CREATE TABLE `wym_bank` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(15) NOT NULL DEFAULT '0',
  `true_name` varchar(255) NOT NULL DEFAULT '0',
  `bank_num` varchar(50) NOT NULL DEFAULT '0',
  `bank_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '银行名称',
  `branch` varchar(255) NOT NULL DEFAULT '0' COMMENT '支行',
  `address` varchar(255) NOT NULL,
  `create_time` int(13) NOT NULL DEFAULT '0',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='银行卡信息';

-- ----------------------------
-- Records of wym_bank
-- ----------------------------

-- ----------------------------
-- Table structure for wym_bonus
-- ----------------------------
DROP TABLE IF EXISTS `wym_bonus`;
CREATE TABLE `wym_bonus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `username` varchar(50) DEFAULT NULL,
  `from_uid` int(11) DEFAULT '0',
  `from_username` varchar(50) DEFAULT '0',
  `type` tinyint(3) DEFAULT '0' COMMENT '1动态奖2分红奖',
  `sourcemoney` decimal(10,2) DEFAULT '0.00' COMMENT '奖金来源表',
  `realmoney` decimal(10,2) DEFAULT '0.00' COMMENT '真实来源',
  `rate` decimal(10,2) DEFAULT '0.00',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for wym_category
-- ----------------------------
DROP TABLE IF EXISTS `wym_category`;
CREATE TABLE `wym_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `alias` varchar(50) DEFAULT '' COMMENT '导航别名',
  `content` longtext COMMENT '分类内容',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `icon` varchar(20) DEFAULT '' COMMENT '分类图标',
  `list_template` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `detail_template` varchar(50) DEFAULT '' COMMENT '分类详情模板',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '分类类型  1  列表  2 单页',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `path` varchar(255) DEFAULT '' COMMENT '路径',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of wym_category
-- ----------------------------
INSERT INTO `wym_category` VALUES ('1', '公告', '', '', '', '', '', '', '1', '0', '0', '0,', '2016-12-22 18:22:24');

-- ----------------------------
-- Table structure for wym_delete_pigs
-- ----------------------------
DROP TABLE IF EXISTS `wym_delete_pigs`;
CREATE TABLE `wym_delete_pigs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `pig_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0可出售 1已成熟',
  `price` decimal(65,2) NOT NULL DEFAULT '0.00',
  `buy_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_delete_pigs
-- ----------------------------

-- ----------------------------
-- Table structure for wym_destory_pigs
-- ----------------------------
DROP TABLE IF EXISTS `wym_destory_pigs`;
CREATE TABLE `wym_destory_pigs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `pig_id` int(11) NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `pig_level` varchar(12) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '0可出售 1已成熟',
  `delete_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_destory_pigs
-- ----------------------------

-- ----------------------------
-- Table structure for wym_dog_sell
-- ----------------------------
DROP TABLE IF EXISTS `wym_dog_sell`;
CREATE TABLE `wym_dog_sell` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `username` varchar(255) NOT NULL,
  `num` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '卖出数量',
  `price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '卖出时的狗狗币价格',
  `real_money` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '卖出的价值人民币',
  `w_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未审核 1审核通过 2拒绝',
  `audit_time` int(10) NOT NULL DEFAULT '0' COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_dog_sell
-- ----------------------------
INSERT INTO `wym_dog_sell` VALUES ('1', '18', '', '10.00', '0.50', '5.00', '1610500547', '1', '1610503912');

-- ----------------------------
-- Table structure for wym_errormoney
-- ----------------------------
DROP TABLE IF EXISTS `wym_errormoney`;
CREATE TABLE `wym_errormoney` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `username` varchar(50) DEFAULT NULL,
  `walltype` varchar(50) DEFAULT '',
  `lastmoney` decimal(10,2) DEFAULT '0.00' COMMENT '上次统计金额',
  `nowmoney` decimal(10,2) DEFAULT '0.00' COMMENT '现在金额',
  `chamoney` decimal(10,2) DEFAULT '0.00' COMMENT '差额',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_errormoney
-- ----------------------------

-- ----------------------------
-- Table structure for wym_identity_auth
-- ----------------------------
DROP TABLE IF EXISTS `wym_identity_auth`;
CREATE TABLE `wym_identity_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `realname` varchar(255) DEFAULT NULL,
  `mobile` char(11) DEFAULT NULL,
  `pusername` char(11) DEFAULT NULL,
  `idCard` char(18) NOT NULL DEFAULT '',
  `bankname` varchar(255) DEFAULT NULL,
  `bankcard` varchar(255) NOT NULL DEFAULT '',
  `alipay_code` varchar(255) DEFAULT NULL,
  `alipay_img` varchar(255) DEFAULT NULL COMMENT '支付宝二维码',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0 待审核 1已审核',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='实名资料';

-- ----------------------------
-- Records of wym_identity_auth
-- ----------------------------
INSERT INTO `wym_identity_auth` VALUES ('1', '2', '测试', '15710029343', null, '411381199605223933', null, '', null, null, '1', '1569255140');
INSERT INTO `wym_identity_auth` VALUES ('2', '4', '袁越', '13641493293', null, '430522199706010262', null, '', null, null, '1', '1570688263');
INSERT INTO `wym_identity_auth` VALUES ('3', '5', '王林', '15221935528', null, '341125198908258536', null, '', null, null, '1', '1571046367');
INSERT INTO `wym_identity_auth` VALUES ('4', '6', '王思', '15901873403', null, '341125198505092534', null, '', null, null, '1', '1571048013');
INSERT INTO `wym_identity_auth` VALUES ('5', '10', '张浩', '18222222222', null, '132451199005121421', null, '', null, null, '1', '1573698543');
INSERT INTO `wym_identity_auth` VALUES ('6', '11', '小森', '17754595359', null, '452727199201100936', null, '', null, null, '1', '1574421927');
INSERT INTO `wym_identity_auth` VALUES ('7', '15', '林祥雄', '18889177984', null, '46900319950228241X', null, '', null, null, '1', '1582025789');
INSERT INTO `wym_identity_auth` VALUES ('8', '17', '林祥雄', '18889177983', null, '469003199502282410', null, '', null, null, '1', '1582083665');
INSERT INTO `wym_identity_auth` VALUES ('9', '1', '会他', '18888888888', null, '543656199206152345', null, '', null, null, '1', '1590654691');

-- ----------------------------
-- Table structure for wym_market_level
-- ----------------------------
DROP TABLE IF EXISTS `wym_market_level`;
CREATE TABLE `wym_market_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` tinyint(3) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '级别名',
  `cnt` int(11) NOT NULL DEFAULT '0',
  `reward` int(11) DEFAULT NULL,
  `tperf` int(11) DEFAULT NULL COMMENT '团队奖励',
  `add_sell_num` int(11) DEFAULT '0' COMMENT '增加每日出售限制',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_market_level
-- ----------------------------
INSERT INTO `wym_market_level` VALUES ('1', '1', '一星达人', '15', '1', '3000', '0');
INSERT INTO `wym_market_level` VALUES ('2', '2', '二星达人', '30', '3', '20000', '0');
INSERT INTO `wym_market_level` VALUES ('3', '3', '三星达人', '60', '5', '50000', '0');

-- ----------------------------
-- Table structure for wym_money_log
-- ----------------------------
DROP TABLE IF EXISTS `wym_money_log`;
CREATE TABLE `wym_money_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` varchar(255) DEFAULT NULL,
  `from_id` int(11) DEFAULT NULL COMMENT '来自用户ID',
  `from_username` varchar(255) DEFAULT NULL COMMENT '来源用户名',
  `currency` varchar(25) DEFAULT 'currency',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '资产数目',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型 1系统充值 2卖出 3预约4推广收益 5团队收益',
  `note` varchar(255) DEFAULT NULL COMMENT '说明信息',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '资产记录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='资产记录';

-- ----------------------------
-- Records of wym_money_log
-- ----------------------------
INSERT INTO `wym_money_log` VALUES ('1', '2', '15710029343', '0', '系统操作', 'money', '-602.00', '12', '买入减少', '2020-09-14 17:57:14');
INSERT INTO `wym_money_log` VALUES ('2', '1', '18888888888', '0', '系统操作', 'money', '602.00', '13', '卖出增加', '2020-09-14 17:57:14');
INSERT INTO `wym_money_log` VALUES ('3', '2', '15710029343', '0', '系统操作', 'pig', '7.00', '9', '买入奖励wia', '2020-09-14 17:57:14');
INSERT INTO `wym_money_log` VALUES ('4', '1', '18888888888', '0', '系统操作', 'pay_points', '-3.00', '3', '抢购矿场', '2020-09-14 18:12:07');
INSERT INTO `wym_money_log` VALUES ('5', '1', '18888888888', '0', '系统操作', 'pay_points', '-5.00', '3', '预约矿场', '2020-09-14 18:12:42');
INSERT INTO `wym_money_log` VALUES ('6', '2', '15710029343', '0', '系统操作', 'money', '-493.00', '14', '提现减少', '2020-09-14 18:24:58');
INSERT INTO `wym_money_log` VALUES ('7', '2', '15710029343', '0', '系统操作', 'money', '105.00', '1', '系统充值', '2020-09-14 18:32:26');
INSERT INTO `wym_money_log` VALUES ('8', '1', '18888888888', '0', '系统操作', 'pay_points', '3.00', '4', '抢购未中奖返还', '2020-09-14 19:35:01');
INSERT INTO `wym_money_log` VALUES ('9', '1', '18888888888', '0', '系统操作', 'pay_points', '-10.00', '3', '预约矿场', '2021-01-10 09:52:41');
INSERT INTO `wym_money_log` VALUES ('10', '1', '18888888888', '0', '系统操作', 'pay_points', '-1.00', '3', '预约矿场', '2021-01-10 09:52:43');
INSERT INTO `wym_money_log` VALUES ('11', '1', '18888888888', '0', '系统操作', 'pay_points', '-10.00', '3', '预约矿场', '2021-01-11 08:45:24');
INSERT INTO `wym_money_log` VALUES ('12', '1', '18888888888', '0', '系统操作', 'pay_points', '-2.00', '3', '预约矿场', '2021-01-11 10:23:14');
INSERT INTO `wym_money_log` VALUES ('13', '2', '15710029343', '0', '系统操作', 'doge', '24.08', '6', 'DOGE收益', '2021-01-11 11:40:09');
INSERT INTO `wym_money_log` VALUES ('14', '1', '18888888888', '0', '系统操作', 'pay_points', '2.00', '4', '预约未中奖立返', '2021-01-11 16:10:56');
INSERT INTO `wym_money_log` VALUES ('15', '17', '18889177983', '0', '系统操作', 'pay_points', '-10.00', '3', '预约矿场', '2021-01-12 16:38:56');
INSERT INTO `wym_money_log` VALUES ('16', '18', '13025987659', '18', '13025987659', 'doge', '-10.00', '7', 'DOGE卖出', '2021-01-13 09:15:47');

-- ----------------------------
-- Table structure for wym_mscode
-- ----------------------------
DROP TABLE IF EXISTS `wym_mscode`;
CREATE TABLE `wym_mscode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `sendtime` int(11) DEFAULT '0',
  `state` tinyint(3) DEFAULT '0',
  `endtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='手机验证码记录';

-- ----------------------------
-- Records of wym_mscode
-- ----------------------------
INSERT INTO `wym_mscode` VALUES ('1', '15710029343', '267845', '1569254998', '0', '1569255598');
INSERT INTO `wym_mscode` VALUES ('2', '15710029343', '921647', '1569255065', '0', '1569255665');
INSERT INTO `wym_mscode` VALUES ('3', '15710029343', '893541', '1569255115', '0', '1569255715');
INSERT INTO `wym_mscode` VALUES ('4', '15710029343', '139346', '1569332897', '0', '1569333497');
INSERT INTO `wym_mscode` VALUES ('5', '15710029343', '448896', '1569495483', '0', '1569496083');
INSERT INTO `wym_mscode` VALUES ('6', '13100550006', '907469', '1570335469', '0', '1570336069');
INSERT INTO `wym_mscode` VALUES ('7', '13100550006', '471383', '1570335506', '0', '1570336106');
INSERT INTO `wym_mscode` VALUES ('8', '13100550006', '848093', '1570335511', '0', '1570336111');
INSERT INTO `wym_mscode` VALUES ('9', '13100550006', '570612', '1570335514', '0', '1570336114');
INSERT INTO `wym_mscode` VALUES ('10', '13641493293', '344771', '1570687708', '0', '1570688308');
INSERT INTO `wym_mscode` VALUES ('11', '13641493293', '775874', '1570687713', '0', '1570688313');
INSERT INTO `wym_mscode` VALUES ('12', '13641493293', '842814', '1570687792', '0', '1570688392');
INSERT INTO `wym_mscode` VALUES ('13', '13641493293', '448154', '1570687795', '0', '1570688395');
INSERT INTO `wym_mscode` VALUES ('14', '13641493293', '172584', '1570687828', '0', '1570688428');
INSERT INTO `wym_mscode` VALUES ('15', '13641493293', '817836', '1570687832', '0', '1570688432');
INSERT INTO `wym_mscode` VALUES ('16', '13641493293', '757638', '1570687835', '0', '1570688435');
INSERT INTO `wym_mscode` VALUES ('17', '13641493293', '730014', '1570687841', '0', '1570688441');
INSERT INTO `wym_mscode` VALUES ('18', '13641493293', '842755', '1570688037', '0', '1570688637');
INSERT INTO `wym_mscode` VALUES ('19', '13641493293', '233627', '1570688126', '0', '1570688726');
INSERT INTO `wym_mscode` VALUES ('20', '13641493293', '836668', '1570688196', '0', '1570688796');
INSERT INTO `wym_mscode` VALUES ('21', '13641493293', '959775', '1570688220', '0', '1570688820');
INSERT INTO `wym_mscode` VALUES ('22', '15221935528', '824278', '1571046036', '0', '1571046636');
INSERT INTO `wym_mscode` VALUES ('23', '15221935528', '993817', '1571046241', '0', '1571046841');
INSERT INTO `wym_mscode` VALUES ('24', '15221935528', '956883', '1571046272', '0', '1571046872');
INSERT INTO `wym_mscode` VALUES ('25', '15221935528', '893137', '1571046322', '0', '1571046922');
INSERT INTO `wym_mscode` VALUES ('26', '15901873403', '745075', '1571047797', '0', '1571048397');
INSERT INTO `wym_mscode` VALUES ('27', '15901873403', '528059', '1571047915', '0', '1571048515');
INSERT INTO `wym_mscode` VALUES ('28', '15901873403', '552059', '1571047940', '0', '1571048540');
INSERT INTO `wym_mscode` VALUES ('29', '15901873403', '151092', '1571047982', '0', '1571048582');
INSERT INTO `wym_mscode` VALUES ('30', '15710029343', '840713', '1571908059', '0', '1571908659');
INSERT INTO `wym_mscode` VALUES ('31', '15710029343', '285813', '1571993434', '0', '1571994034');
INSERT INTO `wym_mscode` VALUES ('32', '18222222222', '806645', '1573698279', '0', '1573698879');
INSERT INTO `wym_mscode` VALUES ('33', '18222222222', '249204', '1573698474', '0', '1573699074');
INSERT INTO `wym_mscode` VALUES ('34', '18222222222', '329850', '1573698515', '0', '1573699115');
INSERT INTO `wym_mscode` VALUES ('35', '17754595359', '438664', '1574421792', '0', '1574422392');
INSERT INTO `wym_mscode` VALUES ('36', '18889177984', '835653', '1582025598', '0', '1582026198');
INSERT INTO `wym_mscode` VALUES ('37', '18889177984', '786969', '1582025682', '0', '1582026282');
INSERT INTO `wym_mscode` VALUES ('38', '18889177984', '839734', '1582025712', '0', '1582026312');
INSERT INTO `wym_mscode` VALUES ('39', '18508939485', '865203', '1582026027', '0', '1582026627');
INSERT INTO `wym_mscode` VALUES ('40', '18508939485', '229623', '1582026035', '0', '1582026635');
INSERT INTO `wym_mscode` VALUES ('41', '18889177984', '385339', '1582026618', '0', '1582027218');
INSERT INTO `wym_mscode` VALUES ('42', '18889177984', '324227', '1582026647', '0', '1582027247');
INSERT INTO `wym_mscode` VALUES ('43', '18889177984', '432462', '1582026687', '0', '1582027287');
INSERT INTO `wym_mscode` VALUES ('44', '18889177984', '322193', '1582027029', '0', '1582027629');
INSERT INTO `wym_mscode` VALUES ('45', '18889177984', '803414', '1582027164', '0', '1582027764');
INSERT INTO `wym_mscode` VALUES ('46', '18889177983', '895105', '1582083517', '0', '1582084117');
INSERT INTO `wym_mscode` VALUES ('47', '18889177983', '880001', '1582083579', '0', '1582084179');
INSERT INTO `wym_mscode` VALUES ('48', '18889177983', '965196', '1582083617', '0', '1582084217');
INSERT INTO `wym_mscode` VALUES ('49', '18889177983', '478880', '1582083783', '0', '1582084383');
INSERT INTO `wym_mscode` VALUES ('50', '13025987659', '430810', '1585192292', '0', '1585192892');
INSERT INTO `wym_mscode` VALUES ('51', '18888888888', '558315', '1590654618', '0', '1590655218');
INSERT INTO `wym_mscode` VALUES ('52', '18888888888', '594079', '1590654649', '0', '1590655249');
INSERT INTO `wym_mscode` VALUES ('53', '13377653534', '168681', '1590681220', '0', '1590681820');
INSERT INTO `wym_mscode` VALUES ('54', '13377653534', '396013', '1590681224', '0', '1590681824');
INSERT INTO `wym_mscode` VALUES ('55', '15710029343', '621396', '1590997235', '0', '1590997835');
INSERT INTO `wym_mscode` VALUES ('56', '15710029343', '798816', '1590998316', '0', '1590998916');
INSERT INTO `wym_mscode` VALUES ('57', '13568000432', '165429', '1593663885', '0', '1593664485');
INSERT INTO `wym_mscode` VALUES ('58', '13568000432', '927821', '1593663888', '0', '1593664488');

-- ----------------------------
-- Table structure for wym_news
-- ----------------------------
DROP TABLE IF EXISTS `wym_news`;
CREATE TABLE `wym_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `cate` tinyint(3) DEFAULT NULL COMMENT '1 系统消息 2 活动通知 3帮助中心',
  `content` text,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_news
-- ----------------------------
INSERT INTO `wym_news` VALUES ('30', '一国统一', '1', '&lt;p style=&quot;margin-top: 1em; margin-bottom: 1em; white-space: normal; padding: 0px; list-style: none; font-family: &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, &amp;quot;Microsoft YaHei UI&amp;quot;, SimSun, Arial, sans-serif; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;color: rgb(34, 34, 34); font-family: Consolas, &amp;quot;Lucida Console&amp;quot;, &amp;quot;Courier New&amp;quot;, monospace; font-size: 12px; white-space: pre-wrap; background-color: rgb(255, 255, 255);&quot;&gt;伴随着富曼链大生态启动，富曼链社群共识游戏平台《环球森林矿》升级为富曼链大生态百万共识平台&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 1em; margin-bottom: 1em; white-space: normal; padding: 0px; list-style: none; font-family: &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, &amp;quot;Microsoft YaHei UI&amp;quot;, SimSun, Arial, sans-serif; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;color: rgb(34, 34, 34); font-family: Consolas, &amp;quot;Lucida Console&amp;quot;, &amp;quot;Courier New&amp;quot;, monospace; font-size: 12px; white-space: pre-wrap; background-color: rgb(255, 255, 255);&quot;&gt;&lt;br/&gt;&lt;/span&gt;&lt;/p&gt;', '1571048401');

-- ----------------------------
-- Table structure for wym_pig_order
-- ----------------------------
DROP TABLE IF EXISTS `wym_pig_order`;
CREATE TABLE `wym_pig_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) DEFAULT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '所属人ID',
  `pig_id` int(11) NOT NULL DEFAULT '0' COMMENT '宠物ID',
  `sell_id` int(11) NOT NULL DEFAULT '0' COMMENT '出售人ID',
  `source_price` decimal(65,2) DEFAULT NULL COMMENT '原出售价格',
  `price` decimal(65,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '订单状态 0未付款 1已付款 2已完成 3已取消',
  `voucher` varchar(255) DEFAULT NULL COMMENT '付款凭证',
  `pig_name` varchar(255) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `point_id` int(11) DEFAULT NULL,
  `is_lock` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_pig_order
-- ----------------------------
INSERT INTO `wym_pig_order` VALUES ('1', '0x5002150931452973074', '2', '13', '1', '602.00', '602.00', '1600077423', '3', null, '怀波阿森林矿场', '1600077434', null, '0');
INSERT INTO `wym_pig_order` VALUES ('2', '0x1101267403902011216', '2', '13', '0', null, '698.32', '1610336409', '0', null, '怀波阿森林矿场', null, null, '0');

-- ----------------------------
-- Table structure for wym_question
-- ----------------------------
DROP TABLE IF EXISTS `wym_question`;
CREATE TABLE `wym_question` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT NULL,
  `user_id` int(10) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `imgs` varchar(255) DEFAULT NULL,
  `reply` varchar(255) DEFAULT NULL,
  `publish_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_question
-- ----------------------------
INSERT INTO `wym_question` VALUES ('1', '5', '2', '15710029343', '线上客服没有返回按钮', 'public/uploads/paycode/2019102415453294813.jpeg', null, '1571903133');

-- ----------------------------
-- Table structure for wym_recharge_mode
-- ----------------------------
DROP TABLE IF EXISTS `wym_recharge_mode`;
CREATE TABLE `wym_recharge_mode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_img` varchar(255) NOT NULL DEFAULT '',
  `wechat_img` varchar(255) DEFAULT NULL,
  `wechat_account` varchar(255) DEFAULT NULL,
  `alipay_img` varchar(255) DEFAULT NULL,
  `alipay_account` varchar(255) DEFAULT NULL,
  `status` tinyint(3) DEFAULT '0' COMMENT '是否启用 0不启用 1启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='充值方式';

-- ----------------------------
-- Records of wym_recharge_mode
-- ----------------------------
INSERT INTO `wym_recharge_mode` VALUES ('4', '/public/uploads/20190905/e1def44ceb26f10cd284f962b6a2b84e.jpg', '/public/uploads/20190719/81b42f60b077e49d57cafb9c31637f2e.jpg', 'peihaos', '/public/uploads/20190719/fd428f4f34fe9ccd774cac6c9f8bfefc.jpg', 'peihaos', '0');

-- ----------------------------
-- Table structure for wym_shensu
-- ----------------------------
DROP TABLE IF EXISTS `wym_shensu`;
CREATE TABLE `wym_shensu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单号',
  `content` varchar(255) DEFAULT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '申诉状态 0处理中 1已处理',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `username` varchar(255) NOT NULL DEFAULT '',
  `pig_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='申诉';

-- ----------------------------
-- Records of wym_shensu
-- ----------------------------

-- ----------------------------
-- Table structure for wym_sign
-- ----------------------------
DROP TABLE IF EXISTS `wym_sign`;
CREATE TABLE `wym_sign` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `money` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='签到记录表';

-- ----------------------------
-- Records of wym_sign
-- ----------------------------

-- ----------------------------
-- Table structure for wym_slide
-- ----------------------------
DROP TABLE IF EXISTS `wym_slide`;
CREATE TABLE `wym_slide` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '轮播图名称',
  `description` varchar(255) DEFAULT '' COMMENT '说明',
  `link` varchar(255) DEFAULT '' COMMENT '链接',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `image` varchar(255) DEFAULT '' COMMENT '轮播图片',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态  1 显示  0  隐藏',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='轮播图表';

-- ----------------------------
-- Records of wym_slide
-- ----------------------------
INSERT INTO `wym_slide` VALUES ('3', '3', '11', '11', '', '', '/uploads/20180918/a7f82e1351b0ba0c176995ecd9b332cc.png', '1', '1');
INSERT INTO `wym_slide` VALUES ('4', '3', '22', '222', '', '', '/uploads/20180918/b992fdcbd899df634191e31dab2c473b.png', '1', '2');
INSERT INTO `wym_slide` VALUES ('5', '5', '线下商铺首页1', '', '', '', '/uploads/20180918/5055dbc96fb1efc23aace116085a06ef.jpg', '1', '2');
INSERT INTO `wym_slide` VALUES ('6', '5', '线下商铺首页2', '', '', '', '/uploads/20180918/664c71aece004c11b4557fb03ed812ac.jpg', '1', '0');

-- ----------------------------
-- Table structure for wym_slide_category
-- ----------------------------
DROP TABLE IF EXISTS `wym_slide_category`;
CREATE TABLE `wym_slide_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '轮播图分类',
  `title` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='轮播图分类表';

-- ----------------------------
-- Records of wym_slide_category
-- ----------------------------
INSERT INTO `wym_slide_category` VALUES ('3', 'index', '首页分类');
INSERT INTO `wym_slide_category` VALUES ('4', 'shop_index', '商城首页轮播');
INSERT INTO `wym_slide_category` VALUES ('5', 'store_index', '线下商铺首页');

-- ----------------------------
-- Table structure for wym_suggest
-- ----------------------------
DROP TABLE IF EXISTS `wym_suggest`;
CREATE TABLE `wym_suggest` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `content` text,
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_suggest
-- ----------------------------

-- ----------------------------
-- Table structure for wym_system
-- ----------------------------
DROP TABLE IF EXISTS `wym_system`;
CREATE TABLE `wym_system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '配置项名称',
  `value` text NOT NULL COMMENT '配置项值',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of wym_system
-- ----------------------------
INSERT INTO `wym_system` VALUES ('1', 'site_config', 'a:14:{s:7:\"secpass\";s:2:\"on\";s:10:\"site_title\";s:6:\"矿产\";s:9:\"login_img\";s:61:\"/public/uploads/20200313/5fe8cf1d144b14c95e83c45461965528.png\";s:6:\"bg_img\";s:61:\"/public/uploads/20200313/f5346b9209b668ada58d8d55365b56b8.jpg\";s:6:\"hb_img\";s:61:\"/public/uploads/20200313/6df4b0f47f82d06a87d64ad329fc35d6.jpg\";s:9:\"index_img\";s:61:\"/public/uploads/20200313/d4159865f01db42b246a6e89b14bb90b.png\";s:10:\"banner_img\";s:61:\"/public/uploads/20200313/04080b69719f54e88b7229cf2bede8d6.png\";s:11:\"api_account\";s:9:\"qukuaigou\";s:12:\"api_password\";s:8:\"102030.0\";s:8:\"sms_sign\";s:0:\"\";s:11:\"app_android\";s:8:\"https://\";s:7:\"app_ios\";s:50:\"itms-services://?action=download-manifest&amp;url=\";s:4:\"open\";s:2:\"on\";s:7:\"content\";s:12:\"维护中...\";}');
INSERT INTO `wym_system` VALUES ('2', 'price_config', 'a:5:{s:4:\"vpay\";a:3:{i:0;s:6:\"1.0000\";i:1;s:6:\"1.0000\";i:2;s:6:\"1.0000\";}s:3:\"btc\";a:3:{i:0;s:10:\"44133.0000\";i:1;s:10:\"44579.0000\";i:2;s:10:\"44002.0000\";}s:3:\"ltc\";a:3:{i:0;s:8:\"389.0000\";i:1;s:8:\"398.0000\";i:2;s:8:\"363.0000\";}s:3:\"eth\";a:3:{i:0;s:9:\"1492.0000\";i:1;s:9:\"1531.0000\";i:2;s:9:\"1463.0000\";}s:8:\"gogecoin\";a:3:{i:0;s:6:\"0.0394\";i:1;s:6:\"0.0395\";i:2;s:6:\"0.0395\";}}');
INSERT INTO `wym_system` VALUES ('3', 'profit_config', 'a:14:{s:4:\"jtsf\";s:3:\"0.2\";s:7:\"jtsf_on\";s:2:\"on\";s:11:\"ztjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"ztjs_scale\";a:4:{i:0;s:1:\"7\";i:1;s:1:\"8\";i:2;s:1:\"9\";i:3;s:2:\"10\";}s:13:\"zt_generation\";a:5:{i:0;s:1:\"3\";i:1;s:1:\"6\";i:2;s:1:\"9\";i:3;s:2:\"12\";i:4;s:2:\"15\";}s:2:\"zt\";a:5:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";}s:11:\"tdjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"tdjs_scale\";a:4:{i:0;s:1:\"1\";i:1;s:3:\"1.5\";i:2;s:1:\"2\";i:3;s:1:\"3\";}s:11:\"jdjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"jdjs_scale\";a:4:{i:0;s:1:\"1\";i:1;s:3:\"1.5\";i:2;s:1:\"2\";i:3;s:1:\"3\";}s:11:\"ltjs_invest\";a:4:{i:0;s:4:\"1500\";i:1;s:5:\"60000\";i:2;s:6:\"200000\";i:3;s:7:\"1000000\";}s:10:\"ltjs_scale\";a:4:{i:0;s:3:\"0.4\";i:1;s:3:\"0.5\";i:2;s:3:\"0.6\";i:3;s:3:\"0.7\";}s:11:\"ltjl_invest\";s:7:\"1000000\";s:10:\"ltjl_scale\";s:1:\"8\";}');
INSERT INTO `wym_system` VALUES ('4', 'base_config', 'a:28:{s:11:\"firt_parent\";s:1:\"8\";s:13:\"second_parent\";s:1:\"3\";s:12:\"third_parent\";s:1:\"5\";s:9:\"dog_price\";s:3:\"0.5\";s:7:\"pig_sxf\";s:1:\"5\";s:8:\"doge_sxf\";s:2:\"10\";s:7:\"jk_open\";s:2:\"on\";s:12:\"jk_open_time\";s:4:\"3600\";s:10:\"pay_points\";s:1:\"5\";s:9:\"split_num\";s:1:\"2\";s:17:\"zc_integral_limit\";s:5:\"15000\";s:14:\"qiangdan_limit\";s:12:\"999999999999\";s:5:\"wf_nb\";s:1:\"1\";s:8:\"wf_lownb\";s:2:\"50\";s:11:\"cancel_time\";s:4:\"7200\";s:10:\"enter_time\";s:4:\"7200\";s:13:\"sell_end_time\";s:4:\"7200\";s:8:\"sell_min\";s:3:\"200\";s:8:\"sell_num\";s:1:\"1\";s:13:\"sare_sell_min\";s:3:\"200\";s:13:\"sare_sell_max\";s:5:\"15000\";s:13:\"sare_sell_num\";s:1:\"1\";s:13:\"team_sell_min\";s:3:\"200\";s:13:\"team_sell_max\";s:5:\"15000\";s:13:\"team_sell_num\";s:1:\"1\";s:11:\"zc_sell_min\";s:3:\"200\";s:11:\"zc_sell_max\";s:5:\"15000\";s:11:\"zc_sell_num\";s:1:\"1\";}');
INSERT INTO `wym_system` VALUES ('5', 'ub_config', 'a:6:{s:10:\"ubj_invest\";a:4:{i:0;s:3:\"100\";i:1;s:4:\"1000\";i:2;s:4:\"5000\";i:3;s:5:\"10000\";}s:9:\"ubj_scale\";a:4:{i:0;s:3:\"0.1\";i:1;s:3:\"0.1\";i:2;s:3:\"0.2\";i:3;s:3:\"0.3\";}s:9:\"zj_invest\";a:4:{i:0;s:3:\"100\";i:1;s:4:\"1000\";i:2;s:4:\"5000\";i:3;s:5:\"10000\";}s:8:\"zj_scale\";a:4:{i:0;s:3:\"0.1\";i:1;s:3:\"0.1\";i:2;s:3:\"0.2\";i:3;s:3:\"0.3\";}s:11:\"team_invest\";a:4:{i:0;s:3:\"100\";i:1;s:4:\"1000\";i:2;s:4:\"5000\";i:3;s:5:\"10000\";}s:10:\"team_scale\";a:4:{i:0;s:4:\"0.01\";i:1;s:4:\"0.01\";i:2;s:4:\"0.02\";i:3;s:4:\"0.03\";}}');

-- ----------------------------
-- Table structure for wym_task_config
-- ----------------------------
DROP TABLE IF EXISTS `wym_task_config`;
CREATE TABLE `wym_task_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL COMMENT '等级名称',
  `cycle` int(11) NOT NULL DEFAULT '0' COMMENT '任务周期',
  `min_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最小价值',
  `max_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最大价值',
  `contract_revenue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '只能合约收益',
  `doge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'DOGE收益',
  `pig` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'PIG收益',
  `pay_points` varchar(255) NOT NULL DEFAULT '' COMMENT '预约积分',
  `qiang_points` varchar(255) DEFAULT '' COMMENT '即抢积分',
  `img` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) NOT NULL DEFAULT '' COMMENT '领养开始时间',
  `end_time` varchar(255) DEFAULT NULL COMMENT '领养结束时间',
  `selled_stock` int(4) DEFAULT '0' COMMENT '已放库存',
  `max_stock` int(4) DEFAULT NULL COMMENT '最大库存',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态 1开启 0关闭',
  `is_open` tinyint(3) NOT NULL DEFAULT '0' COMMENT '今日是否开过奖 0未开奖 1已开奖',
  `is_flush_open` tinyint(3) DEFAULT '0' COMMENT '今日抢购是否开过奖 0未开奖 1已开奖',
  `is_reward` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1注册赠送',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='任务配置';

-- ----------------------------
-- Records of wym_task_config
-- ----------------------------
INSERT INTO `wym_task_config` VALUES ('20', '丹翠雨林矿场', '2', '1', '1200.00', '2800.00', '15.00', '5.00', '3.00', '2', '3', '/public/uploads/20200313/aefd1d05fde5cc4c38b3c74777c7379e.png', '16:00', '19:35', '0', '888', '1', '0', '0', '0');
INSERT INTO `wym_task_config` VALUES ('12', '狐尾松古森林矿场', '橙', '1', '200.00', '600.00', '21.00', '5.00', '9.00', '1', '2', '/public/uploads/20200313/2ffe50a0bb0c1345ff3d963f0ea15bb5.png', '17:34', '22:05', '0', '888', '1', '0', '0', '0');
INSERT INTO `wym_task_config` VALUES ('13', '怀波阿森林矿场', '黃', '1', '600.00', '1200.00', '16.00', '4.00', '7.00', '15', '30', '/public/uploads/20200313/f3772c39599139873778b983dfb63c41.png', '17:55', '21:37', '0', '888', '1', '0', '0', '0');
INSERT INTO `wym_task_config` VALUES ('14', '普通宠物狗', '4', '1', '2800.00', '6800.00', '5.00', '3.00', '5.00', '10', '20', '/public/uploads/20200313/af96c20480fd82241155406534ba92dc.png', '09:20', '09:30', '0', '888', '1', '0', '0', '0');
INSERT INTO `wym_task_config` VALUES ('16', '亚马逊森林矿场', '紫', '1', '6800.00', '15000.00', '15.00', '1.00', '1.00', '5', '10', '/public/uploads/20200313/cba732b5df4807e08b4a78c431fd2a4a.png', '18:15', '23:30', '0', '888', '1', '0', '0', '0');
INSERT INTO `wym_task_config` VALUES ('21', '猴面包树森林矿场', '1', '1', '3001.00', '5000.00', '100.00', '100.00', '100.00', '10', '20', '/public/uploads/20200313/f32381956283b18692694bd58d8d6fb5.png', '16:27', '20:52', '0', '999', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for wym_tixian
-- ----------------------------
DROP TABLE IF EXISTS `wym_tixian`;
CREATE TABLE `wym_tixian` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `mobile` char(11) NOT NULL DEFAULT '',
  `currency` varchar(255) DEFAULT '' COMMENT '币种',
  `wallet_address` varchar(255) NOT NULL DEFAULT '' COMMENT '钱包地址',
  `num` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '提币数目',
  `tx_rate` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '提现手续费',
  `realmoney` varchar(10) DEFAULT '' COMMENT '到账金额',
  `sxf` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '手续',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '0审核1通过2拒绝',
  `create_time` varchar(255) DEFAULT NULL,
  `examine_time` varchar(255) DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_tixian
-- ----------------------------
INSERT INTO `wym_tixian` VALUES ('1', '2', '15710029343', 'money', '', '493.00', '0.00', '493', '0.00', '1', '1600079098', '1600079837');

-- ----------------------------
-- Table structure for wym_user
-- ----------------------------
DROP TABLE IF EXISTS `wym_user`;
CREATE TABLE `wym_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `pay_password` char(32) DEFAULT NULL,
  `ulevel` int(5) DEFAULT '0' COMMENT '会员等级',
  `head_img` varchar(255) DEFAULT '' COMMENT '头像',
  `nickname` varchar(255) NOT NULL,
  `mobile` varchar(11) DEFAULT '' COMMENT '手机',
  `email` varchar(50) DEFAULT '' COMMENT '邮箱',
  `totalmoney` decimal(65,2) DEFAULT '0.00' COMMENT '累计收益',
  `share_integral` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '推广收益',
  `pay_points` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '微分',
  `contract_revenue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合约收益',
  `money` decimal(10,2) NOT NULL,
  `pig` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'PIG币',
  `doge` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'DOGE币',
  `rc_count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计充值',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态  1 正常  2 禁止',
  `trade_order` int(11) NOT NULL DEFAULT '1' COMMENT '排单序号 0 不排单 1正常排单',
  `credit_score` int(11) NOT NULL DEFAULT '100' COMMENT '信用积分',
  `create_time` int(13) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `reg_ip` varchar(255) DEFAULT NULL,
  `last_login_time` int(13) NOT NULL DEFAULT '0' COMMENT '最后登陆时间',
  `last_login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `total_share_integral` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_nb` int(1) DEFAULT '0' COMMENT '是否内部帐号',
  `team_integral` decimal(12,2) DEFAULT '0.00' COMMENT '团队收益',
  `zc_integral` decimal(12,2) DEFAULT '0.00' COMMENT '收益转存',
  `is_Active` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of wym_user
-- ----------------------------
INSERT INTO `wym_user` VALUES ('1', '18888888888', 'd97986b84950f0213ebc5c4e2bca288a', 'd97986b84950f0213ebc5c4e2bca288a', '0', '', '啊哈哈', '18888888888', '', '0.00', '8.56', '6209', '0.00', '5007.00', '0', '0', '0.00', '1', '1', '100', '1569254958', '221.218.208.145', '1610348593', '127.0.0.1', '1.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('2', '15710029343', 'd97986b84950f0213ebc5c4e2bca288a', 'd97986b84950f0213ebc5c4e2bca288a', '2', '', 'zhao1996522', '15710029343', '', '203.36', '0.00', '99676', '0.00', '7105.00', '161', '51', '0.00', '1', '1', '100', '1569255015', '221.218.208.145', '1600078426', '171.15.63.177', '0.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('3', '13100550006', 'd97986b84950f0213ebc5c4e2bca288a', 'a72a7bf267e388953b3dac2982bc1d0c', '0', '', '蓝月', '13100550006', '', '0.00', '0.00', '5', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1570335521', '115.203.57.54', '1570335604', '115.203.57.54', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('4', '13641493293', 'd97986b84950f0213ebc5c4e2bca288a', 'a72a7bf267e388953b3dac2982bc1d0c', '0', '', '空白', '13641493293', '', '0.00', '0.00', '1088', '0.00', '0.00', '7', '0', '0.00', '1', '1', '100', '1570687848', '117.136.88.23', '1570971562', '61.158.147.68', '0.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('5', '15221935528', 'd97986b84950f0213ebc5c4e2bca288a', 'd97986b84950f0213ebc5c4e2bca288a', '0', '', 'stevej', '15221935528', '', '0.00', '0.00', '505', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1571046088', '223.104.212.7', '1571814042', '106.33.22.197', '0.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('6', '15901873403', 'd97986b84950f0213ebc5c4e2bca288a', 'd97986b84950f0213ebc5c4e2bca288a', '0', '', 'steve', '15901873403', '', '0.00', '0.00', '450', '0.00', '0.00', '16', '0', '0.00', '1', '1', '100', '1571047834', '117.136.8.107', '1571212337', '223.104.213.14', '0.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('7', '18866668888', 'd97986b84950f0213ebc5c4e2bca288a', null, '0', '', 'fang', '18866668888', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1571153434', '183.145.79.196', '1571153465', '183.145.79.196', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('8', '14776114977', '68b84fde5265280503b21522bb78b391', null, '0', '', 'Colin', '14776114977', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1571514002', '113.83.195.56', '1571514023', '113.83.195.56', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('9', '13800000000', 'd97986b84950f0213ebc5c4e2bca288a', null, '0', '', '1', '13800000000', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1571626900', '223.74.75.5', '1571627537', '113.87.183.224', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('10', '18222222222', 'd97986b84950f0213ebc5c4e2bca288a', 'a72a7bf267e388953b3dac2982bc1d0c', '0', '', '18222222222', '18222222222', '', '0.00', '0.00', '77', '0.00', '0.00', '8', '0', '0.00', '0', '1', '100', '1573698300', '106.113.189.60', '1585706733', '113.109.219.125', '0.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('11', '17754595359', '3c2caf601e0f0c933ce752c3951272da', null, '0', '', 'Qq', '17754595359', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1574421243', '171.111.6.144', '1574421263', '171.111.6.144', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('12', '13558021658', 'd97986b84950f0213ebc5c4e2bca288a', null, '0', '', '1', '13558021658', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1574421723', '171.111.6.144', '0', '', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('13', '18667106645', 'd97986b84950f0213ebc5c4e2bca288a', null, '0', '', '小蝌蚪', '18667106645', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1574653237', '183.250.76.108', '1585122491', '183.194.170.29', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('14', '18668215221', 'd97986b84950f0213ebc5c4e2bca288a', null, '0', '', 'ziyouyun', '18668215221', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1576563390', '112.14.137.190', '1576565260', '124.160.218.11', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('15', '18889177984', 'd97986b84950f0213ebc5c4e2bca288a', 'a72a7bf267e388953b3dac2982bc1d0c', '0', '', 'aaa ', '18889177984', '', '0.00', '1331.00', '988', '0.00', '0.00', '8', '0', '0.00', '1', '1', '100', '1582025472', '117.136.13.98', '1585616837', '113.65.146.232', '0.00', '0', '1400.00', '1000.00', '1');
INSERT INTO `wym_user` VALUES ('16', '18508939485', 'ffaa9bfd6c4bbe83371114c3d54d73b9', '7a0dcb9ab65282f28cd8f6cbc941ad6a', '0', '', '这是什么', '18508939485', '', '0.00', '0.00', '5', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1582026134', '113.96.219.247', '1582026231', '223.104.23.84', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('17', '18889177983', 'd97986b84950f0213ebc5c4e2bca288a', 'd97986b84950f0213ebc5c4e2bca288a', '0', '', '晚点去无多', '18889177983', '', '0.00', '0.00', '1060', '0.00', '0.00', '7', '0', '0.00', '1', '1', '100', '1582083480', '117.136.13.98', '1610440733', '127.0.0.1', '0.00', '0', '0.00', '0.00', '1');
INSERT INTO `wym_user` VALUES ('18', '13025987659', 'd97986b84950f0213ebc5c4e2bca288a', 'd97986b84950f0213ebc5c4e2bca288a', '0', '', '982304227', '13025987659', '', '0.00', '0.00', '5', '0.00', '0.00', '0', '90', '0.00', '1', '1', '100', '1585192438', '117.183.245.87', '1610500416', '127.0.0.1', '0.00', '0', '0.00', '0.00', '0');
INSERT INTO `wym_user` VALUES ('19', '13800138000', 'd97986b84950f0213ebc5c4e2bca288a', null, '0', '', '1', '13800138000', '', '0.00', '0.00', '0', '0.00', '0.00', '0', '0', '0.00', '1', '1', '100', '1593585728', '117.90.141.9', '1610437131', '127.0.0.1', '0.00', '0', '0.00', '0.00', '0');

-- ----------------------------
-- Table structure for wym_user_level
-- ----------------------------
DROP TABLE IF EXISTS `wym_user_level`;
CREATE TABLE `wym_user_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` tinyint(3) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '级别名',
  `cnt` int(11) NOT NULL DEFAULT '0',
  `money` int(11) DEFAULT NULL,
  `ratio` int(11) DEFAULT NULL COMMENT '团队奖励',
  `add_sell_num` int(11) DEFAULT '0' COMMENT '增加每日出售限制',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_user_level
-- ----------------------------
INSERT INTO `wym_user_level` VALUES ('1', '2', '高级会员', '15', '500', '1', '0');
INSERT INTO `wym_user_level` VALUES ('2', '3', '顶级会员', '30', '3000', '3', '0');
INSERT INTO `wym_user_level` VALUES ('3', '4', '高级合伙人', '60', '5000', '5', '0');
INSERT INTO `wym_user_level` VALUES ('4', '1', '中级会员', '0', '50', '0', '0');
INSERT INTO `wym_user_level` VALUES ('5', '0', '初级会员', '0', '0', '0', '0');
INSERT INTO `wym_user_level` VALUES ('7', '5', '超级合伙人', '100', '10000', '6', '0');
INSERT INTO `wym_user_level` VALUES ('8', '6', '钻石合伙人', '150', '15000', '7', '0');
INSERT INTO `wym_user_level` VALUES ('9', '7', '铂金合伙人', '200', '20000', '8', '0');

-- ----------------------------
-- Table structure for wym_user_payment
-- ----------------------------
DROP TABLE IF EXISTS `wym_user_payment`;
CREATE TABLE `wym_user_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支付方式 1支付宝 2微信 3银行卡',
  `account` varchar(255) DEFAULT NULL COMMENT '账号',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '收款人名称',
  `qrcode_url` varchar(255) DEFAULT NULL COMMENT '收款码',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '银行名称',
  `branch_name` varchar(255) DEFAULT NULL COMMENT '支行名称',
  `uid` int(11) NOT NULL DEFAULT '0',
  `mobile` char(11) NOT NULL DEFAULT '',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_user_payment
-- ----------------------------
INSERT INTO `wym_user_payment` VALUES ('1', '1', '18888888888', '测试', '/public/uploads/paycode/2019092400110443991.jpeg', null, null, '2', '15710029343', '0', '1569255079');
INSERT INTO `wym_user_payment` VALUES ('2', '3', 'zz12222', '11', null, '中国银行', '11', '2', '15710029343', '0', '1569255119');
INSERT INTO `wym_user_payment` VALUES ('3', '2', '359333', '空白', '/public/uploads/paycode/2019101014151530546.jpeg', null, null, '4', '13641493293', '0', '1570688134');
INSERT INTO `wym_user_payment` VALUES ('4', '1', '359331', '333355', '/public/uploads/paycode/2019101014163368736.jpeg', null, null, '4', '13641493293', '0', '1570688205');
INSERT INTO `wym_user_payment` VALUES ('5', '3', '4346481649', '会叫你', null, '中国银行', '黄柠檬', '4', '13641493293', '0', '1570688224');
INSERT INTO `wym_user_payment` VALUES ('6', '2', '15221935528', '王林', '/public/uploads/paycode/2019101417434738735.png', null, null, '5', '15221935528', '0', '1571046251');
INSERT INTO `wym_user_payment` VALUES ('7', '1', '15221935528', '王林', '/public/uploads/paycode/2019101417442256518.png', null, null, '5', '15221935528', '0', '1571046285');
INSERT INTO `wym_user_payment` VALUES ('8', '3', '6214852108084009', '王林', null, '招商银行', '广东支行', '5', '15221935528', '0', '1571046340');
INSERT INTO `wym_user_payment` VALUES ('9', '1', '15901873403', '王思', '/public/uploads/paycode/2019101418115345532.png', null, null, '6', '15901873403', '0', '1571047920');
INSERT INTO `wym_user_payment` VALUES ('10', '2', '15901873403', '王思', '/public/uploads/paycode/2019101418121188364.png', null, null, '6', '15901873403', '0', '1571047948');
INSERT INTO `wym_user_payment` VALUES ('11', '3', '6214852108085423', '王思', null, '招商银行', '广西支行', '6', '15901873403', '0', '1571047988');
INSERT INTO `wym_user_payment` VALUES ('12', '2', '555', '3333', '/public/uploads/paycode/2019111410275282861.png', null, null, '10', '18222222222', '0', '1573698480');
INSERT INTO `wym_user_payment` VALUES ('13', '3', '512315421232112', '张浩', null, '中国银行', '天行', '10', '18222222222', '0', '1573698520');
INSERT INTO `wym_user_payment` VALUES ('14', '3', '34567', '小森', null, '中国银行', '456758889958885895', '11', '17754595359', '0', '1574421822');
INSERT INTO `wym_user_payment` VALUES ('15', '2', '188754848', '1691848', '/public/uploads/paycode/2020021819325892416.jpeg', null, null, '15', '18889177984', '0', '1582025691');
INSERT INTO `wym_user_payment` VALUES ('16', '3', '154875488', '4218946461', null, '中国银行', '中国', '15', '18889177984', '0', '1582025743');
INSERT INTO `wym_user_payment` VALUES ('17', '3', '1584545', '1349488', null, '中国银行', '中国', '17', '18889177983', '0', '1582083591');
INSERT INTO `wym_user_payment` VALUES ('18', '1', '233445', 'fdds', '/public/uploads/paycode/2020052816301625539.png', null, null, '1', '18888888888', '0', '1590654623');
INSERT INTO `wym_user_payment` VALUES ('19', '3', '53465474554353453', '会让', null, '中国银行', '建行', '1', '18888888888', '0', '1590654655');
INSERT INTO `wym_user_payment` VALUES ('21', '2', 'dsasada', 'sadasa', '/public/uploads/paycode/2020060115584986100.png', null, null, '2', '15710029343', '0', '1590998337');

-- ----------------------------
-- Table structure for wym_user_pigs
-- ----------------------------
DROP TABLE IF EXISTS `wym_user_pigs`;
CREATE TABLE `wym_user_pigs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `pig_id` varchar(255) DEFAULT NULL COMMENT '猪ID',
  `pig_name` varchar(255) NOT NULL DEFAULT '',
  `pig_no` varchar(255) NOT NULL DEFAULT '0' COMMENT '宠物编号',
  `price` decimal(65,2) DEFAULT NULL COMMENT '价格',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态 0 不可出售 1可出售 3 等待付款',
  `point_id` int(11) NOT NULL DEFAULT '0' COMMENT '指向ID',
  `from_id` int(11) NOT NULL DEFAULT '0' COMMENT '来源用户',
  `create_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `cycle` int(11) NOT NULL DEFAULT '0' COMMENT '领养周期',
  `contract_revenue` varchar(255) DEFAULT NULL COMMENT '智能合约产出率',
  `doge` decimal(65,2) NOT NULL DEFAULT '0.00' COMMENT 'DOGE产出率',
  `total_revenue` decimal(65,2) NOT NULL DEFAULT '0.00',
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户的猪';

-- ----------------------------
-- Records of wym_user_pigs
-- ----------------------------
INSERT INTO `wym_user_pigs` VALUES ('2', '2', '13', '怀波阿森林矿场', '0x2501245781940305240', '698.32', '1', '0', '1', '1600077434', '1610336409', '1', '16.00', '4.00', '96.32', '2');

-- ----------------------------
-- Table structure for wym_user_relation
-- ----------------------------
DROP TABLE IF EXISTS `wym_user_relation`;
CREATE TABLE `wym_user_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `username` varchar(100) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `pusername` varchar(100) DEFAULT NULL,
  `rel` varchar(255) NOT NULL DEFAULT '' COMMENT '推荐关系字符集',
  `create_time` int(13) NOT NULL DEFAULT '0',
  `pid2` int(11) DEFAULT NULL COMMENT '二级推荐人',
  `pid3` int(11) DEFAULT NULL COMMENT '三级推荐人',
  `cnt` int(11) NOT NULL DEFAULT '0' COMMENT '直推人数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='推荐关系表';

-- ----------------------------
-- Records of wym_user_relation
-- ----------------------------
INSERT INTO `wym_user_relation` VALUES ('1', '1', '18888888888', '0', null, ',0', '1569254958', null, null, '6');
INSERT INTO `wym_user_relation` VALUES ('2', '2', '15710029343', '1', '18888888888', ',1,0', '1569255015', '0', null, '4');
INSERT INTO `wym_user_relation` VALUES ('3', '3', '13100550006', '2', '15710029343', ',2,1,0', '1570335521', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('4', '4', '13641493293', '2', '15710029343', ',2,1,0', '1570687848', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('5', '5', '15221935528', '2', '15710029343', ',2,1,0', '1571046088', '1', null, '3');
INSERT INTO `wym_user_relation` VALUES ('6', '6', '15901873403', '5', '15221935528', ',5,2,1,0', '1571047834', '2', '1', '0');
INSERT INTO `wym_user_relation` VALUES ('7', '7', '18866668888', '5', '15221935528', ',5,2,1,0', '1571153434', '2', '1', '0');
INSERT INTO `wym_user_relation` VALUES ('8', '8', '14776114977', '1', '18888888888', ',1,0', '1571514002', '0', null, '0');
INSERT INTO `wym_user_relation` VALUES ('9', '9', '13800000000', '1', '18888888888', ',1,0', '1571626900', '0', null, '1');
INSERT INTO `wym_user_relation` VALUES ('10', '10', '18222222222', '5', '15221935528', ',5,2,1,0', '1573698300', '2', '1', '0');
INSERT INTO `wym_user_relation` VALUES ('11', '11', '17754595359', '1', '18888888888', ',1,0', '1574421243', '0', null, '2');
INSERT INTO `wym_user_relation` VALUES ('12', '12', '13558021658', '11', '17754595359', ',11,1,0', '1574421723', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('13', '13', '18667106645', '11', '17754595359', ',11,1,0', '1574653237', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('14', '14', '18668215221', '1', '18888888888', ',1,0', '1576563390', '0', null, '0');
INSERT INTO `wym_user_relation` VALUES ('15', '15', '18889177984', '1', '18888888888', ',1,0', '1582025472', '0', null, '2');
INSERT INTO `wym_user_relation` VALUES ('16', '16', '18508939485', '15', '18889177984', ',15,1,0', '1582026134', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('17', '17', '18889177983', '15', '18889177984', ',15,1,0', '1582083480', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('18', '18', '13025987659', '2', '15710029343', ',2,1,0', '1585192438', '1', null, '0');
INSERT INTO `wym_user_relation` VALUES ('19', '19', '13800138000', '9', '13800000000', ',9,1,0', '1593585728', '1', null, '0');

-- ----------------------------
-- Table structure for wym_user_reward
-- ----------------------------
DROP TABLE IF EXISTS `wym_user_reward`;
CREATE TABLE `wym_user_reward` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `from_id` int(11) NOT NULL DEFAULT '0' COMMENT '奖金来源',
  `currency` varchar(255) NOT NULL DEFAULT '' COMMENT '币种',
  `amount` decimal(65,2) NOT NULL DEFAULT '0.00' COMMENT '收益数额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '获取时间',
  `note` varchar(255) NOT NULL DEFAULT '',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '收益类型 1智能合约 2直推收益 3团队收益',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='用户奖金表';

-- ----------------------------
-- Records of wym_user_reward
-- ----------------------------
INSERT INTO `wym_user_reward` VALUES ('1', '2', '0', '', '7.00', '1569257847', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('2', '2', '0', '', '12.00', '1569258248', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('3', '4', '0', '', '7.00', '1570972186', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('4', '6', '0', '', '9.00', '1571049298', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('5', '6', '0', '', '7.00', '1571131153', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('6', '2', '0', '', '9.00', '1571661870', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('7', '10', '0', '', '3.00', '1573698771', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('8', '15', '0', '', '3.00', '1582082950', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('9', '17', '0', '', '7.00', '1582083958', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('10', '2', '0', '', '7.00', '1585121927', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('11', '2', '0', 'contract_revenue', '107.04', '1585201142', '智能合约', '1');
INSERT INTO `wym_user_reward` VALUES ('12', '2', '0', 'doge', '26.76', '1585201142', 'DOGE收益', '5');
INSERT INTO `wym_user_reward` VALUES ('13', '1', '2', 'share_integral', '8.56', '1585201142', '一代推广', '2');
INSERT INTO `wym_user_reward` VALUES ('14', '2', '0', '', '7.00', '1585547221', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('15', '15', '0', '', '5.00', '1585624861', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('16', '10', '0', '', '5.00', '1585624861', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('17', '2', '0', '', '3.00', '1600075318', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('18', '2', '0', '', '100.00', '1600075655', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('19', '2', '0', '', '9.00', '1600076218', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('20', '2', '0', '', '7.00', '1600077434', '交易奖励wia', '5');
INSERT INTO `wym_user_reward` VALUES ('21', '2', '0', 'contract_revenue', '96.32', '1610336409', '智能合约', '1');
INSERT INTO `wym_user_reward` VALUES ('22', '2', '0', 'doge', '24.08', '1610336409', 'DOGE收益', '5');

-- ----------------------------
-- Table structure for wym_wealth
-- ----------------------------
DROP TABLE IF EXISTS `wym_wealth`;
CREATE TABLE `wym_wealth` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(15) NOT NULL DEFAULT '0',
  `username` varchar(255) NOT NULL DEFAULT '0',
  `walltype` varchar(50) NOT NULL DEFAULT '0',
  `oldmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变化前的金额',
  `num` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `newmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变化后的金额',
  `mark` varchar(100) NOT NULL DEFAULT '0' COMMENT '简要说明',
  `plain` varchar(100) DEFAULT NULL COMMENT '详细说明',
  `type` tinyint(3) DEFAULT '0' COMMENT '1充值（投资money）2充值（score）3扣款4动态奖5分红6支付宝充值（投资）7余额转基金(投资)8提现（余额）9退还（余额）10扣除余额',
  `addtime` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(3) DEFAULT '0' COMMENT '0成功1失败',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='金额变动记录表';

-- ----------------------------
-- Records of wym_wealth
-- ----------------------------

-- ----------------------------
-- Table structure for wym_yuyue
-- ----------------------------
DROP TABLE IF EXISTS `wym_yuyue`;
CREATE TABLE `wym_yuyue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `pig_id` int(11) NOT NULL DEFAULT '0' COMMENT '宠物ID',
  `pay_points` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '消耗微分',
  `create_time` int(11) DEFAULT NULL COMMENT '预约时间',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态 0未开始 1中奖 2未中奖',
  `user_sort` int(11) NOT NULL DEFAULT '1' COMMENT '排单序号',
  `credit_score` int(11) NOT NULL DEFAULT '100',
  `buy_type` tinyint(3) DEFAULT '0' COMMENT '0:预约，1:抢购',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_yuyue
-- ----------------------------
INSERT INTO `wym_yuyue` VALUES ('1', '2', '20', '2.00', '1600074088', '1', '1', '100', '2');
INSERT INTO `wym_yuyue` VALUES ('2', '2', '21', '10.00', '1600075435', '1', '1', '100', '2');
INSERT INTO `wym_yuyue` VALUES ('3', '2', '12', '1.00', '1600075984', '1', '1', '100', '2');
INSERT INTO `wym_yuyue` VALUES ('4', '2', '13', '15.00', '1600077259', '1', '1', '100', '2');
INSERT INTO `wym_yuyue` VALUES ('5', '1', '20', '3.00', '1600078327', '2', '1', '100', '1');
INSERT INTO `wym_yuyue` VALUES ('6', '1', '16', '5.00', '1600078362', '0', '1', '100', '0');
INSERT INTO `wym_yuyue` VALUES ('7', '1', '21', '10.00', '1610243561', '0', '1', '100', '0');
INSERT INTO `wym_yuyue` VALUES ('8', '1', '12', '1.00', '1610243563', '0', '1', '100', '0');
INSERT INTO `wym_yuyue` VALUES ('9', '1', '14', '10.00', '1610325924', '0', '1', '100', '0');
INSERT INTO `wym_yuyue` VALUES ('10', '1', '20', '2.00', '1610331794', '2', '1', '100', '2');
INSERT INTO `wym_yuyue` VALUES ('11', '17', '21', '10.00', '1610440736', '0', '1', '100', '0');

-- ----------------------------
-- Table structure for wym_zc_order
-- ----------------------------
DROP TABLE IF EXISTS `wym_zc_order`;
CREATE TABLE `wym_zc_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `num` decimal(10,2) DEFAULT NULL COMMENT '数目',
  `username` varchar(255) DEFAULT NULL COMMENT '用户姓名',
  `mobile` varchar(255) DEFAULT NULL,
  `voucher` varchar(255) DEFAULT NULL COMMENT '支付凭证',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态 0待审核 1已审核',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '认购时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wym_zc_order
-- ----------------------------
