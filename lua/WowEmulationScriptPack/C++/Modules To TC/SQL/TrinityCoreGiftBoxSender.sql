/*
-- ############################################################################################################# --
-- 
--  ____    __                                         ______  __              ____                    __      
-- /\  _`\ /\ \__                  __                 /\__  _\/\ \            /\  _`\                 /\ \__   
-- \ \,\L\_\ \ ,_\  __  __     __ /\_\     __      ___\/_/\ \/\ \ \___      __\ \ \L\ \     __    ____\ \ ,_\  
--  \/_\__ \\ \ \/ /\ \/\ \  /'_ `\/\ \  /'__`\  /' _ `\ \ \ \ \ \  _ `\  /'__`\ \  _ <'  /'__`\ /',__\\ \ \/  
--    /\ \L\ \ \ \_\ \ \_\ \/\ \L\ \ \ \/\ \L\.\_/\ \/\ \ \ \ \ \ \ \ \ \/\  __/\ \ \L\ \/\  __//\__, `\\ \ \_ 
--    \ `\____\ \__\\/`____ \ \____ \ \_\ \__/.\_\ \_\ \_\ \ \_\ \ \_\ \_\ \____\\ \____/\ \____\/\____/ \ \__\
--     \/_____/\/__/ `/___/> \/___L\ \/_/\/__/\/_/\/_/\/_/  \/_/  \/_/\/_/\/____/ \/___/  \/____/\/___/   \/__/
--                     /\___/ /\____/                                                                         
--                     \/__/  \_/__/               http://stygianthebest.github.io                                                    
--
-- ############################################################################################################# --
--
-- 	Giftbox Sender
-- 	By Tkrokli (https://github.com/tkrokli)
-- 	
-- 	Ported to AzerothCore by StygianTheBest
-- 
-- 	This sends the player Landro's Gifts upon reaching a specified level. The items are comprised of TCG loot
--	card items that cannot be obtained within the game.
--
--
--
-- Converted to latest TrinityCore [3.3.5a] (https://github.com/TrinityCore/TrinityCore/blob/3.3.5/)
-- By TheFrozenThr0ne (https://GamersCentral.de/) (https://github.com/MaDmaX1337/)
--
-- ############################################################################################################# --
*/


USE world;

-- ######################################################--
--	GIFT BOX SENDER - 601018
-- ######################################################--

DELETE FROM `creature_template` WHERE `entry`=601018;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `baseattacktime`, `rangeattacktime`, `basevariance`, `rangevariance`,  `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (601018, 0, 0, 0, 0, 0, 21661, 0, 0, 0, 'Styx', 'Loremaster', NULL, 4110, 26, 26, 0, 12, 81, 1, 1.14286, 1, 0, 0, 1, 1, 1500, 2000, 1, 512, 2048, 0, 0, 2, 0, 0, 0, 25, 37, 7, 7, 'SmartAI', 0, 1, 1.05, 1, 1, 0, 0, 0, 0, 1, 0, 2, '', 12340);

-- Achievement For Levels
REPLACE INTO `achievement_reward` (`ID`, `titleA`, `titleH`, `itemID`, `sender`, `subject`, `Body`, `mailTemplateID`) VALUES
(6, 0, 0, 60001, 601018, 'Congrats on your level! (10)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(7, 0, 0, 60002, 601018, 'Congrats on your level! (20)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(8, 0, 0, 60003, 601018, 'Congrats on your level! (30)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(9, 0, 0, 60004, 601018, 'Congrats on your level! (40)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(10, 0, 0, 60005, 601018, 'Congrats on your level! (50)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(11, 0, 0, 60006, 601018, 'Congrats on your level! (60)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(12, 0, 0, 60007, 601018, 'Congrats on your level! (70)', 'Dear $N,$B$BCongratulations on reaching another level milestone! For your hard work and dedication, please accept this gift on behalf of.. well, me. Keep it up!$B$BYour GM,$BGameMaster Styx', 0),
(1558, 0, 0, 33223, 601018, 'We heard you like fishing...', '... so you might as well do it in style, $N!$B$BEnjoy!$BGameMaster Styx', 0),
(1795, 0, 0, 32566, 601018, 'We heard you like cooking...', '... so take some time out to enjoy the fruits of your labour, $N!$B$BEnjoy!$BGameMaster Styx', 0);

-- Items For Loot
DELETE FROM `item_loot_template` WHERE `Entry` = 50301;
DELETE FROM `item_loot_template` WHERE `Entry` = 54218;
REPLACE INTO `item_loot_template` VALUES
(50301, 13582, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 13583, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 13584, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 20371, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 23713, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 32588, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 34492, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 34493, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 35223, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 38050, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 39656, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 45047, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 46779, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 46802, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 49287, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(50301, 49343, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 23705, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 23709, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 32542, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 32566, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 33079, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 33219, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 33223, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 34499, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 35223, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 35227, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38233, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38309, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38310, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38311, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38312, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38313, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38314, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38577, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 38578, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 45037, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 45047, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 45063, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 46779, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 46780, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 49703, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 49704, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 54212, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 54452, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(54218, 54455, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 23720, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 37719, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 43599, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 49282, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 49283, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 49284, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 49285, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 49286, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 49290, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 54068, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 54069, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 54811, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60000, 54860, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60001, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60001, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60001, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60002, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60002, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60002, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60003, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60003, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60003, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60004, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60004, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60004, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60005, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60005, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60005, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60006, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60006, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60006, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60007, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60007, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60007, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60008, 50301, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60008, 54218, 0, 7.69, 0, 1, 1, 1, 1, NULL),
(60008, 60000, 0, 7.69, 0, 1, 1, 1, 1, NULL);

-- Mail Items
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`) VALUES
(50301, 15, 0, -1, 'Landro\'s Pet Box', 35407, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 'NOTE: Not Guaranteed to Contain an Actual Pet', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 10000, 10000, 0, 12340),
(54218, 15, 0, -1, 'Landro\'s Gift Box', 22192, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 'NOTE: Not Guaranteed to Contain an Actual Gift', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 10000, 10000, 0, 12340),
(60000, 15, 0, -1, 'Landro\'s Mount Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 'NOTE: Not Guaranteed to Contain an Actual Mount', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 10000, 10000, 0, 12340),
(60001, 15, 0, -1, 'Level 10 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 10', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 100000, 100000, 0, 12340),
(60002, 15, 0, -1, 'Level 20 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 20', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 200000, 200000, 0, 12340),
(60003, 15, 0, -1, 'Level 30 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 30, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 30', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 300000, 300000, 0, 12340),
(60004, 15, 0, -1, 'Level 40 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 40, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 40', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 400000, 400000, 0, 12340),
(60005, 15, 0, -1, 'Level 50 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 50', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 500000, 500000, 0, 12340),
(60006, 15, 0, -1, 'Level 60 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 60', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 600000, 600000, 0, 12340),
(60007, 15, 0, -1, 'Level 70 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 70', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 700000, 700000, 0, 12340),
(60008, 15, 0, -1, 'Level 80 Gift Box', 53044, 1, 4, 0, 1, 0, 0, 0, -1, -1, 1, 80, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Achievement Reward for Level 80', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 1000000, 1000000, 0, 12340);