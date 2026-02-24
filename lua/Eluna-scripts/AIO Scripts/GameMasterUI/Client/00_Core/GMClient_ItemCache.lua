local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- ============================================================================
-- GameMaster UI - Client-Side Item Cache System
-- ============================================================================
-- This module provides client-side caching for item data to display items
-- properly without relying on server packets. It stores item information
-- received from the server and provides functions to generate proper item
-- links and tooltips.

-- Create global namespace for item cache
if not _G.GMItemCache then
    _G.GMItemCache = {}
end

local GMItemCache = _G.GMItemCache

-- Cache storage
GMItemCache.items = GMItemCache.items or {}

-- Item quality colors (WoW 3.3.5 format)
GMItemCache.QUALITY_COLORS = {
    [0] = "|cff9d9d9d",  -- Poor (Gray)
    [1] = "|cffffffff",  -- Common (White)
    [2] = "|cff1eff00",  -- Uncommon (Green)
    [3] = "|cff0070dd",  -- Rare (Blue)
    [4] = "|cffa335ee",  -- Epic (Purple)
    [5] = "|cffff8000",  -- Legendary (Orange)
    [6] = "|cffe6cc80",  -- Artifact (Light Yellow)
    [7] = "|cffe6cc80",  -- Heirloom (Light Yellow)
}

-- Item quality names
GMItemCache.QUALITY_NAMES = {
    [0] = "Poor",
    [1] = "Common", 
    [2] = "Uncommon",
    [3] = "Rare",
    [4] = "Epic",
    [5] = "Legendary",
    [6] = "Artifact",
    [7] = "Heirloom",
}

-- Class names for items
GMItemCache.CLASS_NAMES = {
    [0] = "Consumable",
    [1] = "Container",
    [2] = "Weapon",
    [3] = "Gem",
    [4] = "Armor",
    [5] = "Reagent",
    [7] = "Trade Goods",
    [9] = "Recipe",
    [11] = "Quiver",
    [12] = "Quest",
    [13] = "Key",
    [15] = "Miscellaneous",
    [16] = "Glyph"
}

-- Store item data in cache
function GMItemCache.StoreItem(itemData)
    if not itemData or not itemData.entry then
        return false
    end
    
    -- Ensure all required fields exist with defaults
    local cacheItem = {
        entry = tonumber(itemData.entry) or 0,
        name = tostring(itemData.name or "Unknown Item"),
        quality = tonumber(itemData.quality) or 1,
        itemLevel = tonumber(itemData.itemLevel) or 1,
        requiredLevel = tonumber(itemData.requiredLevel) or 1,
        class = tonumber(itemData.class) or 15,
        subclass = tonumber(itemData.subclass) or 0,
        inventoryType = tonumber(itemData.inventoryType) or 0,
        stackable = tonumber(itemData.stackable) or 1,
        displayId = tonumber(itemData.displayId) or 0,
        description = tostring(itemData.description or ""),
        sellPrice = tonumber(itemData.sellPrice) or 0,
        buyPrice = tonumber(itemData.buyPrice) or 0,
        
        -- Optional fields
        enchantId = tonumber(itemData.enchantId) or 0,
        
        -- Store timestamp for cache management
        cached = GetTime()
    }
    
    GMItemCache.items[cacheItem.entry] = cacheItem
    return true
end

-- Store multiple items at once
function GMItemCache.StoreItems(itemList)
    if not itemList or type(itemList) ~= "table" then
        return 0
    end
    
    local stored = 0
    for _, itemData in ipairs(itemList) do
        if GMItemCache.StoreItem(itemData) then
            stored = stored + 1
        end
    end
    
    return stored
end

-- Get item data from cache
function GMItemCache.GetItem(itemId)
    local entry = tonumber(itemId)
    if not entry then
        return nil
    end
    
    return GMItemCache.items[entry]
end

-- Check if item exists in cache
function GMItemCache.HasItem(itemId)
    return GMItemCache.GetItem(itemId) ~= nil
end

-- Get item info similar to GetItemInfo but from cache
function GMItemCache.GetItemInfo(itemId)
    local item = GMItemCache.GetItem(itemId)
    if not item then
        -- Try WoW's GetItemInfo as fallback
        local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipLoc, texture, sellPrice = GetItemInfo(itemId)
        if name then
            return name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipLoc, texture, sellPrice
        end
        return nil
    end
    
    -- Build item link from cached data
    local itemLink = GMItemCache.BuildItemLink(item)
    
    -- Map inventory type to equip location string
    local equipLoc = GMItemCache.GetEquipLocationString(item.inventoryType)
    
    -- Get texture (we don't cache this, so use default)
    local texture = "Interface\\Icons\\INV_Misc_QuestionMark"
    
    return item.name, itemLink, item.quality, item.itemLevel, item.requiredLevel, 
           GMItemCache.CLASS_NAMES[item.class] or "Miscellaneous", item.subclass, 
           item.stackable, equipLoc, texture, item.sellPrice
end

-- Build a proper item link from cached data
function GMItemCache.BuildItemLink(item, enchantId)
    if not item then
        return nil
    end
    
    local actualEnchantId = enchantId or item.enchantId or 0
    local quality = item.quality or 1
    local colorCode = GMItemCache.QUALITY_COLORS[quality] or "|cffffffff"
    
    -- WoW 3.3.5 item link format: item:itemId:enchantId:gem1:gem2:gem3:gem4:suffixId:uniqueId:level
    local itemString = string.format("item:%d:%d:0:0:0:0:0:0:%d", 
        item.entry, actualEnchantId, item.itemLevel)
    
    -- Full link format: |cffRRGGBB|Hitem:...|h[name]|h|r
    local itemLink = string.format("%s|H%s|h[%s]|h|r", 
        colorCode, itemString, item.name)
    
    return itemLink
end

-- Get equip location string from inventory type
function GMItemCache.GetEquipLocationString(inventoryType)
    local equipLocMap = {
        [1] = "INVTYPE_HEAD",
        [2] = "INVTYPE_NECK", 
        [3] = "INVTYPE_SHOULDER",
        [4] = "INVTYPE_BODY",
        [5] = "INVTYPE_CHEST",
        [6] = "INVTYPE_WAIST",
        [7] = "INVTYPE_LEGS",
        [8] = "INVTYPE_FEET",
        [9] = "INVTYPE_WRISTS",
        [10] = "INVTYPE_HAND",
        [11] = "INVTYPE_FINGER",
        [12] = "INVTYPE_TRINKET",
        [13] = "INVTYPE_WEAPON",
        [14] = "INVTYPE_SHIELD",
        [15] = "INVTYPE_RANGED",
        [16] = "INVTYPE_CLOAK",
        [17] = "INVTYPE_2HWEAPON",
        [18] = "INVTYPE_BAG",
        [19] = "INVTYPE_TABARD",
        [20] = "INVTYPE_ROBE",
        [21] = "INVTYPE_WEAPONMAINHAND",
        [22] = "INVTYPE_WEAPONOFFHAND",
        [23] = "INVTYPE_HOLDABLE",
        [24] = "INVTYPE_AMMO",
        [25] = "INVTYPE_THROWN",
        [26] = "INVTYPE_RANGEDRIGHT"
    }
    
    return equipLocMap[inventoryType] or ""
end

-- Create enhanced tooltip for cached items
function GMItemCache.SetTooltip(tooltip, itemId, enchantId)
    local item = GMItemCache.GetItem(itemId)
    if not item then
        -- Fallback to standard tooltip
        tooltip:SetHyperlink(string.format("item:%d", itemId))
        return false
    end
    
    -- Clear tooltip
    tooltip:ClearLines()
    
    -- Set item name with quality color
    local colorCode = GMItemCache.QUALITY_COLORS[item.quality] or "|cffffffff"
    tooltip:SetText(colorCode .. item.name .. "|r")
    
    -- Add item level if significant
    if item.itemLevel > 1 then
        tooltip:AddLine("Item Level " .. item.itemLevel, 1, 1, 1)
    end
    
    -- Add required level if > 1
    if item.requiredLevel > 1 then
        local color = UnitLevel("player") >= item.requiredLevel and {0.5, 1, 0.5} or {1, 0.5, 0.5}
        tooltip:AddLine("Requires Level " .. item.requiredLevel, color[1], color[2], color[3])
    end
    
    -- Add item type
    local className = GMItemCache.CLASS_NAMES[item.class]
    if className then
        tooltip:AddLine(className, 1, 1, 1)
    end
    
    -- Add description if available
    if item.description and item.description ~= "" then
        tooltip:AddLine(" ", 1, 1, 1)  -- Spacer
        tooltip:AddLine(item.description, 1, 0.82, 0, 1)  -- Yellow text, wrapped
    end
    
    -- Add sell price if item has value
    if item.sellPrice and item.sellPrice > 0 then
        local gold = math.floor(item.sellPrice / 10000)
        local silver = math.floor((item.sellPrice % 10000) / 100)
        local copper = item.sellPrice % 100
        
        local priceText = "Sell Price: "
        if gold > 0 then
            priceText = priceText .. gold .. "g "
        end
        if silver > 0 or gold > 0 then
            priceText = priceText .. silver .. "s "
        end
        priceText = priceText .. copper .. "c"
        
        tooltip:AddLine(priceText, 1, 1, 1)
    end
    
    tooltip:Show()
    return true
end

-- Clear old cache entries (optional, for memory management)
function GMItemCache.Cleanup(maxAge)
    if not maxAge then
        maxAge = 300  -- 5 minutes default
    end
    
    local currentTime = GetTime()
    local removed = 0
    
    for itemId, item in pairs(GMItemCache.items) do
        if item.cached and (currentTime - item.cached) > maxAge then
            GMItemCache.items[itemId] = nil
            removed = removed + 1
        end
    end
    
    return removed
end

-- Get cache statistics
function GMItemCache.GetStats()
    local count = 0
    local oldestTime = GetTime()
    local newestTime = 0
    
    for _, item in pairs(GMItemCache.items) do
        count = count + 1
        if item.cached then
            if item.cached < oldestTime then
                oldestTime = item.cached
            end
            if item.cached > newestTime then
                newestTime = item.cached
            end
        end
    end
    
    return {
        itemCount = count,
        oldestCacheTime = count > 0 and oldestTime or nil,
        newestCacheTime = count > 0 and newestTime or nil,
        ageSpan = count > 0 and (newestTime - oldestTime) or 0
    }
end

-- Debug function to list cached items
function GMItemCache.ListCachedItems()
    print("=== GMItemCache Contents ===")
    local count = 0
    for itemId, item in pairs(GMItemCache.items) do
        count = count + 1
        local qualityName = GMItemCache.QUALITY_NAMES[item.quality] or "Unknown"
        print(string.format("Item %d: %s (%s, iLvl %d)", 
            itemId, item.name, qualityName, item.itemLevel))
    end
    print(string.format("Total cached items: %d", count))
end

-- GMClient_ItemCache.lua loaded successfully