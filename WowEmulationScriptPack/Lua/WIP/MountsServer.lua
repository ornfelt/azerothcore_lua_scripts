-- change to true if trade routes enabled, otherwise false
TRADE_ROUTE_ENABLED = true
TRADE_ROUTE_DEBUFF = 2000084

-- STABLE CREATURE ID
STABLE_CREATURE = 1000202

local function MountHello(event, player, creature)
	local Mount_Query5 = WorldDBQuery("SELECT `spawned` FROM `eluna_mount_owner` WHERE `character_guid` = " ..player:GetGUIDLow().. " and `spawned` = " ..creature:GetDBTableGUIDLow().. ";")
	if Mount_Query5 == nil then
		player:SendBroadcastMessage("|cff145A32[Mount System]|r: You do not own this mount.")
		player:GossipMenuAddItem(0, "View Owner", 65023, 4)
		player:GossipMenuAddItem(0, "Nevermind", 65023, 0)
		player:GossipSendMenu(65023, creature, MenuId)
	else
	
		player:GossipMenuAddItem(0, "Mount", 65023, 1)
		player:GossipMenuAddItem(0, "Save position", 65023, 2)
		player:GossipMenuAddItem(0, "Toggle follow", 65023, 3)
--		player:GossipMenuAddItem(0, "Steal mount", 65023, 2)
		player:GossipMenuAddItem(0, "Nevermind", 65023, 0)
		player:GossipSendMenu(65023, creature, MenuId)
	end
end

local function MountSelect(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	player:GossipComplete()
	if (intid == 1) then
		if player:IsInCombat() == true then
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: You cannot mount while in combat.")
			return false
		end
		
		if TRADE_ROUTE_ENABLED == true then
			if player:HasAura(TRADE_ROUTE_DEBUFF) == true then
				player:SendBroadcastMessage("[Trade Route]: You cannot mount while on a trade route!")
				return false
			end
		end
		
		creature:RemoveAura(2000005)
		if creature:HasAura(63151) == true then
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: Error. This unit is already mounted.")
			return false
		end
		player:CastSpell(creature, 63151, true)
		player:RemoveAura(63034)
		return false
	elseif (intid == 2) then
		player:SendBroadcastMessage("|cff145A32[Mount System]|r: Your mount's location has been saved.")
		creature:SaveToDB()
		return false
	elseif (intid == 3) then
		-- the third argument, angle, refers to 0-6.28, aka a circle in radians.
		if creature:HasAura(2000039) == false then
			creature:RemoveAura(2000005)
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: Your mount is now following you.")
			creature:AddAura(2000039, creature)
			creature:MoveFollow(player, 2, 3.14)
			return false
		else
			creature:RemoveAura(2000039)
			creature:AddAura(2000005, creature)
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: Your mount is no longer following you.")
			return false
		end
	elseif (intid == 4) then
		local Mount_Query2 = WorldDBQuery("SELECT `character` FROM `eluna_mount_owner` WHERE spawned = " ..creature:GetDBTableGUIDLow().. ";")
		if Mount_Query2 == nil then
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: There is no owner of this mount.")
			return false
		else
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: The owner of this " ..creature:GetName().. " belongs to " ..Mount_Query2:GetString(0).. ".")
			return false
		end
	end
end

local function StableHello(event, player, creature)
	player:GossipMenuAddItem(0, "Withdraw Mount", 65024, 1)
	player:GossipMenuAddItem(0, "Stable Mount", 65024, 2)
	player:GossipMenuAddItem(0, "Nevermind", 65024, 0)
	player:GossipSendMenu(65024, creature, MenuId)
end

local function StableSelect(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	player:GossipComplete()
	if (intid == 1) then
		local Mount_Query3 = WorldDBQuery("SELECT `item_name`, `creature`, `spawned` FROM `eluna_mount_owner` WHERE `character_guid` = " ..player:GetGUIDLow().. ";")
		player:GossipMenuAddItem(0, "Nevermind", 65023, 0)
		if (Mount_Query3 == nil) then
			player:GossipSendMenu(65025, creature, MenuId)
			return false
		else
			for x=1,Mount_Query3:GetRowCount(),1 do
				mount_string = Mount_Query3:GetString(0)
				if Mount_Query3:GetInt32(2) == 0 then
					mount_string = (mount_string.. " [Spawned: No]")
				else
					mount_string = (mount_string.. " [Spawned: Yes]")
				end
				player:GossipMenuAddItem(0, mount_string, 65025, Mount_Query3:GetInt32(1))
				Mount_Query3:NextRow()
			end
			player:GossipSendMenu(65025, creature, MenuId)
		end
	elseif (intid == 2) then
		local Mount_Query4 = WorldDBQuery("SELECT `spawned`, `creature` FROM `eluna_mount_owner` WHERE `spawned` != 0 AND `character_guid` = " ..player:GetGUIDLow().. ";")
		if Mount_Query4 == nil then
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: You do not have a mount to stable.")
			return false
		else
			local new_creatures = player:GetCreaturesInRange(10, Mount_Query4:GetInt32(1))
			found = false
			
			if #new_creatures == 0 then
				player:SendBroadcastMessage("|cff145A32[Mount System]|r: Could not detect a mount. Is it within 10 yards of you?")
				return false
			elseif (player:HasAura(63151) == true) then
				player:SendBroadcastMessage("|cff145A32[Mount System]|r: You must dismount first.")
				return false
			else
				for x=1,#new_creatures,1 do
					if new_creatures[x]:GetDBTableGUIDLow() == Mount_Query4:GetInt32(0) then
						newest_creature = new_creatures[x]
						if newest_creature == nil then
							player:SendBroadcastMessage("[Mount System]: Something broke.")
							return false
						end
						WorldDBExecute("UPDATE `eluna_mount_owner` SET `spawned` = 0 WHERE `spawned` = " ..newest_creature:GetDBTableGUIDLow().. ";")
						local x, y, z, o = player:GetLocation()
						found = true
						player:RemoveAura(63151)
						newest_creature:NearTeleport( x, y, z - 300, o )
						newest_creature:SaveToDB()
						newest_creature:DespawnOrUnsummon( 1000 )
						newest_creature:SetPhaseMask(0, true)
					end
				end
			end
			
			if found == true then
				player:SendBroadcastMessage("|cff145A32[Mount System]|r: Your mount has been stabled.")
			else
				player:SendBroadcastMessage("|cff145A32[Mount System]|r: Could not detect a mount. Is it within 10 yards of you?")
			end
		end
	elseif (intid >= 10) then
		local Mount_Query4 = WorldDBQuery("SELECT `spawned`, `creature` FROM `eluna_mount_owner` WHERE `spawned` != 0 AND `character_guid` = " ..player:GetGUIDLow().. ";")
		if Mount_Query4 ~= nil then
			player:SendBroadcastMessage("|cff145A32[Mount System]|r: You can only have one mount unstabled at a time.")
			return false
		else
			local x, y, z, o = player:GetLocation()
			PerformIngameSpawn(1, intid, player:GetMapId(), player:GetInstanceId(), x, y, z, o, true, 0, 1)
			local new_creature = player:GetNearestCreature(2, intid)
			if new_creature == nil then
				player:SendBroadcastMessage("|cff145A32[Mount System]|r: Something went horribly wrong!")
			else
				WorldDBExecute("UPDATE `eluna_mount_owner` SET `spawned` = " ..new_creature:GetDBTableGUIDLow().. " WHERE `character_guid` = " ..player:GetGUIDLow().. " AND `creature` = " ..new_creature:GetEntry().. " AND `spawned` = 0;")
			end
		end
	end
end


mount_creatures = {}
-- on item use, add to "garage"
local function Mount_OnUse(event, player, item, target)
	item_entry = item:GetEntry()
	WorldDBExecute("INSERT INTO `elunaworld`.`eluna_mount_owner` (`account`, `character`, `character_guid`, `item_name`, `creature`, `spawned`) VALUES ('" ..player:GetAccountName().. "', '" ..player:GetName().. "', '" ..player:GetGUIDLow().. "', '" ..item:GetName().. "', '" ..mount_creatures[item_entry].. "', '0');")
	player:SendBroadcastMessage("|cff145A32[Mount System]|r: You have added " ..item:GetName().. " to your collection. Visit a stable to spawn your mount.")
	player:RemoveItem(item, 1)
	return false
end

-- register events for both creature and items
local function Mount_RegisterEvents()
	local Mount_Query1 = WorldDBQuery("SELECT item, creature FROM eluna_mount_template")
	if (Mount_Query1 == nil) then
		-- Create `apt_template` table if not exists. Print error to populate database.
		PrintInfo("|cff145A32[Mount System]|r: Table `eluna_mount_template` is not populated with any entries. Please create some and restart your server to use the Mount system.")
		return
	else
		mount_creatures = {}
		mount_items = {}
		y = 0
		for x=1,Mount_Query1:GetRowCount(),1 do
			ClearCreatureGossipEvents(Mount_Query1:GetInt32(1))
			RegisterItemEvent(Mount_Query1:GetInt32(0), 2, Mount_OnUse)
			RegisterCreatureGossipEvent(Mount_Query1:GetInt32(1), 1, MountHello)
			RegisterCreatureGossipEvent(Mount_Query1:GetInt32(1), 2, MountSelect)
			y = y + 1
			mount_creatures[Mount_Query1:GetInt32(0)] = Mount_Query1:GetInt32(1) -- Insert into array item_id = gobject
			Mount_Query1:NextRow()
--			mount_items[Mount_Query1:GetInt32(1)] = Mount_Query1:GetInt32(0)
		end
		print("[Mount System]: " ..y.. " mounts and items loaded.")
	end
end

-- On script load, run function.
local function Mount_StartUp(event)
	Mount_RegisterEvents()
end

-- Deletes item events before re-registering them via `.reload mount_template`
local function Mount_ReloadEvents(event, player, command)
	if (command ~= "reload mount_template") then
		return
	else
		for x in pairs(mount_items) do
			ClearItemEvents(mount_items[x], 2) -- table[pos]  [pos]=value
			ClearCreatureGossipEvents(mount_creatures[x])
		end
		SendWorldMessage("DB table `mount_template` reloaded.")
		Mount_RegisterEvents()
		return false
	end
end

local function Mount_Debug(event, player, command)
	if (command:find("mount debug") ~= 1) then
		return
	elseif (player:GetGMRank() < ADMIN_RANK) then
		return
	else
		if player:HasAura(63151) == true then
			local creatures = player:GetCreaturesInRange( 5 )
			for x=1,#creatures,1 do
				local creature_target = creatures[x]
				local creature_vehicle = creature_target:GetVehicleKit()
				local mount_owner = creature_vehicle:GetPassenger( 0 )
				if mount_owner == player then
					creatures[x]:RemoveAura(63151)
					player:RemoveAura(63151)
				end
			end
		end		
	end
end

local function Mount_Logout(event, player)
	if player:HasAura(63151) == false then
		return
	else
		local creatures = player:GetCreaturesInRange( 5 )
		for x=1,#creatures,1 do
			local creature_target = creatures[x]
			local creature_vehicle = creature_target:GetVehicleKit()
			local mount_owner = creature_vehicle:GetPassenger( 0 )
			print("[Mount System]: DEBUG INFORMATION - creature_target: " ..tostring(creature_target).. ", creature_vehicle " ..tostring(creature_vehicle).. ", mount_owner " ..tostring(mount_owner).. ".")
			if mount_owner == player then
				creatures[x]:RemoveAura(63151)
				player:RemoveAura(63151)
				print("[Mount System]: " .. player:GetName() .. " was force dismounted.")
			end
		end
	end
end

-- RegisterPlayerEvent(42, Mount_Debug)
RegisterPlayerEvent(4, Mount_Logout)
RegisterPlayerEvent(42, Mount_ReloadEvents)
RegisterServerEvent(33, Mount_StartUp)
RegisterCreatureGossipEvent(STABLE_CREATURE, 1, StableHello)
RegisterCreatureGossipEvent(STABLE_CREATURE, 2, StableSelect)

-- make npc_spellclick have entry. gossip mount = rideable mount. set flag.