local config = require ('!config')-- Need Don't Remove

local luaName = "Other Menu"
local luaNameShort = "OM_"

local debugON = config.get(luaNameShort.."debugOn")
local enabled = config.get(luaNameShort.."enabled", debugON)
local GossipID = config.get(luaNameShort.."GossipID", debugON)
local minExpRate = config.get(luaNameShort.."minExpRate", debugON)
local maxExpRate = config.get(luaNameShort.."maxExpRate", debugON)

if debugON then
	print("ECC: Configs for "..luaName.." Loaded") -- Finished Loading
end

-- Do not change or remove
local Gold = 10000

--(Start) The Gossip Menu that shows Main Menu
function OtherMenuGossip(event, player)
	if player:IsInCombat() then
        return
    end
	
    local PUID = player:GetGUIDLow(player)
    local Q_EXPrate = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
	local Q_EXPrate = tonumber(string.format("%.2f", Q_EXPrate:GetFloat(1)))
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_letter_05:45:45:-40|t Mail Box", 0, 1)
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_crate_04:45:45:-40|t Personal Bank", 0, 2)
	--player:GossipMenuAddItem(3, "|TInterface\\Icons\\inv_misc_rune_01:45:45:-40|t Guild Bank", 0, 3
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\spell_fire_flare:45:45:-40|t NPC Summon Menu", 0, 4)
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_gizmo_thebiggerone:45:45:-40|t Reset Dungeons & Raids", 0, 10, false, "Note: Leave group before using this!")	
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\achievement_boss_mutanus_the_devourer:45:45:-40|t ReCustomize Character", 0, 20)
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Ability_rogue_disguise:45:45:-40|t Morph Menu", 0, 21)
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\achievement_boss_mutanus_the_devourer:45:45:-40|t Set EXP Rate \n     |TInterface\\Icons\\Inv_misc_coin_01:25|t Current Rate: "..Q_EXPrate.."", 0, 30, true, "Type a number "..minExpRate.." to "..maxExpRate.." to set your experience rate.")
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9999)
	player:GossipSendMenu(1, player, GossipID)

end
--(End)

--(Start)
local function OnSelect(event, player, object, sender, intid, code, menu_id)
	local PlayerName = player:GetName()
	Gossipintid_Use = 100
	Gossipintid_Delete = 1000
	local currentgold = player:GetCoinage()	
    local PUID = player:GetGUIDLow(player)
	
	local x = player:GetX()
	local y = player:GetY()
	local z = player:GetZ()
	local o = player:GetO()
	local map = player:GetMap()
	local mapID = map:GetMapId()
	local areaId = map:GetAreaId( x, y, z )
	
	if(intid == 1) then -- Mail	
		player:SendShowMailBox( GuidN )
	end	
	if(intid == 2) then -- Personal Bank	
		player:SendShowBank( player )
	end	
	if(intid == 3) then -- Guild Bank	
		guild = player:GetGuild()
		player:SendShowBank( guild )
	end
	if(intid == 4) then -- NPC Summon Menu
		NPC_Summon_MenuGossip(event, player)
	end	
	if(intid== 10) then -- Reset Instances/Raids
		player:UnbindAllInstances()
		player:SendBroadcastMessage("|cffff3347Notice: |cffffd000Instances/Raids have been Reset.")
		player:GossipComplete()
	end	
	if(intid == 20) then --ReCustomize Character
		ChangeMenuGossip(event, player)
	end	
	if(intid == 21) then --ReCustomize Character
		Morph_MenuMenuGossip(event, player)
	end	
	if (intid == 30) then
		local ExpRate = tonumber(code)
		if ExpRate and ExpRate >= minExpRate and ExpRate <= maxExpRate then
		
				player:GossipComplete()
                WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
                WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, %.2f)", PUID, ExpRate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your experience rate to %.2fx|r", ExpRate))
				player:GossipComplete()
                return false
        end
	end
	if(intid == 9999) then --Back
		MenuMenusGossip(event, player)
	end
end
--(End)


if enabled then
RegisterPlayerGossipEvent(GossipID, 2, OnSelect)
end
