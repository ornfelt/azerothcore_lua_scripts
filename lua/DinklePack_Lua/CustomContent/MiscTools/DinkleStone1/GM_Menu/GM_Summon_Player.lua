--[[


]]

local GM_SUMMON_GossipID = 9910002
--(Start) Pulles for the guid for the player
local function getPlayerCharacterGUID(player)
    local query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
--(End)
function PLayerListSummonGossip(event, player)
	if player:GetGMRank() < 3 then
		return
	end
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Mail_gmicon:34|t Summon", 0, 1)
	player:GossipMenuAddItem(0, "|TInterface\\Icons\\Inv_misc_tournaments_banner_human:26|t Alliance", 0, 2)
	player:GossipMenuAddItem(0, "|TInterface\\Icons\\Inv_misc_tournaments_banner_orc:26|t Horde", 0, 3)
	player:GossipMenuAddItem(0, "|TInterface\\Icons\\Mail_gmicon:26|t GMs", 0, 4)
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 98)
	player:GossipSendMenu(1, player, GM_SUMMON_GossipID)
end
local function PLayerListAllianceGossip(event, player)
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_misc_tournaments_banner_human:34|t Summon (Alliance)", 0, 2)
	local worldPlayers = GetPlayersInWorld(0)
	for event, v in ipairs(worldPlayers) do
		local Name = tostring(v:GetName())
		local WPlayer = GetPlayerByName(Name)
		local PlayerID = math.floor(getPlayerCharacterGUID(WPlayer) + 1000)
		local Guid_List = getPlayerCharacterGUID(WPlayer)
		local Guid_Player = getPlayerCharacterGUID(player)
		if (Guid_List ~= Guid_Player) then
			player:GossipMenuAddItem(0,Name, 0, PlayerID, false, "Summon "..Name.."?")
		end
	end
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 1)
	player:GossipSendMenu(1, player, GM_SUMMON_GossipID)
end
local function PLayerListHordeGossip(event, player)
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_misc_tournaments_banner_orc:34|t Summon (Horde)", 0, 3)
	local worldPlayers = GetPlayersInWorld(1)
	for event, v in ipairs(worldPlayers) do
		local Name = tostring(v:GetName())
		local WPlayer = GetPlayerByName(Name)
		local PlayerID = math.floor(getPlayerCharacterGUID(WPlayer) + 1000)
		local Guid_List = getPlayerCharacterGUID(WPlayer)
		local Guid_Player = getPlayerCharacterGUID(player)
		if (Guid_List ~= Guid_Player) then
			player:GossipMenuAddItem(0,Name, 0, PlayerID, false, "Summon "..Name.."?")
		end
	end	
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 1)
	player:GossipSendMenu(1, player, GM_SUMMON_GossipID)
end
local function PLayerListGMsGossip(event, player)
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Mail_gmicon:34|t Summon (GM)", 0, 4)
	local worldPlayers = GetPlayersInWorld(2, true)
	for event, v in ipairs(worldPlayers) do
		local Name = tostring(v:GetName())
		local WPlayer = GetPlayerByName(Name)
		local PlayerID = math.floor(getPlayerCharacterGUID(WPlayer) + 1000)
		local Guid_List = getPlayerCharacterGUID(WPlayer)
		local Guid_Player = getPlayerCharacterGUID(player)
		if (Guid_List ~= Guid_Player) then
			player:GossipMenuAddItem(0,Name, 0, PlayerID, false, "Summon "..Name.."?")
		end
	end
	
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 1)
	player:GossipSendMenu(1, player, GM_SUMMON_GossipID)
end

--(Start)
local function GM_SUMMON_OnSelect(event, player, _, sender, intid, code)
local PlayerName = player:GetName()
	if(intid == 1) then --List
		PLayerListGossip(event, player)
	end	
	if(intid == 2) then --List
		PLayerListAllianceGossip(event, player)
	end	
	if(intid == 3) then --List
		PLayerListHordeGossip(event, player)
	end	
	if(intid == 4) then --List
		PLayerListGMsGossip(event, player)
	end
	if(intid == 97) then --Back
		MenuMenusGossip(event, player)
	end
	if(intid == 98) then --Back
		GMSettingsMenuGossip(event, player)
	end
	if(intid == 99) then --Close
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
	local worldPlayers = GetPlayersInWorld(2)
	for event, v in ipairs(worldPlayers) do
		local Name = tostring(v:GetName())
		local WPlayer = GetPlayerByName(Name)
		local PlayerID = math.floor(getPlayerCharacterGUID(WPlayer) + 1000)	
		if(intid == PlayerID) then		
			local map = player:GetMap()
			local mapId = map:GetMapId()
			--[[
			local xstring = string.sub(tostring(player:GetX()),1,10)
			local ystring = string.sub(tostring(player:GetY()),1,10)
			local zstring = string.sub(tostring(player:GetZ()),1,10)
			local ostring = string.sub(tostring(player:GetO()),1,10)
			]]
			local xstring = player:GetX() + 0.0
			local ystring = player:GetY() + 0.0
			local zstring = player:GetZ() + 0.0
			local ostring = player:GetO() + 0.0
			--player:SendBroadcastMessage(mapId.." "..xstring.." "..ystring.." "..zstring.." "..ostring)
			player:GossipComplete()
			WPlayer:Teleport(mapId, xstring, ystring, zstring+0.5, ostring)
			WPlayer:SendBroadcastMessage("|cffff3347Notice: |cffffd000"..Name.."|cff3399FF, You Have been summoned by a GM.")
			player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFSummoned player |cffffd000"..Name)
		end
	end
end
--(End)
RegisterPlayerGossipEvent(GM_SUMMON_GossipID, 2, GM_SUMMON_OnSelect)
