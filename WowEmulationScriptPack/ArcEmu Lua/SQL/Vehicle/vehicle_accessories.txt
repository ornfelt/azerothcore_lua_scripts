CREATE TABLE `vehicle_accessories` (
  `creature_entry` int(10) unsigned NOT NULL DEFAULT '0',
  `accessory_entry` int(10) unsigned NOT NULL DEFAULT '0',
  `seat` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`creature_entry`,`accessory_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

UPDATE `arcemu_db_version` SET `LastUpdate` = '4553';