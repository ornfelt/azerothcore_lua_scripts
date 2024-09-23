
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(210000, 0, 0, 0, 0, 0, 25275, 0, 0, 0, 'Stoic Torbane', 'LevelUp, Inc', NULL, 0, 82, 82, 0, 84, 1, 1, 1.14286, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'Start_NPC.lua', 0),
(210001, 0, 0, 0, 0, 0, 25275, 0, 0, 0, 'Elric Torbane', 'LevelUp, Inc', NULL, 0, 82, 82, 0, 83, 1, 1, 1.14286, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'Start_NPC.lua', 0),
(3460602, 0, 0, 0, 0, 0, 25144, 0, 0, 0, 'Frost Sphere (2)', '', '', 0, 79, 80, 2, 1925, 0, 1, 1.14286, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 0.238095, 1, 1, 0, 721, 0, 0, 0, '', 1),
(3460603, 0, 0, 0, 0, 0, 25144, 0, 0, 0, 'Frost Sphere (3)', '', '', 0, 79, 80, 2, 1925, 0, 1, 1.14286, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 0.238095, 1, 1, 0, 721, 0, 0, 0, '', 1);

INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(55000, 210000),
(55000, 210001);

INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(210000, 'Hey there, $N. I can train you to level 80 and give you Tier 7 gear to start, tested and true. And the prices are set, so if you want to haggle then go find a Goblin.', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(210001, 'Hey there, $N. I can train you to level 80 and give you Tier 7 gear to start, tested and true. And the prices are set, so if you want to haggle then go find a Goblin.', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(590083, 210000, 1, 0, 0, 1, 1, 0, 0, 10331.6, 828.68, 1326.32, 2.04827, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590084, 210000, 0, 0, 0, 1, 1, 0, 0, -8931.37, -134.265, 82.8146, 2.85605, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590085, 210000, 0, 0, 0, 1, 1, 0, 0, -6212.62, 330.992, 383.828, 3.04058, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590088, 210001, 1, 0, 0, 1, 1, 0, 0, -609.033, -4248.59, 38.9561, 4.02041, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590094, 210001, 0, 0, 0, 1, 1, 0, 0, 1675.53, 1668.81, 137.3, 4.45653, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590095, 210001, 1, 0, 0, 1, 1, 0, 0, -2913.26, -253.362, 52.9408, 3.56788, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590096, 210001, 530, 0, 0, 1, 1, 0, 0, 10359.7, -6366.47, 35.7386, 3.41539, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0),
(590097, 210000, 530, 0, 0, 1, 1, 0, 0, -3994.08, -13882, 91.9901, 5.82999, 25, 0, 0, 6662000, 0, 0, 0, 0, 0, NULL, 0);

  MODIFY `guid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier', AUTO_INCREMENT=2023272;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
