/*
Navicat MySQL Data Transfer

Source Server         : 腾讯云
Source Server Version : 50648
Source Host           : 81.68.220.149:3306
Source Database       : 8899

Target Server Type    : MYSQL
Target Server Version : 50648
File Encoding         : 65001

Date: 2021-01-18 17:13:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wym_pay_order
-- ----------------------------
DROP TABLE IF EXISTS `wym_pay_order`;
CREATE TABLE `wym_pay_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `pay_id` int(11) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `pay_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1支付宝2微信3qq',
  `wallet` varchar(255) NOT NULL,
  `ext` varchar(255) NOT NULL,
  `w_time` int(10) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `pay_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
