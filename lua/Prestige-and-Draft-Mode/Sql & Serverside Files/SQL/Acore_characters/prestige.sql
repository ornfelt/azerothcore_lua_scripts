
#################YOU MUST RUN THIS IN ACORE_CHARACTERS DATABASE
#################Characters.prestige_stats
CREATE TABLE IF NOT EXISTS `prestige_stats` (
  `player_id` INT NOT NULL PRIMARY KEY,
  `prestige_level` INT DEFAULT 0,
  `draft_state` TINYINT DEFAULT 0,
  `successful_drafts` INT DEFAULT 0,
  `total_expected_drafts` INT DEFAULT 0,
  `rerolls` INT DEFAULT 0,
  `stored_class` TINYINT DEFAULT 0,
  `offered_spell_1` INT DEFAULT 0,
  `offered_spell_2` INT DEFAULT 0,
  `offered_spell_3` INT DEFAULT 0
);
################characters.drafted_spells
CREATE TABLE IF NOT EXISTS `drafted_spells` (
  `player_guid` INT NOT NULL,
  `spell_id` INT NOT NULL,
  PRIMARY KEY (`player_guid`, `spell_id`)
);
################characters.draft_bans
CREATE TABLE IF NOT EXISTS `draft_bans` (
  `player_id` INT NOT NULL,
  `spell_id` INT NOT NULL,
  PRIMARY KEY (`player_id`, `spell_id`)
);



################UPDATEBLOCK (If you're missing these, add them)
ALTER TABLE `acore_characters`.`prestige_stats`
ADD COLUMN `bans` INT UNSIGNED NOT NULL DEFAULT 0,
ADD COLUMN `taskmaster_state` INT UNSIGNED NOT NULL DEFAULT 0,
ADD COLUMN `tasks_completed` INT UNSIGNED NOT NULL DEFAULT 0,
ADD COLUMN `taskmaster_mode` INT UNSIGNED NOT NULL DEFAULT 0;
ADD COLUMN `on_task` INT UNSIGNED NOT NULL DEFAULT 0;





