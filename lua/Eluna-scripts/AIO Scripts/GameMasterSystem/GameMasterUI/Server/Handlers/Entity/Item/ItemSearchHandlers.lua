--[[
    GameMaster UI - Item Search Handlers Module
    
    This module handles advanced item search and placement operations:
    - Modal item requests
    - Advanced item searching with filters
    - Slot-specific item placement
    - Direct equipment operations
]]--

local ItemSearchHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper
local PlayerHandlers = nil  -- Will be set after all modules are loaded
local ItemDataHandlers = nil  -- Will be set after module loading

function ItemSearchHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register search and placement handlers
    GameMasterSystem.requestModalItems = ItemSearchHandlers.requestModalItems
    GameMasterSystem.searchItemsForModal = ItemSearchHandlers.searchItemsForModal
    GameMasterSystem.searchItems = ItemSearchHandlers.searchItems
    GameMasterSystem.addItemToSpecificSlot = ItemSearchHandlers.addItemToSpecificSlot
    GameMasterSystem.equipItemById = ItemSearchHandlers.equipItemById
end

-- Set module references after all modules are loaded
function ItemSearchHandlers.SetPlayerHandlers(handlers)
    PlayerHandlers = handlers
end

function ItemSearchHandlers.SetItemDataHandlers(handlers)
    ItemDataHandlers = handlers
end

-- Function to display debug messages
local function debugMessage(...)
    if Config.debug then
        print("DEBUG:", ...)
    end
end

-- Handler for requesting items for the modal
function ItemSearchHandlers.requestModalItems(player, searchText, category, qualitiesStr)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Convert qualities string back to table if needed
    local qualities = {}
    if qualitiesStr and qualitiesStr ~= "" then
        if type(qualitiesStr) == "string" then
            -- Split comma-separated string
            for quality in string.gmatch(qualitiesStr, "[^,]+") do
                table.insert(qualities, tonumber(quality))
            end
        elseif type(qualitiesStr) == "table" then
            qualities = qualitiesStr
        end
    end
    
    -- Build the query
    local query = "SELECT entry, name, Quality, ItemLevel, class, subclass, stackable, displayid FROM item_template WHERE 1=1"
    
    -- Add search filter
    if searchText and searchText ~= "" then
        query = query .. " AND (name LIKE '%" .. searchText .. "%' OR entry = '" .. searchText .. "')"
    end
    
    -- Add category filter
    if category and category ~= "all" then
        if category == "weapon" then
            query = query .. " AND class = 2"
        elseif category == "armor" then
            query = query .. " AND class = 4"
        elseif category == "consumable" then
            query = query .. " AND class = 0"
        elseif category == "trade" then
            query = query .. " AND class = 7"
        elseif category == "quest" then
            query = query .. " AND class = 12"
        elseif category == "gem" then
            query = query .. " AND class = 3"
        elseif category == "misc" then
            query = query .. " AND class = 15"
        end
    end
    
    -- Add quality filter
    if qualities and #qualities > 0 then
        local qualityStr = table.concat(qualities, ",")
        query = query .. " AND Quality IN (" .. qualityStr .. ")"
        print("[GameMasterSystem] Quality filter applied: " .. qualityStr)
    end
    
    -- Limit results
    query = query .. " ORDER BY Quality DESC, name ASC LIMIT 100"
    
    -- Execute query
    local results = WorldDBQuery(query)
    local items = {}
    
    if results then
        repeat
            local entry = results:GetUInt32(0)
            local name = results:GetString(1)
            local quality = results:GetUInt32(2)
            local itemLevel = results:GetUInt32(3)
            local class = results:GetUInt32(4)
            local subclass = results:GetUInt32(5)
            local maxStack = results:GetUInt32(6)
            local displayId = results:GetUInt32(7)
            
            table.insert(items, {
                entry = entry,
                name = name,
                quality = quality,
                itemLevel = itemLevel,
                class = class,
                subclass = subclass,
                maxStack = maxStack,
                displayId = displayId,
                link = "item:" .. entry .. ":0:0:0:0:0:0:0"
            })
        until not results:NextRow()
    end
    
    -- Send data to client
    AIO.Handle(player, "GameMasterSystem", "receiveModalItemData", items)
end

-- Handler for searching items in the modal
function ItemSearchHandlers.searchItemsForModal(player, searchText, category, qualities)
    -- Just redirect to requestModalItems with the search parameters
    ItemSearchHandlers.requestModalItems(player, searchText, category, qualities)
end

-- Search items from database with filtering
-- Extended to support level ranges, item level ranges, stackable filter, and sorting
function ItemSearchHandlers.searchItems(player, searchText, category, quality, slotId, 
                                       minLevel, maxLevel, minItemLevel, maxItemLevel, 
                                       stackableOnly, sortBy, sortOrder)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to search items.")
        return
    end
    
    searchText = searchText or ""
    category = category or "all"
    quality = tonumber(quality) or -1  -- -1 means any quality
    slotId = tonumber(slotId)
    minLevel = tonumber(minLevel) or 0
    maxLevel = tonumber(maxLevel) or 85  -- WotLK max level
    minItemLevel = tonumber(minItemLevel) or 0
    maxItemLevel = tonumber(maxItemLevel) or 999
    stackableOnly = stackableOnly or false
    sortBy = sortBy or "ItemLevel"  -- Default sort by item level
    sortOrder = sortOrder or "DESC"  -- Default descending
    
    debugMessage(string.format("[searchItems] Search: '%s', Category: %s, Quality: %d, SlotId: %s", 
        searchText, category, quality, tostring(slotId)))
    
    -- Build the WHERE clause
    local whereConditions = {}
    
    -- Search text (name or entry)
    if searchText ~= "" then
        local escapedSearch = Utils.escapeString(searchText)
        table.insert(whereConditions, string.format("(name LIKE '%%%s%%' OR entry = '%s')", 
            escapedSearch, escapedSearch))
    end
    
    -- Category filter (item class)
    if category ~= "all" then
        local classId = nil
        if category == "armor" then classId = 4
        elseif category == "weapon" then classId = 2
        elseif category == "consumable" then classId = 0
        elseif category == "trade" then classId = 7
        elseif category == "reagent" then classId = 5
        elseif category == "container" then classId = 1
        elseif category == "gem" then classId = 3
        elseif category == "glyph" then classId = 16
        elseif category == "quest" then classId = 12
        elseif category == "misc" then classId = 15
        end
        
        if classId then
            table.insert(whereConditions, string.format("class = %d", classId))
        end
    end
    
    -- Quality filter
    if quality >= 0 and quality <= 6 then
        table.insert(whereConditions, string.format("Quality = %d", quality))
    end
    
    -- Level range filter (RequiredLevel in database)
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
    
    -- Slot filter for equipment (InventoryType)
    if slotId then
        local inventoryType = nil
        -- Map equipment slot IDs to InventoryType values
        if slotId == 0 then inventoryType = 1      -- Head
        elseif slotId == 1 then inventoryType = 2  -- Neck
        elseif slotId == 2 then inventoryType = 3  -- Shoulder
        elseif slotId == 3 then inventoryType = 4  -- Shirt
        elseif slotId == 4 then inventoryType = 5  -- Chest
        elseif slotId == 5 then inventoryType = 6  -- Waist
        elseif slotId == 6 then inventoryType = 7  -- Legs
        elseif slotId == 7 then inventoryType = 8  -- Feet
        elseif slotId == 8 then inventoryType = 9  -- Wrists
        elseif slotId == 9 then inventoryType = 10 -- Hands
        elseif slotId == 10 or slotId == 11 then inventoryType = 11 -- Finger (rings)
        elseif slotId == 12 or slotId == 13 then inventoryType = 12 -- Trinket
        elseif slotId == 14 then inventoryType = 16 -- Back
        elseif slotId == 15 then inventoryType = 13 -- One-Hand weapon
        elseif slotId == 16 then inventoryType = 14 -- Shield
        elseif slotId == 17 then inventoryType = 15 -- Ranged
        elseif slotId == 18 then inventoryType = 19 -- Tabard
        end
        
        if inventoryType then
            -- For weapons, we need to be more flexible
            if slotId == 15 or slotId == 16 then
                -- Main hand or off hand can use various weapon types
                table.insert(whereConditions, string.format(
                    "(InventoryType IN (13, 14, 15, 17, 21, 22, 23))"  -- Various weapon types
                ))
            else
                table.insert(whereConditions, string.format("InventoryType = %d", inventoryType))
            end
        end
    end
    
    -- Build the final WHERE clause
    local whereClause = ""
    if #whereConditions > 0 then
        whereClause = "WHERE " .. table.concat(whereConditions, " AND ")
    end
    
    -- Validate and sanitize sort parameters
    local validSortColumns = {
        ["name"] = "name",
        ["ItemLevel"] = "ItemLevel",
        ["RequiredLevel"] = "RequiredLevel",
        ["Quality"] = "Quality"
    }
    local sortColumn = validSortColumns[sortBy] or "ItemLevel"
    local validSortOrder = (sortOrder == "ASC") and "ASC" or "DESC"
    
    -- Build and execute the query
    local query = string.format([[
        SELECT entry, name, displayid, Quality, ItemLevel, 
               class, subclass, InventoryType, stackable, maxcount, RequiredLevel
        FROM item_template
        %s
        ORDER BY %s %s, name ASC
        LIMIT 50
    ]], whereClause, sortColumn, validSortOrder)
    
    debugMessage("[searchItems] Query:", query)
    
    local result = WorldDBQuery(query)
    local items = {}
    
    if result then
        repeat
            local item = {
                entry = result:GetUInt32(0),
                name = result:GetString(1),
                icon = ItemDataHandlers and ItemDataHandlers.getItemIcon and 
                       ItemDataHandlers.getItemIcon(result:GetUInt32(2)) or 
                       "Interface\\Icons\\INV_Misc_QuestionMark",
                quality = result:GetUInt32(3),
                level = result:GetUInt32(4),  -- ItemLevel
                type = ItemDataHandlers and ItemDataHandlers.getItemTypeName and
                      ItemDataHandlers.getItemTypeName(result:GetUInt32(5), result:GetUInt32(6)) or
                      "Unknown",
                stackable = result:GetUInt32(8) > 0,
                maxstack = result:GetUInt32(9),
                requiredLevel = result:GetUInt32(10)  -- RequiredLevel
            }
            table.insert(items, item)
        until not result:NextRow()
    end
    
    debugMessage(string.format("[searchItems] Found %d items", #items))
    
    -- Send results to client
    AIO.Handle(player, "GameMasterSystem", "receiveItemSearchResults", items)
end

-- Add item to specific bag and slot
-- NOTE: Slot indices are 0-based internally (matching WoW API)
-- When displaying to users, we show 1-based numbering (slot 1, 2, 3...)
function ItemSearchHandlers.addItemToSpecificSlot(player, targetName, itemId, quantity, bagId, slotId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to add items.")
        return
    end
    
    itemId = tonumber(itemId)
    quantity = tonumber(quantity) or 1
    bagId = tonumber(bagId) or 0
    slotId = tonumber(slotId) or 0
    
    if not itemId or itemId <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Verify item exists
    local itemQuery = WorldDBQuery("SELECT name FROM item_template WHERE entry = " .. itemId)
    if not itemQuery then
        Utils.sendMessage(player, "error", "Item ID " .. itemId .. " does not exist.")
        return
    end
    
    local itemName = itemQuery:GetString(0)
    
    debugMessage(string.format("[addItemToSpecificSlot] Adding %dx %s to %s at bag %d slot %d",
        quantity, itemName, targetName, bagId, slotId))
    
    -- Normalize bag IDs for custom bags
    local normalizedBagId = bagId
    if bagId >= 1518 and bagId <= 1521 then
        normalizedBagId = bagId - 1518 + 19  -- Map 1518->19, 1519->20, etc.
        debugMessage(string.format("[addItemToSpecificSlot] Remapping bag %d to %d", bagId, normalizedBagId))
    elseif bagId >= 1500 then
        -- Other custom bags - try to add normally
        local item = targetPlayer:AddItem(itemId, quantity)
        if item then
            targetPlayer:SaveToDB()
            Utils.sendMessage(player, "success", string.format("Added %dx %s to %s's inventory.", 
                quantity, itemName, targetName))
            
            -- Send inventory update notification
            local itemData = {
                entry = itemId,
                name = itemName,
                count = quantity,
                bag = item:GetBagSlot(),
                slot = item:GetSlot()
            }
            AIO.Handle(player, "GameMasterSystem", "handleInventoryUpdate", "add", itemData, item:GetBagSlot(), item:GetSlot())
        else
            Utils.sendMessage(player, "error", "Failed to add item. Inventory might be full.")
        end
        return
    end
    
    -- Use normalized bag ID for the rest of the logic
    bagId = normalizedBagId
    
    -- Check if the specific slot is empty
    local existingItem = targetPlayer:GetItemByPos(bagId, slotId)
    if existingItem then
        -- Slot is occupied, try stacking if same item and stackable
        if existingItem:GetEntry() == itemId then
            local currentCount = existingItem:GetCount()
            local maxStack = existingItem:GetMaxStackCount()
            if currentCount < maxStack then
                local addCount = math.min(quantity, maxStack - currentCount)
                existingItem:SetCount(currentCount + addCount)
                targetPlayer:SaveToDB()
                
                Utils.sendMessage(player, "success", string.format("Stacked %dx %s in bag %d slot %d.", 
                    addCount, itemName, bagId, slotId + 1))
                
                -- Send inventory update notification
                local itemData = {
                    entry = itemId,
                    name = itemName,
                    count = currentCount + addCount,
                    bag = bagId,
                    slot = slotId
                }
                AIO.Handle(player, "GameMasterSystem", "handleInventoryUpdate", "modify", itemData, bagId, slotId)
                return
            end
        end
        Utils.sendMessage(player, "error", "Target slot is already occupied.")
        return
    end
    
    -- Unfortunately, Eluna's AddItem doesn't support specific slot placement
    -- Items are added to the first available slot
    local item = targetPlayer:AddItem(itemId, quantity)
    if item then
        targetPlayer:SaveToDB()
        
        local actualBag = item:GetBagSlot()
        local actualSlot = item:GetSlot()
        
        -- Check if item went to desired location
        if actualBag == bagId and actualSlot == slotId then
            Utils.sendMessage(player, "success", string.format("Added %dx %s to bag %d slot %d.", 
                quantity, itemName, bagId, slotId + 1))
        else
            Utils.sendMessage(player, "warning", string.format("Added %dx %s to inventory (went to bag %d slot %d instead of requested bag %d slot %d).", 
                quantity, itemName, actualBag, actualSlot + 1, bagId, slotId + 1))
        end
        
        -- Send inventory update notification with actual position
        local itemData = {
            entry = itemId,
            name = itemName,
            count = quantity,
            bag = actualBag,
            slot = actualSlot
        }
        AIO.Handle(player, "GameMasterSystem", "handleInventoryUpdate", "add", itemData, actualBag, actualSlot)
    else
        Utils.sendMessage(player, "error", "Failed to add item. Inventory might be full.")
    end
end

-- Equip item directly to equipment slot
function ItemSearchHandlers.equipItemById(player, targetName, itemId, slotId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to equip items.")
        return
    end
    
    itemId = tonumber(itemId)
    slotId = tonumber(slotId)
    
    if not itemId or itemId <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID.")
        return
    end
    
    if not slotId or slotId < 0 or slotId > 18 then
        Utils.sendMessage(player, "error", "Invalid equipment slot.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Verify item exists and can be equipped
    local itemQuery = WorldDBQuery(string.format(
        "SELECT name, InventoryType FROM item_template WHERE entry = %d", itemId))
    if not itemQuery then
        Utils.sendMessage(player, "error", "Item ID " .. itemId .. " does not exist.")
        return
    end
    
    local itemName = itemQuery:GetString(0)
    local inventoryType = itemQuery:GetUInt32(1)
    
    debugMessage(string.format("[equipItemById] Equipping %s to %s in slot %d", 
        itemName, targetName, slotId))
    
    -- Check if there's an item already equipped in that slot
    local currentItem = targetPlayer:GetItemByPos(255, slotId)  -- 255 is equipment bag
    
    -- Try to equip the item directly (Eluna will handle adding it)
    local equippedItem = targetPlayer:EquipItem(itemId, slotId)
    
    -- Check if equipping was successful
    if not equippedItem then
        -- Equipping failed, try adding to inventory instead
        debugMessage(string.format("[equipItemById] Failed to equip %s, adding to inventory instead", itemName))
        local item = targetPlayer:AddItem(itemId, 1)
        if not item then
            Utils.sendMessage(player, "error", "Failed to equip item and inventory is full.")
            return
        end
        Utils.sendMessage(player, "warning", string.format("Could not equip %s (check requirements). Added to inventory instead.", itemName))
        -- Still save and refresh
        targetPlayer:SaveToDB()
        if PlayerHandlers and PlayerHandlers.getPlayerInventory then
            PlayerHandlers.getPlayerInventory(player, targetName)
        else
            AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
        end
        return
    end
    
    -- Save to database immediately
    targetPlayer:SaveToDB()
    
    Utils.sendMessage(player, "success", string.format("Equipped %s to %s's slot %d.", 
        itemName, targetName, slotId))
    
    -- Send fresh inventory data immediately
    if PlayerHandlers and PlayerHandlers.getPlayerInventory then
        print("[ItemSearchHandlers] Sending fresh inventory data after equip")
        -- Send fresh inventory data to the player
        PlayerHandlers.getPlayerInventory(player, targetName)
    else
        -- Fallback to refresh signal
        AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
    end
end

return ItemSearchHandlers