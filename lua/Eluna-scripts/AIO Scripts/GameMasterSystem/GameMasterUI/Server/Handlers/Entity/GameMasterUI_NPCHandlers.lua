--[[
    GameMaster UI - NPC Handlers Module
    
    This module handles all NPC-related functionality:
    - NPC data queries
    - NPC search
    - GameObject data queries
    - GameObject search
]]--

local NPCHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function NPCHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register all NPC-related handlers
    GameMasterSystem.getNPCData = NPCHandlers.getNPCData
    GameMasterSystem.searchNPCData = NPCHandlers.searchNPCData
    GameMasterSystem.getGameObjectData = NPCHandlers.getGameObjectData
    GameMasterSystem.searchGameObjectData = NPCHandlers.searchGameObjectData
end

-- Function to query NPC data from the database with pagination
function NPCHandlers.getNPCData(player, offset, pageSize, sortOrder)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    local coreName = GetCoreName()
    
    -- First, get the total count
    local countQueryFunc = Database.getQuery(coreName, "npcCount")
    local totalCount = 0
    
    if countQueryFunc then
        local countQuery = countQueryFunc()
        local modifiedCountQuery, error = DatabaseHelper.BuildSafeQuery(countQuery, {"creature_template"}, "world")
        if modifiedCountQuery then
            local countResult, countError = DatabaseHelper.SafeQuery(modifiedCountQuery, "world")
            if countResult then
                totalCount = countResult:GetUInt32(0) or 0
            elseif Config.debug then
                print(string.format("[GameMasterUI] Failed to get NPC count: %s", countError or "unknown error"))
            end
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to build NPC count query: %s", error or "unknown error"))
        end
    end
    
    -- Calculate pagination info
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    -- Get the actual data even if total count is 0 (to handle edge cases)
    local queryFunc = Database.getQuery(coreName, "npcData")
    local result, queryError
    local npcData = {}
    
    if queryFunc then
        local query = queryFunc(sortOrder, pageSize, offset)
        local tables = coreName == "AzerothCore" and {"creature_template", "creature_template_model"} or {"creature_template"}
        local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(query, tables, "world")
        if modifiedQuery then
            result, queryError = DatabaseHelper.SafeQuery(modifiedQuery, "world")
            if not result and Config.debug then
                print(string.format("[GameMasterUI] Failed to get NPC data: %s", queryError or "unknown error"))
            end
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to build NPC data query: %s", error or "unknown error"))
        end
    end

    if result then
        repeat
            local npc = {
                entry = result:GetUInt32(0),
                modelid = {},
                name = result:GetString(coreName == "TrinityCore" and 5 or 2),
                subname = result:GetString(coreName == "TrinityCore" and 6 or 3),
                type = result:GetUInt32(coreName == "TrinityCore" and 7 or 4),
            }

            if coreName == "TrinityCore" then
                for i = 1, 4 do
                    local modelId = result:GetUInt32(i)
                    if modelId ~= 0 then
                        table.insert(npc.modelid, modelId)
                    end
                end
            elseif coreName == "AzerothCore" then
                local modelId = result:GetUInt32(1)
                if modelId ~= 0 then
                    table.insert(npc.modelid, modelId)
                end
            end

            table.insert(npcData, npc)
        until not result:NextRow()
    end

    -- Send data with comprehensive pagination info
    if #npcData == 0 and totalCount == 0 then
        player:SendBroadcastMessage("No NPC data available.")
    end
    
    -- Send pagination as separate parameters to avoid serialization issues
    AIO.Handle(player, "GameMasterSystem", "receiveNPCData", 
        npcData, offset, pageSize, paginationInfo.hasNextPage,
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
end

-- Server-side handler to search NPC data
function NPCHandlers.searchNPCData(player, query, offset, pageSize, sortOrder)
    query = Utils.escapeString(query) -- Escape special characters
    local typeId = nil
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    local coreName = GetCoreName()

    local typeQuery = query:match("^%((.-)%)$")
    if typeQuery then
        typeId = Config.npcTypes[typeQuery]
        if not typeId then
            player:SendBroadcastMessage("Invalid NPC type: " .. typeQuery)
            return
        end
    end

    local searchQueryFunc = Database.getQuery(coreName, "searchNpcData")
    local result, queryError
    local npcData = {}
    
    if searchQueryFunc then
        local searchQuery = searchQueryFunc(query, typeId, sortOrder, pageSize, offset)
        local tables = coreName == "AzerothCore" and {"creature_template", "creature_template_model"} or {"creature_template"}
        local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(searchQuery, tables, "world")
        if modifiedQuery then
            result, queryError = DatabaseHelper.SafeQuery(modifiedQuery, "world")
            if not result and Config.debug then
                print(string.format("[GameMasterUI] Failed to search NPC data: %s", queryError or "unknown error"))
            end
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to build NPC search query: %s", error or "unknown error"))
        end
    end

    if result then
        repeat
            local npc = {
                entry = result:GetUInt32(0),
                modelid = {},
                name = result:GetString(coreName == "TrinityCore" and 5 or 2),
                subname = result:GetString(coreName == "TrinityCore" and 6 or 3),
                type = result:GetUInt32(coreName == "TrinityCore" and 7 or 4),
            }

            if coreName == "TrinityCore" then
                for i = 1, 4 do
                    local modelId = result:GetUInt32(i)
                    if modelId ~= 0 then
                        table.insert(npc.modelid, modelId)
                    end
                end
            elseif coreName == "AzerothCore" then
                local modelId = result:GetUInt32(1)
                if modelId ~= 0 then
                    table.insert(npc.modelid, modelId)
                end
            end

            table.insert(npcData, npc)
        until not result:NextRow()
    end

    -- For search, we'll use the simple check since getting exact count for searches can be expensive
    local hasMoreData = #npcData == pageSize
    local paginationInfo = {
        totalCount = -1, -- Unknown for search
        hasNextPage = hasMoreData,
        currentOffset = offset,
        pageSize = pageSize,
        isEmpty = #npcData == 0
    }
    
    -- Only show "no data" message on first search (offset 0), not on pagination
    if #npcData == 0 and offset == 0 then
        player:SendBroadcastMessage("No NPC data found for the search query: " .. query)
    end
    
    AIO.Handle(player, "GameMasterSystem", "receiveNPCData", npcData, offset, pageSize, hasMoreData, paginationInfo)
end

-- Function to query GameObject data from the database with pagination
function NPCHandlers.getGameObjectData(player, offset, pageSize, sortOrder)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    local coreName = GetCoreName()
    
    -- First, get the total count
    local countQueryFunc = Database.getQuery(coreName, "gobCount")
    local totalCount = 0
    
    if countQueryFunc then
        local countQuery = countQueryFunc()
        local modifiedCountQuery, error = DatabaseHelper.BuildSafeQuery(countQuery, {"gameobject_template"}, "world")
        if modifiedCountQuery then
            local countResult, countError = DatabaseHelper.SafeQuery(modifiedCountQuery, "world")
            if countResult then
                totalCount = countResult:GetUInt32(0) or 0
            elseif Config.debug then
                print(string.format("[GameMasterUI] Failed to get GameObject count: %s", countError or "unknown error"))
            end
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to build GameObject count query: %s", error or "unknown error"))
        end
    end
    
    -- Calculate pagination info
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    -- Get the actual data even if total count is 0 (to handle edge cases)
    local queryFunc = Database.getQuery(coreName, "gobData")
    local result, queryError
    local gobData = {}
    
    if queryFunc then
        local query = queryFunc(sortOrder, pageSize, offset)
        local tables = {"gameobject_template", "gameobjectdisplayinfo"}
        local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(query, tables, "world")
        if modifiedQuery then
            result, queryError = DatabaseHelper.SafeQuery(modifiedQuery, "world")
            if not result and Config.debug then
                print(string.format("[GameMasterUI] Failed to get GameObject data: %s", queryError or "unknown error"))
            end
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to build GameObject data query: %s", error or "unknown error"))
        end
    end

    if result then
        repeat
            local gob = {
                entry = result:GetUInt32(0),
                displayid = result:GetUInt32(1),
                name = result:GetString(2),
                modelName = result:GetString(3),
            }
            table.insert(gobData, gob)
        until not result:NextRow()
    end

    -- Send data with comprehensive pagination info
    if #gobData == 0 and totalCount == 0 then
        player:SendBroadcastMessage("No gameobject data available.")
    end
    
    -- Send pagination as individual parameters to avoid AIO serialization issues
    AIO.Handle(player, "GameMasterSystem", "receiveGameObjectData", 
        gobData, offset, pageSize, paginationInfo.hasNextPage,
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
end

-- Server-side handler to search GameObject data
function NPCHandlers.searchGameObjectData(player, query, offset, pageSize, sortOrder)
    query = Utils.escapeString(query) -- Escape special characters
    local typeId = nil
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)

    -- Check if the query is enclosed in parentheses
    local typeQuery = query:match("^%((.-)%)$")
    if typeQuery then
        typeQuery = typeQuery:lower() -- Convert the type query to lowercase
        typeId = Config.gameObjectTypes[typeQuery] -- Get the type ID from the extracted type name
        if not typeId then
            player:SendBroadcastMessage("Invalid GameObject type: " .. typeQuery)
            return
        end
    end

    local searchQueryFunc = Database.getQuery(GetCoreName(), "searchGobData")
    local result, queryError
    local gobData = {}
    
    if searchQueryFunc then
        local searchQuery = searchQueryFunc(query, typeId, sortOrder, pageSize, offset)
        local tables = {"gameobject_template", "gameobjectdisplayinfo"}
        local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(searchQuery, tables, "world")
        if modifiedQuery then
            result, queryError = DatabaseHelper.SafeQuery(modifiedQuery, "world")
            if not result and Config.debug then
                print(string.format("[GameMasterUI] Failed to search GameObject data: %s", queryError or "unknown error"))
            end
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to build GameObject search query: %s", error or "unknown error"))
        end
    end

    if result then
        repeat
            local gob = {
                entry = result:GetUInt32(0),
                displayid = result:GetUInt32(1),
                name = result:GetString(2),
                type = result:GetUInt32(3),
                modelName = result:GetString(4),
            }
            table.insert(gobData, gob)
        until not result:NextRow()
    end

    -- For search, we'll use the simple check since getting exact count for searches can be expensive
    local hasMoreData = #gobData == pageSize
    local paginationInfo = {
        totalCount = -1, -- Unknown for search
        hasNextPage = hasMoreData,
        currentOffset = offset,
        pageSize = pageSize,
        isEmpty = #gobData == 0
    }

    -- Only show "no data" message on first search (offset 0), not on pagination
    if #gobData == 0 and offset == 0 then
        player:SendBroadcastMessage("No gameobject data found for the search query: " .. query)
    end
    
    -- Send pagination as individual parameters to avoid AIO serialization issues
    local totalCount = paginationInfo and paginationInfo.totalCount or 0
    local totalPages = paginationInfo and paginationInfo.totalPages or 1
    local currentPage = paginationInfo and paginationInfo.currentPage or 1
    AIO.Handle(player, "GameMasterSystem", "receiveGameObjectData", 
        gobData, offset, pageSize, hasMoreData,
        totalCount, totalPages, currentPage)
end

return NPCHandlers