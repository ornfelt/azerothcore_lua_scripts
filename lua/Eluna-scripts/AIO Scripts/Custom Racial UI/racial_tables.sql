-- Table structure for tabs
CREATE TABLE IF NOT EXISTS `custom_racial_tabs` (
    `id` INT UNSIGNED NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `maxActiveSpells` INT UNSIGNED NOT NULL DEFAULT 1,
    `icon` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for racial spells
CREATE TABLE `custom_racial_spells` (
    `id` INT(10) NOT NULL,
    `category` INT(10) NULL DEFAULT NULL,
    `name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `itemType` ENUM('spell', 'item', 'profession') NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `costType` ENUM('gold', 'item', 'spell') NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `cost` INT(10) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB;

-- Insert tab data
INSERT INTO `custom_racial_tabs` (`id`, `name`, `maxActiveSpells`, `icon`) VALUES
(1, 'Utility', 1, 'spell_shadow_charm'),
(2, 'Passive', 2, 'spell_nature_wispsplode'),
(3, 'Weapon', 1, 'ability_meleedamage'),
(4, 'Profession perk', 2, 'inv_misc_gear_01'),
(5, 'Profession item', 2, 'inv_misc_gear_01'),
(6, 'Profession skill', 2, 'inv_misc_gear_01'),
(7, 'Secondary skill', 3, 'inv_misc_gear_01'),

-- Insert racial spells data and crafting
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20577, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (2481, 1, NULL, 'spell', 'item', 6265);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20594, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (26297, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (58984, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (59752, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20572, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (28730, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20589, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (7744, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (59542, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20549, 1, NULL, 'spell', 'gold', 10000);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (822, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (6562, 2, NULL, 'spell', 'gold', 1);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (5227, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20598, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20599, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (21009, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (65222, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (58943, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20550, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20551, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (58985, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20555, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20573, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20579, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20582, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20585, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20591, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20592, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20596, 2, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20597, 3, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (26290, 3, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20595, 3, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (59224, 3, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20574, 3, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20558, 3, NULL, 'spell', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20552, 4, NULL, 'spell', 'item', 6265);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (28877, 4, NULL, 'spell', 'item', 6265);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20593, 4, NULL, 'spell', 'item', 6265);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (2901, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (5956, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (6219, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (7005, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (10498, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (39505, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (44452, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (20815, 5, '', 'item', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (50300, 6, 'Herbalism', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (50305, 6, 'Skinning', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (50310, 6, 'Mining', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51302, 6, 'Leatherworking', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51304, 6, 'Alchemy', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51306, 6, 'Engineering', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51309, 6, 'Tailoring', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51311, 6, 'Jewelcrafting', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51313, 6, 'Enchanting', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51300, 6, 'Blacksmithing', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (45542, 7, 'First aid', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51294, 7, 'Fishing', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (51296, 7, 'Cooking', 'profession', 'gold', 100);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (6265, 8, 'PogShard', 'item', 'gold', 33333);
INSERT INTO `custom_racial_spells` (`id`, `category`, `name`, `itemType`, `costType`, `cost`) VALUES (56808, 8, 'Adrenaline rush', 'spell', 'gold', 100);
