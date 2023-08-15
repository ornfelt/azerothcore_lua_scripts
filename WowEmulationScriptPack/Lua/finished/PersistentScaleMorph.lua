-- Owner: grimreapaa

-- rbac rank required to use `.wmorph <display>`
ACCOUNT_LEVEL = 3

-- GOSSIP_MENU entry. make a corresponding npc_text too.
GOSSIP_MENU = 65013

-- creature entry
CREATURE_ENTRY = 1000018

function LoadMorphs()
    MorphsGUIDs = {}
    local Query = CharDBQuery("SELECT DISTINCT guid FROM character_model_info;")
    if(Query) then
        repeat
            MorphsGUIDs[Query:GetUInt32(0)]="true"
        until not Query:NextRow()
        PrintInfo("[PersistentScaleMorph]: GUID list initialized. Loaded "..Query:GetRowCount().." results.")
    else
        PrintInfo("[PersistentScaleMorph]: GUID list initialized. No results found.")
    end
end

local function ThunkHello(event, player, creature)
	player:GossipMenuAddItem(0, "Change Scale", GOSSIP_MENU, 1, true, "Enter any number that is in between 0.8 and 1.15")
	player:GossipMenuAddItem(0, "HIT ME!", GOSSIP_MENU, 2)
	player:GossipSendMenu(GOSSIP_MENU, creature, MenuId)
end

local function ThunkSelect(event, player, creature, sender, intid, code)
	local code2 = tonumber(code)
	local player_guid = player:GetGUIDLow()
	if (intid == 1) then
		if (code2 == nil) then
			player:SendBroadcastMessage("You must enter a valid number.")
			return false
		elseif (code2 < 0.8) then
			player:SendBroadcastMessage("You must enter a valid number.")
			return false
		elseif (code2 > 1.15) then
			player:SendBroadcastMessage("You must enter a valid number.")
			return false
		else
			local Scale_Query1 = CharDBQuery("SELECT `scale` FROM `character_model_info` WHERE `guid` = " ..player_guid.. ";")
			if (Scale_Query1 == nil) then
				CharDBExecute("INSERT INTO `character_model_info` (`guid`, `scale`) VALUES ('" ..player_guid.. "', '" ..code2.. "');")
			else
				CharDBExecute("UPDATE `character_model_info` SET `scale` = " ..code2.. " WHERE `guid` = " ..player_guid.. ";")
			end
			player:SetScale(code2)
			player:GossipClearMenu()
			player:GossipComplete()
			LoadMorphs()
		end
	elseif (intid == 2) then
		lol = math.random(1, 6)
		SPELLS = {16707, 16708, 16709, 16716, 71909, 59047}
		creature:Emote(35)
		creature:CastSpell(player, SPELLS[lol], true)
		creature:SendUnitSay("Okay, but no crying!", 0)
		player:GossipClearMenu()
		player:GossipComplete()
	end
end

local function ScaleApply(event, player)
	local Scale_Query2 = CharDBQuery("SELECT `scale`, `morph` FROM `character_model_info` WHERE `guid` = " ..player:GetGUIDLow().. ";")
	if (Scale_Query2 == nil) then
		return false
	end
	
	local scale = Scale_Query2:GetFloat(0)
	local morph = Scale_Query2:GetInt32(1)
	-- scale nil but morph isnt
	if (scale == nil) and (morph ~= nil) and (morph ~= 0) then
		player:SetDisplayId(morph)
		player:SetNativeDisplayId(morph)
	-- morph nil but scale not
	elseif (morph == nil) and (scale ~= nil) or (morph == 0) then
		player:DeMorph()
		player:SetScale(scale)
	-- both not nil
	else
		player:SetDisplayId(morph)
		player:SetNativeDisplayId(morph)
		player:SetScale(scale)
	end
end

local function GM_Morph(event, player, command)
	if (command:find("wmorph ") ~= 1) then
		return
	elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
		return false
	end

	local pattern = "%S+" -- Separate by spaces
	local parameters = {}
	local parameters = getCommandParameters(command)
	local target = player:GetSelection()
	local morph = tonumber(parameters[2])
	if (morph == nil) then
		player:SendBroadcastMessage("You must input a number.")
		return false
	elseif (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	elseif (target:ToPlayer() == nil) then
		player:SendBroadcastMessage("You must target a player.")
		return false
	end
	
	-- clears morph if id is 0
	local target_guid = target:GetGUIDLow()
	if (morph == 0) then
		CharDBExecute("DELETE FROM `character_model_info` WHERE guid = " ..target_guid.. ";")
		target:SetScale(1.0)
		target:DeMorph()
		player:SendBroadcastMessage("You have cleared scale and morph info for " ..target:GetName().. ". Inform the player to relog to restore their original model.")
		target:SendBroadcastMessage(player:GetName() .. " has cleared scale and morph info for " ..target:GetName().. ". Please relog to restore your model.")
    	LoadMorphs()
		return false
	else
		local Morph_Query1 = CharDBQuery("SELECT `morph` FROM `character_model_info` WHERE `guid` = " ..target_guid.. ";")
		if (Morph_Query1 == nil) then
			CharDBExecute("INSERT INTO `character_model_info` (`guid`, `morph`, `scale`) VALUES ('" ..target_guid.. "', '" ..morph.. "', '1');")
		else
			CharDBExecute("UPDATE `character_model_info` SET `morph` = " ..morph.. " WHERE `guid` = " ..target_guid.. ";")
		end
		target:SetDisplayId(morph)
		target:SetNativeDisplayId(morph)
		player:SendBroadcastMessage("You have set " ..target:GetName().. "'s display to " ..morph.. ".")
		LoadMorphs()
		return false
	end
end

local function Player_Morph(event, player, command)
	if (command:find("morphme") ~= 1) then
		return
	else
    	if (player:IsInCombat() == true) then
			player:SendBroadcastMessage("You cannot be in combat.")
			return false
		elseif (MorphsGUIDs[player:GetGUIDLow()] == "true") then -- Characters GUID exists in preloaded list.
			player:SendBroadcastMessage("Morphing you back.")
			ScaleApply(3, player)
			return false
		else
			player:SendBroadcastMessage("You don't have a morph.")
			return false
		end
	end
end

LoadMorphs()
RegisterPlayerEvent(42, GM_Morph)
RegisterPlayerEvent(3, ScaleApply)
RegisterPlayerEvent(42, Player_Morph)
RegisterCreatureGossipEvent(CREATURE_ENTRY, 1, ThunkHello)
RegisterCreatureGossipEvent(CREATURE_ENTRY, 2, ThunkSelect)
