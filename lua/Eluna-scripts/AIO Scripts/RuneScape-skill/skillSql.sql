
-- place in world
CREATE TABLE IF NOT EXISTS `custom_skills_rs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `icon` VARCHAR(100) NOT NULL,
  `max_level` INT UNSIGNED NOT NULL DEFAULT 99,
  `description` TEXT,
  `display_order` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- place in char
-- CREATE TABLE IF NOT EXISTS `custom_player_skills_rs` (
--   `player_guid` INT UNSIGNED NOT NULL,
--   `skill_id` INT UNSIGNED NOT NULL,
--   `skill_level` INT UNSIGNED NOT NULL DEFAULT 1,
--   `skill_experience` INT UNSIGNED NOT NULL DEFAULT 0,
--   PRIMARY KEY (`player_guid`, `skill_id`),
--   FOREIGN KEY (`skill_id`) REFERENCES `custom_skills_rs`(`id`) ON DELETE CASCADE
-- );

CREATE TABLE IF NOT EXISTS `custom_player_skills_rs` (
  `player_guid` INT UNSIGNED NOT NULL,
  `skill_id` INT UNSIGNED NOT NULL,
  `skill_level` INT UNSIGNED NOT NULL DEFAULT 1,
  `skill_experience` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_guid`, `skill_id`)
);
-- placed in world
CREATE TABLE IF NOT EXISTS `custom_skill_milestones_rs` (
  `skill_id` INT UNSIGNED NOT NULL,
  `level` INT UNSIGNED NOT NULL,
  `milestone_type` ENUM('minor', 'major') NOT NULL,
  `description` TEXT,
  `reward_type` VARCHAR(32) DEFAULT NULL,   -- 'spell', 'item', etc.
  `reward_id` INT DEFAULT NULL,             -- SpellID, ItemID, etc.
  `reward_amount` INT DEFAULT 1,            -- For stackable items/currency
  `reward_data` TEXT DEFAULT NULL,          -- For custom data (JSON, etc.)
  PRIMARY KEY (`skill_id`, `level`),
  FOREIGN KEY (`skill_id`) REFERENCES `custom_skills_rs`(`id`) ON DELETE CASCADE
);
