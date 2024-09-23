-- Dumping structure for table character.character_stats_extra
CREATE TABLE IF NOT EXISTS `character_stats_extra` (
  `guid` int(11) DEFAULT NULL,
  `str` int(11) DEFAULT NULL,
  `agi` int(11) DEFAULT NULL,
  `stam` int(11) DEFAULT NULL,
  `int` int(11) DEFAULT NULL,
  `spirit` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;