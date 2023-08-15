SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `vehicle_data`
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_data`;
CREATE TABLE `vehicle_data` (
  `Id` int(30) NOT NULL auto_increment,
  `flags` int(30) NOT NULL default '0',
  `moveflags` int(30) NOT NULL default '0',
  `spell1` int(30) NOT NULL default '0',
  `spell2` int(30) NOT NULL default '0',
  `spell3` int(30) NOT NULL default '0',
  `spell4` int(30) NOT NULL default '0',
  `spell5` int(30) NOT NULL default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=530 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of vehicle_data
-- ----------------------------
INSERT INTO `vehicle_data` VALUES ('1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('6', '0', '0', '71189', '47922', '60536', '56694', '70063');
INSERT INTO `vehicle_data` VALUES ('7', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('8', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('14', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('16', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('17', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('21', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('22', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('23', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('24', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('25', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('26', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('27', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('28', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('29', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('30', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('31', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('32', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('33', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('34', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('35', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('36', '0', '27', '50025', '50990', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('37', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('38', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('39', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('40', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('41', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('42', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('43', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('44', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('46', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('47', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('48', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('49', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('50', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('51', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('52', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('53', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('54', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('55', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('56', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('57', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('58', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('59', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('60', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('61', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('62', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('64', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('65', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('68', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('69', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('70', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('71', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('72', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('74', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('75', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('76', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('77', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('79', '0', '59', '52435', '52576', '0', '52588', '0');
INSERT INTO `vehicle_data` VALUES ('80', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('81', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('86', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('87', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('88', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('89', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('90', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('91', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('92', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('93', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('97', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('99', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('100', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('102', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('104', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('105', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('106', '0', '59', '50896', '50652', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('107', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('108', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('109', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('110', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('111', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('112', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('113', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('114', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('115', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('116', '0', '59', '57609', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('117', '14267', '27', '51678', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('118', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('120', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('121', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('122', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('123', '5', '0', '52268', '52264', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('124', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('125', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('126', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('127', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('128', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('129', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('130', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('131', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('132', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('134', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('135', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('137', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('138', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('139', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('142', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('143', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('145', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('146', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('147', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('148', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('149', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('150', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('152', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('153', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('154', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('156', '0', '80', '53114', '53112', '53110', '0', '0');
INSERT INTO `vehicle_data` VALUES ('158', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('160', '0', '59', '49872', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('162', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('163', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('164', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('165', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('166', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('167', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('168', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('169', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('171', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('173', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('174', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('175', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('176', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('177', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('178', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('179', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('180', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('181', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('182', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('183', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('186', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('188', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('189', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('190', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('191', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('192', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('193', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('194', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('196', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('197', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('198', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('199', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('200', '0', '59', '52264', '52268', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('201', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('202', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('203', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('204', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('205', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('206', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('207', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('208', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('209', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('210', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('211', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('212', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('213', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('214', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('215', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('216', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('217', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('218', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('219', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('220', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('221', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('222', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('223', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('224', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('225', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('226', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('227', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('228', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('229', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('230', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('231', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('232', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('233', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('234', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('236', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('237', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('238', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('240', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('241', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('242', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('243', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('244', '0', '59', '51421', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('245', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('246', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('247', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('248', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('249', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('250', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('252', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('253', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('254', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('255', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('256', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('257', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('258', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('259', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('260', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('261', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('262', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('263', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('264', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('265', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('266', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('267', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('268', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('269', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('270', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('271', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('272', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('273', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('274', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('275', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('276', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('277', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('278', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('279', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('280', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('281', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('282', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('283', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('284', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('285', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('286', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('287', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('288', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('289', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('290', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('291', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('292', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('293', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('294', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('295', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('296', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('297', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('298', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('299', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('300', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('301', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('302', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('303', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('304', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('305', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('308', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('309', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('310', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('311', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('312', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('313', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('314', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('315', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('316', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('317', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('318', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('320', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('321', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('322', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('323', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('324', '0', '27', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('325', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('327', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('328', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('329', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('331', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('332', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('335', '0', '0', '62974', '62286', '62299', '64660', '0');
INSERT INTO `vehicle_data` VALUES ('336', '0', '0', '62345', '62522', '62346', '0', '0');
INSERT INTO `vehicle_data` VALUES ('337', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('338', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('339', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('340', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('341', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('342', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('343', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('344', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('345', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('347', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('348', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('349', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('352', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('353', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('354', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('356', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('357', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('358', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('359', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('363', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('368', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('369', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('370', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('371', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('372', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('373', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('374', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('375', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('376', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('380', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('381', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('385', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('387', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('388', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('389', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('390', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('392', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('395', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('396', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('397', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('399', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('402', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('405', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('412', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('425', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('430', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('435', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('436', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('437', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('438', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('442', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('443', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('444', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('445', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('446', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('447', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('449', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('452', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('453', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('456', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('461', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('471', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('472', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('477', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('478', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('479', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('480', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('481', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('482', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('483', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('484', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('485', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('486', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('487', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('489', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('492', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('496', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('497', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('498', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('499', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('503', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('509', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('510', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('512', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('514', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_data` VALUES ('529', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `vehicle_seat_data`
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_seat_data`;
CREATE TABLE `vehicle_seat_data` (
  `vehicleId` int(5) unsigned NOT NULL default '0',
  `capacity` int(1) unsigned NOT NULL default '1',
  `seatid_0` int(1) unsigned NOT NULL default '0',
  `entry_0` int(20) unsigned NOT NULL default '0',
  `seatentry0_x` float NOT NULL default '0',
  `seatentry0_y` float NOT NULL default '0',
  `seatentry0_z` float NOT NULL default '0',
  `seatid_1` int(1) unsigned NOT NULL default '1',
  `entry_1` int(20) unsigned NOT NULL default '0',
  `seatentry1_x` float NOT NULL default '0',
  `seatentry1_y` float NOT NULL default '0',
  `seatentry1_z` float NOT NULL default '0',
  `seatid_2` int(1) unsigned NOT NULL default '2',
  `entry_2` int(20) unsigned NOT NULL default '0',
  `seatentry2_x` float NOT NULL default '0',
  `seatentry2_y` float NOT NULL default '0',
  `seatentry2_z` float NOT NULL default '0',
  `seatid_3` int(1) unsigned NOT NULL default '3',
  `entry_3` int(20) unsigned NOT NULL default '0',
  `seatentry3_x` float NOT NULL default '0',
  `seatentry3_y` float NOT NULL default '0',
  `seatentry3_z` float NOT NULL default '0',
  `seatid_4` int(1) unsigned NOT NULL default '4',
  `entry_4` int(20) unsigned NOT NULL default '0',
  `seatentry4_x` float NOT NULL default '0',
  `seatentry4_y` float NOT NULL default '0',
  `seatentry4_z` float NOT NULL default '0',
  `seatid_5` int(1) unsigned NOT NULL default '5',
  `entry_5` int(20) unsigned NOT NULL default '0',
  `seatentry5_x` float NOT NULL default '0',
  `seatentry5_y` float NOT NULL default '0',
  `seatentry5_z` float NOT NULL default '0',
  `seatid_6` int(1) unsigned NOT NULL default '6',
  `entry_6` int(20) unsigned NOT NULL default '0',
  `seatentry6_x` float NOT NULL default '0',
  `seatentry6_y` float NOT NULL default '0',
  `seatentry6_z` float NOT NULL default '0',
  `seatid_7` int(1) unsigned NOT NULL default '7',
  `entry_7` int(20) unsigned NOT NULL default '0',
  `seatentry7_x` float NOT NULL default '0',
  `seatentry7_y` float NOT NULL default '0',
  `seatentry7_z` float NOT NULL default '0',
  PRIMARY KEY  (`vehicleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of vehicle_seat_data
-- ----------------------------
INSERT INTO `vehicle_seat_data` VALUES ('0', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('1', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('6', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('7', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('8', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('14', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('16', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('17', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('21', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('22', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('23', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('24', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('25', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('26', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('27', '7', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('28', '7', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('29', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('30', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('31', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('32', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('33', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('34', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('35', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('36', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('37', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('38', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('39', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('40', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('41', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('42', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('43', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('44', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('46', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('47', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('48', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('49', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('50', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('51', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('52', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('53', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('54', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('55', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('56', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('57', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('58', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('59', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('60', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('61', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('62', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('64', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('65', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('68', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('69', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('70', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('71', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('72', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('74', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('75', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('76', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('77', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('79', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('80', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('81', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('86', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('87', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('88', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('89', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('90', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('91', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('92', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('93', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('97', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('99', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('100', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('102', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('104', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('105', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('106', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('107', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('108', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('109', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('110', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('111', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('112', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('113', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('114', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('115', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('116', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('117', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('118', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('120', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('121', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('122', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('123', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('124', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('125', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('126', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('127', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('128', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('129', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('130', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('131', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('132', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('134', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('135', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('137', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('138', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('139', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('142', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('143', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('145', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('146', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('147', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('148', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('149', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('150', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('152', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('153', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('154', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('156', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('158', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('160', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('162', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('163', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('164', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('165', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('166', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('167', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('168', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('169', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('171', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('173', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('174', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('175', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('176', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('177', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('178', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('179', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('180', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('181', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('182', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('183', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('186', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('188', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('189', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('190', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('191', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('192', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('193', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('194', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('196', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('197', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('198', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('199', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('200', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('201', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('202', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('203', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('204', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('205', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('206', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('207', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('208', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('209', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('210', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('211', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('212', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('213', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('214', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('215', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('216', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('217', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('218', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('219', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('220', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('221', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('222', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('223', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('224', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('225', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('226', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('227', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('228', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('229', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('230', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('231', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('232', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('233', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('234', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('236', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('237', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('238', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('240', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('241', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('242', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('243', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('244', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('245', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('246', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('247', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('248', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('249', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('250', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('252', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('253', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('254', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('255', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('256', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('257', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('258', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('259', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('260', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('261', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('262', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('263', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('264', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('265', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('266', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('267', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('268', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('269', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('270', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('271', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('272', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('273', '8', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('274', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('275', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('276', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('277', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('278', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('279', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('280', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('281', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('282', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('283', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('284', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('285', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('286', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('287', '8', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('288', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('289', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('290', '6', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('291', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('292', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('293', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('294', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('295', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('296', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('297', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('298', '6', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('299', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('300', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('301', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('302', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('303', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('304', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('305', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('308', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('309', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('310', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('311', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('312', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('313', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('314', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('315', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('316', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('317', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('318', '2', '0', '0', '0', '0', '0', '0', '0', '-0.552734', '0.894775', '0.000473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('320', '7', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('321', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('322', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('323', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('324', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('325', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('327', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('328', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('329', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('331', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('332', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('335', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('336', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('337', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('338', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('339', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('340', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('341', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('342', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('343', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('344', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('345', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('347', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('348', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('349', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('352', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('353', '8', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('354', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('356', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('357', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('358', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('359', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('363', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('368', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('369', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('370', '8', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('371', '7', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('372', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('373', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('374', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('375', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('376', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('380', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('381', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('385', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('387', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('388', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('389', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('390', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('392', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('395', '6', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('396', '8', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('397', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('399', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('402', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('405', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('412', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('425', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('430', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('435', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('436', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('437', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('438', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('442', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('443', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('444', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('445', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('446', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('447', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('449', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('452', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('453', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('456', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('461', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('471', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('472', '5', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('477', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('478', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('479', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('480', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('481', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('482', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('483', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('484', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('485', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('486', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('487', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('489', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('492', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('496', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('497', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('498', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('499', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('503', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('509', '3', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('510', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('512', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('514', '4', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');
INSERT INTO `vehicle_seat_data` VALUES ('529', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '2', '0', '0', '0', '0', '3', '0', '0', '0', '0', '4', '0', '0', '0', '0', '5', '0', '0', '0', '0', '6', '0', '0', '0', '0', '7', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `vehicle_staticpassengers`
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_staticpassengers`;
CREATE TABLE `vehicle_staticpassengers` (
  `spawnid` int(20) NOT NULL default '0',
  `parentspawnid` int(20) unsigned NOT NULL default '0',
  `seatid` int(1) unsigned NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `flags` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`spawnid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of vehicle_staticpassengers
-- ----------------------------

alter table `creature_proto` add column `vehicleid` int UNSIGNED DEFAULT '0' NOT NULL after `summonguard`;

UPDATE creature_proto SET vehicleid='336' WHERE entry='33060';
UPDATE creature_proto SET npcflags='16777216' WHERE entry='33060';
UPDATE creature_spawns SET flags='16777216' WHERE entry='33060';

UPDATE creature_proto SET vehicleid='36' WHERE entry='33109';
UPDATE creature_proto SET npcflags='16777216' WHERE entry='33109';
UPDATE creature_spawns SET flags='16777216' WHERE entry='33109';