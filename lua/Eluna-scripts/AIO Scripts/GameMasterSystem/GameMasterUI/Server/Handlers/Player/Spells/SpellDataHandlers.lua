--[[
    GameMaster UI - Spell Data Handlers Sub-Module
    
    This module handles spell data queries and searches:
    - Spell data queries with pagination
    - Spell visual data queries
    - Search functionality for spells
]]--

local SpellDataHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function SpellDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register spell data handlers
    GameMasterSystem.getSpellData = SpellDataHandlers.getSpellData
    GameMasterSystem.searchSpellData = SpellDataHandlers.searchSpellData
    GameMasterSystem.getSpellVisualData = SpellDataHandlers.getSpellVisualData
    GameMasterSystem.searchSpellVisualData = SpellDataHandlers.searchSpellVisualData
    GameMasterSystem.searchSpells = SpellDataHandlers.searchSpells
end

-- Server-side handler to get the spell data for tab3
function SpellDataHandlers.getSpellData(player, offset, pageSize, sortOrder)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    local coreName = GetCoreName()
    
    -- First, get the total count
    local countQuery = Database.getQuery(coreName, "spellCount")()
    local modifiedCountQuery, error = DatabaseHelper.BuildSafeQuery(countQuery, {"spell"}, "world")
    local totalCount = 0
    if modifiedCountQuery then
        totalCount = Utils.getTotalCount(WorldDBQuery, modifiedCountQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build spell count query: %s", error or "unknown error"))
    end
    
    -- Calculate pagination info
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    -- Get the actual data even if total count is 0 (to handle edge cases)
    local query = Database.getQuery(coreName, "spellData")(sortOrder, pageSize, offset)
    local modifiedQuery, queryError = DatabaseHelper.BuildSafeQuery(query, {"spell"}, "world")
    local result = nil
    if modifiedQuery then
        result = WorldDBQuery(modifiedQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build spell data query: %s", queryError or "unknown error"))
    end
    local spellData = {}

    if result then
        repeat
            local spell = {
                spellID = result:GetUInt32(0),
                spellName = result:GetString(1),
                spellDescription = result:GetString(2),
                spellToolTip = result:GetString(3),
                visualID = result:GetUInt32(4),  -- spellVisual1
                visualID2 = result:GetUInt32(5), -- spellVisual2 as fallback
            }
            table.insert(spellData, spell)
        until not result:NextRow()
    end

    -- Send data with comprehensive pagination info
    if #spellData == 0 and totalCount == 0 then
        player:SendBroadcastMessage("No spell data available.")
    end
    
    AIO.Handle(player, "GameMasterSystem", "receiveSpellData", spellData, offset, pageSize, paginationInfo.hasNextPage, paginationInfo)
end

-- Server-side handler to search spell data
function SpellDataHandlers.searchSpellData(player, query, offset, pageSize, sortOrder)
    query = Utils.escapeString(query) -- Escape special characters
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)

    local searchQuery = Database.getQuery(GetCoreName(), "searchSpellData")(query, sortOrder, pageSize, offset)
    
    local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(searchQuery, {"spell"}, "world")
    local result = nil
    if modifiedQuery then
        result = WorldDBQuery(modifiedQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build spell search query: %s", error or "unknown error"))
    end
    
    local spellData = {}

    if result then
        repeat
            local spell = {
                spellID = result:GetUInt32(0),
                spellName = result:GetString(1),
                spellDescription = result:GetString(2),
                spellToolTip = result:GetString(3),
                visualID = result:GetUInt32(4),  -- spellVisual1
                visualID2 = result:GetUInt32(5), -- spellVisual2 as fallback
            }
            table.insert(spellData, spell)
        until not result:NextRow()
    end

    -- For search, we'll use the simple check since getting exact count for searches can be expensive
    local hasMoreData = #spellData == pageSize
    local paginationInfo = {
        totalCount = -1, -- Unknown for search
        hasNextPage = hasMoreData,
        currentOffset = offset,
        pageSize = pageSize,
        isEmpty = #spellData == 0
    }

    -- Only show "no data" message on first search (offset 0), not on pagination
    if #spellData == 0 and offset == 0 then
        player:SendBroadcastMessage("No spell data found for the search query: " .. query)
    end
    
    AIO.Handle(player, "GameMasterSystem", "receiveSpellData", spellData, offset, pageSize, hasMoreData, paginationInfo)
end

-- Function to get the spell visual data
function SpellDataHandlers.getSpellVisualData(player, offset, pageSize, sortOrder)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    local coreName = GetCoreName()
    
    -- First, get the total count
    local countQuery = Database.getQuery(coreName, "spellVisualCount")()
    local modifiedCountQuery, error = DatabaseHelper.BuildSafeQuery(countQuery, {"spellvisualeffectname"}, "world")
    local totalCount = 0
    if modifiedCountQuery then
        totalCount = Utils.getTotalCount(WorldDBQuery, modifiedCountQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build spell visual count query: %s", error or "unknown error"))
    end
    
    -- Calculate pagination info
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    -- Get the actual data even if total count is 0 (to handle edge cases)
    local query = Database.getQuery(coreName, "spellVisualData")(sortOrder, pageSize, offset)
    local modifiedQuery, queryError = DatabaseHelper.BuildSafeQuery(query, {"spellvisualeffectname"}, "world")
    local result = nil
    if modifiedQuery then
        result = WorldDBQuery(modifiedQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build spell visual data query: %s", queryError or "unknown error"))
    end
    local spellVisualData = {}

    if result then
        repeat
            local spellVisual = {
                ID = result:GetUInt32(0),
                Name = result:GetString(1),
                FilePath = result:GetString(2),
                AreaEffectSize = result:GetFloat(3),
                Scale = result:GetFloat(4),
                MinAllowedScale = result:GetFloat(5),
                MaxAllowedScale = result:GetFloat(6),
            }

            table.insert(spellVisualData, spellVisual)
        until not result:NextRow()
    end

    -- Send data with comprehensive pagination info
    if #spellVisualData == 0 and totalCount == 0 then
        player:SendBroadcastMessage("No spell visual data available.")
    end
    
    AIO.Handle(player, "GameMasterSystem", "receiveSpellVisualData", 
        spellVisualData, offset, pageSize, paginationInfo.hasNextPage, 
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
end

-- Function to search spell visual data
function SpellDataHandlers.searchSpellVisualData(player, query, offset, pageSize, sortOrder)
    query = Utils.escapeString(query) -- Escape special characters
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    local coreName = GetCoreName()

    local searchQuery = Database.getQuery(coreName, "searchSpellVisualData")(query, sortOrder, pageSize, offset)
    
    local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(searchQuery, {"spellvisualeffectname"}, "world")
    local result = nil
    if modifiedQuery then
        result = WorldDBQuery(modifiedQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build spell visual search query: %s", error or "unknown error"))
    end
    local spellVisualData = {}

    if result then
        repeat
            local spellVisual = {
                ID = result:GetUInt32(0),
                Name = result:GetString(1),
                FilePath = result:GetString(2),
                AreaEffectSize = result:GetFloat(3),
                Scale = result:GetFloat(4),
                MinAllowedScale = result:GetFloat(5),
                MaxAllowedScale = result:GetFloat(6),
            }
            table.insert(spellVisualData, spellVisual)
        until not result:NextRow()
    end

    -- For search, we'll use the simple check since getting exact count for searches can be expensive
    local hasMoreData = #spellVisualData == pageSize
    local paginationInfo = {
        totalCount = -1, -- Unknown for search
        hasNextPage = hasMoreData,
        currentOffset = offset,
        pageSize = pageSize,
        isEmpty = #spellVisualData == 0
    }

    -- Only show "no data" message on first search (offset 0), not on pagination
    if #spellVisualData == 0 and offset == 0 then
        player:SendBroadcastMessage("No spell visual data found for the search query: " .. query)
    end
    
    AIO.Handle(player, "GameMasterSystem", "receiveSpellVisualData", 
        spellVisualData, offset, pageSize, hasMoreData, 
        paginationInfo.totalCount or -1, paginationInfo.totalPages or 1, paginationInfo.currentPage or 1)
end

-- Handler for searching spells from database
function SpellDataHandlers.searchSpells(player, searchText, offset, pageSize)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or 50)
    
    -- First get total count
    local countQuery
    if searchText and searchText ~= "" then
        searchText = Utils.escapeString(searchText)
        countQuery = string.format([[
            SELECT COUNT(*) 
            FROM spell 
            WHERE spellName0 LIKE '%%%s%%' OR id = '%s'
        ]], searchText, searchText)
    else
        countQuery = [[
            SELECT COUNT(*) 
            FROM spell 
            WHERE spellName0 != ''
        ]]
    end
    
    local countResult = WorldDBQuery(countQuery)
    local totalCount = 0
    if countResult then
        totalCount = countResult:GetUInt32(0)
    end
    
    -- Now get the actual spells
    local query
    if searchText and searchText ~= "" then
        -- Search by name or ID
        query = string.format([[
            SELECT id, spellName0 
            FROM spell 
            WHERE spellName0 LIKE '%%%s%%' OR id = '%s'
            ORDER BY id ASC 
            LIMIT %d OFFSET %d
        ]], searchText, searchText, pageSize, offset)
    else
        -- Get all spells
        query = string.format([[
            SELECT id, spellName0 
            FROM spell 
            WHERE spellName0 != '' 
            ORDER BY id ASC 
            LIMIT %d OFFSET %d
        ]], pageSize, offset)
    end
    
    local result = WorldDBQuery(query)
    local spells = {}
    
    if result then
        repeat
            local spellId = result:GetUInt32(0)
            local spellName = result:GetString(1)
            
            -- Don't get icon on server side - client will get it
            table.insert(spells, {
                spellId = spellId,
                name = spellName,
                -- icon will be fetched on client side using GetSpellTexture
            })
        until not result:NextRow()
    end
    
    -- Calculate if there are more results
    local hasMoreData = (offset + #spells) < totalCount
    
    -- Send data to client with pagination info
    AIO.Handle(player, "GameMasterSystem", "receiveSpellSearchResults", spells, offset, pageSize, hasMoreData, totalCount)
end

return SpellDataHandlers