SET @ENTRY := 40400;

UPDATE `creature` SET `spawntimesecs`=86400 WHERE `id` IN (@ENTRY+17, @ENTRY+19, @ENTRY+21, @ENTRY+23);
DELETE FROM `creature_loot_template` WHERE `entry` IN (39746, 39747, 39751);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(39751, 49426, 100, 1, 0, 1, 1),
(39747, 49426, 100, 1, 0, 1, 1),
(39746, 49426, 100, 1, 0, 1, 1);
SET @ENTRY := 40400;
/*Leave as comment until I will get more dataz
UPDATE `creature_template` SET `mindmg`=, `maxdmg`=, `attackpower`=, `dmg_multiplier`=, `ScriptName`='npc_charscale_assaulter' WHERE `entry`=@ENTRY+19;
UPDATE `creature_template` SET `mindmg`=, `maxdmg`=, `attackpower`=, `dmg_multiplier`=, `ScriptName`='npc_charscale_elite' WHERE `entry`=@ENTRY+21
UPDATE `creature_template` SET `mindmg`=, `maxdmg`=, `attackpower`=, `dmg_multiplier`=, `ScriptName`='npc_charscale_commander' WHERE `entry`=@ENTRY+23;
UPDATE `creature_template` SET `mindmg`=, `maxdmg`=, `attackpower`=, `dmg_multiplier`=, `ScriptName`='npc_charscale_invoker' WHERE `entry`=@ENTRY+17;
*/
UPDATE `instance_template` SET `script`='instance_ruby_sanctum' WHERE `map`=724;
