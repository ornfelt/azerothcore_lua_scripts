-- Require the modules
local queriesModule = require("GameMasterUI.Server.Database.GameMasterUI_Database")
local getQuery = queriesModule.getQuery
local configModule = require("GameMasterUI.Server.Core.GameMasterUI_Config")
local config = configModule
local DatabaseHelper = require("GameMasterUI.Server.Core.GameMasterUI_DatabaseHelper")
local DatabaseErrorHelper = require("GameMasterUI.Server.Core.GameMasterUI_DatabaseErrorHelper")
local Utils = require("GameMasterUI.Server.Core.GameMasterUI_Utils")
local debug = require("debug")

-- Initialize DatabaseHelper and DatabaseErrorHelper
DatabaseHelper.Initialize(config)
DatabaseErrorHelper.Initialize(config, DatabaseHelper, Utils)



local CreatureDisplays = {
	Cache = {},
}

-- Item packet system
local PlayerItemCache = {} -- [playerGuid][itemEntry] = true

-- CONFIGURATION: Enable/disable item packet sending
-- Set to false to disable all item query response packets
local ENABLE_ITEM_PACKETS = false

-- Constants for packet information
local CREATURE_QUERY_RESPONSE = 97
local ITEM_QUERY_RESPONSE = 0x58 -- SMSG_ITEM_QUERY_SINGLE_RESPONSE
local CREATURE_PACKET_SIZE = 100
local ITEM_PACKET_SIZE = 800 -- Larger for item data
local DEFAULT_STRING = ""
local DEFAULT_FLAGS = 0

-- Forward declarations for functions that need to be called before they're defined
local LoadItemFromDatabase
local SendItemQueryResponse

-- Define the actual functions that will be used globally
local function SendItemQueryForList(player, itemEntries)
	if not ENABLE_ITEM_PACKETS then
		if config.debug then
			print(string.format("[GameMasterUI] Item packet sending is DISABLED. Skipping %d items", #(itemEntries or {})))
		end
		return
	end
	
	if not player or not itemEntries then
		return
	end
	
	local guid = player:GetGUIDLow()
	if not PlayerItemCache[guid] then
		PlayerItemCache[guid] = {}
	end
	
	local sentCount = 0
	local errorCount = 0
	for _, entry in ipairs(itemEntries) do
		if entry and entry > 0 and not PlayerItemCache[guid][entry] then
			print(string.format("[GameMasterUI] Processing item: %d", entry))
			
			-- Wrap in pcall to prevent one bad item from stopping the entire process
			local success, result = pcall(function()
				local itemData = LoadItemFromDatabase(entry)
				if itemData then
					-- SendItemQueryResponse now always returns true on successful call
					local packetSent = SendItemQueryResponse(player, itemData)
					if packetSent then
						PlayerItemCache[guid][entry] = true
						return true
					else
						-- Failed to send packet
						return false
					end
				else
					-- Failed to load item data
					return false
				end
			end)
			
			if success and result then
				sentCount = sentCount + 1
			else
				errorCount = errorCount + 1
				if not success then
					-- Exception processing item
				end
				-- Mark problematic items as "sent" to avoid retrying them
				PlayerItemCache[guid][entry] = true
			end
		end
	end
	
	-- Packet sending completed (debug messages removed)
end

local function extractItemEntriesFromResults(items)
	-- Extract item entries from results
	
	local entries = {}
	for _, item in ipairs(items or {}) do
		if item.entry then
			table.insert(entries, item.entry)
		elseif item.itemEntry then
			table.insert(entries, item.itemEntry)
		end
	end
	
	print(string.format("[GameMasterUI] Extracted %d item entries", #entries))
	return entries
end

-- Register global functions immediately
_G.GameMasterUI_SendItemQueryForList = SendItemQueryForList
_G.GameMasterUI_ExtractItemEntries = extractItemEntriesFromResults

local function LoadCreatureDisplays()
	local coreName = config.core.name
	local queryFunc = getQuery(coreName, "loadCreatureDisplays")

	if not queryFunc then
		if config.debug then
			print("[GameMasterUI] LoadCreatureDisplays query not found for core: " .. coreName)
		end
		return
	end

	local result, queryError = DatabaseHelper.SafeQuery(queryFunc(), "world")

	if result then
		repeat
			local creatureDisplay = {
				entry = result:GetUInt32(0),
				name = result:GetString(1),
				subname = result:GetString(2),
				iconName = result:GetString(3),
				type_flags = result:GetUInt32(4),
				cType = result:GetUInt32(5),
				family = result:GetUInt32(6),
				rank = result:GetUInt32(7),
				killCredit1 = result:GetUInt32(8),
				killCredit2 = result:GetUInt32(9),
				healthMod = result:GetFloat(10),
				manaMod = result:GetFloat(11),
				racialLeader = result:GetUInt32(12),
				movementType = result:GetUInt32(13),
				model1 = 0,
				model2 = 0,
				model3 = 0,
				model4 = 0,
			}

			if coreName == "TrinityCore" then
				creatureDisplay.model1 = result:GetUInt32(14)
				creatureDisplay.model2 = result:GetUInt32(15)
				creatureDisplay.model3 = result:GetUInt32(16)
				creatureDisplay.model4 = result:GetUInt32(17)
			elseif coreName == "AzerothCore" then
				creatureDisplay.model1 = result:GetUInt32(14)
			end

			table.insert(CreatureDisplays.Cache, creatureDisplay)
		until not result:NextRow()
	else
		if config.debug then
			local fileName = debug.getinfo(1).source
			print(string.format("[GameMasterUI] Error loading creature displays from database in file: %s", fileName))
			if queryError then
				print(string.format("[GameMasterUI] Database error: %s", queryError))
			end
		end
	end
end

-- Initialize caches on server start
LoadCreatureDisplays()

-- Load single item from database for packet
function LoadItemFromDatabase(itemEntry)
	print(string.format("[GameMasterUI] LoadItemFromDatabase called for item: %d", itemEntry))

	local coreName = config.core.name
	local queryFunc = getQuery(coreName, "loadItemForPacket")

	if not queryFunc then
		print("[GameMasterUI] ERROR: LoadItemFromDatabase query not found for core: " .. coreName)
		return nil
	end
	
	local result, queryError = DatabaseHelper.SafeQuery(queryFunc(itemEntry), "world")
	
	if not result then
		print(string.format("[GameMasterUI] ERROR: Failed to query item %d from database", itemEntry))
		if queryError then
			print(string.format("[GameMasterUI] Database error: %s", queryError))
		end
		return nil
	end
	
	if result then
		-- Basic validation of essential fields first
		local success, basicData = pcall(function()
			return {
				entry = result:GetUInt32(0),
				name = result:GetString(3) or ("Item " .. itemEntry),
				class = result:GetUInt32(1),
				quality = result:GetUInt32(5)
			}
		end)
		
		if not success then
			print(string.format("[GameMasterUI] ERROR: Failed to extract basic data for item %d: %s", itemEntry, tostring(basicData)))
			return nil
		end
		
		-- Now extract the full data structure
		local itemData = {
			entry = result:GetUInt32(0),
			class = result:GetUInt32(1),
			subclass = result:GetInt32(2),
			name = result:GetString(3) or ("Item " .. itemEntry),
			displayid = result:GetUInt32(4),
			quality = result:GetUInt32(5),
			flags = result:GetUInt32(6),
			flagsExtra = result:GetUInt32(7),
			buyPrice = result:GetInt32(8),
			sellPrice = result:GetUInt32(9),
			inventoryType = result:GetUInt32(10),
			allowableClass = result:GetInt32(11),
			allowableRace = result:GetInt32(12),
			itemLevel = result:GetUInt32(13),
			requiredLevel = result:GetUInt32(14),
			requiredSkill = result:GetUInt32(15),
			requiredSkillRank = result:GetUInt32(16),
			requiredSpell = result:GetUInt32(17),
			requiredHonorRank = result:GetUInt32(18),
			requiredCityRank = result:GetUInt32(19),
			requiredReputationFaction = result:GetUInt32(20),
			requiredReputationRank = result:GetUInt32(21),
			maxCount = result:GetInt32(22),
			stackable = result:GetInt32(23),
			containerSlots = result:GetUInt32(24),
			-- Stats
			statType = {},
			statValue = {},
		}
		
		-- Load 10 stat pairs
		for i = 1, 10 do
			itemData.statType[i] = result:GetUInt32(24 + (i-1)*2 + 1) or 0
			itemData.statValue[i] = result:GetInt32(24 + (i-1)*2 + 2) or 0
		end
		
		-- Continue loading other fields (starting at index 45)
		local idx = 45
		itemData.scalingStatDistribution = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.scalingStatValue = result:GetUInt32(idx) or 0
		idx = idx + 1
		
		-- Damage
		itemData.dmgMin1 = result:GetFloat(idx) or 0
		idx = idx + 1
		itemData.dmgMax1 = result:GetFloat(idx) or 0
		idx = idx + 1
		itemData.dmgType1 = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.dmgMin2 = result:GetFloat(idx) or 0
		idx = idx + 1
		itemData.dmgMax2 = result:GetFloat(idx) or 0
		idx = idx + 1
		itemData.dmgType2 = result:GetUInt32(idx) or 0
		idx = idx + 1
		
		-- Defense
		itemData.armor = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.holyRes = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.fireRes = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.natureRes = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.frostRes = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.shadowRes = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.arcaneRes = result:GetUInt32(idx) or 0
		idx = idx + 1
		
		-- Weapon stats
		itemData.delay = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.ammoType = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.rangedModRange = result:GetFloat(idx) or 0
		idx = idx + 1
		
		-- Spells (5 sets of 7 fields each)
		itemData.spells = {}
		for i = 1, 5 do
			itemData.spells[i] = {
				spellId = result:GetInt32(idx) or 0,
				spellTrigger = result:GetUInt32(idx + 1) or 0,
				spellCharges = result:GetInt32(idx + 2) or 0,
				spellPpmRate = result:GetFloat(idx + 3) or 0,
				spellCooldown = result:GetInt32(idx + 4) or 0,
				spellCategory = result:GetUInt32(idx + 5) or 0,
				spellCategoryCooldown = result:GetInt32(idx + 6) or 0
			}
			idx = idx + 7
		end
		
		-- Other properties
		itemData.bonding = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.description = result:GetString(idx) or ""
		idx = idx + 1
		itemData.pageText = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.languageId = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.pageMaterial = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.startQuest = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.lockId = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.material = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.sheath = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.randomProperty = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.randomSuffix = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.block = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.itemSet = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.maxDurability = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.area = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.map = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.bagFamily = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.totemCategory = result:GetInt32(idx) or 0
		idx = idx + 1
		
		-- Sockets
		itemData.socketColor1 = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.socketContent1 = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.socketColor2 = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.socketContent2 = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.socketColor3 = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.socketContent3 = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.socketBonus = result:GetInt32(idx) or 0
		idx = idx + 1
		
		-- Final fields
		itemData.gemProperties = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.requiredDisenchantSkill = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.armorDamageModifier = result:GetFloat(idx) or 0
		idx = idx + 1
		itemData.duration = result:GetUInt32(idx) or 0
		idx = idx + 1
		itemData.itemLimitCategory = result:GetInt32(idx) or 0
		idx = idx + 1
		itemData.holidayId = result:GetUInt32(idx) or 0
		
		print(string.format("[GameMasterUI] Successfully loaded item %d: %s", itemData.entry, itemData.name or "Unknown"))
		return itemData
	else
		print(string.format("[GameMasterUI] ERROR: Failed to load item %d from database", itemEntry))
		if queryError then
			print(string.format("[GameMasterUI] Database error: %s", queryError))
		end
		return nil
	end
end

-- Send item query response packet to client
function SendItemQueryResponse(player, itemData)
	-- Input validation
	if not player or not itemData then
		return false
	end
	
	-- Validate required data
	if not itemData.entry then
		return false
	end
	
	print(string.format("[GameMasterUI] SendItemQueryResponse called for item: %d (%s)", itemData.entry, itemData.name or "Unknown"))
	
	-- Create response packet
	print(string.format("[GameMasterUI] Creating packet with opcode: 0x%X, size: %d", ITEM_QUERY_RESPONSE, ITEM_PACKET_SIZE))
	local packet = CreatePacket(ITEM_QUERY_RESPONSE, ITEM_PACKET_SIZE)
	if not packet then
		print("[GameMasterUI] ERROR: CreatePacket returned nil!")
		return false
	end
	print("[GameMasterUI] Packet created successfully")
	
	-- Helper function to safely write data
	local function SafeWrite(value, default)
		return value or default
	end
	
	-- Write simplified packet data for testing
	print("[GameMasterUI] Writing simplified packet data...")
	local success, error = pcall(function()
		-- Essential item data only
		packet:WriteULong(itemData.entry or 0) -- Item entry ID
		packet:WriteULong(SafeWrite(itemData.class, 0)) -- Item class
		packet:WriteULong(SafeWrite(itemData.subclass, 0)) -- Item subclass
		packet:WriteLong(-1) -- sound_override_subclass (usually -1)
		
		-- Item name and variants (ensure name is not nil)
		local itemName = itemData.name
		if not itemName or itemName == "" then
			itemName = "Item " .. (itemData.entry or "Unknown")
		end
		packet:WriteString(itemName)
		packet:WriteString("") -- name2 - empty
		packet:WriteString("") -- name3 - empty 
		packet:WriteString("") -- name4 - empty
		
		-- Display and quality (fix field names - they should match what we stored)
		packet:WriteULong(SafeWrite(itemData.displayid, 0)) -- Display ID
		packet:WriteULong(SafeWrite(itemData.quality, 0)) -- Item quality
		packet:WriteULong(SafeWrite(itemData.flags, 0)) -- Item flags
		packet:WriteULong(SafeWrite(itemData.flagsExtra, 0)) -- Extra flags
		
		-- Basic pricing
		packet:WriteULong(SafeWrite(itemData.buyPrice, 0)) -- Buy price
		packet:WriteULong(SafeWrite(itemData.sellPrice, 0)) -- Sell price
		packet:WriteULong(SafeWrite(itemData.inventoryType, 0)) -- Inventory type
		packet:WriteLong(SafeWrite(itemData.allowableClass, -1)) -- Allowable class
		packet:WriteLong(SafeWrite(itemData.allowableRace, -1)) -- Allowable race
		packet:WriteULong(SafeWrite(itemData.itemLevel, 1)) -- Item level
		packet:WriteULong(SafeWrite(itemData.requiredLevel, 0)) -- Required level
		
		-- Basic packet fields written
	end)
	
	if not success then
		print(string.format("[GameMasterUI] ERROR writing packet data: %s", tostring(error)))
		return false
	end
	-- Packet data written successfully
	
	-- Send packet (SendPacket returns nothing, so we return true on successful call)
	player:SendPacket(packet)
	return true
end

local function SendCreatureQueryResponse(player, data)
	-- Input validation
	if not player or not data then
		return false
	end

	-- Validate required data
	if not data.entry then
		return false
	end

    ---- Debug print for monitoring query responses
    --if config.debug then
    --    print(string.format("Sending creature query response for entry: %d", data.entry))
    --end

	-- Create response packet
	local packet = CreatePacket(CREATURE_QUERY_RESPONSE, CREATURE_PACKET_SIZE)
	if not packet then
		return false
	end

	-- Helper function to safely write data
	local function SafeWrite(value, default)
		return value or default
	end

	-- Write packet data with safe defaults
	pcall(function()
		packet:WriteULong(data.entry)
		packet:WriteString(SafeWrite(data.name, DEFAULT_STRING))
		packet:WriteUByte(DEFAULT_FLAGS) -- Flags 1
		packet:WriteUByte(DEFAULT_FLAGS) -- Flags 2
		packet:WriteUByte(DEFAULT_FLAGS) -- Flags 3
		packet:WriteString(SafeWrite(data.subname, DEFAULT_STRING))
		packet:WriteString(SafeWrite(data.iconName, DEFAULT_STRING))
		packet:WriteULong(SafeWrite(data.type_flags, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.cType, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.family, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.rank, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.killCredit1, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.killCredit2, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.model1, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.model2, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.model3, DEFAULT_FLAGS))
		packet:WriteULong(SafeWrite(data.model4, DEFAULT_FLAGS))
		packet:WriteFloat(SafeWrite(data.healthMod, 1.0))
		packet:WriteFloat(SafeWrite(data.manaMod, 1.0))
		packet:WriteUByte(SafeWrite(data.racialLeader, DEFAULT_FLAGS))

		-- Write remaining default values
		for i = 1, 6 do
			packet:WriteULong(DEFAULT_FLAGS)
		end
		-- TODO!: This will make npc moonwalk some odd behavior
		-- packet:WriteULong(SafeWrite(data.movementType, DEFAULT_FLAGS))
	end)

	-- Send packet (SendPacket returns nothing, so we return true on successful call)
	--print(string.format("[GameMasterUI] Sending creature packet for entry %d", data.entry))
	player:SendPacket(packet)
	--print(string.format("[GameMasterUI] Creature packet sent successfully for entry %d", data.entry))
	return true
end

-- Functions have been moved up and are now available globally

-- Cleanup player cache on logout
local function CleanupPlayerCache(event, player)
	local guid = player:GetGUIDLow()
	PlayerItemCache[guid] = nil
end

-- Functions moved up and registered globally

-- Test command for packet testing
local function OnPlayerChat(event, player, msg, type, lang)
	-- Only process messages that start with # (command prefix)
	if not msg:match("^#") then
		return
	end
	
	if player:GetGMRank() > 0 then
		if msg:sub(1, 13) == "#testitempack" then
			local itemId = msg:match("(%d+)")
			if not itemId then
				itemId = 19019 -- Default to Thunderfury
			else
				itemId = tonumber(itemId)
			end
			
			print(string.format("[GameMasterUI] Test command triggered - Item ID: %d", itemId))
			player:SendBroadcastMessage(string.format("Testing item packet for item ID: %d", itemId))
			
			local itemData = LoadItemFromDatabase(itemId)
			if itemData then
				print(string.format("[GameMasterUI] Item data loaded: %s", itemData.name))
				SendItemQueryResponse(player, itemData)
				player:SendBroadcastMessage(string.format("Packet sent for item: %s", itemData.name or "Unknown"))
			else
				print(string.format("[GameMasterUI] Item %d not found", itemId))
				player:SendBroadcastMessage(string.format("Item %d not found in database", itemId))
			end
			
			return false -- Don't display the command in chat
		elseif msg == "#testglobals" then
			-- Test if global functions exist
			print(string.format("[GameMasterUI] Testing global functions..."))
			player:SendBroadcastMessage("Testing global functions...")
			
			-- Function availability checks
			if _G.GameMasterUI_SendItemQueryForList then
				player:SendBroadcastMessage("✓ GameMasterUI_SendItemQueryForList exists")
			else
				player:SendBroadcastMessage("✗ GameMasterUI_SendItemQueryForList missing")
			end
			
			if _G.GameMasterUI_ExtractItemEntries then
				player:SendBroadcastMessage("✓ GameMasterUI_ExtractItemEntries exists")
			else
				player:SendBroadcastMessage("✗ GameMasterUI_ExtractItemEntries missing")
			end
			
			return false
		elseif msg:sub(1, 14) == "#testitemquery" then
			-- Test loading a specific item from database without sending packet
			local itemId = msg:match("(%d+)")
			if not itemId then
				itemId = 57001 -- Default to the problematic item
			else
				itemId = tonumber(itemId)
			end
			
			print(string.format("[GameMasterUI] Testing item query for item ID: %d", itemId))
			player:SendBroadcastMessage(string.format("Testing item query for item ID: %d", itemId))
			
			local itemData = LoadItemFromDatabase(itemId)
			if itemData then
				print(string.format("[GameMasterUI] Item query test SUCCESS: %s (ID: %d)", itemData.name, itemData.entry))
				player:SendBroadcastMessage(string.format("✓ Item loaded: %s (ID: %d)", itemData.name, itemData.entry))
				player:SendBroadcastMessage(string.format("  Class: %d, Quality: %d, Display: %d", itemData.class or 0, itemData.quality or 0, itemData.displayid or 0))
			else
				print(string.format("[GameMasterUI] Item query test FAILED for item %d", itemId))
				player:SendBroadcastMessage(string.format("✗ Failed to load item %d", itemId))
			end
			
			return false
		end
	end
end

local function OnLogin(event, player)
	for _, cachedDisplay in pairs(CreatureDisplays.Cache) do
		SendCreatureQueryResponse(player, cachedDisplay)
	end

	-- Check server capabilities for GM players
	if player:GetGMRank() > 0 then
		-- Delay the capability check slightly to ensure AIO is ready
		player:RegisterEvent(function(eventId, delay, repeats, player)
			if GameMasterSystem and GameMasterSystem.checkServerCapabilities then
				GameMasterSystem.checkServerCapabilities(player)
			end

			-- Check database status and notify player if there are issues
			if DatabaseErrorHelper and DatabaseErrorHelper.SendStartupDatabaseStatus then
				DatabaseErrorHelper.SendStartupDatabaseStatus(player)
			end
		end, 1000, 1)
	end
end

RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(4, CleanupPlayerCache)
RegisterPlayerEvent(18, OnPlayerChat) -- PLAYER_EVENT_ON_CHAT

-- print("[GameMasterUI] GameMasterUI_Init.lua loaded successfully!")
-- print("[GameMasterUI] Test commands available:")
-- print("[GameMasterUI] - #testitempack [itemid] - Test sending item packet")
-- print("[GameMasterUI] - #testglobals - Test global function availability")
-- print("[GameMasterUI] - #testitemquery [itemid] - Test loading item from database (default: 57001)")
-- Global functions registered (debug output removed)
