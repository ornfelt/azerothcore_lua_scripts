/*
Navicat MySQL Data Transfer

Source Server         : AzerothCore
Source Server Version : 50509
Source Host           : localhost:3306
Source Database       : world

Target Server Type    : MYSQL
Target Server Version : 50509
File Encoding         : 65001

Date: 2018-06-12 09:39:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for spellregulator
-- ----------------------------
DROP TABLE IF EXISTS `spellregulator`;
CREATE TABLE `spellregulator` (
  `spellId` int(11) unsigned NOT NULL,
  `percentage` float NOT NULL DEFAULT '100',
  PRIMARY KEY (`spellId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET FOREIGN_KEY_CHECKS=1;
