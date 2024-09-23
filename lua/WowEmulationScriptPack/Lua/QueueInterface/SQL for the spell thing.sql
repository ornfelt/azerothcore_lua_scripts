--Char DB
CREATE TABLE `character_perks` (
  `GUID` int(10) unsigned NOT NULL,
  `perk1` int(11) NOT NULL DEFAULT '0',
  `perk2` int(11) NOT NULL DEFAULT '0',
  `perk3` int(11) NOT NULL DEFAULT '0',
  `perk4` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`GUID`)
)