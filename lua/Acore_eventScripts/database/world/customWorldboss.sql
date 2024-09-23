DELETE FROM `creature_template` WHERE `entry` IN
(1112001,1112002,1112003,1112011,1112012,1112013,1112021,1112022,1112023,1112031,1112032,1112033,1112041,1112042,1112043,1112051,1112052,1112053,1112061,1112062,1112063,1112999);
DELETE FROM `npc_text` WHERE `ID` IN (91101,91102,91111,91112,91113,91114,91115,91116,91117);
DELETE FROM `gossip_menu` WHERE `MenuID` IN (62001,62002,62003,62004,62005,62006,62007);
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN
(1112011,1112021,1112031,1112041,1112051,1112061);
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN
(1112001,1112002,1112003,1112011,1112012,1112013,1112021,1112022,1112023,1112031,1112032,1112033,1112041,1112042,1112043,1112051,1112052,1112053,1112061,1112062,1112063,1112999);


INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
-- Party-only NPC:
(1112999, 0, 0, 0, 0, 0, 11062, 0, 0, 0, 'Amber Haze', 'Dark Queen of Timeshifts', 62001, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 1 Boss:
(1112001, 0, 0, 0, 0, 0, 3456, 0, 0, 0, 'Glorifrir Flintshoulder', '', 0, 50, 50, 0, 63, 0, 1, 2, 3, 3, 0, 30, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 450, 1, 1, 0, 0, 1, 634077055, 0, 256, '', 0),
-- Custom Chromie 1:
(1112002, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62001, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 1 Add:
(1112003, 0, 0, 0, 0, 0, 21443, 0, 0, 0, 'Zombie Captain', '', 0, 50, 50, 0, 415, 0, 1, 2, 1, 1, 0, 10, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 60, 1, 1, 0, 0, 1, 667631487, 0, 256, '', 0),
-- Event 2 Boss:
(1112011, 0, 0, 0, 0, 0, 24722, 0, 0, 0, 'Pondulum of Deem', '', 0, 40, 40, 0, 63, 0, 1, 2, 3, 3, 0, 30, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 300, 1, 1, 0, 0, 1, 667631231, 0, 0, '', 0),
-- Custom Chromie 2:
(1112012, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62002, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 2 Add:
(1112013, 0, 0, 0, 0, 0, 17953, 0, 0, 0, 'Seawitch', '', 0, 40, 40, 0, 63, 0, 1, 2, 1, 1, 0, 10, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 80, 100, 1, 0, 0, 1, 634077055, 0, 256, '', 0),
-- Event 3 Boss:
(1112021, 0, 0, 0, 0, 0, 17557, 0, 0, 0, 'Crocolisk Dundee', '', 0, 50, 50, 0, 63, 0, 1, 2, 2, 3, 0, 15, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 300, 100, 1, 0, 0, 1, 667631231, 0, 0, '', 0),
-- Custom Chromie 3:
(1112022, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62003, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 3 Add:
(1112023, 0, 0, 0, 0, 0, 1034, 0, 0, 0, 'Aligator Minion', '', 0, 50, 50, 0, 63, 0, 1, 2, 1, 1, 0, 5, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 50, 100, 1, 0, 0, 1, 667631227, 0, 256, '', 0),
-- Event 4 Boss:
(1112031, 0, 0, 0, 0, 0, 17557, 0, 0, 0, 'Crocolisk Bunbee', '', 0, 50, 50, 0, 63, 0, 1, 2, 2, 3, 0, 25, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 300, 100, 1, 0, 0, 1, 667631231, 0, 0, '', 0),
-- Custom Chromie 4:
(1112032, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62004, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 4 Add:
(1112033, 0, 0, 0, 0, 0, 1034, 0, 0, 0, 'Aligator Pet', '', 0, 50, 50, 0, 63, 0, 1, 2, 1, 1, 0, 5, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 50, 100, 1, 0, 0, 1, 667631227, 0, 256, '', 0),
-- Event 4 Boss:
(1112041, 0, 0, 0, 0, 0, 17557, 0, 0, 0, 'Crocolisk Rundee', '', 0, 60, 60, 0, 63, 0, 1, 2, 2, 3, 0, 30, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 600, 100, 1, 0, 0, 1, 667631231, 0, 0, '', 0),
-- Custom Chromie 4:
(1112042, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62005, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 4 Add:
(1112043, 0, 0, 0, 0, 0, 1034, 0, 0, 0, 'Aligator Guard', '', 0, 60, 60, 0, 63, 0, 1, 2, 1, 1, 0, 15, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 70, 100, 1, 0, 0, 1, 667631227, 0, 256, '', 0),
-- Event 6 Boss:
(1112051, 0, 0, 0, 0, 0, 9475, 0, 0, 0, 'One-Three-Three-Seven', '', 0, 60, 60, 0, 63, 0, 1, 2, 2, 3, 0, 30, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1200, 100, 1, 0, 0, 1, 667631231, 0, 0, '', 0),
-- Custom Chromie 6:
(1112052, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62006, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 6 Add:
(1112053, 0, 0, 0, 0, 0, 8409, 0, 0, 0, 'Ragnarix Qt', '', 0, 60, 60, 0, 63, 0, 1, 2, 2, 1, 0, 15, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 600, 100, 1, 0, 0, 1, 667631227, 0, 256, '', 0),
-- Event 7 Boss:
(1112061, 0, 0, 0, 0, 0, 15656, 0, 0, 0, 'Big Bad Bug', '...not related to coding.', 0, 60, 60, 0, 63, 0, 1, 1, 2, 3, 0, 30, 2000, 2000, 1, 1, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1200, 100, 1, 0, 0, 1, 667631231, 0, 0, '', 0),
-- Custom Chromie 7:
(1112062, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', 62007, 63, 63, 0, 35, 1, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1.35, 1, 1, 0, 0, 1, 0, 0, 2, '', 0),
-- Event 7 Add:
(1112063, 0, 0, 0, 0, 0, 21955, 0, 0, 0, 'Bug\'s Bunny', '', 0, 62, 62, 0, 63, 0, 1, 5, 2, 1, 0, 15, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 600, 100, 1, 0, 0, 1, 667631227, 0, 256, '', 0);

-- Npc_text
SET @NPC_TEXT = 'Greetings, $n. One of the invaders of the timeline is in a nearby timenode. I might be able to make them visible for your eyes and vulnerable to your magic and weapons, but i can not aid you in this fight while i am maintaining the spell. Are you ready to face the worst this timeline has to deal with?\n';
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(91101, CONCAT(@NPC_TEXT, 'How strong do you think you are?'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91102, CONCAT(@NPC_TEXT, 'And which enemy would you want to face?'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91111, CONCAT(@NPC_TEXT, 'From what i can tell, you want to try and keep them far apart. And watch out for fire rains.'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91112, CONCAT(@NPC_TEXT, 'From what i can tell, you want to try and prevent their spells from being cast. And once the Axe becomes desperate, my advice is to stand very close together.'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91113, CONCAT(@NPC_TEXT, 'The hunter drains power from the minions. You want to get rid of them as soon as you can.'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91114, CONCAT(@NPC_TEXT, 'The hunter drains power from the minions. They have strong healing powers. You must seperate them from each other! And watch out for fire rains.'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91115, CONCAT(@NPC_TEXT, 'The hunter drains power from the minions. They have strong healing powers. You must seperate them from each other! And watch out for fire rains.'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91116, CONCAT(@NPC_TEXT, 'The elementals empower the robot. Kill them fast! Stand together when the storm and meteors happen, you stand no chance alone! And split up to avoid the explosion. Watch out for the elementals. You must pick your target carefully so you do not kill yourself!'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(91117, CONCAT(@NPC_TEXT, 'Watch out for the bunnies. Kill them fast! When fighting them, you must pick your target carefully so you do not kill yourself!'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(62001, 91111),
(62002, 91112),
(62003, 91113),
(62004, 91114),
(62005, 91115),
(62006, 91116),
(62007, 91117);

INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(1112011, 1, 41175, 0, 0, 18019),
(1112021, 1, 7682, 0, 0, 18019),
(1112031, 1, 7682, 0, 0, 18019),
(1112041, 1, 7682, 0, 0, 18019);

-- insert new movement type adjustments since their old inhabit type was 3 for ground and water
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(1112001, 1, 1, 0, 0, 0, 0, NULL), -- Event 1 Boss
(1112002, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 1
(1112003, 1, 1, 0, 0, 0, 0, NULL), -- Event 1 Add
(1112011, 1, 1, 0, 0, 0, 0, NULL), -- Event 2 Boss
(1112012, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 2
(1112013, 1, 1, 0, 0, 0, 0, NULL), -- Event 2 Add
(1112021, 1, 1, 0, 0, 0, 0, NULL), -- Event 3 Boss
(1112022, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 3
(1112023, 1, 1, 0, 0, 0, 0, NULL), -- Event 3 Add
(1112031, 1, 1, 0, 0, 0, 0, NULL), -- Event 4 Boss
(1112032, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 4
(1112033, 1, 1, 0, 0, 0, 0, NULL), -- Event 4 Add
(1112041, 1, 1, 0, 0, 0, 0, NULL), -- Event 5 Boss
(1112042, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 5
(1112043, 1, 1, 0, 0, 0, 0, NULL), -- Event 5 Add
(1112051, 1, 1, 0, 0, 0, 0, NULL), -- Event 6 Boss
(1112052, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 6
(1112053, 1, 1, 0, 0, 0, 0, NULL), -- Event 6 Add
(1112061, 1, 1, 0, 0, 0, 0, NULL), -- Event 7 Boss
(1112062, 1, 1, 0, 0, 0, 0, NULL), -- Custom Chromie 7
(1112063, 1, 1, 0, 0, 0, 0, NULL); -- Event 7 Add
