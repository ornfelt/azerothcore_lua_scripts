--[[
    GameMaster UI - Item Data Handlers Module
    
    This module handles item data queries and search operations:
    - Item data fetching
    - Item search functionality
    - Item icon and type utilities
]]--

local ItemDataHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function ItemDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register data-related handlers
    GameMasterSystem.getItemData = ItemDataHandlers.getItemData
    GameMasterSystem.handleItemCategory = ItemDataHandlers.getItemData -- Alias for backward compatibility
    GameMasterSystem.searchItemData = ItemDataHandlers.searchItemData
    GameMasterSystem.requestItemPacketsForList = ItemDataHandlers.requestItemPacketsForList
    GameMasterSystem.getItemIcon = ItemDataHandlers.getItemIcon
    GameMasterSystem.getItemTypeName = ItemDataHandlers.getItemTypeName
end

-- Function to display debug messages
local function debugMessage(...)
    if Config.debug then
        print("DEBUG:", ...)
    end
end

-- Server-side handler for item data requests
function ItemDataHandlers.getItemData(player, offset, pageSize, sortOrder, inventoryType)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")
    local coreName = GetCoreName()

    -- First, get the total count asynchronously
    local countQuery = Database.getQuery(coreName, "itemCount")(inventoryType)
    DatabaseHelper.BuildSafeQueryAsync(countQuery, {"item_template"}, function(countResult, countError)
        local totalCount = 0
        if countResult then
            totalCount = Utils.getTotalCount(function() return countResult end, "")
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to get item count: %s", countError or "unknown error"))
        end

        -- Calculate pagination info
        local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)

        -- Get the actual data asynchronously
        local query = Database.getQuery(coreName, "itemData")(sortOrder, pageSize, offset, inventoryType)
        DatabaseHelper.BuildSafeQueryAsync(query, {"item_template"}, function(result, queryError)
            local itemData = {}

            if result then
                repeat
                    local item = {
                        entry = result:GetUInt32(0),
                        name = result:GetString(1),
                        description = result:GetString(2),
                        displayid = result:GetUInt32(3),
                        inventoryType = result:GetUInt32(4),
                        quality = result:GetUInt32(5),
                        itemLevel = result:GetUInt32(6),
                        class = result:GetUInt32(7),
                        subclass = result:GetUInt32(8),
                    }
                    table.insert(itemData, item)
                until not result:NextRow()
            elseif Config.debug then
                print(string.format("[GameMasterUI] Failed to get item data: %s", queryError or "unknown error"))
            end

            -- Send data with comprehensive pagination info
            if #itemData == 0 and totalCount == 0 then
                Utils.sendMessage(player, "info", "No item data available.")
            end

            -- DISABLED: Send item packets before sending data to client
            -- This functionality has been disabled to prevent packet sending
            -- To re-enable, set ENABLE_ITEM_PACKETS = true in GameMasterUI_Init.lua
            --[[
            debugMessage(string.format("Sending packets for %d items before sending data", #itemData))
            if _G.GameMasterUI_SendItemQueryForList and _G.GameMasterUI_ExtractItemEntries then
                local itemEntries = _G.GameMasterUI_ExtractItemEntries(itemData)
                _G.GameMasterUI_SendItemQueryForList(player, itemEntries)
            else
                if Config.debug then
                    print("[ItemDataHandlers] ERROR: Global packet functions not found!")
                end
            end
            --]]

            -- debugMessage("Sending item data to player")  -- Debug disabled
            AIO.Handle(
                player,
                "GameMasterSystem",
                "receiveItemData",
                itemData,
                offset,
                pageSize,
                paginationInfo.hasNextPage,
                inventoryType,
                paginationInfo
            )
        end, "world")
    end, "world")
end

-- Function to search item data
function ItemDataHandlers.searchItemData(player, query, offset, pageSize, sortOrder, inventoryType)
    if not query or query == "" then
        return ItemDataHandlers.getItemData(player, offset, pageSize, sortOrder, inventoryType)
    end

    -- Ensure parameters are valid
    query = Utils.escapeString(query)
    offset = tonumber(offset) or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "DESC")

    local coreName = GetCoreName()
    local searchQuery = Database.getQuery(coreName, "searchItemData")(query, sortOrder, pageSize, offset, inventoryType)

    DatabaseHelper.BuildSafeQueryAsync(searchQuery, {"item_template"}, function(result, error)
        local itemData = {}

        if result then
            repeat
                local item = {
                    entry = result:GetUInt32(0),
                    name = result:GetString(1),
                    description = result:GetString(2),
                    displayid = result:GetUInt32(3),
                    quality = result:GetUInt32(4),
                    inventoryType = result:GetUInt32(5),
                    itemLevel = result:GetUInt32(6),
                    class = result:GetUInt32(7),
                    subclass = result:GetUInt32(8),
                }
                table.insert(itemData, item)
            until not result:NextRow()
        elseif Config.debug then
            print(string.format("[GameMasterUI] Failed to search item data: %s", error or "unknown error"))
        end

        -- For search, we'll use the simple check since getting exact count for searches can be expensive
        local hasMoreData = #itemData == pageSize
        local paginationInfo = {
            totalCount = -1, -- Unknown for search
            hasNextPage = hasMoreData,
            currentOffset = offset,
            pageSize = pageSize,
            isEmpty = #itemData == 0
        }

        -- Only show "no data" message on first search (offset 0), not on pagination
        if #itemData == 0 and offset == 0 then
            Utils.sendMessage(player, "info", "No item data found for the search query: " .. query)
        end

        -- DISABLED: Send item packets before sending data to client
        -- This functionality has been disabled to prevent packet sending
        -- To re-enable, set ENABLE_ITEM_PACKETS = true in GameMasterUI_Init.lua
        --[[
        debugMessage(string.format("Sending packets for %d search result items", #itemData))
        if _G.GameMasterUI_SendItemQueryForList and _G.GameMasterUI_ExtractItemEntries then
            local itemEntries = _G.GameMasterUI_ExtractItemEntries(itemData)
            _G.GameMasterUI_SendItemQueryForList(player, itemEntries)
        else
            if Config.debug then
                print("[ItemDataHandlers] ERROR: Global packet functions not found for search!")
            end
        end
        --]]

        -- Send pagination as individual parameters to avoid AIO serialization issues
        local totalCount = paginationInfo and paginationInfo.totalCount or 0
        local totalPages = paginationInfo and paginationInfo.totalPages or 1
        local currentPage = paginationInfo and paginationInfo.currentPage or 1
        AIO.Handle(player, "GameMasterSystem", "receiveItemData",
            itemData, offset, pageSize, hasMoreData, inventoryType,
            totalCount, totalPages, currentPage)
    end, "world")
end

-- Helper function to get item icon from displayid
function ItemDataHandlers.getItemIcon(displayId)
    -- This would normally query ItemDisplayInfo.dbc but we'll use common patterns
    -- In a real implementation, you'd want to query the proper table
    return "Interface\\Icons\\INV_Misc_QuestionMark"  -- Default icon
end

-- Helper function to get item type name
function ItemDataHandlers.getItemTypeName(class, subclass)
    local classNames = {
        [0] = "Consumable",
        [1] = "Container", 
        [2] = "Weapon",
        [3] = "Gem",
        [4] = "Armor",
        [5] = "Reagent",
        [7] = "Trade Goods",
        [12] = "Quest",
        [15] = "Miscellaneous",
        [16] = "Glyph"
    }
    return classNames[class] or "Unknown"
end

-- Handler for client requesting item packets for a list of items
function ItemDataHandlers.requestItemPacketsForList(player, itemList)
    -- Validate input
    if not player or not itemList or type(itemList) ~= "table" then
        return
    end
    
    -- debugMessage(string.format("Client requested packets for %d items", #itemList))  -- Debug disabled
    
    -- DISABLED: Send item packets using the global functions
    -- This functionality has been disabled to prevent packet sending
    -- To re-enable, set ENABLE_ITEM_PACKETS = true in GameMasterUI_Init.lua
    --[[
    if _G.GameMasterUI_SendItemQueryForList and _G.GameMasterUI_ExtractItemEntries then
        local itemEntries = _G.GameMasterUI_ExtractItemEntries(itemList)
        _G.GameMasterUI_SendItemQueryForList(player, itemEntries)
        -- debugMessage(string.format("Sent packets for %d item entries", #itemEntries))  -- Debug disabled
    else
        if Config.debug then
            print("[ItemDataHandlers] ERROR: Global packet functions not available for client request!")
        end
    end
    --]]
end

return ItemDataHandlers