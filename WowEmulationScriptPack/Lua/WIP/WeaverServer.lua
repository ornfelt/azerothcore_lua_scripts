local AIO = AIO or require("AIO")
local WeaverHandlers = AIO.AddHandlers("Weaver", {})
local ToolBarHandlers4 = AIO.AddHandlers("ToolBar4", {})

-- notes:
-- (player:GetGMRank() == 0) refers to players with RBAC ID 0, or by default, normal players

-- amount of objects to cap for a weaver to spawn
WEAVER_CAP_OBJECT = 50

-- amount of NPCs to cap for a weaver to spawn
WEAVER_CAP_NPC = 50

-- amount of stacks of dmg/hp buffs a weaver can put on an npc
WEAVER_CAP_BUFF = 10

-- the RBAC ID for a weaver account
WEAVER_RBAC_ID = 1

-- AURA IDs for .wbuff 
damage_aura = 2000036
health_aura = 2000035

-- REALM ID for weavers to function on
REALM_ID = 1



-- .weaver broadcast
local function WeaverChat(event, player, command)
	if (command:find("weaver ") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	else
		command = string.gsub(command,"weaver ","")
		-- gets every character in world
		local GM = GetPlayersInWorld(2)
		for x=1,#GM,1 do
			-- sends broadcast message to player, so long as they are not RBAC rank 0.
			if (GM[x]:GetGMRank() ~= 0) then
				PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WEAVER` with parameters: " ..command.. ".")
				GM[x]:SendBroadcastMessage("[|cff00FFFFWeaver announce by|r |cff66ffcc" ..player:GetName().. "|r]: " ..command)
			end
		end
		return false
	end
end

-- .wspawns
local function WeaverSpawns(event, player, command)
	if (command:find("wspawns") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local WeaverQuery7 = WorldDBQuery("SELECT `guid`, `entry`, `type` FROM `weaver_spawned` WHERE `owner_account` = '" ..player:GetAccountName().. "' GROUP BY `type` ASC;")
	if WeaverQuery7 == nil then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You do not have any spawns used.")
		return false
	else
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: Your following spawns are:")
		npc_count = 0
		obj_count = 0
		for m=1,WeaverQuery7:GetRowCount(),1 do
			if WeaverQuery7:GetInt32(2) == 1 then
				npc_count = npc_count + 1
				string = "OBJ (" ..npc_count.. "/" ..WEAVER_CAP_NPC.. ")"
			else
				obj_count = obj_count + 1
				string = "NPC (" ..obj_count.. "/" ..WEAVER_CAP_OBJECT.. ")"
			end
			player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: " ..string.. " with GUID: " ..WeaverQuery7:GetInt32(0).. " and Entry: " ..WeaverQuery7:GetInt32(1).. ".")
			WeaverQuery7:NextRow()
		end
		return false
	end
end

-- .wobject add
local function WeaverObjectAdd(event, player, command)
	if (command:find("wobj add") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local pattern = "%S+" -- Separate by spaces
	local parameters = {}
	local parameters = getCommandParameters(command)
	if (parameters[3] == nil) or tonumber(parameters[3]) == nil then
		player:SendBroadcastMessage("Syntax: .wobj add $entry\nSpawns an object based on entry. Weavers can have up to " ..WEAVER_CAP_OBJECT.. " objects spawned at a time.\nTo find objects, use .lookup object.")
		return false
	end
	
	-- here we stop error spam from a nil instanceid
	local instanceid = player:GetInstanceId()
	if (instanceid == nil) then
		instanceid = 0
	end
	
	-- does our weaver already have 5 spawns?
	local WeaverQuery1 = WorldDBQuery("SELECT `guid` FROM `weaver_spawned` WHERE `owner_guid` = " ..player:GetGUIDLow().. " AND `type` = 1;")
	local x, y, z, o = player:GetLocation()
	RowCount = 0
	if (WeaverQuery1 ~= nil) then
		RowCount = WeaverQuery1:GetRowCount()
		if (RowCount >= WEAVER_CAP_OBJECT) then
			player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You can only spawn " ..WEAVER_CAP_OBJECT.. " objects.")
			return false
		end
	end
	
	local x, y, z, o = player:GetLocation()
	local map_id = player:GetMapId()

	-- spawn the object
	PerformIngameSpawn(2, parameters[3], map_id, instanceid, x, y, z, o, true, 0, 1)
	
	local nearestobjects = player:GetGameObjectsInRange(10, parameters[3], 0)
	-- did the object spawn? if it didnt, more than likely an incorrect entry.
	if (nearestobjects[1] == nil) then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: The entry you provided does not exist.")
		return false
	end
	
	local WeaverQuery2 = WorldDBQuery("SELECT `guid` FROM `weaver_spawned` WHERE `type` = 1 AND `guid` = " ..nearestobjects[1]:GetDBTableGUIDLow().. ";")
	
	-- this is made to catch any overlap of GUIDs and attempts to fix them.
	for x=1,#nearestobjects,1 do
		if WeaverQuery2 ~= nearestobjects[x] then
--			player:SendBroadcastMessage("Detecting break. Fixing?")
			nearestobject_guid = nearestobjects[x]:GetDBTableGUIDLow()
			nearestobject_raw = nearestobjects[x]:GetGUIDLow()
			break
		end
	end
	
	-- type = 1 for obj spawn
	WorldDBExecute("INSERT INTO `elunaworld`.`weaver_spawned` (`type`, `guid`, `guid_raw`, `entry`, `map`, `x`, `y`, `z`, `o`, `timestamp`, `owner_character`, `owner_account`, `owner_guid`) VALUES ('1', '" ..nearestobject_guid.. "', '" ..nearestobject_raw.. "', '" ..parameters[3].. "', '" ..map_id.. "', '" ..x.. "', '" ..y.. "', '" ..z.. "', '" ..o.. "', '" ..tostring(GetGameTime()).. "', '" ..player:GetName().. "', '" ..player:GetAccountName().. "', '" ..player:GetGUIDLow().. "');")
	player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You have spawned an object with GUID " ..nearestobject_guid.. " (Spawned: " ..(RowCount + 1).. "/" ..WEAVER_CAP_OBJECT..").")
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WOBJ ADD` with parameters: " ..command.. " and GUID: " ..nearestobject_guid.. ".")
	return false
end

-- .wobject del
local function WeaverObjectDel(event, player, command)
	if (command:find("wobj del") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local pattern = "%S+" -- Separate by spaces
	local parameters = {}
	local parameters = getCommandParameters(command)
	if (parameters[3] == nil) or (tonumber(parameters[3] == nil)) then
		-- help message
		player:SendBroadcastMessage("Syntax: .wobj del $guid\nDeletes an object based on entry. Weavers can have up to " ..WEAVER_CAP_OBJECT.. " objects spawned at a time.\nTo find objects, use .gob tar.")
		return false
	end
	
	local WeaverQuery3 = WorldDBQuery("SELECT `guid_raw`, `entry`, `map`, `owner_account`, `owner_character` FROM `weaver_spawned` WHERE `guid` = " ..parameters[3].. " AND `type` = 1;")
	if WeaverQuery3 == nil then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: That entry does not exist as a weaver spawn.")
		return false
	elseif WeaverQuery3:GetString(3) ~= player:GetAccountName() then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: That spawn does not belong to you, but a weaver named " ..WeaverQuery3:GetString(4).. ".")
		return false
	end
	
	local map = GetMapById(WeaverQuery3:GetInt32(2))
	local build = GetObjectGUID(WeaverQuery3:GetInt32(0), WeaverQuery3:GetInt32(1))
	local object = map:GetWorldObject(build)
	object:RemoveFromWorld(true)
	WorldDBExecute("DELETE FROM `weaver_spawned` WHERE `guid` = " ..parameters[3].. ";")
	player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You have deleted object with GUID " ..parameters[3].. ".")
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WOBJ DEL` with parameters: " ..command.. ".")
	return false
end

-- .wnpc add
local function WeaverNPCAdd(event, player, command)
	if (command:find("wnpc add") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end

	local pattern = "%S+" -- Separate by spaces
	local parameters = {}
	local parameters = getCommandParameters(command)
	if (parameters[3] == nil) or (tonumber(parameters[3] == nil)) then
		-- help message
		player:SendBroadcastMessage("Syntax: .wnpc add $entry\nSpawns an NPC based on entry. Weavers can have up to " ..WEAVER_CAP_NPC.. " NPCs spawned at a time.\nTo find NPCs, use .lookup creature.")
		return false
	end
	
	-- here we stop error spam from a nil instanceid
	local instanceid = player:GetInstanceId()
	if (instanceid == nil) then
		instanceid = 0
	end

	-- does our weaver already have 5 spawns?
	local WeaverQuery4 = WorldDBQuery("SELECT `guid` FROM `weaver_spawned` WHERE `owner_guid` = " ..player:GetGUIDLow().. " AND `type` = 2;")
	local x, y, z, o = player:GetLocation()
	RowCount = 0
	if (WeaverQuery4 ~= nil) then
		RowCount = WeaverQuery4:GetRowCount()
		if (RowCount >= WEAVER_CAP_OBJECT) then
			player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You can only spawn " ..WEAVER_CAP_NPC.. " NPCs.")
			return false
		end
	end
	
	local x, y, z, o = player:GetLocation()
	local map_id = player:GetMapId()

	-- spawn the object
	PerformIngameSpawn(1, parameters[3], map_id, instanceid, x, y, z, o, true, 0, 1)

	local nearestobjects = player:GetCreaturesInRange(10, parameters[3], 0)
	-- did the object spawn? if it didnt, more than likely an incorrect entry.
	if (nearestobjects[1] == nil) then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: The entry you provided does not exist.")
		return false
	end

	local WeaverQuery5 = WorldDBQuery("SELECT `guid` FROM `weaver_spawned` WHERE `type` = 2 AND `guid` = " ..nearestobjects[1]:GetDBTableGUIDLow().. ";")
	
	for x=1,#nearestobjects,1 do
		if WeaverQuery2 ~= nearestobjects[x] then
--			player:SendBroadcastMessage("Detecting break. Fixing?")
			nearestobject_guid = nearestobjects[x]:GetDBTableGUIDLow()
			nearestobject_raw = nearestobjects[x]:GetGUIDLow()
			nearestobject = nearestobjects[x]
			break
		end
		nearestobject = nearestobjects[x]
	end
	
	if nearestobject:IsWorldBoss() == true then
		local x, y, z, o = nearestobject:GetLocation()
		nearestobject:NearTeleport(x, y, z - 100, o)
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You cannot spawn creatures of that rank.")
		return false
	end
	
	-- type = 1 for obj spawn
	WorldDBExecute("INSERT INTO `elunaworld`.`weaver_spawned` (`type`, `guid`, `guid_raw`, `entry`, `map`, `x`, `y`, `z`, `o`, `timestamp`, `owner_character`, `owner_account`, `owner_guid`) VALUES ('2', '" ..nearestobject_guid.. "', '" ..nearestobject_raw.. "', '" ..parameters[3].. "', '" ..map_id.. "', '" ..x.. "', '" ..y.. "', '" ..z.. "', '" ..o.. "', '" ..tostring(GetGameTime()).. "', '" ..player:GetName().. "', '" ..player:GetAccountName().. "', '" ..player:GetGUIDLow().. "');")
	player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You have spawned an NPC with GUID " ..nearestobject_guid.. " (Spawned: " ..(RowCount + 1).. "/" ..WEAVER_CAP_NPC..").")
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WNPC ADD` with parameters: " ..command.. ".")
	return false
end

-- .wnpc del
local function WeaverNPCDel(event, player, command)
	if (command:find("wnpc del") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end

	local pattern = "%S+" -- Separate by spaces
	local parameters = {}
	local parameters = getCommandParameters(command)
	local target = player:GetSelection()
	local entry_stuff = false
	local target_stuff = false
	if (target == nil) and (parameters[3] == nil) then
		--help menu
		player:SendBroadcastMessage("Syntax: .wnpc del\nDeletes an NPC based on target. Weavers can have up to " ..WEAVER_CAP_NPC.. " NPCs spawned at a time.\nTo delete an NPC, target before using this command.")
		return false
--	elseif (parameters[3] ~= nil) then
--		-- i want to delete by entry if i have parameters
--		entry_stuff = true
	elseif (parameters[3] == nil) and (target ~= nil) then
		-- i want to delete by target if i have no parameters but i have a target
		target_stuff = true
	end
	
	if target_stuff == true then
		if target:ToCreature() == nil then
			player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You must target a creature.")
			return false
		-- is creature a world boss? is the player's account rank weaver? stop from continuing.
		elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
			player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You cannot command creatures of this rank.")
		end
		guidlow = target:GetDBTableGUIDLow()
--	elseif entry_stuff == true then
--		if (tonumber(parameters[3]) == nil) then
--			-- help menu
--			player:SendBroadcastMessage("[Weaver]: You must input a GUID.")
--		end
--		guidlow = parameters[3]
	end
	
	local WeaverQuery6 = WorldDBQuery("SELECT `guid_raw`, `entry`, `map`, `owner_account`, `owner_character` FROM `weaver_spawned` WHERE `guid` = " ..guidlow.. " AND `type` = 2;")
	if WeaverQuery6 == nil then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: That entry does not exist as a weaver spawn.")
		return false
	elseif WeaverQuery6:GetString(3) ~= player:GetAccountName() then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: That spawn does not belong to you, but a weaver named " ..WeaverQuery6:GetString(4).. ".")
		return false
	end	

--	local map = GetMapById(WeaverQuery6:GetInt32(2))
--	print(map)
--	local build = GetObjectGUID(WeaverQuery6:GetInt32(0), WeaverQuery6:GetInt32(1))
--	print(build)
--	local object = map:GetWorldObject(build)
	target:SetPhaseMask(0, true)
	local x, y, z, o = player:GetLocation()
	target:NearTeleport( x, y, z - 300, o )	
	target:SaveToDB()
	target:DespawnOrUnsummon( 1000 )
	target:SetPhaseMask(0, true)
	WorldDBExecute("DELETE FROM `weaver_spawned` WHERE `guid` = " ..guidlow.. ";")
	player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You have deleted NPC with GUID " ..guidlow.. ".")	
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WNPC DEL` on target: " ..target:GetDBTableGUIDLow().. ".")
	return false
end

-- .wemote
local function WeaverEmote(event, player, command)
	if (command:find("wemote") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: You cannot command creatures of this rank.")
	end
	
    local pattern = "%S+" -- Separate by spaces
    local parameters = {}
    local parameters = getCommandParameters(command)
    local param2 = tostring(parameters[2])
    local param3 = tostring(parameters[3])

    if (param2 == "loop") then
            local emoteID = tonumber(param3)
            if (emoteID == nil or emoteID >= 477 or emoteID < 0) then
                    player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: Missing or invalid emote ID.")
                    return false
            else
                    target:EmoteState(emoteID)
                    return false
            end
    elseif (param2 == "stop") then
            target:Emote(0)
            target:EmoteState(0)
            return false
    else
        local emoteID = tonumber(param2)
        if (emoteID == nil or emoteID >= 477 or emoteID < 0) then
                player:SendBroadcastMessage("[|cff00FFFFWeaver|r]: Missing or invalid emote ID.")
                return false
        else
                target:Emote(emoteID)
                return false
        end
    end
end



-- .wcometome 
local function WeaverComeToMe(event, player, command)
	if (command:find("wcometome") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
	end
	
	local x, y, z, o = player:GetLocation()
	if (command:find("wcometome walk") == 1) then
		target:SetWalk(true)
		target:MoveTo(0, x, y, z, true)
		return false
	elseif (command:find("wcometome run") == 1) then
		target:SetWalk(false)
		target:MoveTo(0, x, y, z, true)
		return false
	elseif (command:find("wcometome homerun") == 1) then
		target:MoveHome()
		target:SetWalk(false)
		return false
	elseif (command:find("wcometome homewalk") == 1) then
		target:MoveHome()
		target:SetWalk(true)
		return false
	else
		-- help message. add .help command in future
		player:SendBroadcastMessage("Syntax: .wcometome $subcommand \nMakes the target NPC walk or run to your location. Subcommand homerun or homewalk returns the NPC to its spawn point.\nwalk\nrun\nhomerun\nhomewalk")
		return false
	end
end

-- .wfollow
-- makes an npc follow you until .wfollow is used again.
local function WeaverFollow(event, player, command)
	if (command:find("wfollow") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end

	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
end

-- .wbuff, allowing weavers to give a 10% dam/hp buff up to a certain amount of stacks.
local function WeaverBuff(event, player, command)
	if (command:find("wbuff") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	
	if (command:find("wbuff damage") == 1) then
		aura = target:GetAura(damage_aura)
		if (aura == nil) then
			target:AddAura(damage_aura, target)
			return false
		elseif (aura:GetStackAmount() >= WEAVER_CAP_BUFF) then
			player:SendBroadcastMessage("You can only buff this unit up to " ..WEAVER_CAP_BUFF.. " times.")
			return false
		else
			target:AddAura(damage_aura, target)
			return false
		end
	elseif (command:find("wbuff health") == 1) then
		aura = target:GetAura(health_aura)
		if (aura == nil) then
			target:AddAura(health_aura, target)
			return false
		elseif (aura:GetStackAmount() >= WEAVER_CAP_BUFF) then
			player:SendBroadcastMessage("You can only buff this unit up to " ..WEAVER_CAP_BUFF.. " times.")
			return false
		else
			PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `" ..command.. "` on target: " ..target:GetName().. ".")
			target:AddAura(health_aura, target)
			return false
		end
	elseif (command:find("wbuff reset") == 1) then
		target:RemoveAura(health_aura)
		target:RemoveAura(damage_aura)
	end
	player:SendBroadcastMessage("Syntax: .wbuff $subcommand \nBuffs the targeted NPC with a 10% increase in damage or health. Subcommand reset sets these to 0.\ndamage\nhealth\nreset")
	return false
end

-- .waura add aura to target
local function WeaverAura(event, player, command)
	if (command:find("waura") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end

	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	local parameters = {}
	local parameters = getCommandParameters(command)
	if parameters[2] ~= nil and tonumber(parameters[2]) ~= nil then
		target:AddAura(parameters[2], target)
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `" ..command.. "` on target: " ..target:GetName().. ".")
		return false
	else
		-- print help
		player:SendBroadcastMessage("Syntax: .waura $entry \nAdds $entry as an aura to the target, where $entry is a spell.")
		return false
	end
end

-- .wunaura remove aura from target
local function WeaverUnAura(event, player, command)
	if (command:find("wunaura") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end

	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	local parameters = {}
	local parameters = getCommandParameters(command)
	if parameters[2] ~= nil and tonumber(parameters[2]) ~= nil then
		target:RemoveAura(parameters[2])
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `" ..command.. "` on target: " ..target:GetName().. ".")
		return false
	elseif parameters[2] == "all" then
		target:RemoveAllAuras()
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `" ..command.. "` on target: " ..target:GetName().. ".")
		return false
	else
		-- print help
		player:SendBroadcastMessage("Syntax: .wunaura $entry \nRemoves $entry as an aura to the target, where $entry is a spell. Subcommand all removes all auras.\nall")
		return false
	end
end

-- .wpossess, lets a weaver possess an npc.
local function WeaverPossessAggroCheck(eventid, delay, repeats, creature)
	if creature:HasAura(530) == false then
		creature:SetAggroEnabled(true)
		RemoveEventById( eventid )
		return false
	end
end

-- .wpossess, continued
local function WeaverPossess(event, player, command)
	if (command:find("wpossess") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	if target:HasAura(530) == true then
		player:SendBroadcastMessage("This unit is already possessed.")
		return false
	end
	
	if target:GetVehicleKit() ~= nil then
		player:SendBroadcastMessage("You cannot possess mounts/vehicles due to technical limitations.")
		return false
	end

	if (command:find("wpossess") == 1) then
		player:AddAura(530, target)
		target:SetAggroEnabled(false)
		-- gotta set an event to loop so we can know when to toggle aggro back
		target:RegisterEvent(WeaverPossessAggroCheck, 2000, 0)
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WPOSSESS` on target: " ..target:GetName().. ".")
		return false
	end
		
	player:SendBroadcastMessage("Syntax: .wpossess \nTake control over the target NPC. Dismiss by right clicking the unit portrait under your own.")
	return false
end

-- emote, say, and yell
local function WeaverTextEmote(event, player, command)
	if (command:find("wtextemote") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	if (command:find("wtextemote ") == 1) then
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `wtextemote` with parameters: " ..command.. " on target: " ..target:GetName().. ".")
		command = string.gsub(command,"wtextemote ","")
		target:SendUnitEmote(command)
		return false
	end
	player:SendBroadcastMessage("Syntax: .wtextemote $string \nNarrates any text as an emote from the selected target.")
	return false
end

local function WeaverSay(event, player, command)
	if (command:find("wsay") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	if (command:find("wsay ") == 1) then
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WSAY` with parameters: " ..command.. " on target: " ..target:GetName().. ".")
		command = string.gsub(command,"wsay ","")
		target:SendUnitSay(command, 0)
		return false
	end
	player:SendBroadcastMessage("Syntax: .wsay $string \nSpeaks any text from the selected target.")
	return false
end

local function WeaverYell(event, player, command)
	if (command:find("wyell") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	end
	
	if target:ToCreature() == nil then
		player:SendBroadcastMessage("You must target a creature.")
		return false
	-- is creature a world boss? is the player's account rank weaver? stop from continuing.
	elseif (target:IsWorldBoss() == true) and (player:GetGMRank() == WEAVER_RBAC_ID) then
		player:SendBroadcastMessage("You cannot command creatures of this rank.")
		return false
	end
	
	if (command:find("wyell ") == 1) then
		PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WYELL` with parameters: " ..command.. " on target: " ..target:GetName().. ".")
		command = string.gsub(command,"wyell ","")
		target:SendUnitYell(command, 0)
		return false
	end
	player:SendBroadcastMessage("Syntax: .wyell $string \nYells any text from the selected target.")
	return false
end

-- toggles invis for weavers
local function WeaverInvis(event, player, command)
	if (command:find("winvis") ~= 1) then
		return
	elseif (player:GetGMRank() == 0) then
		return
	end
	
	if player:IsGMVisible() == true then
		player:SetGMVisible(false)
		player:AddAura(37800, player)
		state = "INVISIBLE"
	else
		player:RemoveAura(37800)
		player:SetGMVisible(true)
		state = "VISIBLE"
	end
	player:SetGameMaster(false)
	player:SendBroadcastMessage("[Weaver]: You are now " .. state ..".")
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has used command: `WINVIS` with parameters: " ..state.. ".")
	return false
end


-- send Guild Masters the ToolBarClient button for Weavers
local function SendGMButton(event, player)
	if (player:GetGuildRank() == 0) and (player:GetGuildId() ~= 0) then
		AIO.Handle(player, "ToolBar4", "ShowGuildMasterButton")
	end
end

-- shows weaver panel and updates text as needed
function ToolBarHandlers4.ShowGuildMasterWeaverPanel(player)
	guild = player:GetGuild()
	local WeaverQuery8 = WorldDBQuery("SELECT `weaver_character` FROM `weaver_appointed` WHERE `guild` = " ..player:GetGuildId().. ";")
	if WeaverQuery8 == nil then
		current_weavers = 0
	else
		current_weavers = WeaverQuery8:GetRowCount()
	end
	
	guild_count = guild:GetMemberCount()
	max_weavers = math.floor(guild_count / 5)
	AIO.Handle(player, "Weaver", "ShowGuildMasterWeaverMenu", current_weavers, max_weavers)
end

-- confirms weaver appointment
function WeaverHandlers.WeaverConfirm(player, editbox)
	local parameters = {}
	local parameters = getCommandParameters(editbox)
	parameters[1] = sterilize.generic(parameters[1])
	if editbox == nil or editbox == "" then
		player:SendBroadcastMessage("You must input a name.")
		return false
	end

	local WeaverQuery12 = CharDBQuery("SELECT `guid` FROM `characters` WHERE `name` = '" ..editbox.. "';")
	if WeaverQuery12 == nil then
		player:SendBroadcastMessage("That character does not exist.")
		return false
	end
	
	local WeaverQuery9 = CharDBQuery("SELECT `guid` FROM `guild_member` WHERE `guildid` = " ..player:GetGuildId().. " AND `guid` = " ..WeaverQuery12:GetInt32(0).. ";")
	if WeaverQuery9 == nil then
		player:SendBroadcastMessage("You can only appoint players in your guild.")
		return false
	end
	
	local WeaverQuery8 = WorldDBQuery("SELECT `weaver_character` FROM `weaver_appointed` WHERE `guild` = " ..player:GetGuildId().. " AND `weaver_character` = '" ..editbox.. "';")
	if (WeaverQuery8 ~= nil) then
		-- player is appointed by guild and in guild. send AIO to confirm demote.
		AIO.Handle(player, "Weaver", "ConfirmDemote")
		return false
	end
	
	local WeaverQuery10 = CharDBQuery("SELECT `account` FROM `characters` WHERE `guid` = " ..WeaverQuery9:GetInt32(0).. ";")
	local account_id = WeaverQuery10:GetInt32(0)
	print("SELECT `gmlevel` FROM `account_access` WHERE `id` = " ..account_id.. ";")
	local WeaverQuery11 = AuthDBQuery("SELECT `gmlevel` FROM `account_access` WHERE `id` = " ..account_id.. ";")
	if WeaverQuery11 ~= nil then
		print(WeaverQuery11:GetInt32(0))
		player:SendBroadcastMessage("That player is already appointed to a powerful position, possibly from another guild.")
		return false
	end
	
	guild = player:GetGuild()
	local WeaverQuery8 = WorldDBQuery("SELECT `weaver_character` FROM `weaver_appointed` WHERE `guild` = " ..player:GetGuildId().. ";")
	if WeaverQuery8 == nil then
		current_weavers = 0
	else
		current_weavers = WeaverQuery8:GetRowCount()
	end
	
	guild_count = guild:GetMemberCount()
	max_weavers = math.floor(guild_count / 5)
	if (current_weavers >= max_weavers) then
		player:SendBroadcastMessage("You have reached the maximum amount of weavers you can have. To gain more, recruit more people!")
		return false
	end
	
	
	AuthDBExecute("INSERT INTO `elunaauth`.`account_access` (`id`, `gmlevel`, `RealmID`) VALUES ('" ..account_id.. "', '" ..WEAVER_RBAC_ID.. "', '" ..REALM_ID.. "');")
	WorldDBExecute("INSERT INTO `elunaworld`.`weaver_appointed` (`weaver_acc`, `weaver_character`, `weaver_guid`, `guild`, `appointed_by`, `timestamp`) VALUES ('" ..account_id.. "', '" ..editbox.. "', " ..WeaverQuery12:GetInt32(0).. ", '" ..player:GetGuildId().. "', '" ..player:GetName().. "', '" ..tostring(GetGameTime()).. "');")
	player:SendBroadcastMessage("You have successfully appointed " ..editbox.. " as a weaver.")
	current_weavers = current_weavers + 1
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has APPOINTED " ..editbox.. " with account ID " ..account_id.. ".")
	AIO.Handle(player, "Weaver", "UpdateText", current_weavers, max_weavers)
end

-- demote confirmation
function WeaverHandlers.WeaverDemote(player, editbox)
	local parameters = {}
	local parameters = getCommandParameters(editbox)
	parameters[1] = sterilize.generic(parameters[1])
	if editbox == nil or editbox == "" then
		player:SendBroadcastMessage("You must input a name.")
		return false
	end

	local WeaverQuery12 = CharDBQuery("SELECT `guid` FROM `characters` WHERE `name` = '" ..editbox.. "';")
	if WeaverQuery12 == nil then
		player:SendBroadcastMessage("That character does not exist.")
		return false
	end
	
	local WeaverQuery9 = CharDBQuery("SELECT `guid` FROM `guild_member` WHERE `guildid` = " ..player:GetGuildId().. " AND `guid` = " ..WeaverQuery12:GetInt32(0).. ";")
	if WeaverQuery9 == nil then
		player:SendBroadcastMessage("You can only demote players in your guild.")
		return false
	end
	
	local WeaverQuery8 = WorldDBQuery("SELECT `weaver_character` FROM `weaver_appointed` WHERE `guild` = " ..player:GetGuildId().. ";")
	if WeaverQuery8 == nil then
		current_weavers = 0
	else
		current_weavers = WeaverQuery8:GetRowCount()
	end
	guild = player:GetGuild()
	guild_count = guild:GetMemberCount()
	max_weavers = math.floor(guild_count / 5)
	
	guild_id = player:GetGuildId()
	local WeaverQuery10 = CharDBQuery("SELECT `account` FROM `characters` WHERE `guid` = " ..WeaverQuery9:GetInt32(0).. ";")
	weaver_account = WeaverQuery10:GetInt32(0)
 	WorldDBExecute("DELETE FROM `weaver_appointed` WHERE `guild` = " ..guild_id.. " AND `weaver_character` = '" ..editbox.. "';")
 	AuthDBExecute("DELETE FROM `account_access` WHERE `id` = " ..weaver_account.. " AND `gmlevel` = " ..WEAVER_RBAC_ID.. ";")
	player:SendBroadcastMessage("You have successfully removed " ..editbox.. " as a weaver.")
	current_weavers = current_weavers - 1
	PrintInfo("[Weaver]: " ..player:GetName().. " (Account: " ..player:GetAccountId().. ") has DEMOTED " ..editbox.. " with account ID " ..weaver_account.. ".")
	AIO.Handle(player, "Weaver", "UpdateText", current_weavers, max_weavers)
end

-- if char deletes, and is weaver, delete that information too.
local function WeaverCleanUp(event, guid)
	local WeaverQuery14 = WorldDBQuery("SELECT `weaver_acc` FROM `weaver_appointed` WHERE `weaver_guid` = " ..guid.. ";")
	if WeaverQuery14 ~= nil then
		WorldDBExecute("DELETE FROM `weaver_appointed` WHERE `weaver_guid` = " ..guid.. ";")
		AuthDBExecute("DELETE FROM `account_access` WHERE `id` = " ..WeaverQuery14:GetInt32(0).. " AND `gmlevel` = 1;")
	end
end

-- demotes a weaver on guild leave
-- function ToolBarHandlers4.LeaverWeaver(player)
-- 	guild_id = player:GetGuildId()
-- 	print(guild_id)
-- 	local WeaverQuery13 = WorldDBQuery("SELECT `weaver_character` FROM `weaver_appointed` WHERE `guild` = " ..guild_id.. " AND `weaver_character` = '" ..player:GetName().. "';")
-- 	if WeaverQuery13 == nil then
-- 		return false
-- 	end
-- 	
-- 	print("DELETE FROM `weaver_appointed` WHERE `guild` = " ..guild_id.. " AND `weaver_character` = '" ..player:GetName().. ";")
-- 	print("DELETE FROM `account_access` WHERE `id` = " ..player:GetAccountId().. " AND `gmlevel` = " ..WEAVER_RBAC_ID.. ";")
-- 	WorldDBExecute("DELETE FROM `weaver_appointed` WHERE `guild` = " ..guild_id.. " AND `weaver_character` = '" ..player:GetName().. "';")
-- 	AuthDBExecute("DELETE FROM `account_access` WHERE `id` = " ..player:GetAccountId().. " AND `gmlevel` = " ..WEAVER_RBAC_ID.. ";")
-- 	print("deleted")
-- end


RegisterPlayerEvent(42, WeaverComeToMe)
RegisterPlayerEvent(42, WeaverChat)
RegisterPlayerEvent(42, WeaverBuff)
RegisterPlayerEvent(42, WeaverPossess)
RegisterPlayerEvent(42, WeaverAura)
RegisterPlayerEvent(42, WeaverUnAura)
RegisterPlayerEvent(42, WeaverTextEmote)
RegisterPlayerEvent(42, WeaverEmote)
RegisterPlayerEvent(42, WeaverSay)
RegisterPlayerEvent(42, WeaverYell)
RegisterPlayerEvent(42, WeaverObjectAdd)
RegisterPlayerEvent(42, WeaverObjectDel)
RegisterPlayerEvent(42, WeaverNPCAdd)
RegisterPlayerEvent(42, WeaverNPCDel)
RegisterPlayerEvent(42, WeaverSpawns)
RegisterPlayerEvent(42, WeaverInvis)
RegisterPlayerEvent(3, SendGMButton)
RegisterPlayerEvent(2, WeaverCleanUp)