-- DROP TABLE IF EXISTS `character_magic_find`;

CREATE TABLE `character_magic_find` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'player guid',
  `mf` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Magic Find System';
