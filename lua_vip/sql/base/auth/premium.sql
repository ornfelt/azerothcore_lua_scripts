DROP TABLE IF EXISTS `premium`;

CREATE TABLE `premium` (
  `AccountId` int unsigned NOT NULL,
  `active` int unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

