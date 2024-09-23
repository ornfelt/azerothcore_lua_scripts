local AIO = AIO or require("AIO")
local GobRotHandlers = AIO.AddHandlers("RotateGobs", {})
local ToolBarHandlers2 = AIO.AddHandlers("ToolBar2", {})

-- gm level for weavers
WEAVER_RBAC_ID = 1

function GobRotHandlers.CheckRotate(player, val_1, val_2, val_3, editbox, val_4, val_5)
	print(val_1, val_2, val_3, val_4, val_5)
	if (isNumber(editbox) == false) then
		player:SendBroadcastMessage("You must input a number.")
	else
		local CheckRotate_Query1 = WorldDBQuery("SELECT `gobject_guid`, `gobject_entry`, `map`, `owner_guid`, `gobject_raw` FROM `apt_spawned` WHERE `gobject_guid` = " ..editbox.. ";")
		local CheckRotate_Query2 = WorldDBQuery("SELECT `guid`, `entry`, `map`, `owner_guid`, `guid_raw` FROM `weaver_spawned` WHERE `guid` = " ..editbox.. " AND `owner_account` = '" ..player:GetAccountName().. "';")
		-- does exist in weaver_spawned, not in apt_spawned, and is a weaver player
		if (CheckRotate_Query2 ~= nil) and (CheckRotate_Query1 == nil) and (player:GetGMRank() == WEAVER_RBAC_ID) then
			map_data = CheckRotate_Query2:GetInt32(2)
			entry_data = CheckRotate_Query2:GetInt32(1)
			guid_data = CheckRotate_Query2:GetInt32(0)
			owner_guid = CheckRotate_Query2:GetInt32(3)
			query_string1 = "`weaver_spawned`"
			query_string2 = "`guid_raw`"
			query_string3 = "`guid`"
		elseif (CheckRotate_Query1 ~= nil) then
			map_data = CheckRotate_Query1:GetInt32(2)
			entry_data = CheckRotate_Query1:GetInt32(1)
			guid_data = CheckRotate_Query1:GetInt32(0)
			owner_guid = CheckRotate_Query1:GetInt32(3)
			query_string1 = "`apt_spawned`"
			query_string2 = "`gobject_raw`"
			query_string3 = "`gobject_guid`"			
		end
		if (CheckRotate_Query1 == nil) and (player:GetGMRank() == 0) then
			player:SendBroadcastMessage("That object GUID does not exist or is not under your ownership. Code:a")
			return false
		-- is it not in a weaver query, is the player a weaver, is there no APT entry?
		elseif (CheckRotate_Query2 == nil) and (player:GetGMRank() == WEAVER_RBAC_ID) and (CheckRotate_Query1 == nil) then
			player:SendBroadcastMessage("That object GUID does not exist or is not under your ownership. Code:b")
			return false
		elseif (CheckRotate_Query1 == nil) and (player:GetGMRank() >= 2) then
			gm = true
			AIO.Handle(player, "RotateGobs", "CommandOutput", val_1, val_2, val_3, editbox, gm)
			return false
		elseif (owner_guid ~= player:GetGUIDLow()) and (player:GetGMRank() < 3) then
			player:SendBroadcastMessage("That object GUID does not exist or is not under your ownership. Code:c")
			return false
		else
			local map = GetMapById(map_data)
			local gameobjects = player:GetGameObjectsInRange(533, entry_data)
			for x=1,#gameobjects,1 do
				if (gameobjects[x]:GetDBTableGUIDLow() == guid_data) then
					object = map:GetWorldObject(GetObjectGUID(gameobjects[x]:GetGUIDLow(), entry_data))
				end
			end
			
			if (val_4) ~= 0 and tonumber(val_4) ~= nil then
				local x, y, z, o = object:GetLocation()
				-- a new "object" is generated when this is TP'd, so we need to get it again to reapply the scale values.
				local old_scale = object:GetScale()
				object:TeleportObject(editbox, x, y, z + val_4)
				local map = GetMapById(map_data)
				local gameobjects = player:GetGameObjectsInRange(533, entry_data)
				player:SendBroadcastMessage("Object with GUID " ..editbox.. " was adjusted.")
				for x=1,#gameobjects,1 do
					if (gameobjects[x]:GetDBTableGUIDLow() == guid_data) then
						object = map:GetWorldObject(GetObjectGUID(gameobjects[x]:GetGUIDLow(), entry_data))
						player:SendBroadcastMessage("Object with GUID " ..editbox.. " was adjusted.")
					end
				end
				object:SetGameObjectScale(old_scale)
				object:SaveToDB()
				WorldDBExecute("UPDATE gameobject SET size = " .. old_scale .. " WHERE guid = " .. object:GetDBTableGUIDLow())
				return
			elseif (val_5 ~= nil) and (val_5 ~= 0) then
				if val_5 > 2.0 or val_5 < 0 then
					player:SendBroadcastMessage("fuckin hacker man how did you do this?")
					return false
				else
					print("setting scale to " ..val_5)
					object:SetGameObjectScale(val_5)
					WorldDBExecute("UPDATE gameobject SET size = " .. val_5 .. " WHERE guid = " .. object:GetDBTableGUIDLow())
					print(object:GetScale())
					player:SendBroadcastMessage("Object with GUID " ..editbox.. " was adjusted.")
					return
				end
			else
				-- SetTurn resets the objects scale, so we need to grab the scale and reapply it.
				local old_scale = object:GetScale()
				object:SetTurn(editbox, val_1, val_2, val_3)
				-- rerun object definition here to obtain new object guidlow, since SetTurn() creates a new GUIDLow()
				local map = GetMapById(map_data)
				local gameobjects = player:GetGameObjectsInRange(533, entry_data)
				for x=1,#gameobjects,1 do
					if (gameobjects[x]:GetDBTableGUIDLow() == guid_data) then
						object = map:GetWorldObject(GetObjectGUID(gameobjects[x]:GetGUIDLow(), entry_data))
					end
				end
				object:SetGameObjectScale(old_scale)
				WorldDBExecute("UPDATE gameobject SET size = " .. old_scale .. " WHERE guid = " .. object:GetDBTableGUIDLow())
				WorldDBExecute("UPDATE " ..query_string1.. " SET " ..query_string2.. " = " ..object:GetGUIDLow().. " WHERE " ..query_string3.. " = " ..guid_data.. ";")
				player:SendBroadcastMessage("Object with GUID " ..editbox.. " was adjusted.")
				return false
			end
		end
	end
end

local function GobRot_Menu(event, player, command)
	if (command:find("apt show") ~= 1) then
		return
	else
		AIO.Handle(player, "RotateGobs", "ShowMain")
		return false
	end
end

-- allow button to work on toolbar
function ToolBarHandlers2.ShowRotateUI(player)
	AIO.Handle(player, "RotateGobs", "ShowMain")
end

RegisterPlayerEvent(42, GobRot_Menu)


--[[
local function Gobject_Rotate(event, player, command)
    if (player:GetGMRank() < 3) then
        return
    elseif (command:find("gob rotate") ~= 1) then
        return
    else
		-- command syntax .gob rotate guid x y z
		local pattern = "%S+" -- Separate by spaces
		local parameters = {}
		for parameter in string.gmatch(command, pattern) do -- Take the entire command and split it by spaces, put into a table.
			table.insert(parameters, parameter) 
        end
		
		local Gobject_Rotate_Query1 = WorldDBQuery("SELECT guid, id, map FROM gameobject WHERE guid = " ..parameters[3].. ";")
		local map = GetMapById(Gobject_Rotate_Query1:GetInt32(2))
		local build = GetObjectGUID(Gobject_Rotate_Query1:GetInt32(0), Gobject_Rotate_Query1:GetInt32(1))
		local object = map:GetWorldObject(build)
		local object2 = player:GetGameObjectsInRange(100, Gobject_Rotate_Query1:GetInt32(1))
		WorldDBExecute("UPDATE gameobject SET rotation1 = " ..parameters[4].. ", rotation2 = " ..parameters[5].. ", rotation3 = " ..parameters[6].. " WHERE guid = " ..parameters[3].. ";")
		player:SendBroadcastMessage(tostring(parameters[3].. "."))
		for z=1,#object2,1 do
			player:SendBroadcastMessage("running loop")
			if (tonumber(object2[z]:GetDBTableGUIDLow()) == tonumber(parameters[3])) then
--				object2[z]:SaveToDB()
--				object2[z]:RemoveFromWorld(false)
				object2[z]:Despawn()
				object2[z]:Respawn()
				player:SendBroadcastMessage("object respawned?")--
				return
			elseif (object2[z]:GetDBTableGUIDLow() ~= parameters[3]) then
				player:SendBroadcastMessage("could not grab gameobject with entry " ..object2[z]:GetDBTableGUIDLow().. ".")
			end
		end
		player:SendBroadcastMessage("loop done")
--		object2:RemoveFromWorld(false)
	end
end

RegisterPlayerEvent(42, Gobject_Rotate)

]]