--[[
    GameMaster UI - Teleport Handlers
    
    This module handles teleportation functionality:
    - Fetching teleport locations from game_tele table
    - Searching and filtering locations
    - Executing teleportation commands
    - Managing teleport presets
]]--

local AIO = AIO or require("AIO")

-- Local references
local TeleportHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, DatabaseHelper


-- Cache for teleport locations
local teleportCache = {
    data = nil,
    lastUpdate = 0,
    cacheTimeout = 300 -- 5 minutes
}

-- Preset teleport locations (commonly used)
local teleportPresets = {
    -- Alliance Cities
    Stormwind = { map = 0, x = -8913.23, y = 554.633, z = 93.7944, o = 0.0 },
    Ironforge = { map = 0, x = -4981.25, y = -881.542, z = 501.66, o = 0.0 },
    Darnassus = { map = 1, x = 9948.55, y = 2413.59, z = 1316.21, o = 0.0 },
    Exodar = { map = 530, x = -4014.08, y = -11895.8, z = -1.99, o = 0.0 },
    
    -- Horde Cities
    Orgrimmar = { map = 1, x = 1676.21, y = -4315.29, z = 61.5293, o = 0.0 },
    ThunderBluff = { map = 1, x = -1196.22, y = 29.0941, z = 176.949, o = 0.0 },
    Undercity = { map = 0, x = 1586.48, y = 239.562, z = -52.149, o = 0.0 },
    Silvermoon = { map = 530, x = 9473.03, y = -7279.67, z = 14.2285, o = 0.0 },
    
    -- Neutral Cities
    Shattrath = { map = 530, x = -1863.03, y = 4998.05, z = -21.1847, o = 0.0 },
    Dalaran = { map = 571, x = 5804.15, y = 624.771, z = 647.767, o = 0.0 },
    
    -- Starting Zones
    Northshire = { map = 0, x = -8949.95, y = -132.493, z = 83.5312, o = 0.0 },
    ColdridgeValley = { map = 0, x = -6240.32, y = 331.033, z = 382.758, o = 0.0 },
    Shadowglen = { map = 1, x = 10311.3, y = 832.463, z = 1326.41, o = 0.0 },
    AmmenVale = { map = 530, x = -4037.21, y = -13791.4, z = 74.6916, o = 0.0 },
    ValleyOfTrials = { map = 1, x = -618.518, y = -4251.67, z = 38.718, o = 0.0 },
    CampNarache = { map = 1, x = -2917.58, y = -257.98, z = 52.9968, o = 0.0 },
    Deathknell = { map = 0, x = 1676.71, y = 1678.31, z = 120.933, o = 0.0 },
    SunstriderIsle = { map = 530, x = 10349.6, y = -6357.29, z = 33.4026, o = 0.0 },
    Acherus = { map = 609, x = 2355.84, y = -5664.77, z = 426.028, o = 0.0 },
    
    -- GM/Dev Areas
    GMIsland = { map = 1, x = 16222.1, y = 16252.1, z = 12.5872, o = 0.0 },
    DeveloperLand = { map = 451, x = 16303.5, y = -16173.5, z = 40.4444, o = 0.0 },
    ProgrammerIsle = { map = 451, x = 16303.5, y = -16173.5, z = 40.4444, o = 0.0 },
    DesignerIsland = { map = 451, x = 16303.5, y = -16173.5, z = 40.4444, o = 0.0 },
}

-- Get teleport locations with pagination
function TeleportHandlers.GetTeleportLocations(player, page, pageSize, sortOrder)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    page = page or 1
    pageSize = pageSize or 20
    sortOrder = sortOrder or "id_desc"
    local offset = (page - 1) * pageSize
    
    -- Parse sort order
    local orderBy = "id DESC"  -- default
    if sortOrder == "id_asc" then
        orderBy = "id ASC"
    elseif sortOrder == "name_asc" then
        orderBy = "name ASC"
    elseif sortOrder == "name_desc" then
        orderBy = "name DESC"
    elseif sortOrder == "map_asc" then
        orderBy = "map ASC, name ASC"
    end
    
    -- Get total count
    local countQuery = "SELECT COUNT(*) as total FROM game_tele"
    local countResult = WorldDBQuery(countQuery)
    local totalCount = 0
    
    if countResult then
        totalCount = countResult:GetUInt32(0)
    end
    
    local totalPages = math.ceil(totalCount / pageSize)
    
    -- Get paginated data with dynamic sort order
    local query = string.format(
        "SELECT id, position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele " ..
        "ORDER BY %s " ..
        "LIMIT %d OFFSET %d",
        orderBy, pageSize, offset
    )
    
    local result = WorldDBQuery(query)
    local locations = {}
    
    if result then
        repeat
            table.insert(locations, {
                id = result:GetUInt32(0),
                position_x = result:GetFloat(1),
                position_y = result:GetFloat(2),
                position_z = result:GetFloat(3),
                orientation = result:GetFloat(4),
                map = result:GetUInt16(5),
                name = result:GetString(6)
            })
        until not result:NextRow()
    end
    
    -- Send data to client
    AIO.Handle(player, "GameMasterSystem", "ReceiveTeleportData", locations, totalCount, totalPages)
end

-- Search teleport locations
function TeleportHandlers.SearchTeleportLocations(player, searchText, page, pageSize, sortOrder)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    page = page or 1
    pageSize = pageSize or 20
    sortOrder = sortOrder or "id_desc"
    local offset = (page - 1) * pageSize
    
    -- Parse sort order
    local orderBy = "id DESC"  -- default
    if sortOrder == "id_asc" then
        orderBy = "id ASC"
    elseif sortOrder == "name_asc" then
        orderBy = "name ASC"
    elseif sortOrder == "name_desc" then
        orderBy = "name DESC"
    elseif sortOrder == "map_asc" then
        orderBy = "map ASC, name ASC"
    end
    
    -- Sanitize search text
    searchText = searchText:gsub("'", "''")
    
    -- Get total count for search
    local countQuery = string.format(
        "SELECT COUNT(*) as total FROM game_tele WHERE name LIKE '%%%s%%'",
        searchText
    )
    local countResult = WorldDBQuery(countQuery)
    local totalCount = 0
    
    if countResult then
        totalCount = countResult:GetUInt32(0)
    end
    
    local totalPages = math.ceil(totalCount / pageSize)
    
    -- Get paginated search results with dynamic sort order
    local query = string.format(
        "SELECT id, position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele " ..
        "WHERE name LIKE '%%%s%%' " ..
        "ORDER BY %s " ..
        "LIMIT %d OFFSET %d",
        searchText, orderBy, pageSize, offset
    )
    
    local result = WorldDBQuery(query)
    local locations = {}
    
    if result then
        repeat
            table.insert(locations, {
                id = result:GetUInt32(0),
                position_x = result:GetFloat(1),
                position_y = result:GetFloat(2),
                position_z = result:GetFloat(3),
                orientation = result:GetFloat(4),
                map = result:GetUInt16(5),
                name = result:GetString(6)
            })
        until not result:NextRow()
    end
    
    -- Send data to client
    AIO.Handle(player, "GameMasterSystem", "ReceiveTeleportData", locations, totalCount, totalPages)
end

-- Get all teleport locations (for advanced search)
function TeleportHandlers.GetAllTeleportLocations(player)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Check cache
    local currentTime = os.time()
    if teleportCache.data and (currentTime - teleportCache.lastUpdate) < teleportCache.cacheTimeout then
        -- Use cached data
        AIO.Handle(player, "GameMasterSystem", "ReceiveAllTeleportData", teleportCache.data)
        return
    end
    
    -- Query all locations
    local query = "SELECT id, position_x, position_y, position_z, orientation, map, name " ..
                 "FROM game_tele ORDER BY name ASC"
    
    local result = WorldDBQuery(query)
    local locations = {}
    
    if result then
        repeat
            table.insert(locations, {
                id = result:GetUInt32(0),
                position_x = result:GetFloat(1),
                position_y = result:GetFloat(2),
                position_z = result:GetFloat(3),
                orientation = result:GetFloat(4),
                map = result:GetUInt16(5),
                name = result:GetString(6)
            })
        until not result:NextRow()
    end
    
    -- Update cache
    teleportCache.data = locations
    teleportCache.lastUpdate = currentTime
    
    -- Send data to client
    AIO.Handle(player, "GameMasterSystem", "ReceiveAllTeleportData", locations)
end

-- Teleport to location (self)
function TeleportHandlers.TeleportToLocation(player, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Query location details
    local query = string.format(
        "SELECT position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele WHERE id = %d",
        locationId
    )
    
    local result = WorldDBQuery(query)
    if result then
        local x = result:GetFloat(0)
        local y = result:GetFloat(1)
        local z = result:GetFloat(2)
        local o = result:GetFloat(3)
        local mapId = result:GetUInt16(4)
        local name = result:GetString(5)
        
        -- Teleport player
        player:Teleport(mapId, x, y, z, o)
        Utils.sendMessage(player, "success", "Teleported to " .. name)
    else
        Utils.sendMessage(player, "error", "Location not found.")
    end
end

-- Teleport player to location
function TeleportHandlers.TeleportPlayerToLocation(player, targetName, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Query location details
    local query = string.format(
        "SELECT position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele WHERE id = %d",
        locationId
    )
    
    local result = WorldDBQuery(query)
    if result then
        local x = result:GetFloat(0)
        local y = result:GetFloat(1)
        local z = result:GetFloat(2)
        local o = result:GetFloat(3)
        local mapId = result:GetUInt16(4)
        local name = result:GetString(5)
        
        -- Teleport target player
        targetPlayer:Teleport(mapId, x, y, z, o)
        
        -- Notify both players
        Utils.sendMessage(player, "success", string.format("Teleported %s to %s", targetName, name))
        targetPlayer:SendBroadcastMessage(string.format("You have been teleported to %s by GM %s", name, player:GetName()))
    else
        Utils.sendMessage(player, "error", "Location not found.")
    end
end

-- Teleport to preset location
function TeleportHandlers.TeleportToPreset(player, presetName)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local preset = teleportPresets[presetName]
    if preset then
        player:Teleport(preset.map, preset.x, preset.y, preset.z, preset.o)
        Utils.sendMessage(player, "success", "Teleported to " .. presetName)
    else
        Utils.sendMessage(player, "error", "Preset location '" .. presetName .. "' not found.")
    end
end

-- Teleport to player (existing functionality)
function TeleportHandlers.TeleportToPlayer(player, targetName)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Teleport GM to player
    player:Teleport(
        targetPlayer:GetMapId(),
        targetPlayer:GetX(),
        targetPlayer:GetY(),
        targetPlayer:GetZ(),
        targetPlayer:GetO()
    )
    
    Utils.sendMessage(player, "success", "Teleported to " .. targetName .. ".")
end

-- Summon player (existing functionality)
function TeleportHandlers.SummonPlayer(player, targetName)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Summon player to GM
    targetPlayer:Teleport(
        player:GetMapId(),
        player:GetX(),
        player:GetY(),
        player:GetZ(),
        player:GetO()
    )
    
    -- Notify both players
    Utils.sendMessage(player, "success", "Summoned " .. targetName .. ".")
    targetPlayer:SendBroadcastMessage("You have been summoned by GM " .. player:GetName())
end

-- ================================================================================
-- CRUD OPERATIONS FOR TELEPORT LOCATIONS
-- ================================================================================

-- Create new teleport location at current position
function TeleportHandlers.CreateTeleportAtCurrentPosition(player, name)
    -- Validate GM permissions
    if player:GetGMRank() < 3 then -- Require higher rank for creating locations
        Utils.sendMessage(player, "error", "You need GM rank 3+ to create teleport locations.")
        return
    end
    
    -- Sanitize name
    name = name:gsub("'", "''")
    
    -- Get player's current position
    local x = player:GetX()
    local y = player:GetY()
    local z = player:GetZ()
    local o = player:GetO()
    local mapId = player:GetMapId()
    
    -- First, get the next available ID
    local maxIdQuery = "SELECT COALESCE(MAX(id), 0) + 1 as next_id FROM game_tele"
    local result = WorldDBQuery(maxIdQuery)
    local nextId = 1
    
    if result then
        nextId = result:GetUInt32(0)
    end
    
    -- Insert into database with explicit ID
    local query = string.format(
        "INSERT INTO game_tele (id, position_x, position_y, position_z, orientation, map, name) " ..
        "VALUES (%d, %.6f, %.6f, %.6f, %.6f, %d, '%s')",
        nextId, x, y, z, o, mapId, name
    )
    
    WorldDBExecute(query)
    
    -- Clear cache
    teleportCache.data = nil
    
    Utils.sendMessage(player, "success", "Created teleport location: " .. name)
end

-- Update teleport location name
function TeleportHandlers.UpdateTeleportLocation(player, locationId, newName)
    -- Validate GM permissions
    if player:GetGMRank() < 3 then
        Utils.sendMessage(player, "error", "You need GM rank 3+ to edit teleport locations.")
        return
    end
    
    -- Sanitize name
    newName = newName:gsub("'", "''")
    
    -- Update in database
    local query = string.format(
        "UPDATE game_tele SET name = '%s' WHERE id = %d",
        newName, locationId
    )
    
    WorldDBExecute(query)
    
    -- Clear cache
    teleportCache.data = nil
    
    Utils.sendMessage(player, "success", "Updated teleport location name to: " .. newName)
end

-- Delete teleport location
function TeleportHandlers.DeleteTeleportLocation(player, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 3 then
        Utils.sendMessage(player, "error", "You need GM rank 3+ to delete teleport locations.")
        return
    end
    
    -- Get location name first for confirmation message
    local nameQuery = string.format("SELECT name FROM game_tele WHERE id = %d", locationId)
    local nameResult = WorldDBQuery(nameQuery)
    local locationName = "Unknown"
    
    if nameResult then
        locationName = nameResult:GetString(0)
    end
    
    -- Delete from database
    local query = string.format("DELETE FROM game_tele WHERE id = %d", locationId)
    WorldDBExecute(query)
    
    -- Clear cache
    teleportCache.data = nil
    
    Utils.sendMessage(player, "success", "Deleted teleport location: " .. locationName)
end

-- Duplicate teleport location
function TeleportHandlers.DuplicateTeleportLocation(player, locationId, newName)
    -- Validate GM permissions
    if player:GetGMRank() < 3 then
        Utils.sendMessage(player, "error", "You need GM rank 3+ to duplicate teleport locations.")
        return
    end
    
    -- Sanitize name
    newName = newName:gsub("'", "''")
    
    -- Get original location data
    local query = string.format(
        "SELECT position_x, position_y, position_z, orientation, map " ..
        "FROM game_tele WHERE id = %d",
        locationId
    )
    
    local result = WorldDBQuery(query)
    if result then
        local x = result:GetFloat(0)
        local y = result:GetFloat(1)
        local z = result:GetFloat(2)
        local o = result:GetFloat(3)
        local mapId = result:GetUInt16(4)
        
        -- Get the next available ID
        local maxIdQuery = "SELECT COALESCE(MAX(id), 0) + 1 as next_id FROM game_tele"
        local idResult = WorldDBQuery(maxIdQuery)
        local nextId = 1
        
        if idResult then
            nextId = idResult:GetUInt32(0)
        end
        
        -- Insert duplicate with explicit ID
        local insertQuery = string.format(
            "INSERT INTO game_tele (id, position_x, position_y, position_z, orientation, map, name) " ..
            "VALUES (%d, %.6f, %.6f, %.6f, %.6f, %d, '%s')",
            nextId, x, y, z, o, mapId, newName
        )
        
        WorldDBExecute(insertQuery)
        
        -- Clear cache
        teleportCache.data = nil
        
        Utils.sendMessage(player, "success", "Duplicated teleport location as: " .. newName)
    else
        Utils.sendMessage(player, "error", "Original location not found.")
    end
end

-- Teleport party to location
function TeleportHandlers.TeleportPartyToLocation(player, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Query location details
    local query = string.format(
        "SELECT position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele WHERE id = %d",
        locationId
    )
    
    local result = WorldDBQuery(query)
    if result then
        local x = result:GetFloat(0)
        local y = result:GetFloat(1)
        local z = result:GetFloat(2)
        local o = result:GetFloat(3)
        local mapId = result:GetUInt16(4)
        local name = result:GetString(5)
        
        -- Get party/raid members
        local group = player:GetGroup()
        if group then
            local members = group:GetMembers()
            local count = 0
            
            for _, member in ipairs(members) do
                if member and member:IsInWorld() then
                    member:Teleport(mapId, x, y, z, o)
                    member:SendBroadcastMessage("You have been teleported to " .. name .. " by GM " .. player:GetName())
                    count = count + 1
                end
            end
            
            Utils.sendMessage(player, "success", string.format("Teleported %d party/raid members to %s", count, name))
        else
            -- Just teleport the player if not in a group
            player:Teleport(mapId, x, y, z, o)
            Utils.sendMessage(player, "success", "Teleported to " .. name .. " (not in a group)")
        end
    else
        Utils.sendMessage(player, "error", "Location not found.")
    end
end

-- Summon player to specific location
function TeleportHandlers.SummonPlayerToLocation(player, targetName, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Query location details
    local query = string.format(
        "SELECT position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele WHERE id = %d",
        locationId
    )
    
    local result = WorldDBQuery(query)
    if result then
        local x = result:GetFloat(0)
        local y = result:GetFloat(1)
        local z = result:GetFloat(2)
        local o = result:GetFloat(3)
        local mapId = result:GetUInt16(4)
        local name = result:GetString(5)
        
        -- Teleport target player
        targetPlayer:Teleport(mapId, x, y, z, o)
        
        -- Notify both players
        Utils.sendMessage(player, "success", string.format("Summoned %s to %s", targetName, name))
        targetPlayer:SendBroadcastMessage(string.format("You have been summoned to %s by GM %s", name, player:GetName()))
    else
        Utils.sendMessage(player, "error", "Location not found.")
    end
end

-- Test teleport location (teleport and return after delay)
function TeleportHandlers.TestTeleportLocation(player, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Store return position
    local returnX = player:GetX()
    local returnY = player:GetY()
    local returnZ = player:GetZ()
    local returnO = player:GetO()
    local returnMap = player:GetMapId()
    
    -- Query location details
    local query = string.format(
        "SELECT position_x, position_y, position_z, orientation, map, name " ..
        "FROM game_tele WHERE id = %d",
        locationId
    )
    
    local result = WorldDBQuery(query)
    if result then
        local x = result:GetFloat(0)
        local y = result:GetFloat(1)
        local z = result:GetFloat(2)
        local o = result:GetFloat(3)
        local mapId = result:GetUInt16(4)
        local name = result:GetString(5)
        
        -- Teleport to location
        player:Teleport(mapId, x, y, z, o)
        Utils.sendMessage(player, "success", "Testing location: " .. name .. " (returning in 10 seconds)")
        
        -- Schedule return teleport
        player:RegisterEvent(function(eventId, delay, repeats, player)
            player:Teleport(returnMap, returnX, returnY, returnZ, returnO)
            Utils.sendMessage(player, "success", "Returned from test location")
        end, 10000, 1)
    else
        Utils.sendMessage(player, "error", "Location not found.")
    end
end

-- Set home location (placeholder - would need custom table)
function TeleportHandlers.SetHomeLocation(player, locationId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- This would require a custom table to store per-player home locations
    -- For now, just send a message
    Utils.sendMessage(player, "info", "Home location feature not yet implemented")
end

-- Set favorite location (placeholder - would need custom table)
function TeleportHandlers.SetTeleportFavorite(player, locationId)
    -- This would require a custom table to store favorites
    Utils.sendMessage(player, "info", "Favorite locations feature not yet implemented")
end

-- Add to quick access (placeholder - would need custom table)
function TeleportHandlers.AddTeleportQuickAccess(player, locationId)
    -- This would require a custom table to store quick access items
    Utils.sendMessage(player, "info", "Quick access feature not yet implemented")
end

-- Register the new CRUD handlers
function TeleportHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    DatabaseHelper = dbHelper
    
    -- Register all teleport handlers
    GameMasterSystem.GetTeleportLocations = TeleportHandlers.GetTeleportLocations
    GameMasterSystem.SearchTeleportLocations = TeleportHandlers.SearchTeleportLocations
    GameMasterSystem.GetAllTeleportLocations = TeleportHandlers.GetAllTeleportLocations
    GameMasterSystem.TeleportToLocation = TeleportHandlers.TeleportToLocation
    GameMasterSystem.TeleportPlayerToLocation = TeleportHandlers.TeleportPlayerToLocation
    GameMasterSystem.TeleportToPreset = TeleportHandlers.TeleportToPreset
    GameMasterSystem.TeleportToPlayer = TeleportHandlers.TeleportToPlayer
    GameMasterSystem.SummonPlayer = TeleportHandlers.SummonPlayer
    
    -- Register CRUD handlers
    GameMasterSystem.CreateTeleportAtCurrentPosition = TeleportHandlers.CreateTeleportAtCurrentPosition
    GameMasterSystem.UpdateTeleportLocation = TeleportHandlers.UpdateTeleportLocation
    GameMasterSystem.DeleteTeleportLocation = TeleportHandlers.DeleteTeleportLocation
    GameMasterSystem.DuplicateTeleportLocation = TeleportHandlers.DuplicateTeleportLocation
    GameMasterSystem.TeleportPartyToLocation = TeleportHandlers.TeleportPartyToLocation
    GameMasterSystem.SummonPlayerToLocation = TeleportHandlers.SummonPlayerToLocation
    GameMasterSystem.TestTeleportLocation = TeleportHandlers.TestTeleportLocation
    GameMasterSystem.SetHomeLocation = TeleportHandlers.SetHomeLocation
    GameMasterSystem.SetTeleportFavorite = TeleportHandlers.SetTeleportFavorite
    GameMasterSystem.AddTeleportQuickAccess = TeleportHandlers.AddTeleportQuickAccess
end

-- Module exports
return TeleportHandlers