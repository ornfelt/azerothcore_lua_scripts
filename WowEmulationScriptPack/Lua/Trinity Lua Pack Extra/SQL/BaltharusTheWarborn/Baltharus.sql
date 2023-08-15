DELETE FROM `areatrigger_scripts` WHERE `entry`=5867;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES 
(5867, 'at_baltharus_plateau');
UPDATE `creature` SET `spawntimesecs`=604800 WHERE `id`=39751;

UPDATE `creature_template` SET `npcflag`=2, `ScriptName`='npc_sanctum_guard_xerestrasza' WHERE `entry`=40429;
UPDATE `creature_template` SET `lootid`=39751, `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35, `ScriptName`= 'boss_baltharus_the_warborn' WHERE `entry`=39751;
UPDATE `creature_template` SET `exp`=2, `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=70 WHERE `entry`=39920;
UPDATE `creature_template` SET `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=70, `ScriptName`='npc_baltharus_the_warborn_clone' WHERE `entry`=39899;
DELETE FROM `creature_text` WHERE `entry` IN (39751,40429);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(39751, 0, 0, 'Your power wanes, ancient one.... Soon you will join your friends.', 14, 0, 100, 0, 0, 17525, 'Baltharus the Warborn - SAY_INTRO'),
(39751, 1, 0, 'Ah, the entertainment has arrived.', 14, 0, 100, 0, 0, 17520, 'Baltharus the Warborn - SAY_AGGRO'),
(39751, 2, 0, 'Baltharus leaves no survivors!', 14, 0, 100, 0, 0, 17521, 'Baltharus the Warborn - SAY_KILL'),
(39751, 2, 1, 'This world has enough heroes.', 14, 0, 100, 0, 0, 17522, 'Baltharus the Warborn - SAY_KILL'),
(39751, 3, 0, 'Twice the pain and half the fun.', 14, 0, 100, 0, 0, 17524, 'Baltharus the Warborn - SAY_SPLIT'),
(39751, 4, 1, 'I... didn''t see that coming....', 14, 0, 100, 0, 0, 17523, 'Baltharus the Warborn - SAY_DEATH'),
-- Sanctum Guard Xerestrasza
(40429, 0, 0, 'Thank you! I could not have held out for much longer.... A terrible thing has happened here.', 14, 0, 100, 5, 0, 17491, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT'),
(40429, 1, 0, 'We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.', 12, 0, 100, 1, 0, 17492, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_1'),
(40429, 2, 0, 'The Black dragonkin materialized from thin air, and set upon us before we could react.', 12, 0, 100, 1, 0, 17493, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_2'),
(40429, 3, 0, 'We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.', 12, 0, 100, 1, 0, 17494, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_3'),
(40429, 4, 0, 'They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.', 12, 0, 100, 1, 0, 17495, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_4'),
(40429, 5, 0, 'The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.', 12, 0, 100, 1, 0, 17496, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_5'),
(40429, 6, 0, 'In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.', 12, 0, 100, 1, 0, 17497, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_6'),
(40429, 7, 0, 'I know not the extent of their plans, heroes, but I know this: They cannot be allowed to succeed!', 12, 0, 100, 5, 0, 17498, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_EVENT_7'),
(40429, 8, 0, 'Help! I am trapped within this tree! I require aid!', 14, 0, 100, 5, 0, 17490, 'Sanctum Guardian Xerestrasza  - SAY_XERESTRASZA_INTRO');
-- Delete Smart AI for Baltarhus the Warborn Clone
SET @ENTRY := 39899; -- NPC entry
UPDATE `creature_template` SET `AIName`= '' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `spell_script_names` WHERE `spell_id` IN (74502, 74505) AND `ScriptName` IN ('spell_baltharus_enervating_brand', 'spell_baltharus_enervating_brand_trigger');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(74502, 'spell_baltharus_enervating_brand'),
(74505, 'spell_baltharus_enervating_brand_trigger');
