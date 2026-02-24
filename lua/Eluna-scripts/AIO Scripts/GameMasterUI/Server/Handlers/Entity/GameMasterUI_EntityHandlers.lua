local utils = require("GameMasterUI.Server.Core.GameMasterUI_Utils")
local config = require("GameMasterUI.Server.Core.GameMasterUI_Config")

local EntityHandlers = {
	spawnNpcEntity = function(player, entry)
		entry = tonumber(tostring(entry):match("^%s*(.-)%s*$")) -- Trim spaces and convert to number
		if not entry or entry <= 0 then
			utils.sendMessage(player, "error", "Invalid entry ID: " .. (entry or "nil"))
			return
		end

		local x, y, z, o = utils.calculatePosition(player, 3)
		local mapId = player:GetMapId()
		local instanceId = player:GetInstanceId()
		local save = true -- Temporary spawns by default
		local durorresptime = 0 -- 60 seconds
		local phase = player:GetPhaseMask() or 1 -- Default to player's phase

		utils.sendMessage(player, "info", "Attempting to spawn creature with ID: " .. entry)

		if config.debug then
			print(
				string.format(
					"Spawn Parameters: Entry: %d, Map: %d, Instance: %d, X: %.2f, Y: %.2f, Z: %.2f, O: %.2f",
					entry,
					mapId,
					instanceId,
					x,
					y,
					z,
					o
				)
			)
		end

		-- Use PerformIngameSpawn for better compatibility
		local spawnedCreature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, save, respawnTime, phase)

		if spawnedCreature then
			utils.sendMessage(player, "success", "Successfully spawned creature with ID: " .. entry)
			return spawnedCreature
		else
			utils.sendMessage(player, "error", "Failed to spawn creature with ID: " .. entry)
			return nil
		end
	end,

	deleteNpcEntity = function(player, entry)
		if not entry or entry == "" then
			utils.sendMessage(player, "error", "Entry is nil or empty")
			return
		end

		local creature = player:GetNearestCreature(100, entry)

		if creature then
			utils.sendMessage(player, "success", "Received delete request for NPC with entry: " .. entry)
			creature:RemoveFromWorld(config.removeFromWorld)
		end
	end,

	morphNpcEntity = function(player, entry)
		if not entry or entry == "" then
			utils.sendMessage(player, "error", "Entry is nil or empty")
			return
		end

		local target = player:GetSelection()
		if target then
			target:SetDisplayId(entry)
			utils.sendMessage(player, "success", "Morphed target entity with displayid: " .. entry)
		else
			player:SetDisplayId(entry)
			utils.sendMessage(player, "success", "Morphed self with displayid: " .. entry)
		end
	end,

	demorphNpcEntity = function(player)
		local target = player:GetSelection()
		if target then
			target:DeMorph()
			utils.sendMessage(player, "success", "Demorphed target entity.")
		else
			player:DeMorph()
			utils.sendMessage(player, "success", "Demorphed self.")
		end
	end,

	spawnGameObject = function(player, entry)
		entry = tonumber(tostring(entry):match("^%s*(.-)%s*$")) -- Trim spaces and convert to number
		if not entry or entry <= 0 then
			utils.sendMessage(player, "error", "Invalid GameObject entry ID: " .. (entry or "nil"))
			return
		end

		local x, y, z, o = utils.calculatePosition(player, 3)
		local mapId = player:GetMapId()
		local instanceId = player:GetInstanceId()
		local save = true -- Temporary spawns by default
		local durorresptime = 0 -- 60 seconds
		local phase = player:GetPhaseMask() or 1 -- Default to player's phase

		utils.sendMessage(player, "info", "Attempting to spawn GameObject with ID: " .. entry)

		if config.debug then
			print(
				string.format(
					"GameObject Spawn Parameters: Entry: %d, Map: %d, Instance: %d, X: %.2f, Y: %.2f, Z: %.2f, O: %.2f",
					entry,
					mapId,
					instanceId,
					x,
					y,
					z,
					o
				)
			)
		end

		-- Use PerformIngameSpawn for better compatibility (2 = GameObject type)
		local gob = PerformIngameSpawn(2, entry, mapId, instanceId, x, y, z, o, save, durorresptime, phase)

		if gob then
			utils.sendMessage(player, "success", "Successfully spawned GameObject with ID: " .. entry)
			
			-- Hook for ObjectEditor - send object data to client
			local ObjectEditorHandlers = require("GameMasterUI.Server.Handlers.Entity.GameMasterUI_ObjectEditorHandlers")
			if ObjectEditorHandlers and ObjectEditorHandlers.onGameObjectSpawn then
				ObjectEditorHandlers.onGameObjectSpawn(player, gob)
			end
			
			return gob
		else
			utils.sendMessage(player, "error", "Failed to spawn GameObject with ID: " .. entry)
			return nil
		end
	end,

	deleteGameObjectEntity = function(player, entry)
		if not entry or entry == "" then
			utils.sendMessage(player, "error", "Entry is nil or empty")
			return
		end

		local gob = player:GetNearObject(100, 3, tonumber(entry))

		if gob then
			gob:RemoveFromWorld(config.removeFromWorld)
		end
	end,

	spawnAndDeleteNpcEntity = function(player, entry)
		entry = tostring(entry):match("^%s*(.-)%s*$") -- Trim spaces
		if not entry or entry == "" then
			utils.sendMessage(player, "error", "Entry is nil or empty")
			return
		end

		utils.sendMessage(player, "success", "Received spawn and delete request for NPC with entry: " .. entry)

		local x, y, z, oppositeAngle = utils.calculatePosition(player, 3)
		local spawnedCreature = player:SpawnCreature(entry, x, y, z, oppositeAngle)

		if spawnedCreature and spawnedCreature:IsInWorld() then
			spawnedCreature:RemoveFromWorld(config.removeFromWorld)
			spawnedCreature:SetFaction(player:GetFaction())
		else
			utils.sendMessage(player, "error", "Failed to spawn entity with entry: " .. entry)
		end
	end,

	spawnAndDeleteGameObjectEntity = function(player, entry)
		entry = tostring(entry):match("^%s*(.-)%s*$") -- Trim spaces
		if not entry or entry == "" then
			utils.sendMessage(player, "error", "Entry is nil or empty")
			return
		end

		utils.sendMessage(player, "success", "Received spawn and delete request for GameObject with entry: " .. entry)

		local x, y, z, oppositeAngle = utils.calculatePosition(player, 3)
		local mapId = player:GetMapId()
		local instanceId = player:GetInstanceId()
		local save = false
		local durorresptime = 30000
		local phase = 1

		local gob = PerformIngameSpawn(2, entry, mapId, instanceId, x, y, z, oppositeAngle, save, durorresptime, phase)
		if gob then
			gob:Despawn()
			utils.sendMessage(player, "success", "Spawned and despawned GameObject with entry: " .. entry)
		else
			utils.sendMessage(player, "error", "Failed to spawn GameObject with entry: " .. entry)
		end
	end,

	duplicateNpcEntity = function(player, entry)
		entry = tonumber(entry)
		if not entry or entry <= 0 then
			utils.sendMessage(player, "error", "Invalid NPC entry ID.")
			return
		end

		-- Check if entry exists
		local checkQuery = WorldDBQuery("SELECT entry, name FROM creature_template WHERE entry = " .. entry)
		if not checkQuery then
			utils.sendMessage(player, "error", "NPC entry " .. entry .. " does not exist in the database.")
			return
		end

		local sourceName = checkQuery:GetString(1)

		-- Use temporary tables for efficient duplication (from lua-command+)
		WorldDBExecute(
			"CREATE TEMPORARY TABLE TEMP_QUERY ENGINE=MEMORY SELECT * FROM creature_template WHERE entry = " .. entry
		)
		WorldDBExecute("UPDATE TEMP_QUERY SET entry=(SELECT MAX(entry)+1 FROM creature_template)")
		WorldDBExecute("UPDATE TEMP_QUERY SET name=CONCAT(name, ' (Clone)') WHERE 1=1")
		WorldDBExecute("INSERT INTO creature_template SELECT * FROM TEMP_QUERY")
		WorldDBExecute("DROP TABLE TEMP_QUERY")

		-- Get the new entry ID
		local newEntryId = WorldDBQuery("SELECT MAX(entry) FROM creature_template"):GetUInt32(0)

		-- Set lootid, pickpocketloot, and skinloot to 0 for the clone to prevent duplicating drop tables
		WorldDBExecute(
			"UPDATE creature_template SET lootid = 0, pickpocketloot = 0, skinloot = 0 WHERE entry = " .. newEntryId
		)

		-- Try to duplicate related tables (creature_equip_template, creature_template_addon, etc.)
		pcall(function()
			-- First check if table structure exists with CreatureID column (Trinity)
			local hasCreatureIDColumn = WorldDBQuery("SHOW COLUMNS FROM creature_equip_template LIKE 'CreatureID'")

			if hasCreatureIDColumn then
				WorldDBExecute(
					string.format(
						"INSERT INTO creature_equip_template (CreatureID, ID, ItemID1, ItemID2, ItemID3) "
							.. "SELECT %d, ID, ItemID1, ItemID2, ItemID3 "
							.. "FROM creature_equip_template WHERE CreatureID = %d",
						newEntryId,
						entry
					)
				)
			else
				-- Try with entry column instead
				WorldDBExecute(
					string.format(
						"INSERT INTO creature_equip_template (entry, id, ItemID1, ItemID2, ItemID3) "
							.. "SELECT %d, id, ItemID1, ItemID2, ItemID3 "
							.. "FROM creature_equip_template WHERE entry = %d",
						newEntryId,
						entry
					)
				)
			end
		end)

		-- Duplicate template addon
		pcall(function()
			WorldDBExecute(
				string.format(
					"INSERT IGNORE INTO creature_template_addon (entry, path_id, mount, MountCreatureID, "
						.. "StandState, AnimTier, VisFlags, SheathState, PvPFlags, emote, visibilityDistanceType, auras) "
						.. "SELECT %d, path_id, mount, MountCreatureID, StandState, AnimTier, VisFlags, SheathState, "
						.. "PvPFlags, emote, visibilityDistanceType, auras "
						.. "FROM creature_template_addon WHERE entry = %d",
					newEntryId,
					entry
				)
			)
		end)

		utils.sendMessage(
			player,
			"success",
			string.format("Successfully duplicated NPC '%s' (ID: %d) to new entry %d", sourceName, entry, newEntryId)
		)

		return newEntryId
	end,

	duplicateGameObjectEntity = function(player, entry)
		entry = tonumber(entry)
		if not entry or entry <= 0 then
			utils.sendMessage(player, "error", "Invalid GameObject entry ID.")
			return
		end

		-- Check if entry exists
		local checkQuery = WorldDBQuery("SELECT entry, name FROM gameobject_template WHERE entry = " .. entry)
		if not checkQuery then
			utils.sendMessage(player, "error", "GameObject entry " .. entry .. " does not exist in the database.")
			return
		end

		local sourceName = checkQuery:GetString(1)

		-- Use temporary tables for efficient duplication (from lua-command+)
		WorldDBExecute(
			"CREATE TEMPORARY TABLE TEMP_QUERY ENGINE=MEMORY SELECT * FROM gameobject_template WHERE entry = " .. entry
		)
		WorldDBExecute("UPDATE TEMP_QUERY SET entry=(SELECT MAX(entry)+1 FROM gameobject_template)")
		WorldDBExecute("UPDATE TEMP_QUERY SET name=CONCAT(name, ' (Clone)') WHERE 1=1")
		WorldDBExecute("INSERT INTO gameobject_template SELECT * FROM TEMP_QUERY")
		WorldDBExecute("DROP TABLE TEMP_QUERY")

		-- Get the new entry ID
		local newEntryId = WorldDBQuery("SELECT MAX(entry) FROM gameobject_template"):GetUInt32(0)

		-- Try to duplicate gameobject_template_addon if exists
		pcall(function()
			WorldDBExecute(
				string.format(
					"INSERT IGNORE INTO gameobject_template_addon (entry, faction, flags, mingold, maxgold) "
						.. "SELECT %d, faction, flags, mingold, maxgold "
						.. "FROM gameobject_template_addon WHERE entry = %d",
					newEntryId,
					entry
				)
			)
		end)

		utils.sendMessage(
			player,
			"success",
			string.format(
				"Successfully duplicated GameObject '%s' (ID: %d) to new entry %d",
				sourceName,
				entry,
				newEntryId
			)
		)

		return newEntryId
	end,

	-- New function for duplicating items
	duplicateItemEntity = function(player, entry)
		entry = tonumber(entry)
		if not entry or entry <= 0 then
			utils.sendMessage(player, "error", "Invalid Item entry ID.")
			return
		end

		-- Check if entry exists
		local checkQuery = WorldDBQuery("SELECT entry, name FROM item_template WHERE entry = " .. entry)
		if not checkQuery then
			utils.sendMessage(player, "error", "Item entry " .. entry .. " does not exist in the database.")
			return
		end

		local sourceName = checkQuery:GetString(1)

		-- Use temporary tables for efficient duplication (from lua-command+)
		WorldDBExecute(
			"CREATE TEMPORARY TABLE TEMP_QUERY ENGINE=MEMORY SELECT * FROM item_template WHERE entry = " .. entry
		)
		WorldDBExecute("UPDATE TEMP_QUERY SET entry=(SELECT MAX(entry)+1 FROM item_template)")
		WorldDBExecute("UPDATE TEMP_QUERY SET name=CONCAT(name, ' (Clone)') WHERE 1=1")
		WorldDBExecute("INSERT INTO item_template SELECT * FROM TEMP_QUERY")
		WorldDBExecute("DROP TABLE TEMP_QUERY")

		-- Get the new entry ID
		local newEntryId = WorldDBQuery("SELECT MAX(entry) FROM item_template"):GetUInt32(0)

		-- Try to duplicate related tables if they exist

		-- item_enchantment_template
		pcall(function()
			WorldDBExecute(
				string.format(
					"INSERT INTO item_enchantment_template (entry, ench, chance) "
						.. "SELECT %d, ench, chance FROM item_enchantment_template WHERE entry = %d",
					newEntryId,
					entry
				)
			)
		end)

		-- item_loot_template (don't duplicate loot tables to prevent duplication issues)
		pcall(function()
			local lootCheck = WorldDBQuery("SELECT COUNT(*) FROM item_loot_template WHERE Entry = " .. entry)
			if lootCheck and lootCheck:GetUInt32(0) > 0 then
				utils.sendMessage(
					player,
					"warning",
					string.format(
						"The original item (ID: %d) has loot templates that were not duplicated. "
							.. "You'll need to set up loot separately for the new item (ID: %d).",
						entry,
						newEntryId
					)
				)
			end
		end)

		utils.sendMessage(
			player,
			"success",
			string.format("Successfully duplicated Item '%s' (ID: %d) to new entry %d", sourceName, entry, newEntryId)
		)

		-- Provide command to add the item
		utils.sendMessage(
			player,
			"info",
			string.format("You can add the cloned Item with command: .additem %d", newEntryId)
		)

		return newEntryId
	end,
}

return EntityHandlers
