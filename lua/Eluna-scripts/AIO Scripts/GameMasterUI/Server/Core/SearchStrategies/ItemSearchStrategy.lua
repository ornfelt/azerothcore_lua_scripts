--[[
    GameMasterUI - Item Search Strategy

    Configuration for item search using the unified SearchManager

    Features:
    - Search by item name or ID
    - Advanced filtering (category, quality, level, item level, stackable)
    - Sorting (name, ItemLevel, RequiredLevel, Quality)
    - Result caching (10 minutes)
    - Equipment slot filtering
]]--

local ItemSearchStrategy = {}

-- Module dependencies
local Utils

function ItemSearchStrategy.Initialize(utils)
    Utils = utils
end

-- Category to class ID mapping
local ITEM_CATEGORIES = {
    all = nil,
    armor = 4,
    weapon = 2,
    consumable = 0,
    trade = 7,
    reagent = 5,
    container = 1,
    gem = 3,
    glyph = 16,
    quest = 12,
    misc = 15
}

-- Slot ID to InventoryType mapping
local SLOT_TO_INVENTORY_TYPE = {
    [0] = 1,   -- Head
    [1] = 2,   -- Neck
    [2] = 3,   -- Shoulder
    [3] = 4,   -- Shirt
    [4] = 5,   -- Chest
    [5] = 6,   -- Waist
    [6] = 7,   -- Legs
    [7] = 8,   -- Feet
    [8] = 9,   -- Wrists
    [9] = 10,  -- Hands
    [10] = 11, -- Finger
    [11] = 11, -- Finger
    [12] = 12, -- Trinket
    [13] = 12, -- Trinket
    [14] = 16, -- Back
    [15] = 13, -- One-Hand
    [16] = 14, -- Shield/Off-hand
    [17] = 15, -- Ranged
    [18] = 19  -- Tabard
}

--[[
    Create and return the item search configuration
]]--
function ItemSearchStrategy.GetConfig()
    return {
        -- Unique identifier
        searchType = "items",

        -- Permissions
        requiredGMRank = 2,

        -- Caching configuration
        cache = {
            enabled = true,
            ttl = 600,  -- 10 minutes (items rarely change)
            keyGenerator = function(params)
                local parts = {
                    params.query or "",
                    params.category or "all",
                    params.quality or -1,
                    params.slotId or -1,
                    params.minLevel or 0,
                    params.maxLevel or 85,
                    params.minItemLevel or 0,
                    params.maxItemLevel or 999,
                    params.stackableOnly and "stack" or "",
                    params.sortBy or "ItemLevel",
                    params.sortOrder or "DESC"
                }
                return table.concat(parts, ":")
            end
        },

        -- Pagination configuration
        pagination = {
            defaultPageSize = 50,
            minPageSize = 10,
            maxPageSize = 100  -- Limit for items to prevent large result sets
        },

        -- No count query for items (estimate based on result count)
        buildCountQuery = nil,

        -- Build main query with filters
        buildQuery = function(params)
            local whereConditions = {}
            local query = params.query or ""
            local category = params.category or "all"
            local quality = tonumber(params.quality) or -1
            local slotId = tonumber(params.slotId)
            local minLevel = tonumber(params.minLevel) or 0
            local maxLevel = tonumber(params.maxLevel) or 85
            local minItemLevel = tonumber(params.minItemLevel) or 0
            local maxItemLevel = tonumber(params.maxItemLevel) or 999
            local stackableOnly = params.stackableOnly or false
            local sortBy = params.sortBy or "ItemLevel"
            local sortOrder = params.sortOrder or "DESC"
            local offset = params.offset or 0
            local pageSize = params.pageSize or 50

            -- Search text (name or entry)
            if query ~= "" then
                table.insert(whereConditions,
                    string.format("(name LIKE '%%%s%%' OR entry = '%s')", query, query))
            end

            -- Category filter (item class)
            if category ~= "all" and ITEM_CATEGORIES[category] then
                table.insert(whereConditions,
                    string.format("class = %d", ITEM_CATEGORIES[category]))
            end

            -- Quality filter
            if quality >= 0 and quality <= 6 then
                table.insert(whereConditions, string.format("Quality = %d", quality))
            end

            -- Level range filter
            if minLevel > 0 then
                table.insert(whereConditions, string.format("RequiredLevel >= %d", minLevel))
            end
            if maxLevel < 85 then
                table.insert(whereConditions, string.format("RequiredLevel <= %d", maxLevel))
            end

            -- Item level range filter
            if minItemLevel > 0 then
                table.insert(whereConditions, string.format("ItemLevel >= %d", minItemLevel))
            end
            if maxItemLevel < 999 then
                table.insert(whereConditions, string.format("ItemLevel <= %d", maxItemLevel))
            end

            -- Stackable filter
            if stackableOnly then
                table.insert(whereConditions, "stackable > 1")
            end

            -- Slot filter for equipment
            if slotId and SLOT_TO_INVENTORY_TYPE[slotId] then
                if slotId == 15 or slotId == 16 then
                    -- Weapons - flexible matching
                    table.insert(whereConditions,
                        "(InventoryType IN (13, 14, 15, 17, 21, 22, 23))")
                else
                    table.insert(whereConditions,
                        string.format("InventoryType = %d", SLOT_TO_INVENTORY_TYPE[slotId]))
                end
            end

            -- Build WHERE clause
            local whereClause = ""
            if #whereConditions > 0 then
                whereClause = "WHERE " .. table.concat(whereConditions, " AND ")
            end

            -- Validate and sanitize sort parameters
            local validSortColumns = {
                name = "name",
                ItemLevel = "ItemLevel",
                RequiredLevel = "RequiredLevel",
                Quality = "Quality"
            }
            local sortColumn = validSortColumns[sortBy] or "ItemLevel"
            local validSortOrder = (sortOrder == "ASC") and "ASC" or "DESC"

            -- Build final query
            return string.format([[
                SELECT entry, name, displayid, Quality, ItemLevel,
                       class, subclass, InventoryType, stackable, maxcount, RequiredLevel
                FROM item_template
                %s
                ORDER BY %s %s, name ASC
                LIMIT %d OFFSET %d
            ]], whereClause, sortColumn, validSortOrder, pageSize, offset)
        end,

        -- Transform database row to result object
        transformResult = function(dbRow, params)
            local entry = dbRow:GetUInt32(0)
            local name = dbRow:GetString(1)
            local displayId = dbRow:GetUInt32(2)
            local quality = dbRow:GetUInt32(3)
            local itemLevel = dbRow:GetUInt32(4)
            local class = dbRow:GetUInt32(5)
            local subclass = dbRow:GetUInt32(6)
            local inventoryType = dbRow:GetUInt32(7)
            local stackable = dbRow:GetUInt32(8)
            local maxcount = dbRow:GetUInt32(9)
            local requiredLevel = dbRow:GetUInt32(10)

            return {
                entry = entry,
                name = name,
                displayId = displayId,
                quality = quality,
                level = itemLevel,
                class = class,
                subclass = subclass,
                inventoryType = inventoryType,
                stackable = stackable > 0,
                maxstack = maxcount,
                requiredLevel = requiredLevel,
                link = "item:" .. entry .. ":0:0:0:0:0:0:0"
            }
        end,

        -- Parameter validation
        validateParams = function(params)
            -- Validate quality range
            if params.quality then
                local quality = tonumber(params.quality)
                if quality and (quality < -1 or quality > 6) then
                    return false, "Quality must be between -1 and 6"
                end
            end

            -- Validate level ranges
            if params.minLevel and params.maxLevel then
                local minLvl = tonumber(params.minLevel) or 0
                local maxLvl = tonumber(params.maxLevel) or 85
                if minLvl > maxLvl then
                    return false, "Minimum level cannot exceed maximum level"
                end
            end

            -- Validate item level ranges
            if params.minItemLevel and params.maxItemLevel then
                local minIlvl = tonumber(params.minItemLevel) or 0
                local maxIlvl = tonumber(params.maxItemLevel) or 999
                if minIlvl > maxIlvl then
                    return false, "Minimum item level cannot exceed maximum item level"
                end
            end

            return true, nil
        end
    }
end

--[[
    Register this search strategy with SearchManager
]]--
function ItemSearchStrategy.Register(searchManager, utils)
    ItemSearchStrategy.Initialize(utils)
    local config = ItemSearchStrategy.GetConfig()
    searchManager.RegisterSearchType(config)
end

return ItemSearchStrategy
