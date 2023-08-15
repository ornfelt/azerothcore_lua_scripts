UPDATE `creature_template` SET `unit_flags`=64, `faction_A`=103, `faction_H`=103, `lootid`=39746, `Health_mod`=297.5, `mindmg`=497,`maxdmg`=676,`attackpower`=795,`dmg_multiplier`=35, `ScriptName`='boss_general_zarithrian' WHERE `entry`=39746; -- General Zarithrian 10 mode
UPDATE `creature_template` SET `exp`=2, `unit_flags`=64, `faction_A`=103, `faction_H`=103, `lootid`=39746, `Health_mod`=1010.97, `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35 WHERE `entry`=39805; -- General Zarithrian 25 mode
UPDATE `creature_template` SET `exp`=2, `minlevel`=82, `maxlevel`=82, `faction_A`=14, `faction_H`=14 WHERE `entry` IN (39814, 39815); -- Onyx Flamecaller 10 & 25 Modes don't know about melle dmg
UPDATE `creature_template` SET `ScriptName`='npc_onyx_flamecaller' WHERE `entry`=39814;
UPDATE `creature_template` SET `InhabitType`=3 WHERE `entry`=39794;

UPDATE `creature` SET `spawntimesecs`=604800 WHERE `id`=39746;
DELETE FROM `creature_text` WHERE `entry` = 39746;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(39746, 0, 0, 'Alexstrasza has chosen capable allies... A pity that I must END YOU!', 1, 0, 100, 0, 0, 17512, 'General Zarithrian - SAY_AGGRO'),
(39746, 1, 0, 'You thought you stood a chance?', 1, 0, 100, 0, 0, 17513, 'General Zarithrian - SAY_KILL'),
(39746, 1, 1, 'It''s for the best.', 1, 0, 100, 0, 0, 17514, 'General Zarithrian - SAY_KILL'),
(39746, 2, 0, 'Turn them to ash, minions!', 1, 0, 100, 0, 0, 17516, 'General Zarithrian - SAY_FLAMECALLER'),
(39746, 3, 0, 'HALION! I...', 1, 0, 100, 0, 0, 17515, 'General Zarithrian - SAY_DEATH');
DELETE FROM `spell_script_names` WHERE `spell_id`=74398 AND `ScriptName`='spell_zarithrian_summon_flamecaller';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(74398, 'spell_zarithrian_summon_flamecaller');
