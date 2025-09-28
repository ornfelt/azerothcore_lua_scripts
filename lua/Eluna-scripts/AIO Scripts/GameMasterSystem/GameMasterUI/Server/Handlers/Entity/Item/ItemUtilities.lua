--[[
    GameMaster UI - Item Utilities Module
    
    This module contains shared utility functions for item operations:
    - Item finding and validation
    - Bag size helpers
    - Inventory position validation
]]--

local ItemUtilities = {}

-- Module dependencies (will be injected)
local Config

function ItemUtilities.Initialize(config)
    Config = config
end

-- Helper function to get bag size safely
function ItemUtilities.getBagSize(player, bagSlot)
    local bag = player:GetItemByPos(255, bagSlot)
    if bag then
        local size = bag:GetBagSize()
        return size > 0 and size or 16  -- Default to 16 if GetBagSize returns 0
    end
    return 0  -- No bag equipped
end

-- Helper function to validate inventory position with bag size checking
function ItemUtilities.isValidInventoryPosition(player, bag, slot)
    -- Equipment slots (bag 255, slots 0-18)
    if bag == 255 and slot >= 0 and slot <= 18 then
        return true, "equipment"
    end
    -- Equipped bag slots - the bags themselves (bag 255, slots 19-22)
    if bag == 255 and slot >= 19 and slot <= 22 then
        return true, "equipped_bag_slot"
    end
    -- Backpack slots (bag 255, slots 23-38)
    if bag == 255 and slot >= 23 and slot <= 38 then
        return true, "backpack"
    end
    -- Bank main slots (bag 255, slots 39-66)
    if bag == 255 and slot >= 39 and slot <= 66 then
        return true, "bank_main"
    end
    -- Bank bag slots - the bags themselves (bag 255, slots 67-73) - WoW 3.3.5 has 7 bank bag slots
    if bag == 255 and slot >= 67 and slot <= 73 then
        return true, "bank_bag_slot"
    end
    -- Equipped bags content (bags 19-22, slots 0 to bag size)
    if bag >= 19 and bag <= 22 and slot >= 0 then
        if player then
            local bagSize = ItemUtilities.getBagSize(player, bag)
            if slot < bagSize then
                return true, string.format("equipped_bag_content (size=%d)", bagSize)
            else
                return false, string.format("slot_out_of_bounds (bag_size=%d)", bagSize)
            end
        else
            -- Fallback when player not available
            if slot <= 35 then
                return true, "equipped_bag_content (no_size_check)"
            end
        end
    end
    -- Bank bags content (bags 67-73, slots 0 to bag size) - WoW 3.3.5 has 7 bank bag slots
    if bag >= 67 and bag <= 73 and slot >= 0 then
        if player then
            local bagSize = ItemUtilities.getBagSize(player, bag)
            if slot < bagSize then
                return true, string.format("bank_bag_content (size=%d)", bagSize)
            else
                return false, string.format("slot_out_of_bounds (bag_size=%d)", bagSize)
            end
        else
            -- Fallback when player not available
            if slot <= 35 then
                return true, "bank_bag_content (no_size_check)"
            end
        end
    end
    -- Alternative backpack format (bag 0, various slots)
    if bag == 0 and slot >= 0 and slot <= 35 then
        return true, "alt_backpack"
    end
    -- Alternative bag format (bags 1-4)
    if bag >= 1 and bag <= 4 and slot >= 0 and slot <= 35 then
        return true, "alt_equipped_bag"
    end
    return false, "invalid"
end

-- Helper function to find item using multiple methods
function ItemUtilities.findInventoryItem(player, bag, slot, itemGuid)
    print(string.format("[ItemUtilities] findInventoryItem: bag=%d, slot=%d, guid=%s", 
        bag, slot, tostring(itemGuid)))
    
    -- CUSTOM BAG HANDLING: For bags >= 1500 (custom 64-slot bags)
    if bag >= 1500 then
        print(string.format("[ItemUtilities] CUSTOM 64-SLOT BAG %d detected, using GUID lookup", bag))
        
        -- Method 1: Try to iterate through all player items to find matching GUID
        if itemGuid and itemGuid > 0 then
            print(string.format("[ItemUtilities] CUSTOM BAG: Looking for item with GUID %d", itemGuid))
            
            -- Try iterating through all bags and slots to find the item
            for checkBag = 0, 4 do -- Check main bags
                for checkSlot = 0, 36 do
                    local item = player:GetItemByPos(checkBag, checkSlot)
                    if item and item:GetGUIDLow() == itemGuid then
                        print(string.format("[ItemUtilities] CUSTOM BAG SUCCESS: Found item %s in bag %d slot %d by GUID scan", 
                            item:GetName(), checkBag, checkSlot))
                        return item
                    end
                end
            end
            
            -- Also check bank bags (WoW 3.3.5 has 7 bank bag slots)
            for checkBag = 67, 73 do
                for checkSlot = 0, 36 do
                    local item = player:GetItemByPos(checkBag, checkSlot)
                    if item and item:GetGUIDLow() == itemGuid then
                        print(string.format("[ItemUtilities] CUSTOM BAG SUCCESS: Found item %s in bank bag %d slot %d by GUID scan", 
                            item:GetName(), checkBag, checkSlot))
                        return item
                    end
                end
            end
            
            print(string.format("[ItemUtilities] CUSTOM BAG: GUID scan failed - item with GUID %d not found in any accessible bag", itemGuid))
        else
            print(string.format("[ItemUtilities] CUSTOM BAG: No GUID provided or GUID is 0"))
        end
        
        -- Method 2: Query database for item entry and create new item reference
        print(string.format("[ItemUtilities] CUSTOM BAG: Method 2 - Querying DB for player GUID %d, bag %d, slot %d", 
            player:GetGUIDLow(), bag, slot))
        local query = CharDBQuery(string.format([[
            SELECT ci.item, ii.itemEntry, ii.count 
            FROM character_inventory ci
            JOIN item_instance ii ON ci.item = ii.guid
            WHERE ci.guid = %d AND ci.bag = %d AND ci.slot = %d
        ]], player:GetGUIDLow(), bag, slot))
        
        if query then
            local dbItemGuid = query:GetUInt32(0)
            local itemEntry = query:GetUInt32(1)
            local itemCount = query:GetUInt32(2)
            print(string.format("[ItemUtilities] CUSTOM BAG: Found in DB - GUID: %d, Entry: %d, Count: %d", 
                dbItemGuid, itemEntry, itemCount))
            
            -- Try to find item by scanning player's inventory for matching GUID
            for checkBag = 0, 4 do
                for checkSlot = 0, 36 do
                    local item = player:GetItemByPos(checkBag, checkSlot)
                    if item and item:GetGUIDLow() == dbItemGuid then
                        print(string.format("[ItemUtilities] CUSTOM BAG SUCCESS: Found item %s by DB GUID scan", item:GetName()))
                        return item
                    end
                end
            end
            
            print(string.format("[ItemUtilities] CUSTOM BAG ERROR: Item exists in DB but not found in player inventory scan"))
        else
            print(string.format("[ItemUtilities] CUSTOM BAG ERROR: No item found in DB for player %d at bag %d, slot %d", 
                player:GetGUIDLow(), bag, slot))
        end
        
        -- Custom bags don't work with GetItemByPos, so return nil if GUID methods fail
        print("[ItemUtilities] CUSTOM BAG: All GUID methods failed for custom bag")
        return nil
    end
    
    -- Validate the position first (for normal bags)
    local isValid, positionType = ItemUtilities.isValidInventoryPosition(player, bag, slot)
    if not isValid then
        print(string.format("[ItemUtilities] WARNING: %s (bag=%d, slot=%d)", positionType, bag, slot))
    else
        print(string.format("[ItemUtilities] Position type: %s (bag=%d, slot=%d)", positionType, bag, slot))
    end
    
    -- Method 1: Direct position lookup (for normal bags)
    local item = player:GetItemByPos(bag, slot)
    if item then
        print(string.format("[ItemUtilities] Method 1 SUCCESS: Found item %s at bag=%d, slot=%d", 
            item:GetName(), bag, slot))
        return item
    end
    
    -- Method 2: Try alternative bag mappings for common cases
    local alternativeBags = {}
    
    print(string.format("[ItemUtilities] Method 2: Trying alternative bag mappings for bag=%d, slot=%d", bag, slot))
    
    -- CRITICAL FIX: The database stores equipped bags as 19-22, but client might send as 0-4 or 1-4
    if bag == 0 then
        -- Bag 0 could mean backpack (255) or sometimes bag 19 in database
        table.insert(alternativeBags, {255, slot})  -- Try as backpack slot
        if slot >= 0 and slot <= 15 then
            table.insert(alternativeBags, {255, 23 + slot})  -- Backpack slots 23-38
        end
        -- Also try bag 19 (first equipped bag sometimes stored as bag 0)
        table.insert(alternativeBags, {19, slot})
    elseif bag >= 1 and bag <= 4 then
        -- Client bags 1-4 map to database bags 19-22
        local realBag = 18 + bag  -- Convert to 19-22
        table.insert(alternativeBags, {realBag, slot})
        print(string.format("[ItemUtilities] Mapping client bag %d to database bag %d", bag, realBag))
    elseif bag >= 5 and bag <= 11 then
        -- Bank bags: client bags 5-11 map to database bags 67-73 (WoW 3.3.5 has 7 bank bag slots)
        local realBag = 62 + bag  -- Convert to 67-73
        table.insert(alternativeBags, {realBag, slot})
        print(string.format("[ItemUtilities] Mapping client bank bag %d to database bag %d", bag, realBag))
    elseif bag >= 19 and bag <= 22 then
        -- Already in correct format for equipped bags, but also try offset versions
        table.insert(alternativeBags, {bag - 18, slot})  -- Try as bags 1-4
        table.insert(alternativeBags, {bag - 19, slot})  -- Try as bags 0-3
    elseif bag >= 67 and bag <= 73 then
        -- Already in correct format for bank bags, but also try offset versions
        table.insert(alternativeBags, {bag - 62, slot})  -- Try as bags 5-12
        table.insert(alternativeBags, {bag - 67, slot})  -- Try as bags 0-7
    elseif bag == 255 then
        -- Bag 255 with specific slot ranges
        if slot >= 23 and slot <= 38 then
            -- Backpack slots: also try as bag 0
            table.insert(alternativeBags, {0, slot - 23})
        end
    end
    
    -- Try alternative mappings
    for _, mapping in ipairs(alternativeBags) do
        local altBag, altSlot = mapping[1], mapping[2]
        item = player:GetItemByPos(altBag, altSlot)
        if item then
            print(string.format("[ItemUtilities] Method 2 SUCCESS: Found item %s at alternative bag=%d, slot=%d", 
                item:GetName(), altBag, altSlot))
            return item
        end
    end
    
    -- Method 3: Search by GUID if available
    if itemGuid and itemGuid > 0 then
        item = player:GetItemByGUID(itemGuid)
        if item then
            print(string.format("[ItemUtilities] Method 3 SUCCESS: Found item %s by GUID %d", 
                item:GetName(), itemGuid))
            return item
        end
    end
    
    -- Method 4: Comprehensive search through all inventory positions (last resort)
    print("[ItemUtilities] Method 4: Comprehensive inventory search - checking ALL inventory areas")
    
    local foundItems = {}
    
    -- Search equipment slots (bag 255, slots 0-18)
    for testSlot = 0, 18 do
        local testItem = player:GetItemByPos(255, testSlot)
        if testItem then
            table.insert(foundItems, {
                item = testItem,
                bag = 255,
                slot = testSlot,
                name = testItem:GetName(),
                entry = testItem:GetEntry(),
                area = "equipment"
            })
        end
    end
    
    -- Search backpack (bag 255, slots 23-38)
    for testSlot = 23, 38 do
        local testItem = player:GetItemByPos(255, testSlot)
        if testItem then
            table.insert(foundItems, {
                item = testItem,
                bag = 255,
                slot = testSlot,
                name = testItem:GetName(),
                entry = testItem:GetEntry(),
                area = "backpack"
            })
        end
    end
    
    -- Search bank main slots (bag 255, slots 39-66)
    for testSlot = 39, 66 do
        local testItem = player:GetItemByPos(255, testSlot)
        if testItem then
            table.insert(foundItems, {
                item = testItem,
                bag = 255,
                slot = testSlot,
                name = testItem:GetName(),
                entry = testItem:GetEntry(),
                area = "bank_main"
            })
        end
    end
    
    -- Search equipped bags (bags 19-22) with proper size checking
    for testBag = 19, 22 do
        local bagSize = ItemUtilities.getBagSize(player, testBag)
        if bagSize > 0 then
            print(string.format("[ItemUtilities] Equipped bag %d has size %d", testBag, bagSize))
            for testSlot = 0, bagSize - 1 do
                local testItem = player:GetItemByPos(testBag, testSlot)
                if testItem then
                    table.insert(foundItems, {
                        item = testItem,
                        bag = testBag,
                        slot = testSlot,
                        name = testItem:GetName(),
                        entry = testItem:GetEntry(),
                        area = string.format("equipped_bag_%d", testBag)
                    })
                end
            end
        else
            print(string.format("[ItemUtilities] No bag equipped in slot %d", testBag))
        end
    end
    
    -- Search bank bags (bags 67-73) with proper size checking - WoW 3.3.5 has 7 bank bag slots
    for testBag = 67, 73 do
        local bagSize = ItemUtilities.getBagSize(player, testBag)
        if bagSize > 0 then
            print(string.format("[ItemUtilities] Bank bag %d has size %d", testBag, bagSize))
            for testSlot = 0, bagSize - 1 do
                local testItem = player:GetItemByPos(testBag, testSlot)
                if testItem then
                    table.insert(foundItems, {
                        item = testItem,
                        bag = testBag,
                        slot = testSlot,
                        name = testItem:GetName(),
                        entry = testItem:GetEntry(),
                        area = string.format("bank_bag_%d", testBag)
                    })
                end
            end
        else
            print(string.format("[ItemUtilities] No bank bag equipped in slot %d", testBag))
        end
    end
    
    print(string.format("[ItemUtilities] Method 4: Found %d total items across ALL inventory areas", #foundItems))
    
    -- Print all found items for debugging, organized by area
    local itemsByArea = {}
    for _, itemInfo in ipairs(foundItems) do
        if not itemsByArea[itemInfo.area] then
            itemsByArea[itemInfo.area] = {}
        end
        table.insert(itemsByArea[itemInfo.area], itemInfo)
    end
    
    for area, items in pairs(itemsByArea) do
        print(string.format("[ItemUtilities] === %s (%d items) ===", area, #items))
        for i, itemInfo in ipairs(items) do
            print(string.format("  %d: %s (ID: %d) at bag=%d, slot=%d", 
                i, itemInfo.name, itemInfo.entry, itemInfo.bag, itemInfo.slot))
        end
    end
    
    print("[ItemUtilities] All methods failed to find item")
    return nil
end

return ItemUtilities