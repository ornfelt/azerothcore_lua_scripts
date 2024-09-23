--[[
Rock, Paper, Scissor Game
Original script made by Billtheslug.
Updated and converted to eluna by ToxicDev.
Version 1.1
modified by slp13at420 into gambling game.

-- vmangos v21
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
VALUES ('71000', '0', '11121', '0', '0'
	, '0', '赌博系统', '石头、剪刀、布', '0', '55'
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
]]--
local GOSSIP_EVENT_ON_HELLO                           = 1
local GOSSIP_EVENT_ON_SELECT                          = 2
print("Loading the Rock_Paper_Scissor")

local NPC_ID = 71000
local price = 100 -- in gold. min 1 gold.

function On_Gossip(event, plr, unit)
	if(plr:GetCoinage()>=(price*10000))then
		plr:GossipMenuAddItem(0, "|cffcc0000费用"..price.."金币|r", 0, 0, 0)
		plr:GossipMenuAddItem(0, "|cff0000ff我出石头|r", 0, 1, 0)
		plr:GossipMenuAddItem(0, "|cffcc0033我出布|r", 0, 2, 0)
		plr:GossipMenuAddItem(0, "|cff009900我出剪刀|r", 0, 3, 0)
		plr:GossipMenuAddItem(0, "|cffff0000没钱就快给我滚蛋!|r", 0, 4,0)
		plr:GossipSendMenu(1, unit)
	else
	    plr:SendBroadcastMessage("需要 "..price.." |cffffcc00金币|r")
	end
end

function On_Select(event, plr, unit, arg2, intid)
	if(intid == 0)then
		On_Gossip(event, plr, unit)
		return
		
	elseif(intid == 4)then
		plr:GossipComplete()
		return
		
	else
		plr:ModifyMoney(-(price*10000))
		plr:SendBroadcastMessage("|cffff00ff支付"..price.."|r")

		if (intid == 1) then
			local m = math.random(1, 3)
			if (m == 1) then
				plr:SendBroadcastMessage("|cffffcc00居然是平手这不科学啊！|r")
				plr:GossipComplete()
			end
			if (m == 2) then
				plr:SendBroadcastMessage("|cffffcc00哈哈！这次不能得意了吧！钱拿来！|r")
				plr:GossipComplete()
			end
			if (m == 3) then
				plr:SendBroadcastMessage("|cffffcc00失误！你赢了！不要得意有本事继续|r.")
				plr:SendBroadcastMessage("|cffff00ff获得了"..(price*2).."|r")
				plr:ModifyMoney((price*10000)*2)
				plr:GossipComplete()
			end
		end
	
		if (intid == 2) then
			local m = math.random(1, 3)
			if (m == 1) then
				plr:SendBroadcastMessage("|cffffcc00失误！你赢了！我让你的|r.")
				plr:SendBroadcastMessage("|cffff00ff获得了"..(price*2).."|r")
				plr:ModifyMoney((price*10000)*2)
				plr:GossipComplete()
			end
			if (m == 2) then
				plr:SendBroadcastMessage("|cffffcc00哎！早知道我出剪刀|r")
				plr:GossipComplete()
			end
			if (m == 3) then
				plr:SendBroadcastMessage("|cffffcc00我赢了！如果没钱你可以脱衣服！|r")
				plr:GossipComplete()
			end
		end
	
		if (intid == 3) then
			local m = math.random(1, 3)
			if (m == 1) then
				plr:SendBroadcastMessage("|cffffcc00我赢了！如果没钱你可以脱衣服！|r")
				plr:GossipComplete()
			end
			if (m == 2) then
				plr:SendBroadcastMessage("|cffffcc00失误！你赢了！|r")
				plr:SendBroadcastMessage("|cffff00ff获得了"..(price*2).."|r")
				plr:ModifyMoney((price*10000)*2)
				plr:GossipComplete()
			end
			if (m == 3) then
				plr:SendBroadcastMessage("|cffffcc00平手！你居然也出剪刀！|r")
				plr:GossipComplete()
			end
		end
	end
end

RegisterCreatureGossipEvent(NPC_ID, GOSSIP_EVENT_ON_HELLO, On_Gossip)
RegisterCreatureGossipEvent(NPC_ID, GOSSIP_EVENT_ON_SELECT, On_Select)