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
    
    -- First, get the total count
    local countQuery = Database.getQuery(coreName, "itemCount")(inventoryType)
    local modifiedCountQuery, error = DatabaseHelper.BuildSafeQuery(countQuery, {"item_template"}, "world")
    local totalCount = 0
    if modifiedCountQuery then
        totalCount = Utils.getTotalCount(WorldDBQuery, modifiedCountQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build item count query: %s", error or "unknown error"))
    end
    
    -- Calculate pagination info
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    -- Get the actual data even if total count is 0 (to handle edge cases)
    local query = Database.getQuery(coreName, "itemData")(sortOrder, pageSize, offset, inventoryType)
    local modifiedQuery, queryError = DatabaseHelper.BuildSafeQuery(query, {"item_template"}, "world")
    local result = nil
    if modifiedQuery then
        result = WorldDBQuery(modifiedQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build item data query: %s", queryError or "unknown error"))
    end
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
    end

    -- Send data with comprehensive pagination info
    if #itemData == 0 and totalCount == 0 then
        player:SendBroadcastMessage("No item data available.")
    end
    
    debugMessage("Sending item data to player")
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
    
    local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(searchQuery, {"item_template"}, "world")
    local result = nil
    if modifiedQuery then
        if Config.debug then
            print("Item search query:", modifiedQuery)
        end
        result = WorldDBQuery(modifiedQuery)
    elseif Config.debug then
        print(string.format("[GameMasterUI] Failed to build item search query: %s", error or "unknown error"))
    end
    
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
        player:SendBroadcastMessage("No item data found for the search query: " .. query)
    end
    
    -- Send pagination as individual parameters to avoid AIO serialization issues
    local totalCount = paginationInfo and paginationInfo.totalCount or 0
    local totalPages = paginationInfo and paginationInfo.totalPages or 1
    local currentPage = paginationInfo and paginationInfo.currentPage or 1
    AIO.Handle(player, "GameMasterSystem", "receiveItemData", 
        itemData, offset, pageSize, hasMoreData, inventoryType,
        totalCount, totalPages, currentPage)
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

return ItemDataHandlers