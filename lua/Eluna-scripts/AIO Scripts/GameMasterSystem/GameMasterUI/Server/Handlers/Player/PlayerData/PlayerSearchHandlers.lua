--[[
    GameMaster UI - Player Search Handlers Sub-Module
    
    This sub-module handles player search and refresh operations:
    - Search players by name
    - Refresh player data
    - Search helper functions
]]--

local PlayerSearchHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

-- Reference to query handlers for refresh operation
local PlayerDataQueryHandlers

function PlayerSearchHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register search handlers
    GameMasterSystem.searchPlayerData = PlayerSearchHandlers.searchPlayerData
    GameMasterSystem.refreshPlayerData = PlayerSearchHandlers.refreshPlayerData
end

-- Set reference to PlayerDataQueryHandlers for refresh operation
function PlayerSearchHandlers.SetQueryHandlers(queryHandlers)
    PlayerDataQueryHandlers = queryHandlers
end

-- Helper function to check ban status
local function checkBanStatus(accountId, charGuid)
    local isBanned = false
    local banType = nil
    
    -- Check account ban
    local accountBan = AuthDBQuery(string.format(
        "SELECT 1 FROM account_banned WHERE id = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        accountId
    ))
    if accountBan then
        isBanned = true
        banType = "Account"
    else
        -- Check character ban
        local charBan = CharDBQuery(string.format(
            "SELECT 1 FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
            charGuid
        ))
        if not charBan then
            charBan = AuthDBQuery(string.format(
                "SELECT 1 FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
                charGuid
            ))
        end
        if charBan then
            isBanned = true
            banType = "Character"
        end
    end
    
    return isBanned, banType
end

-- Helper function to get zone name
local function getZoneName(areaId)
    local zoneName = "Unknown"
    
    if areaId and areaId > 0 then
        -- Try to get area name using global function
        local success, areaName = pcall(function()
            return GetAreaName(areaId)
        end)
        if success and areaName then
            zoneName = areaName
        else
            -- Fallback: Query database if GetAreaName fails
            local zoneQuery = WorldDBQuery(string.format(
                "SELECT name FROM area_template WHERE entry = %d",
                areaId
            ))
            if zoneQuery then
                zoneName = zoneQuery:GetString(0) or "Unknown"
            end
        end
    end
    
    return zoneName
end

-- Search players by name
function PlayerSearchHandlers.searchPlayerData(player, query, offset, pageSize, sortOrder)
    if not query or query == "" then
        -- If no query, fall back to getting all player data
        if PlayerDataQueryHandlers then
            return PlayerDataQueryHandlers.getPlayerData(player, offset, pageSize, sortOrder)
        else
            print("[PlayerSearchHandlers] Warning: PlayerDataQueryHandlers not set, cannot fall back to getPlayerData")
            return
        end
    end
    
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "ASC")
    
    local playerData = {}
    local onlinePlayers = GetPlayersInWorld()
    local matchingPlayers = {}
    
    -- Filter players by search query
    query = query:lower()
    for _, targetPlayer in ipairs(onlinePlayers) do
        if targetPlayer:GetName():lower():find(query, 1, true) then
            table.insert(matchingPlayers, targetPlayer)
        end
    end
    
    local totalCount = #matchingPlayers
    
    -- For search, we use limited pagination info since we're working with in-memory data
    local paginationInfo = {
        totalCount = totalCount,
        hasNextPage = (offset + pageSize) < totalCount,
        currentOffset = offset,
        pageSize = pageSize,
        isEmpty = totalCount == 0
    }
    
    -- If no matching players, send empty response
    if paginationInfo.isEmpty then
        AIO.Handle(player, "GameMasterSystem", "receivePlayerData", 
            {}, offset, pageSize, false, 
            paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
        return
    end
    
    -- Sort matching players
    table.sort(matchingPlayers, function(a, b)
        if sortOrder == "ASC" then
            return a:GetName() < b:GetName()
        else
            return a:GetName() > b:GetName()
        end
    end)
    
    -- Apply pagination to matching players
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, #matchingPlayers)
    
    for i = startIdx, endIdx do
        local targetPlayer = matchingPlayers[i]
        if targetPlayer then
            local class = targetPlayer:GetClass()
            local race = targetPlayer:GetRace()
            local guild = targetPlayer:GetGuild()
            local totalMoney = targetPlayer:GetCoinage()
            local gold = math.floor(totalMoney / 10000)
            
            -- Check ban status
            local accountId = targetPlayer:GetAccountId()
            local isBanned, banType = checkBanStatus(accountId, targetPlayer:GetGUIDLow())
            
            -- Get zone name
            local areaId = targetPlayer:GetAreaId()
            local zoneName = getZoneName(areaId)
            
            local playerInfo = {
                name = targetPlayer:GetName(),
                level = targetPlayer:GetLevel(),
                class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                race = Utils.raceInfo[race] or "Unknown",
                zone = zoneName,
                gold = gold,
                guildName = guild and guild:GetName() or nil,
                online = true,
                displayId = targetPlayer:GetDisplayId(),
                isBanned = isBanned,
                banType = banType
            }
            
            table.insert(playerData, playerInfo)
        end
    end
    
    AIO.Handle(player, "GameMasterSystem", "receivePlayerData", 
        playerData, offset, pageSize, paginationInfo.hasNextPage, 
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
end

-- Refresh player data (forces a fresh fetch)
function PlayerSearchHandlers.refreshPlayerData(player)
    -- Force a complete refresh by clearing any cached data first
    -- Note: Since we're fetching live data from GetPlayersInWorld(), 
    -- this will always get the current online players
    
    -- Simply call getPlayerData with default parameters
    if PlayerDataQueryHandlers then
        PlayerDataQueryHandlers.getPlayerData(player, 0, Config.defaultPageSize, "ASC")
    else
        print("[PlayerSearchHandlers] Warning: PlayerDataQueryHandlers not set, cannot refresh player data")
    end
end

return PlayerSearchHandlers