local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Verify namespace exists
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get module references
local GMDataHandler = _G.GMDataHandler
local GMData = _G.GMData
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local GMUI = _G.GMUI

-- Data filtering functions
function GMDataHandler.FilterDataByType(data, filterType)
    if not data or not filterType then
        return data
    end
    
    local filtered = {}
    
    -- Filter based on the current tab
    if filterType == "items" then
        -- Items don't need filtering, return as is
        return data
    elseif filterType == "creatures" then
        -- Creatures don't need filtering, return as is
        return data
    elseif filterType == "gameobjects" then
        -- GameObjects don't need filtering, return as is
        return data
    elseif filterType == "quests" then
        -- Quests don't need filtering, return as is
        return data
    elseif filterType == "spells" then
        -- Spells don't need filtering, return as is
        return data
    end
    
    return data
end

-- Filter items by inventory type
function GMDataHandler.FilterItemsByInventoryType(items, inventoryType)
    if not items or not inventoryType or inventoryType == "all" then
        return items
    end
    
    local filtered = {}
    local invTypeMapping = {
        head = 1,
        neck = 2,
        shoulder = 3,
        body = 4,
        chest = 5,
        waist = 6,
        legs = 7,
        feet = 8,
        wrist = 9,
        hands = 10,
        finger = 11,
        trinket = 12,
        weapon = 13,
        shield = 14,
        ranged = 15,
        cloak = 16,
        twohand = 17,
        bag = 18,
        tabard = 19,
        robe = 20,
        weaponmainhand = 21,
        weaponoffhand = 22,
        holdable = 23,
        ammo = 24,
        thrown = 25,
        rangedright = 26,
        quiver = 28,
        relic = 29
    }
    
    local targetInvType = invTypeMapping[inventoryType]
    if not targetInvType then
        return items
    end
    
    for _, item in ipairs(items) do
        if item.inventoryType == targetInvType then
            table.insert(filtered, item)
        end
    end
    
    return filtered
end

-- Search functionality
function GMDataHandler.SearchData(data, searchText, searchFields)
    if not data or not searchText or searchText == "" then
        return data
    end
    
    searchText = searchText:lower()
    local filtered = {}
    
    -- Default search fields if none provided
    if not searchFields then
        searchFields = {"name", "id"}
    end
    
    for _, item in ipairs(data) do
        local found = false
        
        for _, field in ipairs(searchFields) do
            local value = item[field]
            if value then
                -- Convert to string and lowercase for comparison
                local strValue = tostring(value):lower()
                if strValue:find(searchText, 1, true) then
                    found = true
                    break
                end
            end
        end
        
        if found then
            table.insert(filtered, item)
        end
    end
    
    return filtered
end

-- Apply all active filters
function GMDataHandler.ApplyAllFilters()
    local currentTab = GMData.DataStore.currentTab or "items"
    local baseData = GMData.DataStore[currentTab] or {}
    local filteredData = baseData
    
    -- Apply search filter if search box exists and has text
    if GMData.frames.mainFrame and GMData.frames.mainFrame.searchBox then
        local searchText = GMData.frames.mainFrame.searchBox:GetText()
        if searchText and searchText ~= "" then
            -- Define search fields based on tab
            local searchFields = {}
            if currentTab == "items" then
                searchFields = {"name", "id", "displayId"}
            elseif currentTab == "creatures" then
                searchFields = {"name", "id", "subname"}
            elseif currentTab == "gameobjects" then
                searchFields = {"name", "id", "type"}
            elseif currentTab == "quests" then
                searchFields = {"title", "id"}
            elseif currentTab == "spells" then
                searchFields = {"name", "id"}
            elseif currentTab == "players" then
                searchFields = {"name"}
            end
            
            filteredData = GMDataHandler.SearchData(filteredData, searchText, searchFields)
        end
    end
    
    -- Apply inventory type filter for items
    if currentTab == "items" and GMData.DataStore.currentInventoryFilter and GMData.DataStore.currentInventoryFilter ~= "all" then
        filteredData = GMDataHandler.FilterItemsByInventoryType(filteredData, GMData.DataStore.currentInventoryFilter)
    end
    
    -- Apply additional type-specific filters here
    
    return filteredData
end

-- Update data store with new data
function GMDataHandler.UpdateDataStore(dataType, data)
    if not dataType or not data then
        return
    end
    
    -- Store the raw data
    GMData.DataStore[dataType] = data
    
    -- If this is the current tab, update the display
    if GMData.DataStore.currentTab == dataType then
        GMDataHandler.RefreshCurrentDisplay()
    end
end

-- Refresh the current display
function GMDataHandler.RefreshCurrentDisplay()
    -- Apply filters and update the list
    local filteredData = GMDataHandler.ApplyAllFilters()
    
    -- Update the content based on current tab
    if GMData.DataStore.currentTab == "items" and GMDataHandler.UpdateItemList then
        GMDataHandler.UpdateItemList(filteredData)
    elseif GMData.DataStore.currentTab == "creatures" and GMDataHandler.UpdateCreatureList then
        GMDataHandler.UpdateCreatureList(filteredData)
    elseif GMData.DataStore.currentTab == "gameobjects" and GMDataHandler.UpdateGameObjectList then
        GMDataHandler.UpdateGameObjectList(filteredData)
    elseif GMData.DataStore.currentTab == "quests" and GMDataHandler.UpdateQuestList then
        GMDataHandler.UpdateQuestList(filteredData)
    elseif GMData.DataStore.currentTab == "spells" and GMDataHandler.UpdateSpellList then
        GMDataHandler.UpdateSpellList(filteredData)
    elseif GMData.DataStore.currentTab == "players" then
        -- Players use the generic updateContentForActiveTab, no special handler needed
        if GMUI and GMUI.updateContentForActiveTab then
            GMUI.updateContentForActiveTab()
        end
    end
    
    -- Update result count if available
    if GMData.frames.mainFrame and GMData.frames.mainFrame.resultCount then
        GMData.frames.mainFrame.resultCount:SetText(string.format("Results: %d", #filteredData))
    end
end

-- Request data for the current tab
function GMDataHandler.RequestDataForCurrentTab()
    local currentTab = GMData.DataStore.currentTab or "items"
    
    -- Show loading indicator if available
    if GMData.frames.mainFrame and GMData.frames.mainFrame.loadingText then
        GMData.frames.mainFrame.loadingText:Show()
    end
    
    -- Send request to server based on current tab
    if currentTab == "items" then
        AIO.Handle("GameMasterUI", "RequestItems")
    elseif currentTab == "creatures" then
        AIO.Handle("GameMasterUI", "RequestCreatures")
    elseif currentTab == "gameobjects" then
        AIO.Handle("GameMasterUI", "RequestGameObjects")
    elseif currentTab == "quests" then
        AIO.Handle("GameMasterUI", "RequestQuests")
    elseif currentTab == "spells" then
        AIO.Handle("GameMasterUI", "RequestSpells")
    elseif currentTab == "players" then
        -- Players use GameMasterSystem handlers, not GameMasterUI
        local offset = GMData.currentOffset or 0
        local pageSize = GMConfig.config.PAGE_SIZE or 15
        local sortOrder = GMData.sortOrder or "ASC"
        AIO.Handle("GameMasterSystem", "getPlayerData", offset, pageSize, sortOrder)
    end
end

-- Data transformation functions
function GMDataHandler.TransformItemData(rawItem)
    -- Transform raw item data into display format
    return {
        id = rawItem.entry or rawItem.id,
        name = rawItem.name or "Unknown Item",
        displayId = rawItem.displayid or rawItem.displayId or 0,
        quality = rawItem.Quality or rawItem.quality or 0,
        itemLevel = rawItem.ItemLevel or rawItem.itemLevel or 0,
        requiredLevel = rawItem.RequiredLevel or rawItem.requiredLevel or 0,
        inventoryType = rawItem.InventoryType or rawItem.inventoryType or 0,
        class = rawItem.class or 0,
        subclass = rawItem.subclass or 0
    }
end

function GMDataHandler.TransformCreatureData(rawCreature)
    -- Transform raw creature data into display format
    return {
        id = rawCreature.entry or rawCreature.id,
        name = rawCreature.name or "Unknown Creature",
        subname = rawCreature.subname or "",
        level = rawCreature.minlevel or rawCreature.level or 0,
        maxLevel = rawCreature.maxlevel or rawCreature.level or 0,
        rank = rawCreature.rank or 0,
        family = rawCreature.family or 0
    }
end

function GMDataHandler.TransformGameObjectData(rawGO)
    -- Transform raw gameobject data into display format
    return {
        id = rawGO.entry or rawGO.id,
        name = rawGO.name or "Unknown GameObject",
        type = rawGO.type or 0,
        displayId = rawGO.displayId or 0
    }
end

function GMDataHandler.TransformQuestData(rawQuest)
    -- Transform raw quest data into display format
    return {
        id = rawQuest.ID or rawQuest.id,
        title = rawQuest.Title or rawQuest.LogTitle or "Unknown Quest",
        level = rawQuest.QuestLevel or rawQuest.MinLevel or 0,
        requiredLevel = rawQuest.MinLevel or 0,
        type = rawQuest.QuestType or rawQuest.Type or 0
    }
end

function GMDataHandler.TransformSpellData(rawSpell)
    -- Transform raw spell data into display format
    return {
        id = rawSpell.ID or rawSpell.id,
        name = rawSpell.SpellName or rawSpell.name or "Unknown Spell",
        rank = rawSpell.Rank or "",
        school = rawSpell.School or 0,
        powerType = rawSpell.PowerType or 0,
        castTime = rawSpell.CastingTime or 0,
        cooldown = rawSpell.RecoveryTime or 0
    }
end

-- Batch transform data
function GMDataHandler.TransformDataBatch(dataType, rawData)
    if not rawData or type(rawData) ~= "table" then
        return {}
    end
    
    local transformed = {}
    local transformFunc
    
    if dataType == "items" then
        transformFunc = GMDataHandler.TransformItemData
    elseif dataType == "creatures" then
        transformFunc = GMDataHandler.TransformCreatureData
    elseif dataType == "gameobjects" then
        transformFunc = GMDataHandler.TransformGameObjectData
    elseif dataType == "quests" then
        transformFunc = GMDataHandler.TransformQuestData
    elseif dataType == "spells" then
        transformFunc = GMDataHandler.TransformSpellData
    else
        return rawData
    end
    
    for _, item in ipairs(rawData) do
        table.insert(transformed, transformFunc(item))
    end
    
    return transformed
end

-- Clear data for a specific type
function GMDataHandler.ClearData(dataType)
    if dataType and GMData.DataStore[dataType] then
        GMData.DataStore[dataType] = {}
        
        -- If clearing current tab data, refresh display
        if GMData.DataStore.currentTab == dataType then
            GMDataHandler.RefreshCurrentDisplay()
        end
    end
end

-- Clear all cached data
function GMDataHandler.ClearAllData()
    GMData.DataStore.items = {}
    GMData.DataStore.creatures = {}
    GMData.DataStore.gameobjects = {}
    GMData.DataStore.quests = {}
    GMData.DataStore.spells = {}
    GMData.DataStore.players = {}
    
    GMDataHandler.RefreshCurrentDisplay()
end

-- Get filtered data count
function GMDataHandler.GetFilteredDataCount()
    local filteredData = GMDataHandler.ApplyAllFilters()
    return #filteredData
end

-- Check if data is loaded for current tab
function GMDataHandler.IsDataLoaded()
    local currentTab = GMData.DataStore.currentTab or "items"
    local data = GMData.DataStore[currentTab]
    return data and #data > 0
end

-- Export data management module loaded confirmation
-- Data management module loaded