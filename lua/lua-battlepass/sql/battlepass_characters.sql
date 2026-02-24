-- ============================================================================
-- Battle Pass System - Characters Database Tables
-- Database: acore_characters
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Table: character_battlepass
-- Stores player progress for the Battle Pass system
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `character_battlepass` (
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character GUID (FK to characters.guid)',
    `current_level` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Current Battle Pass level',
    `current_exp` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Experience towards next level',
    `total_exp` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Lifetime accumulated experience',
    `claimed_levels` TEXT DEFAULT NULL COMMENT 'Comma-separated list of claimed level rewards',
    `last_daily_login` DATE DEFAULT NULL COMMENT 'Last daily login bonus date',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Record creation timestamp',
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp',
    PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
