-- ============================================================================
-- Battle Pass System - World Database Tables
-- Database: acore_world
-- RE-APPLICABLE: Uses CREATE TABLE IF NOT EXISTS and INSERT IGNORE
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Table: battlepass_config
-- Global configuration settings for the Battle Pass system
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `battlepass_config` (
    `config_key` VARCHAR(50) NOT NULL COMMENT 'Configuration key name',
    `config_value` VARCHAR(255) NOT NULL COMMENT 'Configuration value',
    `description` VARCHAR(255) DEFAULT NULL COMMENT 'Description of the setting',
    PRIMARY KEY (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default config values (IGNORE if already exists)
INSERT IGNORE INTO `battlepass_config` (`config_key`, `config_value`, `description`) VALUES
('enabled', '1', 'Enable/disable the entire Battle Pass system'),
('max_level', '100', 'Maximum Battle Pass level'),
('exp_per_level', '1000', 'Base experience required per level'),
('exp_scaling', '1.1', 'Multiplier for exp required each level (1.0 = linear, >1 = exponential)'),
('npc_entry', '90100', 'NPC entry ID for Battle Pass vendor'),
('debug_mode', '0', 'Enable debug messages in server console');

-- ----------------------------------------------------------------------------
-- Table: battlepass_reward_types
-- Defines the types of rewards that can be granted
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `battlepass_reward_types` (
    `type_id` TINYINT UNSIGNED NOT NULL COMMENT 'Reward type identifier',
    `type_name` VARCHAR(50) NOT NULL COMMENT 'Human-readable name',
    `handler_func` VARCHAR(50) NOT NULL COMMENT 'Lua function to call for this reward type',
    `description` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert reward types (IGNORE if already exists)
INSERT IGNORE INTO `battlepass_reward_types` (`type_id`, `type_name`, `handler_func`, `description`) VALUES
(1, 'item', 'GrantItemReward', 'Grants an item (reward_id = item entry, reward_count = quantity)'),
(2, 'gold', 'GrantGoldReward', 'Grants gold (reward_id = 0, reward_count = copper amount)'),
(3, 'title', 'GrantTitleReward', 'Grants a character title (reward_id = title ID)'),
(4, 'spell', 'GrantSpellReward', 'Teaches a spell (reward_id = spell ID)'),
(5, 'currency', 'GrantCurrencyReward', 'Grants custom currency item (reward_id = item entry, reward_count = quantity)');

-- ----------------------------------------------------------------------------
-- Table: battlepass_levels
-- Defines each Battle Pass level and its associated reward
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `battlepass_levels` (
    `level` SMALLINT UNSIGNED NOT NULL COMMENT 'Battle Pass level (1-max_level)',
    `exp_required` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Custom XP to reach this level (0 = use formula)',
    `reward_type` TINYINT UNSIGNED NOT NULL COMMENT 'FK to battlepass_reward_types.type_id',
    `reward_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Item ID, Spell ID, Title ID, or 0 for gold',
    `reward_count` INT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Quantity (items) or copper amount (gold)',
    `reward_name` VARCHAR(100) NOT NULL COMMENT 'Display name for the reward',
    `reward_icon` VARCHAR(100) DEFAULT 'INV_Misc_QuestionMark' COMMENT 'Icon name (without Interface\\Icons\\)',
    `description` VARCHAR(255) DEFAULT NULL COMMENT 'Flavor text shown in UI',
    PRIMARY KEY (`level`),
    KEY `idx_reward_type` (`reward_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert level rewards (IGNORE if already exists - allows customization)
INSERT IGNORE INTO `battlepass_levels` (`level`, `exp_required`, `reward_type`, `reward_id`, `reward_count`, `reward_name`, `reward_icon`, `description`) VALUES
(1,  0, 2, 0, 10000,   '1 Gold',                'INV_Misc_Coin_02',              'A small reward to start your journey'),
(2,  0, 1, 4306, 10,   'Silk Cloth x10',        'INV_Fabric_Silk_01',            'Useful crafting material'),
(3,  0, 2, 0, 25000,   '2 Gold 50 Silver',      'INV_Misc_Coin_02',              'Building your fortune'),
(4,  0, 1, 8529, 5,    'Noggenfogger Elixir x5','INV_Potion_10',                 'Fun transformation potion'),
(5,  0, 2, 0, 50000,   '5 Gold',                'INV_Misc_Coin_01',              'A nice gold boost'),
(6,  0, 1, 21877, 10,  'Netherweave Cloth x10', 'INV_Fabric_Netherweave',        'Outland crafting material'),
(7,  0, 2, 0, 75000,   '7 Gold 50 Silver',      'INV_Misc_Coin_01',              'Growing wealth'),
(8,  0, 1, 33470, 5,   'Frostweave Cloth x5',   'INV_Fabric_Frostweave',         'Northrend crafting material'),
(9,  0, 2, 0, 100000,  '10 Gold',               'INV_Misc_Coin_01',              'Double digits!'),
(10, 0, 1, 49426, 1,   'Emblem of Frost',       'Spell_Holy_SummonChampion',     'Tier 10 currency'),
(11, 0, 2, 0, 150000,  '15 Gold',               'INV_Misc_Coin_01',              'Nice savings'),
(12, 0, 1, 43102, 5,   'Frozen Orb x5',         'Spell_Nature_Removecurse',      'Crafting reagent'),
(13, 0, 2, 0, 200000,  '20 Gold',               'INV_Misc_Coin_01',              'Halfway to a mount'),
(14, 0, 1, 44731, 1,   'Bouquet of Red Roses',  'INV_ValentinesRose_Red',        'Rare vanity item'),
(15, 0, 4, 33388, 1,   'Apprentice Riding',     'Ability_Mount_Ridinghorse',     'Learn to ride!'),
(16, 0, 2, 0, 300000,  '30 Gold',               'INV_Misc_Coin_01',              'Substantial funds'),
(17, 0, 1, 49427, 3,   'Emblem of Triumph x3',  'Spell_Holy_SummonChampion',     'Tier 9 currency'),
(18, 0, 2, 0, 400000,  '40 Gold',               'INV_Misc_Coin_01',              'Mounting funds'),
(19, 0, 1, 20400, 1,   'Pumpkin Bag',           'INV_Misc_Bag_10_Blue',          '16 slot bag'),
(20, 0, 3, 42, 0,      'the Explorer',          'Achievement_Zone_EasternKingdoms_01', 'Title: <name> the Explorer'),
(21, 0, 2, 0, 500000,  '50 Gold',               'INV_Misc_Coin_01',              'Half century of gold'),
(22, 0, 1, 49426, 5,   'Emblem of Frost x5',    'Spell_Holy_SummonChampion',     'Tier 10 currency bundle'),
(23, 0, 2, 0, 750000,  '75 Gold',               'INV_Misc_Coin_01',              'Growing fortune'),
(24, 0, 1, 34498, 1,   'Paper Zeppelin Kit',    'INV_Misc_Paperpackage_01',      'Fun toy'),
(25, 0, 4, 34090, 1,   'Journeyman Riding',     'Ability_Mount_Ridinghorse',     '100% ground speed'),
(26, 0, 2, 0, 1000000, '100 Gold',              'INV_Misc_Coin_01',              'One hundred gold!'),
(27, 0, 1, 44990, 1,   'Runed Orb',             'INV_Misc_RunedOrb_01',          'Epic crafting material'),
(28, 0, 2, 0, 1500000, '150 Gold',              'INV_Misc_Coin_01',              'Serious wealth'),
(29, 0, 1, 49908, 1,   'Primordial Saronite',   'INV_Misc_EnchantedPearle',      'ICC crafting material'),
(30, 0, 3, 113, 0,     'of the Shattered Sun',  'Spell_Holy_ChampionsBond',      'Title: <name> of the Shattered Sun');

-- ----------------------------------------------------------------------------
-- Table: battlepass_progress_sources
-- Configurable XP sources with multipliers
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `battlepass_progress_sources` (
    `source_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `source_type` VARCHAR(50) NOT NULL COMMENT 'Event type identifier',
    `source_subtype` INT UNSIGNED DEFAULT 0 COMMENT 'Specific ID (creature_id, quest_id, etc.) or 0 for all',
    `exp_value` INT NOT NULL DEFAULT 10 COMMENT 'Base XP awarded',
    `multiplier` FLOAT NOT NULL DEFAULT 1.0 COMMENT 'XP multiplier',
    `min_level` TINYINT UNSIGNED DEFAULT 1 COMMENT 'Minimum player level required',
    `max_level` TINYINT UNSIGNED DEFAULT 80 COMMENT 'Maximum player level (0 = no limit)',
    `enabled` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Is this source active',
    `description` VARCHAR(255) DEFAULT NULL COMMENT 'Description of the XP source',
    PRIMARY KEY (`source_id`),
    UNIQUE KEY `uk_source` (`source_type`, `source_subtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert progress sources (IGNORE if already exists - allows customization)
INSERT IGNORE INTO `battlepass_progress_sources` (`source_type`, `source_subtype`, `exp_value`, `multiplier`, `min_level`, `max_level`, `enabled`, `description`) VALUES
-- Creature kills
('KILL_CREATURE',    0, 5,   1.0, 1, 80, 1, 'Any creature kill'),
('KILL_ELITE',       0, 25,  1.0, 1, 80, 1, 'Elite creature kill (rank >= 1)'),
('KILL_BOSS',        0, 100, 1.0, 1, 80, 1, 'Dungeon/Raid boss kill'),

-- Quest completion
('COMPLETE_QUEST',   0, 50,  1.0, 1, 80, 1, 'Any quest completion'),
('COMPLETE_DAILY',   0, 100, 1.0, 80, 80, 1, 'Daily quest completion'),

-- Player progression
('PLAYER_LEVELUP',   0, 200, 1.0, 1, 79, 1, 'Player gains a level'),

-- PvP activities
('WIN_BATTLEGROUND', 0, 150, 1.0, 10, 80, 1, 'Battleground victory'),
('LOSE_BATTLEGROUND',0, 50,  1.0, 10, 80, 1, 'Battleground participation (loss)'),
('HONOR_KILL',       0, 10,  1.0, 10, 80, 1, 'Honorable kill in PvP'),

-- Special
('LOGIN_DAILY',      0, 100, 1.0, 1, 80, 1, 'First login of the day'),
('CUSTOM',           0, 0,   1.0, 1, 80, 1, 'Custom events via admin command');
