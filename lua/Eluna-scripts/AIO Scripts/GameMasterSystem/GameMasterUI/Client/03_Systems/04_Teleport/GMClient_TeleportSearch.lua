local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

local Teleport = GameMasterSystem.Teleport
if not Teleport then
    print("[ERROR] Teleport namespace not found! Check load order.")
    return
end

-- Teleport Search Module
local TeleportSearch = {}
Teleport.Search = TeleportSearch

-- Cache for teleport locations to reduce server requests
local teleportCache = {
    data = {},
    lastUpdate = 0,
    cacheTimeout = 300, -- 5 minutes
    searchCache = {} -- Cache search results
}

-- Advanced search dialog with filters
function TeleportSearch.ShowAdvancedSearch(targetPlayer)
    -- Store target player
    Teleport.targetPlayer = targetPlayer
    
    -- Create main frame with a global name for UISpecialFrames
    local frameName = "GameMasterTeleportSearch" .. math.random(10000)
    local dialogFrame = CreateFrame("Frame", frameName, UIParent)
    
    -- Apply dark theme styling manually
    dialogFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 1,
        insets = {left = 1, right = 1, top = 1, bottom = 1}
    })
    dialogFrame:SetBackdropColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 1)
    dialogFrame:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    
    local dialog = dialogFrame  -- Use dialogFrame as dialog
    dialogFrame:SetSize(700, 600)
    dialogFrame:SetPoint("CENTER")
    dialogFrame:SetFrameStrata("DIALOG")
    dialogFrame:SetFrameLevel(100)
    
    -- Make frame movable
    dialogFrame:SetMovable(true)
    dialogFrame:EnableMouse(true)
    dialogFrame:RegisterForDrag("LeftButton")
    dialogFrame:SetScript("OnDragStart", dialogFrame.StartMoving)
    dialogFrame:SetScript("OnDragStop", dialogFrame.StopMovingOrSizing)
    
    -- Add to UISpecialFrames for ESC key support
    tinsert(UISpecialFrames, frameName)
    
    -- Title
    local title = dialogFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("Advanced Teleport Search")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    
    -- Close button
    local closeBtn = CreateStyledButton(dialogFrame, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Filter Frame
    local filterFrame = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.SectionBg)
    filterFrame:SetHeight(100)
    filterFrame:SetPoint("TOPLEFT", 10, -50)
    filterFrame:SetPoint("TOPRIGHT", -10, -50)
    
    -- Search box
    local searchBox = CreateStyledSearchBox(filterFrame, 300, "Search by name...", function(text)
        TeleportSearch.ApplyFilters(dialog, text)
    end)
    searchBox:SetPoint("TOPLEFT", 10, -10)
    dialog.searchBox = searchBox
    
    -- Map filter dropdown
    local mapLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mapLabel:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", 0, -10)
    mapLabel:SetText("Map:")
    
    local mapItems = {
        { text = "All Maps", value = "all" },
        { text = "Eastern Kingdoms (0)", value = 0 },
        { text = "Kalimdor (1)", value = 1 },
        { text = "Outland (530)", value = 530 },
        { text = "Northrend (571)", value = 571 },
        { text = "Dungeons", value = "dungeons" },
        { text = "Raids", value = "raids" },
        { text = "Battlegrounds", value = "battlegrounds" }
    }
    
    local mapDropdown = CreateFullyStyledDropdown(
        filterFrame,
        150,
        mapItems,
        "All Maps",
        function(value)
            TeleportSearch.ApplyFilters(dialog, nil, value)
        end
    )
    mapDropdown:SetPoint("LEFT", mapLabel, "RIGHT", 10, 0)
    dialog.mapFilter = mapDropdown
    dialog.currentMapFilter = "all"
    
    -- Quick filters
    local quickFilterLabel = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quickFilterLabel:SetPoint("LEFT", mapDropdown, "RIGHT", 20, 0)
    quickFilterLabel:SetText("Quick Filters:")
    
    local filterButtons = {
        { text = "Cities", filter = "city" },
        { text = "Instances", filter = "instance" },
        { text = "Developer", filter = "dev" },
        { text = "GM Areas", filter = "gm" }
    }
    
    local xOffset = 0
    for _, filterInfo in ipairs(filterButtons) do
        local btn = CreateStyledButton(filterFrame, filterInfo.text, 60, 20)
        btn:SetPoint("LEFT", quickFilterLabel, "RIGHT", 10 + xOffset, 0)
        btn:SetScript("OnClick", function()
            TeleportSearch.ApplyQuickFilter(dialog, filterInfo.filter)
        end)
        xOffset = xOffset + 65
    end
    
    -- Results area
    local resultsFrame = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.OptionBg)
    resultsFrame:SetPoint("TOPLEFT", filterFrame, "BOTTOMLEFT", 0, -10)
    resultsFrame:SetPoint("BOTTOMRIGHT", dialogFrame, "BOTTOMRIGHT", -10, 40)
    
    -- Results count
    local resultCount = resultsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resultCount:SetPoint("TOPLEFT", 10, -5)
    resultCount:SetText("0 results")
    resultCount:SetTextColor(0.7, 0.7, 0.7)
    dialog.resultCount = resultCount
    
    -- Create scrollable results
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(
        resultsFrame,
        resultsFrame:GetWidth() - 10,
        resultsFrame:GetHeight() - 25
    )
    container:SetPoint("TOPLEFT", 5, -20)
    
    dialog.content = content
    dialog.updateScrollBar = updateScrollBar
    dialog.results = {}
    
    -- Bottom buttons
    local bottomFrame = CreateFrame("Frame", nil, dialogFrame)
    bottomFrame:SetHeight(30)
    bottomFrame:SetPoint("BOTTOMLEFT", 10, 5)
    bottomFrame:SetPoint("BOTTOMRIGHT", -10, 5)
    
    -- Refresh button
    local refreshBtn = CreateStyledButton(bottomFrame, "Refresh", 80, 25)
    refreshBtn:SetPoint("LEFT", 0, 0)
    refreshBtn:SetScript("OnClick", function()
        teleportCache.lastUpdate = 0 -- Force cache refresh
        TeleportSearch.LoadAllTeleports(dialog)
    end)
    
    -- Favorites button
    local favoritesBtn = CreateStyledButton(bottomFrame, "Favorites", 80, 25)
    favoritesBtn:SetPoint("LEFT", refreshBtn, "RIGHT", 10, 0)
    favoritesBtn:SetScript("OnClick", function()
        TeleportSearch.ShowFavorites(dialog)
    end)
    
    -- Recent button
    local recentBtn = CreateStyledButton(bottomFrame, "Recent", 80, 25)
    recentBtn:SetPoint("LEFT", favoritesBtn, "RIGHT", 10, 0)
    recentBtn:SetScript("OnClick", function()
        TeleportSearch.ShowRecent(dialog)
    end)
    
    -- Cancel button
    local cancelBtn = CreateStyledButton(bottomFrame, "Cancel", 80, 25)
    cancelBtn:SetPoint("RIGHT", 0, 0)
    cancelBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- ESC key handled by UISpecialFrames
    
    -- Load initial data
    TeleportSearch.LoadAllTeleports(dialog)
    
    -- Show the dialog
    dialog:Show()
    
    -- Auto-focus search box
    if searchBox.editBox then
        searchBox.editBox:SetFocus()
    end
    
    return dialog
end

-- Load all teleports (with caching)
function TeleportSearch.LoadAllTeleports(dialog)
    local currentTime = GetTime()
    
    -- Check cache validity
    if currentTime - teleportCache.lastUpdate > teleportCache.cacheTimeout then
        -- Request fresh data from server
        AIO.Handle("GameMasterSystem", "GetAllTeleportLocations")
        
        -- Show loading state
        if dialog and dialog.resultCount then
            dialog.resultCount:SetText("Loading...")
        end
    else
        -- Use cached data
        TeleportSearch.DisplayResults(dialog, teleportCache.data)
    end
end

-- Apply filters to results
function TeleportSearch.ApplyFilters(dialog, searchText, mapFilter)
    if not dialog then return end
    
    -- Update search text if provided
    if searchText ~= nil then
        dialog.currentSearch = searchText
    end
    
    -- Update map filter if provided
    if mapFilter ~= nil then
        dialog.currentMapFilter = mapFilter
    end
    
    local filtered = {}
    local search = (dialog.currentSearch or ""):lower()
    local map = dialog.currentMapFilter or "all"
    
    -- Filter the cached data
    for _, location in ipairs(teleportCache.data) do
        local include = true
        
        -- Apply search filter
        if search ~= "" then
            local nameLower = location.name:lower()
            if not string.find(nameLower, search) then
                include = false
            end
        end
        
        -- Apply map filter
        if include and map ~= "all" then
            if type(map) == "number" then
                -- Specific map ID
                if location.map ~= map then
                    include = false
                end
            elseif map == "dungeons" then
                -- Check for dungeon maps (typically instance maps)
                local dungeonMaps = {
                    [33] = true, [34] = true, [35] = true, [36] = true, -- Stormwind Stockade, etc
                    [43] = true, [47] = true, [48] = true, -- Wailing Caverns, etc
                    -- Add more dungeon map IDs as needed
                }
                if not dungeonMaps[location.map] then
                    include = false
                end
            elseif map == "raids" then
                -- Check for raid maps
                local raidMaps = {
                    [249] = true, -- Onyxia's Lair
                    [409] = true, -- Molten Core
                    [469] = true, -- Blackwing Lair
                    -- Add more raid map IDs as needed
                }
                if not raidMaps[location.map] then
                    include = false
                end
            elseif map == "battlegrounds" then
                -- Check for battleground maps
                local bgMaps = {
                    [30] = true,  -- Alterac Valley
                    [489] = true, -- Warsong Gulch
                    [529] = true, -- Arathi Basin
                    -- Add more BG map IDs as needed
                }
                if not bgMaps[location.map] then
                    include = false
                end
            end
        end
        
        if include then
            table.insert(filtered, location)
        end
    end
    
    -- Display filtered results
    TeleportSearch.DisplayResults(dialog, filtered)
end

-- Apply quick filter
function TeleportSearch.ApplyQuickFilter(dialog, filterType)
    if not dialog then return end
    
    local filtered = {}
    
    for _, location in ipairs(teleportCache.data) do
        local include = false
        local nameLower = location.name:lower()
        
        if filterType == "city" then
            -- Common city keywords
            local cities = {"stormwind", "ironforge", "darnassus", "orgrimmar", 
                           "thunder bluff", "undercity", "shattrath", "dalaran"}
            for _, city in ipairs(cities) do
                if string.find(nameLower, city) then
                    include = true
                    break
                end
            end
        elseif filterType == "instance" then
            -- Instance entrance keywords
            if string.find(nameLower, "entrance") or 
               string.find(nameLower, "instance") or
               string.find(nameLower, "dungeon") then
                include = true
            end
        elseif filterType == "dev" then
            -- Developer area keywords
            if string.find(nameLower, "test") or 
               string.find(nameLower, "dev") or
               string.find(nameLower, "qa") or
               string.find(nameLower, "unused") then
                include = true
            end
        elseif filterType == "gm" then
            -- GM area keywords
            if string.find(nameLower, "gm") or 
               string.find(nameLower, "jail") or
               string.find(nameLower, "prison") then
                include = true
            end
        end
        
        if include then
            table.insert(filtered, location)
        end
    end
    
    -- Display filtered results
    TeleportSearch.DisplayResults(dialog, filtered)
end

-- Display search results
function TeleportSearch.DisplayResults(dialog, results)
    if not dialog then return end
    
    -- Clear existing results
    if dialog.results then
        for _, btn in ipairs(dialog.results) do
            btn:Hide()
            btn:SetParent(nil)
        end
    end
    dialog.results = {}
    
    -- Update result count
    dialog.resultCount:SetText(string.format("%d results", #results))
    
    -- Create result buttons
    local yOffset = -5
    for i, location in ipairs(results) do
        local btn = CreateStyledButton(dialog.content, "", 650, 30)
        btn:SetPoint("TOPLEFT", 10, yOffset)
        
        -- Location name
        local nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nameText:SetPoint("LEFT", 10, 0)
        nameText:SetText(location.name)
        nameText:SetTextColor(1, 1, 1)
        nameText:SetJustifyH("LEFT")
        nameText:SetWidth(300)
        
        -- Map name
        local mapText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        mapText:SetPoint("CENTER", 50, 0)
        mapText:SetText(TeleportSearch.GetMapName(location.map))
        mapText:SetTextColor(0.7, 0.7, 0.7)
        
        -- Coordinates (moved left for better visibility)
        local coordText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        coordText:SetPoint("RIGHT", -60, 0)
        coordText:SetText(string.format("%.1f, %.1f, %.1f", 
            location.position_x, location.position_y, location.position_z))
        coordText:SetTextColor(0.6, 0.6, 0.6)
        
        -- Click handlers
        btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        btn:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                Teleport.TeleportToLocation(location)
                dialog:Hide()
            elseif button == "RightButton" then
                -- Show context menu
                if Teleport.ShowContextMenu then
                    Teleport.ShowContextMenu(self, location)
                end
            end
        end)
        
        -- Tooltip
        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(location.name, 1, 1, 1)
            GameTooltip:AddLine(string.format("Map: %s (%d)", 
                TeleportSearch.GetMapName(location.map), location.map), 0.8, 0.8, 0.8)
            GameTooltip:AddLine(string.format("Coordinates: %.2f, %.2f, %.2f", 
                location.position_x, location.position_y, location.position_z), 0.7, 0.7, 0.7)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click to teleport", 0, 1, 0)
            GameTooltip:AddLine("Shift+Click to add to favorites", 0.7, 0.7, 0.7)
            GameTooltip:Show()
        end)
        
        btn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        table.insert(dialog.results, btn)
        yOffset = yOffset - 32
    end
    
    -- Update content height
    dialog.content:SetHeight(math.max(400, #results * 32 + 10))
    dialog.updateScrollBar()
end

-- Get map name from ID
function TeleportSearch.GetMapName(mapId)
    local mapNames = {
        [0] = "Eastern Kingdoms",
        [1] = "Kalimdor",
        [530] = "Outland",
        [571] = "Northrend",
        -- Add more as needed
    }
    return mapNames[mapId] or string.format("Map %d", mapId)
end

-- Handle server response with all teleport data
function GameMasterSystem.ReceiveAllTeleportData(player, data)
    -- Update cache
    teleportCache.data = data or {}
    teleportCache.lastUpdate = GetTime()
    
    -- If there's an open dialog, update it
    -- (The dialog reference would need to be stored globally or passed)
end

-- Export functions
Teleport.ShowAdvancedSearch = TeleportSearch.ShowAdvancedSearch

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterUI] Teleport search module loaded")
end