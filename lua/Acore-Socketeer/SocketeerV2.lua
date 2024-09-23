-- by Dinkledork
-- Run the following SQL first: DELETE FROM `creature_template` WHERE `entry`=190015;
-- INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (190015, 0, 0, 0, 0, 0, 2575, 0, 0, 0, 'Aria Willowleaf', 'Socketeer', NULL, 0, 10, 10, 0, 35, 1, 1.2, 1.24286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 2, '', 12340);
-- UPDATE `item_template` SET `entry`=37430, `class`=0, `subclass`=6, `SoundOverrideSubclass`=-1, `name`='Socket Enchant', `displayid`=811, `Quality`=3, `Flags`=268435520, `FlagsExtra`=0, `BuyCount`=1, `BuyPrice`=0, `SellPrice`=0, `InventoryType`=0, `AllowableClass`=-1, `AllowableRace`=-1, `ItemLevel`=0, `RequiredLevel`=0, `RequiredSkill`=0, `RequiredSkillRank`=0, `requiredspell`=0, `requiredhonorrank`=0, `RequiredCityRank`=0, `RequiredReputationFaction`=0, `RequiredReputationRank`=0, `maxcount`=0, `stackable`=200, `ContainerSlots`=0, `StatsCount`=0, `stat_type1`=0, `stat_value1`=0, `stat_type2`=0, `stat_value2`=0, `stat_type3`=0, `stat_value3`=0, `stat_type4`=0, `stat_value4`=0, `stat_type5`=0, `stat_value5`=0, `stat_type6`=0, `stat_value6`=0, `stat_type7`=0, `stat_value7`=0, `stat_type8`=0, `stat_value8`=0, `stat_type9`=0, `stat_value9`=0, `stat_type10`=0, `stat_value10`=0, `ScalingStatDistribution`=0, `ScalingStatValue`=0, `dmg_min1`=0, `dmg_max1`=0, `dmg_type1`=0, `dmg_min2`=0, `dmg_max2`=0, `dmg_type2`=0, `armor`=0, `holy_res`=0, `fire_res`=0, `nature_res`=0, `frost_res`=0, `shadow_res`=0, `arcane_res`=0, `delay`=0, `ammo_type`=0, `RangedModRange`=0, `spellid_1`=50270, `spelltrigger_1`=0, `spellcharges_1`=-1, `spellppmRate_1`=0, `spellcooldown_1`=0, `spellcategory_1`=0, `spellcategorycooldown_1`=0, `spellid_2`=0, `spelltrigger_2`=0, `spellcharges_2`=0, `spellppmRate_2`=0, `spellcooldown_2`=-1, `spellcategory_2`=0, `spellcategorycooldown_2`=-1, `spellid_3`=0, `spelltrigger_3`=0, `spellcharges_3`=0, `spellppmRate_3`=0, `spellcooldown_3`=-1, `spellcategory_3`=0, `spellcategorycooldown_3`=-1, `spellid_4`=0, `spelltrigger_4`=0, `spellcharges_4`=0, `spellppmRate_4`=0, `spellcooldown_4`=-1, `spellcategory_4`=0, `spellcategorycooldown_4`=-1, `spellid_5`=0, `spelltrigger_5`=0, `spellcharges_5`=0, `spellppmRate_5`=0, `spellcooldown_5`=-1, `spellcategory_5`=0, `spellcategorycooldown_5`=-1, `bonding`=0, `description`='On Use: Socket a piece of equipment.', `PageText`=0, `LanguageID`=0, `PageMaterial`=0, `startquest`=0, `lockid`=0, `Material`=8, `sheath`=0, `RandomProperty`=0, `RandomSuffix`=0, `block`=0, `itemset`=0, `MaxDurability`=0, `area`=0, `Map`=0, `BagFamily`=0, `TotemCategory`=0, `socketColor_1`=0, `socketContent_1`=0, `socketColor_2`=0, `socketContent_2`=0, `socketColor_3`=0, `socketContent_3`=0, `socketBonus`=0, `GemProperties`=0, `RequiredDisenchantSkill`=-1, `ArmorDamageModifier`=0, `duration`=0, `ItemLimitCategory`=0, `HolidayId`=0, `ScriptName`='', `DisenchantID`=0, `FoodType`=0, `minMoneyLoot`=0, `maxMoneyLoot`=0, `flagsCustom`=0, `VerifiedBuild`=12340 WHERE `entry`=37430;

-- This script creates an NPC that allows you to exchange money for a socket enchant you can use on any piece of equipment
--Just .npc add 190015 You may need to restart server first.

local SocketEnchant = 37430 -- Item ID
local RequiredMoney = 100000 -- Example required money amount in copper (10g)

local function OnGossipHello(event, player, creature)
player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_misc_gem_variety_01:50:50:-43:0|tPurchase gem sockets for your gear?", 0, 1)
player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
if (intid == 1) then
local requiredMoney = RequiredMoney
player:SendBroadcastMessage("Exchanging " .. requiredMoney / 100 / 100 .. " gold for a socket enchant. Are you sure?")
player:GossipMenuAddItem(0, "Yes", 0, 2)
player:GossipMenuAddItem(0, "No", 0, 3)
player:GossipSendMenu(1, creature)
elseif (intid == 2) then
if (player:GetCoinage() >= RequiredMoney) then
player:SetCoinage(player:GetCoinage() - RequiredMoney)
player:AddItem(SocketEnchant, 1)
player:SendBroadcastMessage("The socket enchant has been added to your inventory.")
player:GossipComplete()
else
player:SendBroadcastMessage("You do not have enough money.")
player:GossipComplete()
end
elseif (intid == 3) then
player:GossipComplete()
end
end

RegisterCreatureGossipEvent(190015, 1, OnGossipHello)
RegisterCreatureGossipEvent(190015, 2, OnGossipSelect)


