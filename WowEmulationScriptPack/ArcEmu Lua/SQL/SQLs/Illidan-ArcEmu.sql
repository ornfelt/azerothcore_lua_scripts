-- // Thanks for ArcScript helping me build these \\ --
REPLACE INTO creature_names (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `unk4`, `spelldataid`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `civilian`, `leader`) VALUES 
(229170, 'Illidan Stormrage', 'The Betrayer', '', 0, 3, 0, 3, 0, 0, 21135, 0, 0, 0, 2, 1, 0, 1),
(229900, 'Akama', '', '', 0, 7, 0, 3, 0, 0, 20681, 0, 0, 0, 1, 1, 0, 0), -- Main Akama that Talks
(229901, 'Akama', '', '', 0, 7, 0, 3, 0, 0, 20681, 0, 0, 0, 1, 1, 0, 0), -- Akama runs up stairs
(229902, 'Akama', '', '', 0, 7, 0, 3, 0, 0, 20681, 0, 0, 0, 1, 1, 0, 0), -- Akama get ready to fight
(229903, 'Akama', '', '', 0, 7, 0, 3, 0, 0, 20681, 0, 0, 0, 1, 1, 0, 0), -- Akama Fighter
(229904, 'Akama', '', '', 0, 7, 0, 3, 0, 0, 20681, 0, 0, 0, 1, 1, 0, 0), -- Akama After Fight
(229960, 'Blade of Azzinoth', '', '', 0, 0, 0, 0, 0, 0, 21431, 0, 0, 0, 1, 1, 0, 0),
(229970, 'Flame of Azzinoth', '', '', 0, 3, 0, 0, 0, 0, 20431, 0, 0, 0, 1, 1, 0, 0),
(231970, 'Maiev Shadowsong', '', '', 0, 10, 0, 3, 0, 0, 20628, 0, 0, 0, 1, 1, 0, 0),
(232590, 'Blaze', 'Blaze Effect', '', 0, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 1, 1, 0, 0),
(233360, 'Flame Crash', 'Flame Crash Effect', '', 0, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 1, 1, 0, 0),
(230691, 'Demon FireSpawner', ' ', '', 0, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 1, 1, 0, 0),
(230690, 'Demon Fire', ' ', '', 0, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 1, 1, 0, 0),
(30001, 'Door Event Trigger', ' ', '', 0, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 1, 1, 0, 0);

REPLACE INTO creature_proto (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `mindamage`, `maxdamage`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `death_state`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`) VALUES 
(229170, 73, 73, 1825, 5534309, 5534309, 6774, 1.3, 0, 2000, 10000, 14000, 0, 0, 0, 360000, 8000, 25, 25, 25, 25, 25, 25, 1.25, 1, "", 1, 0, 0, 0, 2.5, 8, 14, 0),
(229900, 73, 73, 1858, 480000, 480000, 338700, 2.0, 1, 2000, 350, 550, 0, 0, 0, 360000, 0, 0, 0, 0, 0, 0, 0, 1.3, 1.3, "", 0, 0, 0, 0, 2.5, 8, 14, 0),
(229901, 73, 73, 1858, 480000, 480000, 338700, 2.0, 0, 2000, 350, 550, 0, 0, 0, 360000, 0, 0, 0, 0, 0, 0, 0, 1.3, 1.3, "", 0, 0, 0, 0, 2.5, 8, 14, 0),
(229902, 73, 73, 1858, 480000, 480000, 338700, 2.0, 1, 2000, 350, 550, 0, 0, 0, 360000, 0, 0, 0, 0, 0, 0, 0, 1.3, 1.3, "", 0, 0, 0, 0, 2.5, 8, 14, 0),
(229903, 73, 73, 1858, 480000, 480000, 338700, 2.0, 0, 2000, 350, 550, 0, 0, 0, 360000, 0, 0, 0, 0, 0, 0, 0, 1.3, 1.3, "", 0, 0, 0, 0, 2.5, 8, 14, 0),
(229904, 73, 73, 1858, 480000, 480000, 338700, 2.0, 0, 2000, 350, 550, 0, 0, 0, 360000, 0, 0, 0, 0, 0, 0, 0, 1.3, 1.3, "", 0, 0, 0, 0, 2.5, 8, 14, 0),
(229960, 73, 73, 35, 16000, 16000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, " ", 1, 0, 0, 0, 2.5, 8, 14, 0),
(229970, 73, 73, 1825, 1100000, 1100000, 0, 4, 0, 2000, 650, 1000, 0, 0, 0, 3600, 0, 0, 0, 0, 0, 0, 0, 2, 3, "", 0, 0, 0, 0, 2.5, 8, 14, 0),
(231970, 73, 73, 1867, 27000, 27000, 3387, 2, 0, 2000, 643, 898, 0, 0, 0, 360000, 0, 0, 0, 0, 0, 0, 0, 2, 1, "", 1, 0, 0, 0, 2.5, 8, 14, 0),
(232590, 70, 70, 1825, 6000, 6000, 6000, 1, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0, 0, 2.5, 8, 14, 0),
(233360, 70, 70, 1825, 6000, 6000, 6000, 1, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0, 0, 2.5, 8, 14, 0),
(230690, 70, 70, 1825, 100000, 100000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0, 0, 2.5, 8, 14, 0),
(230691, 70, 70, 1825, 200000000, 200000000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0, 0, 2.5, 8, 14, 0),
(30001, 70, 70, 35, 100000, 100000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, '0', 0, 0, 0, 0, 2.5, 8, 14, 0);


REPLACE INTO `creature_spawns` (`id`,`entry`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`movetype`,`displayid`,`faction`,`flags`,`bytes0`,`bytes1`,`bytes2`,`emote_state`,`npc_respawn_link`,`channel_spell`,`channel_target_sqlid`,`channel_target_sqlid_creature`,`standstate`,`mountdisplayid`,`slot1item`,`slot2item`,`slot3item`) VALUES (4661153,229900,564,641.623,310.398,271.683,0.0196238,4,20681,1858,1,0,0,0,0,0,0,0,0,0,0,30699,30699,0);
delete from gameobject_spawns where entry in (185905, 200000, 200001);
DELETE FROM gameobject_spawns WHERE (`entry`= 3000003 AND `map`= 564);

REPLACE INTO npc_text (`entry`, `prob0`, `text0_0`, `text0_1`, `lang0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `prob1`, `text1_0`, `text1_1`, `lang1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `prob2`, `text2_0`, `text2_1`, `lang2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `prob3`, `text3_0`, `text3_1`, `lang3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `prob4`, `text4_0`, `text4_1`, `lang4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `prob5`, `text5_0`, `text5_1`, `lang5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `prob6`, `text6_0`, `text6_1`, `lang6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `prob7`, `text7_0`, `text7_1`, `lang7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`) VALUES 
(229901, 1, 'The time has come to face Illidan, $N. Are you ready?', 'The time has come to face Illidan, $N. Are you ready?', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0),
(229902, 1, 'Be wary, friends. The Betrayer meditates in the court just beyond.', 'Be wary, friends. The Betrayer meditates in the court just beyond.', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0, 0, ' ', ' ', 0, 0, 0, 0, 0, 0, 0);

delete from items where `entry`=30699;
REPLACE INTO items
   (`entry`, `class`, `subclass`, `field4`, `name1`, `displayid`, `quality`, `flags`, `buyprice`, `sellprice`, `inventorytype`, `allowableclass`, `allowablerace`, `itemlevel`, `requiredlevel`, `RequiredSkill`, `RequiredSkillRank`, `RequiredSkillSubRank`, `RequiredPlayerRank1`, `RequiredPlayerRank2`, `RequiredFaction`, `RequiredFactionStanding`, `Unique`, `maxcount`, `ContainerSlots`, `ScaledStatsDistributionId`, `ScaledStatsDistributionFlags`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `delay`, `ammo_type`, `range`, `bonding`, `description`, `page_id`, `page_language`, `page_material`, `quest_id`, `lock_id`, `lock_material`, `sheathID`, `randomprop`, `unk203_1`, `block`, `itemset`, `MaxDurability`, `ZoneNameID`, `mapid`, `bagfamily`, `TotemCategory`, `socket_color_1`, `unk201_3`, `socket_color_2`, `unk201_5`, `socket_color_3`, `unk201_7`, `socket_bonus`, `GemProperties`, `ReqDisenchantSkill`, `unk2`, `ItemLimitCategoryId`)
VALUES
   (30699, 2, 7, -1, 'Akamas Weapon (ONLY FOR DISPLAY)', 43903, 0, 0, 0, 0, 13, -1, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 7, 0, 2000, 0, 0, 0, '', 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0);
DELETE FROM creature_spawns WHERE (`entry`= 22990 AND `map`= 564 AND `faction`= 1858 AND `displayid`= 20681);

UPDATE `creature_proto` SET `scale`=1.4 WHERE `entry`=229970;

delete from gameobject_spawns where entry in (185905, 200000, 200001);
INSERT INTO gameobject_spawns (Entry, map, position_x, position_y, position_z, Facing, orientation1, orientation2, orientation3, orientation4, State, Flags, Faction, Scale, stateNpcLink) VALUES 
(185905, 564, 774.7, 304.6, 314.85, 1.53, 0, 0, 0.706767, 0.707446, 1, 1, 0, 1, 0);