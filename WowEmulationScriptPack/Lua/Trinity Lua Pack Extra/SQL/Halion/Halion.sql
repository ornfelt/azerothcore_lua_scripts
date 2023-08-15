UPDATE `creature` SET `spawntimesecs`=604800 WHERE `id`=39863;
-- Copyright (C) kaelima <https://github.com/kaelima/>  and more updates from me(MindBreaker)

UPDATE `creature_template` SET `exp`=2, `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35, `ScriptName`='boss_halion' WHERE `entry`=39863;
UPDATE `creature_template` SET `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35, `RegenHealth`=0, `ScriptName`='boss_halion_twilight' WHERE `entry`=40142;
UPDATE `creature_template` SET `ScriptName`='npc_halion_controller' WHERE `entry`=40146;
UPDATE `creature_template` SET `ScriptName`='npc_meteor', `flags_extra`=130 WHERE `entry`=40029;
UPDATE `creature_template` SET `ScriptName`='npc_meteor_flame', `flags_extra`=130 WHERE `entry` IN (40041, 40042, 40043, 40044);
UPDATE `creature_template` SET `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35, `ScriptName`='npc_living_inferno' WHERE `entry`=40681;
UPDATE `creature_template` SET `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35 WHERE `entry`=40682;
UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry`=40055;
UPDATE `creature_template` SET `exp`=2 WHERE `entry` IN (39864,39944,39945);

UPDATE `creature_template` SET `scale`=1,`exp`=2,`baseattacktime`=2000,`unit_flags`=33554432, `flags_extra`=130 WHERE `entry`=40135; -- Consumption
UPDATE `creature_template` SET `scale`=1,`flags_extra`=130 WHERE `entry`=40001;
UPDATE `creature_model_info` SET `bounding_radius`=3.8,`combat_reach`=7.6,`gender`=2 WHERE `modelid`=16946;
UPDATE `creature_template_addon` SET `auras`=74629 WHERE `entry`=40001; -- Combustion
DELETE FROM `creature_template_addon` WHERE `entry`=40135;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(40135, 0, 0, 0x1, 0, 0, 74803); -- Consumption
DELETE FROM `creature_text` WHERE `entry` = 39863;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(39863, 0, 0, 'Meddlesome insects! You''re too late: The Ruby Sanctum''s lost.', 1, 0, 100, 0, 0, 17499, 'Halion - SAY_ARRIVAL'),
(39863, 1, 0, 'Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!', 1, 0, 100, 0, 0, 17500, 'Halion - SAY_AGGRO'),
(39863, 2, 0, 'The heavens burn!', 1, 0, 100, 0, 0, 17505, 'Halion - SAY_METEOR_STRIKE'),
(39863, 3, 0, 'You will find only suffering within the realm of twilight! Enter if you dare!', 1, 0, 100, 0, 0, 17507, 'Halion - SAY_PHASE_2'),
(39863, 4, 0, 'Beware the shadow!', 1, 0, 100, 0, 0, 17506, 'Halion - SAY_SPHERE_PULSE'),
(39863, 5, 0, 'The orbiting spheres pulse with dark energy!', 16, 0, 100, 0, 0, 0, 'Halion Twilight - EMOTE_SPHERE_PULSE'),
(39863, 6, 0, 'I am the light and the darkness! Cower, mortals, before the herald of Deathwing!', 1, 0, 100, 0, 0, 17508, 'Halion - SAY_PHASE_3'),
(39863, 7, 0, 'Not good enough.', 1, 0, 100, 0, 0, 17504, 'Halion - SAY_BERSERK'),
(39863, 8, 0, 'Another "hero" falls.', 1, 0, 100, 0, 0, 17501, 'Halion - SAY_KILL'),
(39863, 9, 0, 'Relish this victory, mortals, for it will be your last! This world will burn with the master''s return!', 1, 0, 100, 0, 0, 17503, 'Halion - SAY_DEATH');
SET @GUID := 1000000; -- Not like Trinity Core (maybe trinitycore will don't add this and if a use the next id free in DB they will overwrite it with other fix from them)

DELETE FROM `gameobject` WHERE `guid`=@GUID;
INSERT INTO `gameobject` VALUES (@GUID, 203624, 724, 15, 32, '3154.99', '535.637', '72.8887', '3.14159', 0, 0, 0, 0, 120, 0, 1);
UPDATE `gameobject_template` SET `data10`=75074, `ScriptName`='' WHERE `entry`=202794;
UPDATE `gameobject_template` SET `faction`=35, `data10`=0, `ScriptName`='go_physical_portal' WHERE `entry`=202795;
DELETE FROM `spelldifficulty_dbc` WHERE `id` BETWEEN 5000 AND 5006;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (74802, 74630, 75882, 75883, 75884, 75874, 75875, 75876);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(74630, 74607, 1, 'Halion Combustion Damage Aura trigger knock back'),
(75882, 74607, 1, 'Halion Combustion Damage Aura trigger knock back'),
(75883, 74607, 1, 'Halion Combustion Damage Aura trigger knock back'),
(75884, 74607, 1, 'Halion Combustion Damage Aura trigger knock back'),
(74802, 74799, 1, 'Halion Consumption Damage Aura trigger knock back'),
(75874, 74799, 1, 'Halion Consumption Damage Aura trigger knock back'),
(75875, 74799, 1, 'Halion Consumption Damage Aura trigger knock back'),
(75876, 74799, 1, 'Halion Consumption Damage Aura trigger knock back');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (76006, 74641, 74562, 74567, 74792, 74795);
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_cosmetic_fire_pillar';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_meteor_strike_marker';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_fiery_combustion';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_mark_of_combustion';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_soul_consumption';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_mark_of_consumption';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(76006, 'spell_halion_cosmetic_fire_pillar'),
(74641, 'spell_halion_meteor_strike_marker'),
(74562, 'spell_halion_fiery_combustion'),
(74567, 'spell_halion_mark_of_combustion'),
(74792, 'spell_halion_soul_consumption'),
(74795, 'spell_halion_mark_of_consumption');
