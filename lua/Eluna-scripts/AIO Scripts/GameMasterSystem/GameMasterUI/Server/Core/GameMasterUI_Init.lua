-- Require the modules
local queriesModule = require("GameMasterUI.Server.Database.GameMasterUI_Database")
local getQuery = queriesModule.getQuery
local configModule = require("GameMasterUI.Server.Core.GameMasterUI_Config")
local config = configModule
local DatabaseHelper = require("GameMasterUI.Server.Core.GameMasterUI_DatabaseHelper")
local debug = require("debug")

-- Initialize DatabaseHelper
DatabaseHelper.Initialize(config)



local CreatureDisplays = {
	Cache = {},
}
-- Constants for packet information
local CREATURE_QUERY_RESPONSE = 97
local PACKET_SIZE = 100
local DEFAULT_STRING = ""
local DEFAULT_FLAGS = 0

local function LoadCreatureDisplays()
	local coreName = GetCoreName()
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

local function SendCreatureQueryResponse(player, data)
	-- Input validation
	if not player or not data then
		return false
	end

	-- Validate required data
	if not data.entry then
		return false
	end

    -- Debug print for monitoring query responses
    if config.debug then
        print(string.format("Sending creature query response for entry: %d", data.entry))
    end

	-- Create response packet
	local packet = CreatePacket(CREATURE_QUERY_RESPONSE, PACKET_SIZE)
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

	-- Send packet and return success
	return player:SendPacket(packet)
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
		end, 1000, 1)
	end
end

RegisterPlayerEvent(3, OnLogin)
