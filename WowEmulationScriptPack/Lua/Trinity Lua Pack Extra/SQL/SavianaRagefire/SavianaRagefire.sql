UPDATE `creature` SET `spawntimesecs`=604800 WHERE `id`=39747;

UPDATE `creature_template` SET `lootid`=39747, `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35, `ScriptName`='boss_saviana_ragefire' WHERE `entry`=39747; -- Saviana Ragefire 10 mode
UPDATE `creature_template` SET `exp`=2, `lootid`=39747, `mindmg`=497, `maxdmg`=676, `attackpower`=795, `dmg_multiplier`=35 WHERE `entry`=39823; -- Saviana Ragefire 25 mode
DELETE FROM `creature_text` WHERE `entry`=39747;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(39747, 0, 0, 'You will sssuffer for this intrusion!', 1, 0, 100, 0, 0, 17528, 'Saviana Ragefire - SAY_AGGRO'),
(39747, 1, 0, 'As it should be...', 1, 0, 100, 0, 0, 17529, 'Saviana Ragefire - SAY_KILL'),
(39747, 1, 1, 'Halion will be pleased.', 1, 0, 100, 0, 0, 17530, 'Saviana Ragefire - SAY_KILL'),
(39747, 2, 0, 'Burn in the master''s flame!', 1, 0, 100, 0, 0, 17532, 'Saviana Ragefire - SAY_CONFLAGRATION'),
(39747, 3, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 'Saviana Ragefire - EMOTE_ENRAGE');
DELETE FROM `spell_script_names` WHERE `spell_id` =74453;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(74453, 'spell_saviana_flame_beacon');
