--[[

--VMangos V21
INSERT INTO `creature_template` (`entry`, `patch`, `display_id1`, `display_id2`, `display_id3`
	, `display_id4`, `name`, `subname`, `gossip_menu_id`, `level_min`
	, `level_max`, `faction`, `npc_flags`, `speed_walk`, `speed_run`
	, `display_scale1`, `detection_range`, `call_for_help_range`, `leash_range`, `rank`
	, `xp_multiplier`, `damage_school`, `damage_multiplier`, `base_attack_time`, `ranged_attack_time`
	, `unit_class`, `unit_flags`, `pet_family`, `trainer_type`, `trainer_spell`
	, `trainer_class`, `trainer_race`, `type`, `type_flags`, `loot_id`
	, `pickpocket_loot_id`, `skinning_loot_id`, `holy_res`, `fire_res`, `nature_res`
	, `frost_res`, `shadow_res`, `arcane_res`, `spell_id1`, `spell_id2`
	, `spell_id3`, `spell_id4`, `spell_list_id`, `pet_spell_list_id`, `gold_min`
	, `gold_max`, `ai_name`, `movement_type`, `inhabit_type`, `civilian`
	, `racial_leader`, `regeneration`, `equipment_id`, `trainer_id`, `vendor_id`
	, `mechanic_immune_mask`, `school_immune_mask`, `flags_extra`, `script_name`)
VALUES ('70009', '0', '11121', '0', '0'
	, '0', '角色更改系统', '角色更改系统', '0', '55'
	, '55', '35', '1', '1.1', '1.14286'
	, '0.1', '20', '5', '0', '0'
	, '1', '0', '1', '2000', '2000'
	, '8', '32768', '0', '0', '0'
	, '0', '0', '7', '0', '0'
	, '0', '0', '0', '0', '0'
	, '0', '0', '0', '0', '0'
	, '0', '0', '0', '0', '0'
	, '0', '', '0', '3', '0'
	, '0', '3', '0', '0', '0'
	, '0', '0', '0', '');

INSERT INTO `item_template` (`entry`, `patch`, `class`, `subclass`, `name`
	, `description`, `display_id`, `quality`, `flags`, `buy_count`
	, `buy_price`, `sell_price`, `inventory_type`, `allowable_class`, `allowable_race`
	, `item_level`, `required_level`, `required_skill`, `required_skill_rank`, `required_spell`
	, `required_honor_rank`, `required_city_rank`, `required_reputation_faction`, `required_reputation_rank`, `max_count`
	, `stackable`, `container_slots`, `stat_type1`, `stat_value1`, `stat_type2`
	, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`
	, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`
	, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`
	, `stat_type10`, `stat_value10`, `delay`, `range_mod`, `ammo_type`
	, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`
	, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`
	, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`
	, `block`, `armor`, `holy_res`, `fire_res`, `nature_res`
	, `frost_res`, `shadow_res`, `arcane_res`, `spellid_1`, `spelltrigger_1`
	, `spellcharges_1`, `spellppmrate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`
	, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmrate_2`, `spellcooldown_2`
	, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`
	, `spellppmrate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`
	, `spelltrigger_4`, `spellcharges_4`, `spellppmrate_4`, `spellcooldown_4`, `spellcategory_4`
	, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmrate_5`
	, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `page_text`
	, `page_language`, `page_material`, `start_quest`, `lock_id`, `material`
	, `sheath`, `random_property`, `set_id`, `max_durability`, `area_bound`
	, `map_bound`, `duration`, `bag_family`, `disenchant_id`, `food_type`
	, `min_money_loot`, `max_money_loot`, `wrapped_gift`, `extra_flags`, `other_team_entry`)
VALUES (25001, 0, 7, 0, 'Aquamarine'
	, '', 13496, 2, 0, 1
	, 4000, 1000, 0, -1, -1
	, 45, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 20, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, -1, 0, -1
	, 0, 0, 0, 0, -1
	, 0, -1, 0, 0, 0
	, 0, -1, 0, -1, 0
	, 0, 0, 0, -1, 0
	, -1, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 0
	, 0, 0, 0, 0, 1);


    INSERT INTO `mangos`.`locales_item` (`entry`, `name_loc1`, `name_loc2`, `name_loc3`, `name_loc4`, `name_loc5`, `name_loc6`, `name_loc7`, `name_loc8`, `description_loc1`, `description_loc2`, `description_loc3`, `description_loc4`, `description_loc5`, `description_loc6`, `description_loc7`, `description_loc8`) VALUES (25001, '남옥', 'Aigue-marine', 'Aquamarin', '我的钱', '青綠石', 'Aguamarina', 'Aguamarina', 'Аквамарин', '', NULL, '', '', '', '', '', NULL);


]]
print("player change system.")
local NpcEntry = 70009
local ItemEntry = 25001
local ItemName = GetItemLink(ItemEntry,4)
local function OnGossipHello(event, player, item)
    --print(ItemName)
    player:GossipClearMenu()
    player:GossipMenuAddItem(3, "修改玩家名称"..ItemName.." x10", 0, 1)
    -- player:GossipMenuAddItem(10, "更改角色外观"..ItemName.." x10", 0, 2)
    -- player:GossipMenuAddItem(10, "更改玩家阵营"..ItemName.." x10", 0, 3)
    -- player:GossipMenuAddItem(10, "更改玩家种族"..ItemName.." x10", 0, 4)
    player:GossipSendMenu(1, item)
end

local function OnGossipSelect(event, player, item, sender, intid, code)
    if (intid == 1) then
        if (player:HasItem(ItemEntry) and player:GetItemCount(ItemEntry) >= 10) then
            player:SetAtLoginFlag(0x01)
            player:RemoveItem(ItemEntry, 10)
            player:SendNotification("修改成功！玩家返回到角色选择界面即可修改角色名称！")
			player:GossipComplete()
        else
            player:SendNotification("你的"..ItemName.."不足，无法进行此项操作！")
			player:GossipComplete()
        end
    elseif (intid == 2) then
        if (player:HasItem(ItemEntry) and player:GetItemCount(ItemEntry) >= 10) then
            player:SetAtLoginFlag(0x08)
            player:RemoveItem(ItemEntry, 10)
            player:SendNotification("修改成功！玩家返回到角色选择界面即可修改角色外观！")
			player:GossipComplete()
        else
            player:SendNotification("你的"..ItemName.."不足，无法进行此项操作！")
			player:GossipComplete()
        end
    elseif (intid == 3) then
        if (player:HasItem(ItemEntry) and player:GetItemCount(ItemEntry) >= 10) then
            player:SetAtLoginFlag(0x40)
            player:RemoveItem(ItemEntry, 10)
            player:SendNotification("修改成功！玩家返回到角色选择界面即可修改角色阵营！")
			player:GossipComplete()
        else
            player:SendNotification("你的"..ItemName.."不足，无法进行此项操作！")
			player:GossipComplete()
        end
    elseif (intid == 4) then
        if (player:HasItem(ItemEntry) and player:GetItemCount(ItemEntry) >= 10) then
            player:SetAtLoginFlag(0x80)
            player:RemoveItem(ItemEntry, 10)
            player:SendNotification("修改成功！玩家返回到角色选择界面即可修改角色种族！")
			player:GossipComplete()
        else
            player:SendNotification("你的"..ItemName.."不足，无法进行此项操作！")
			player:GossipComplete()
        end
    end
end
RegisterCreatureGossipEvent(NpcEntry, 1, OnGossipHello)
RegisterCreatureGossipEvent(NpcEntry, 2, OnGossipSelect)
-- RegisterItemGossipEvent(itemid, 1, OnGossipHello)
-- RegisterItemGossipEvent(itemid, 2, OnGossipSelect)
