USE acore_world;

DROP TABLE IF EXISTS `custom_xp`;
CREATE TABLE IF NOT EXISTS `custom_xp` (
  `CharID` int unsigned NOT NULL,
  `Rate` float unsigned NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
