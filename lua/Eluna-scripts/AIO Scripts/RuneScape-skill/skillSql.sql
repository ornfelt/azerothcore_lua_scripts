-- place in char to store for each character. (this is not in the world database)
CREATE TABLE IF NOT EXISTS `custom_player_skills_rs`
(
    `player_guid`      INT UNSIGNED NOT NULL,
    `skill_id`         INT UNSIGNED NOT NULL,
    `skill_level`      INT UNSIGNED NOT NULL DEFAULT 1,
    `skill_experience` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`player_guid`, `skill_id`)
);

-- place in the world (this is not in the char database)
CREATE TABLE IF NOT EXISTS `custom_skills_rs`
(
    `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`          VARCHAR(50)  NOT NULL,
    `icon`          VARCHAR(100) NOT NULL,
    `max_level`     INT UNSIGNED NOT NULL DEFAULT 99,
    `description`   TEXT,
    `display_order` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
);

-- placed in the world (this is not in char database)
CREATE TABLE IF NOT EXISTS `custom_skill_milestones_rs`
(
    `skill_id`       INT UNSIGNED            NOT NULL,
    `level`          INT UNSIGNED            NOT NULL,
    `milestone_type` ENUM ('minor', 'major') NOT NULL,
    `description`    TEXT,
    `reward_type`    VARCHAR(32) DEFAULT NULL, -- 'spell', 'item', etc.
    `reward_id`      INT         DEFAULT NULL, -- SpellID, ItemID, etc.
    `reward_amount`  INT         DEFAULT 1,    -- For stackable items/currency
    `reward_data`    TEXT        DEFAULT NULL, -- For custom data (JSON, etc. Might not work correctly right now)
    PRIMARY KEY (`skill_id`, `level`),
    FOREIGN KEY (`skill_id`) REFERENCES `custom_skills_rs` (`id`) ON DELETE CASCADE
);


# This is original professions from WoW. Add them or just make custom ones as you want.
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (1, 'Alchemy', 'INV_Potion_23', 99,
        'Mix potions, elixirs, flasks, and other alchemical substances using herbs and other reagents.', 1);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (2, 'Blacksmith', 'INV_Hammer_01', 99, 'Forge weapons and armor using metals and other materials.', 2);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (3, 'Enchanting', 'INV_Enchant_DustDream', 99, 'Imbue weapons and armor with magical properties.', 3);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (4, 'Engineering', 'INV_Gizmo_02', 99, 'Design and build various gadgets, explosives, and mechanical devices.',
        4);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (5, 'Herbalism', 'INV_Misc_Herb_02', 99, 'Gather herbs found throughout the world.', 5);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (6, 'Inscription', 'INV_Inscription_Pigment_Silver', 99, 'Create glyphs, scrolls, and other magical writings.',
        6);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (7, 'Jewelcrafting', 'INV_Misc_Gem_01', 99, 'Cut gems and craft jewelry.', 7);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (8, 'Leatherworking', 'INV_Misc_ArmorKit_17', 99,
        'Craft leather and mail armor using hides and other materials.', 8);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (9, 'Mining', 'INV_Pick_02', 99, 'Extract ores and gems from mineral veins.', 9);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (10, 'Skinning', 'INV_Misc_Pelt_Wolf_01', 99, 'Skin the corpses of certain creatures for their hides.', 10);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (11, 'Tailoring', 'INV_Fabric_Silk_01', 99, 'Sew cloth armor and bags using various fabrics.', 11);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (12, 'Cooking', 'INV_Misc_Food_15', 99, 'Prepare food that grants various buffs.', 12);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (13, 'Fishing', 'INV_Fishing-pole_01', 99, 'Catch fish and other items from bodies of water.', 13);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (14, 'First Aid', 'INV_Misc_Bandage_01', 99, 'Create bandages and other healing items.', 14);
INSERT INTO world.custom_skills_rs (id, name, icon, max_level, description, display_order)
VALUES (15, 'Archaeology', 'INV_Misc_Rune_01', 99, 'Uncover artifacts and relics from ancient civilizations.', 15);

# This is for the alchemy to show how to add milestones. level 1 to 25. You can add more or less as you want.
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 1, 'minor', 'Successfully brewed your first concoction!', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 2, 'minor', 'Improved your stirring technique.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 3, 'minor', 'Discovered a slightly more stable mixture.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 4, 'minor', 'Recognize basic herb properties faster.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 5, 'major', 'Mastered the basics of simple potions.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 6, 'minor', 'Can now identify common reagents by smell.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 7, 'minor', 'Learned to filter impurities more effectively.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 8, 'minor', 'Increased precision in measuring liquids.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 9, 'minor', 'Gained confidence in handling volatile substances.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 10, 'major', 'Reached a solid understanding of basic elixirs.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 11, 'minor', 'Can now distinguish between similar-looking herbs.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 12, 'minor', 'Improved ability to control brewing temperature.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 13, 'minor', 'Learned to properly clean alchemical equipment.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 14, 'minor', 'Gained insight into basic reagent interactions.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 15, 'major', 'Became proficient in crafting standard healing and mana potions.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 16, 'minor', 'Can now identify common potion effects by color.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 17, 'minor', 'Improved ability to prevent potion fizzing.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 18, 'minor', 'Learned a trick for faster reagent grinding.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 19, 'minor', 'Gained a better understanding of elemental infusions.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 20, 'major', 'Achieved competence in crafting basic combat elixirs.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 21, 'minor', 'Can now spot subtle differences in herb quality.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 22, 'minor', 'Improved technique for distilling potent extracts.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 23, 'minor', 'Learned to store volatile compounds safely.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 24, 'minor', 'Gained a preliminary understanding of transmutations.', null, null, 1, null);
INSERT INTO world.custom_skill_milestones_rs (skill_id, level, milestone_type, description, reward_type, reward_id,
                                              reward_amount, reward_data)
VALUES (1, 25, 'major', 'Achieved Journeyman Alchemist status, unlocking more complex recipes.', null, null, 1, null);
