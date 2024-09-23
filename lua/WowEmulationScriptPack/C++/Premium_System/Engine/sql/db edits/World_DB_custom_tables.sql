DROP TABLE IF EXISTS `premium_locations`;
CREATE TABLE IF NOT EXISTS `premium_locations` (
  `team_id` tinyint(1) unsigned NOT NULL,
  `map_id` mediumint(8) unsigned NOT NULL,
  `x` float unsigned NOT NULL,
  `y` float unsigned NOT NULL,
  `z` float unsigned NOT NULL,
  `o` float unsigned NOT NULL,
  UNIQUE KEY `team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='other premium only teleport locations.\r\ntype 0 = premium only location\r\ntype 1 = public location';
DELETE FROM `premium_locations`;


DROP TABLE IF EXISTS `premium_mall_locations`;
CREATE TABLE IF NOT EXISTS `premium_mall_locations` (
  `team_id` tinyint(1) unsigned NOT NULL,
  `map_id` mediumint(8) unsigned NOT NULL,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  UNIQUE KEY `team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DELETE FROM `premium_mall_locations`;


DROP TABLE IF EXISTS `premium_public_mall_locations`;
CREATE TABLE IF NOT EXISTS `premium_public_mall_locations` (
  `team_id` tinyint(1) unsigned NOT NULL,
  `map_id` mediumint(8) unsigned NOT NULL,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  UNIQUE KEY `team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DELETE FROM `premium_public_mall_locations`;


DROP TABLE IF EXISTS `premium_player_teleports`;
CREATE TABLE IF NOT EXISTS `premium_player_teleports` (
  `guid` mediumint(8) unsigned NOT NULL,
  `map_id` mediumint(8) unsigned NOT NULL,
  `x` float unsigned NOT NULL,
  `y` float unsigned NOT NULL,
  `z` float unsigned NOT NULL,
  `o` float unsigned NOT NULL,
  UNIQUE KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DELETE FROM `premium_player_teleports`;


DROP TABLE IF EXISTS `premium_team_teleports`;
CREATE TABLE IF NOT EXISTS `premium_team_teleports` (
  `team_id` tinyint(3) unsigned NOT NULL,
  `map_id` mediumint(8) unsigned NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `o` float NOT NULL,
  UNIQUE KEY `team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DELETE FROM `premium_team_teleports`;

INSERT INTO `premium_team_teleports` (`team_id`, `map_id`, `x`, `y`, `z`, `o`) VALUES
	(0, 0, -4902, -960.816, 501.459, 2.20724),
	(1, 1, 1600.98, -4378.82, 9.99832, 5.24819);