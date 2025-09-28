local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize EntitySelectionDialog namespace
_G.EntitySelectionDialog = _G.EntitySelectionDialog or {}
local EntitySelectionDialog = _G.EntitySelectionDialog

-- Get references
local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local ObjectEditor = _G.ObjectEditor

-- Configuration
EntitySelectionDialog.CONFIG = {
    DIALOG_WIDTH = 550,
    DIALOG_HEIGHT = 650,
    ITEM_HEIGHT = 32,
    MAX_VISIBLE_ITEMS = 15,
    REFRESH_RANGE = 50, -- yards
    COLORS = {
        CLOSE = "|cFF00FF00",    -- Green for < 10 yards
        MEDIUM = "|cFFFFFF00",   -- Yellow for 10-20 yards
        FAR = "|cFFFF8800",      -- Orange for 20-30 yards
        VERY_FAR = "|cFFFF0000", -- Red for > 30 yards
    },
    ENTITY_ICONS = {
        Creature = "Interface\\Icons\\INV_Pet_BabyBlizzardBear",
        GameObject = "Interface\\Icons\\INV_Box_01",
    }
}

-- Current state
EntitySelectionDialog.currentFilter = "All" -- "All", "Creatures", "Objects"
EntitySelectionDialog.entities = {}
EntitySelectionDialog.filteredEntities = {}
EntitySelectionDialog.searchText = ""
EntitySelectionDialog.selectedEntity = nil

-- Create the main selection dialog
function EntitySelectionDialog.CreateDialog()
    if EntitySelectionDialog.dialog then
        return EntitySelectionDialog.dialog
    end
    
    local CONFIG = EntitySelectionDialog.CONFIG
    
    -- Main dialog frame (no modal overlay)
    local dialog = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(CONFIG.DIALOG_WIDTH, CONFIG.DIALOG_HEIGHT)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
    dialog:SetFrameLevel(100)
    dialog:SetMovable(true)
    dialog:EnableMouse(true)
    
    -- Title bar for dragging
    local titleBar = CreateFrame("Frame", nil, dialog)
    titleBar:SetHeight(40)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() dialog:StartMoving() end)
    titleBar:SetScript("OnDragStop", function() dialog:StopMovingOrSizing() end)
    
    -- Title text
    local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", titleBar, "TOP", 0, -12)
    title:SetText("Edit Nearby Entities")
    title:SetTextColor(1, 1, 1)  -- Ensure white text
    
    -- Refresh button (R) - positioned left of close button
    local refreshBtn = CreateStyledButton(dialog, "R", 24, 24)
    refreshBtn:SetPoint("TOPRIGHT", -36, -8)
    refreshBtn:SetScript("OnClick", function(self)
        -- Simple visual feedback - change color temporarily
        self.text:SetTextColor(0, 1, 0)  -- Green during refresh
        
        -- Use OnUpdate to restore color after a short time
        local elapsed = 0
        self:SetScript("OnUpdate", function(btn, delta)
            elapsed = elapsed + delta
            if elapsed > 0.3 then
                btn.text:SetTextColor(1, 1, 1)  -- Restore white color
                btn:SetScript("OnUpdate", nil)
            end
        end)
        
        EntitySelectionDialog.RefreshEntities()
    end)
    refreshBtn:SetTooltip("Refresh", "Refresh the entity list (Ctrl+R)")
    
    -- Close button
    local closeBtn = CreateStyledButton(dialog, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", -8, -8)
    closeBtn:SetScript("OnClick", function()
        dialog:Hide()
        EntitySelectionDialog.CleanUp()
    end)
    
    -- Filter buttons container
    local filterContainer = CreateFrame("Frame", nil, dialog)
    filterContainer:SetHeight(30)
    filterContainer:SetPoint("TOPLEFT", dialog, "TOPLEFT", 15, -50)
    filterContainer:SetPoint("TOPRIGHT", dialog, "TOPRIGHT", -15, -50)
    
    -- Filter buttons
    local filterButtons = {}
    local filters = {"All", "Creatures", "Objects"}
    local buttonWidth = 100
    
    for i, filterName in ipairs(filters) do
        local btn = CreateStyledButton(filterContainer, filterName, buttonWidth, 26)
        btn:SetPoint("LEFT", filterContainer, "LEFT", (i-1) * (buttonWidth + 5), 0)
        
        btn.filterType = filterName
        btn:SetScript("OnClick", function(self)
            EntitySelectionDialog.SetFilter(self.filterType)
            -- Update button states
            for _, b in pairs(filterButtons) do
                if b == self then
                    b:LockHighlight()
                else
                    b:UnlockHighlight()
                end
            end
        end)
        
        filterButtons[filterName] = btn
        
        -- Set initial state
        if filterName == "All" then
            btn:LockHighlight()
        end
    end
    
    dialog.filterButtons = filterButtons
    
    -- Search box
    local searchBox = CreateStyledSearchBox(dialog, 380, "Search by name or ID...", function(text)
        EntitySelectionDialog.searchText = text
        EntitySelectionDialog.ApplyFilters()
    end)
    searchBox:SetPoint("TOP", filterContainer, "BOTTOM", 0, -10)
    
    -- Result count label
    local resultCount = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resultCount:SetPoint("LEFT", searchBox, "RIGHT", 10, 0)
    resultCount:SetTextColor(0.7, 0.7, 0.7)
    resultCount:SetText("0 entities")
    dialog.resultCountLabel = resultCount
    
    -- Create scrollable content area
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(dialog, 
        CONFIG.DIALOG_WIDTH - 40, 
        CONFIG.DIALOG_HEIGHT - 180)
    container:SetPoint("TOP", searchBox, "BOTTOM", 0, -10)
    
    -- Store references
    dialog.content = content
    dialog.updateScrollBar = updateScrollBar
    dialog.listItems = {}
    
    -- Bottom bar for range slider
    local bottomBar = CreateFrame("Frame", nil, dialog)
    bottomBar:SetHeight(40)
    bottomBar:SetPoint("BOTTOMLEFT", dialog, "BOTTOMLEFT", 15, 10)
    bottomBar:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -15, 10)
    
    -- Range slider using styled slider
    local rangeSliderContainer = CreateFrame("Frame", nil, bottomBar)
    rangeSliderContainer:SetSize(250, 30)
    rangeSliderContainer:SetPoint("CENTER", bottomBar, "CENTER", 0, 0)
    
    -- Create the styled slider
    local rangeSlider = CreateStyledSlider and CreateStyledSlider(rangeSliderContainer, 150, 20, 10, 100, 10, CONFIG.REFRESH_RANGE) or nil
    
    if rangeSlider then
        rangeSlider:SetPoint("CENTER", rangeSliderContainer, "CENTER", 0, 0)
        rangeSlider:SetLabel("Range")
        rangeSlider:SetValueText("%.0f yds")
        rangeSlider:SetOnValueChanged(function(value)
            EntitySelectionDialog.CONFIG.REFRESH_RANGE = value
        end)
    else
        -- Fallback to basic slider if styled slider not available
        local rangeLabel = rangeSliderContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rangeLabel:SetPoint("LEFT", 0, 0)
        rangeLabel:SetText("Range:")
        
        local basicSlider = CreateFrame("Slider", nil, rangeSliderContainer, "OptionsSliderTemplate")
        basicSlider:SetSize(120, 16)
        basicSlider:SetPoint("LEFT", rangeLabel, "RIGHT", 5, 0)
        basicSlider:SetOrientation("HORIZONTAL")
        basicSlider:SetMinMaxValues(10, 100)
        basicSlider:SetValue(CONFIG.REFRESH_RANGE)
        basicSlider:SetValueStep(10)
        basicSlider:SetScript("OnValueChanged", function(self, value)
            EntitySelectionDialog.CONFIG.REFRESH_RANGE = value
            dialog.rangeText:SetText(value .. " yds")
        end)
        
        local rangeText = rangeSliderContainer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        rangeText:SetPoint("LEFT", basicSlider, "RIGHT", 5, 0)
        rangeText:SetText(CONFIG.REFRESH_RANGE .. " yds")
        dialog.rangeText = rangeText
    end
    
    -- Enable keyboard input for shortcuts
    dialog:EnableKeyboard(true)
    dialog:SetScript("OnKeyDown", function(self, key)
        -- Check for Ctrl+R
        if key == "R" and IsControlKeyDown() then
            -- Trigger refresh with visual feedback
            if refreshBtn then
                refreshBtn.text:SetTextColor(0, 1, 0)  -- Green during refresh
                
                -- Use OnUpdate to restore color after a short time
                local elapsed = 0
                refreshBtn:SetScript("OnUpdate", function(btn, delta)
                    elapsed = elapsed + delta
                    if elapsed > 0.3 then
                        btn.text:SetTextColor(1, 1, 1)  -- Restore white color
                        btn:SetScript("OnUpdate", nil)
                    end
                end)
            end
            
            EntitySelectionDialog.RefreshEntities()
        elseif key == "ESCAPE" then
            -- Close on Escape
            dialog:Hide()
            EntitySelectionDialog.CleanUp()
        end
    end)
    
    -- Store references
    EntitySelectionDialog.dialog = dialog
    EntitySelectionDialog.refreshBtn = refreshBtn
    
    return dialog
end

-- Create a list item for an entity
function EntitySelectionDialog.CreateListItem(parent, entity, index)
    local CONFIG = EntitySelectionDialog.CONFIG
    
    local item = CreateFrame("Button", nil, parent)
    item:SetSize(parent:GetWidth() - 10, CONFIG.ITEM_HEIGHT)
    item:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, -((index - 1) * (CONFIG.ITEM_HEIGHT + 2)))
    
    -- Background
    local bg = item:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
    bg:SetVertexColor(0.2, 0.2, 0.2, 0.5)
    bg:Hide()
    item.bg = bg
    
    -- Hover effect
    item:SetScript("OnEnter", function(self)
        self.bg:Show()
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        EntitySelectionDialog.ShowEntityTooltip(self.entity)
        GameTooltip:Show()
    end)
    
    item:SetScript("OnLeave", function(self)
        self.bg:Hide()
        GameTooltip:Hide()
    end)
    
    -- Icon
    local icon = item:CreateTexture(nil, "ARTWORK")
    icon:SetSize(24, 24)
    icon:SetPoint("LEFT", item, "LEFT", 4, 0)
    icon:SetTexture(CONFIG.ENTITY_ICONS[entity.entityType] or "Interface\\Icons\\INV_Misc_QuestionMark")
    item.icon = icon
    
    -- Entity type indicator with better logic
    local typeText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    typeText:SetPoint("LEFT", icon, "RIGHT", 4, 8)
    -- Improved logic to handle entityType properly
    local typeLabel = "[???]" -- Default for unknown
    if entity.entityType == "Creature" then
        typeLabel = "[NPC]"
    elseif entity.entityType == "GameObject" then
        typeLabel = "[OBJ]"
    else
        -- Fallback: log unexpected type
        print(string.format("[EntitySelectionDialog] Unexpected entityType: %s for entity %s (Entry: %d)", 
            tostring(entity.entityType), entity.name or "Unknown", entity.entry or 0))
    end
    typeText:SetText(typeLabel)
    typeText:SetTextColor(0.6, 0.6, 0.6)
    
    -- Name and ID
    local nameText = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", icon, "RIGHT", 4, -4)
    nameText:SetPoint("RIGHT", item, "RIGHT", -80, -4)
    nameText:SetJustifyH("LEFT")
    
    local displayName = entity.name or ("Unknown " .. entity.entityType)
    if string.len(displayName) > 30 then
        displayName = string.sub(displayName, 1, 27) .. "..."
    end
    -- Use color codes: white for name, gray for ID
    nameText:SetText(string.format("|cFFFFFFFF%s|r |cFFAAAAAA(%d)|r", displayName, entity.entry))
    
    -- Distance with color coding
    local distanceText = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    distanceText:SetPoint("RIGHT", item, "RIGHT", -8, 0)
    distanceText:SetJustifyH("RIGHT")
    
    local color = EntitySelectionDialog.GetDistanceColor(entity.distance)
    distanceText:SetText(string.format("%s%.1f yds|r", color, entity.distance))
    
    -- Click handlers
    item:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            -- Open editor
            EntitySelectionDialog.EditEntity(self.entity)
        elseif button == "RightButton" then
            -- Show context menu
            EntitySelectionDialog.ShowContextMenu(self.entity, self)
        end
    end)
    
    -- Store entity reference
    item.entity = entity
    
    return item
end

-- Get color based on distance
function EntitySelectionDialog.GetDistanceColor(distance)
    local COLORS = EntitySelectionDialog.CONFIG.COLORS
    if distance < 10 then
        return COLORS.CLOSE
    elseif distance < 20 then
        return COLORS.MEDIUM
    elseif distance < 30 then
        return COLORS.FAR
    else
        return COLORS.VERY_FAR
    end
end

-- Show entity tooltip
function EntitySelectionDialog.ShowEntityTooltip(entity)
    GameTooltip:AddLine(entity.name or "Unknown", 1, 1, 1)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine("Type:", entity.entityType, 0.7, 0.7, 0.7, 1, 1, 1)
    GameTooltip:AddDoubleLine("Entry ID:", entity.entry, 0.7, 0.7, 0.7, 1, 1, 1)
    GameTooltip:AddDoubleLine("GUID:", entity.guid, 0.7, 0.7, 0.7, 1, 1, 1)
    GameTooltip:AddDoubleLine("Distance:", string.format("%.1f yards", entity.distance), 0.7, 0.7, 0.7, 1, 1, 1)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine("Position:", string.format("%.1f, %.1f, %.1f", entity.x, entity.y, entity.z), 0.7, 0.7, 0.7, 0.8, 0.8, 0.8)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Left-click to edit", 1, 1, 1)
    GameTooltip:AddLine("Right-click for more options", 1, 1, 1)
end

-- Show context menu for entity
function EntitySelectionDialog.ShowContextMenu(entity, anchor)
    local menu = {
        {
            text = entity.name or ("Unknown " .. entity.entityType),
            isTitle = true,
            notCheckable = true,
        },
        {
            text = "Edit",
            func = function() EntitySelectionDialog.EditEntity(entity) end,
            notCheckable = true,
        },
        {
            text = "Delete from World",
            func = function() EntitySelectionDialog.DeleteEntity(entity) end,
            notCheckable = true,
        },
        {
            text = "Duplicate",
            func = function() EntitySelectionDialog.DuplicateEntity(entity) end,
            notCheckable = true,
        },
        {
            text = "",
            disabled = true,
            notCheckable = true,
        },
        {
            text = "Teleport to Entity",
            func = function() EntitySelectionDialog.TeleportToEntity(entity) end,
            notCheckable = true,
        },
        {
            text = "Copy Position",
            func = function() EntitySelectionDialog.CopyPosition(entity) end,
            notCheckable = true,
        },
        {
            text = "",
            disabled = true,
            notCheckable = true,
        },
        {
            text = "Cancel",
            notCheckable = true,
        },
    }
    
    EasyMenu(menu, CreateFrame("Frame"), "cursor", 0, 0, "MENU")
end

-- Entity actions
function EntitySelectionDialog.EditEntity(entity)
    print(string.format("[EntitySelectionDialog] EditEntity called for %s: %s (Entry: %d, GUID: %s, Type: %s)", 
        entity.entityType or "Unknown", 
        entity.name or "Unknown", 
        entity.entry or 0, 
        tostring(entity.guid), 
        entity.entityType or "nil"))
    
    if entity.entityType == "Creature" then
        print(string.format("[EntitySelectionDialog] Sending creature edit request for GUID: %s", tostring(entity.guid)))
        AIO.Handle("GameMasterSystem", "getCreatureForEdit", entity.guid)
    else
        print(string.format("[EntitySelectionDialog] Sending GameObject edit request for GUID: %s", tostring(entity.guid)))
        AIO.Handle("GameMasterSystem", "getGameObjectForEdit", entity.guid)
    end
    -- Close dialog after selecting
    if EntitySelectionDialog.dialog then
        EntitySelectionDialog.dialog:Hide()
        EntitySelectionDialog.CleanUp()
    end
end

function EntitySelectionDialog.DeleteEntity(entity)
    StaticPopup_Show("GM_CONFIRM_DELETE_ENTITY", entity.name or "this entity", nil, {
        entity = entity,
        callback = function()
            if entity.entityType == "Creature" then
                AIO.Handle("GameMasterSystem", "deleteCreatureFromWorld", entity.guid)
            else
                AIO.Handle("GameMasterSystem", "deleteGameObjectFromWorld", entity.guid)
            end
            -- Refresh list after deletion
            C_Timer.After(0.5, function()
                EntitySelectionDialog.RefreshEntities()
            end)
        end
    })
end

function EntitySelectionDialog.DuplicateEntity(entity)
    if entity.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "duplicateCreatureAtPosition", entity.entry, entity.x, entity.y, entity.z, entity.o)
    else
        AIO.Handle("GameMasterSystem", "duplicateGameObjectAtPosition", entity.entry, entity.x, entity.y, entity.z, entity.o)
    end
    -- Refresh list after duplication
    C_Timer.After(0.5, function()
        EntitySelectionDialog.RefreshEntities()
    end)
end

function EntitySelectionDialog.TeleportToEntity(entity)
    AIO.Handle("GameMasterSystem", "teleportToPosition", entity.x, entity.y, entity.z)
end

function EntitySelectionDialog.CopyPosition(entity)
    local posText = string.format("%.2f %.2f %.2f %.2f", entity.x, entity.y, entity.z, entity.o or 0)
    DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF00FF00Position copied: %s|r", posText))
    -- Also send to server for potential clipboard functionality
    AIO.Handle("GameMasterSystem", "copyPositionToClipboard", posText)
end

-- Filter and search
function EntitySelectionDialog.SetFilter(filterType)
    EntitySelectionDialog.currentFilter = filterType
    EntitySelectionDialog.ApplyFilters()
end

function EntitySelectionDialog.ApplyFilters()
    EntitySelectionDialog.filteredEntities = {}
    
    for _, entity in ipairs(EntitySelectionDialog.entities) do
        local passFilter = true
        
        -- Apply type filter
        if EntitySelectionDialog.currentFilter ~= "All" then
            if EntitySelectionDialog.currentFilter == "Creatures" and entity.entityType ~= "Creature" then
                passFilter = false
            elseif EntitySelectionDialog.currentFilter == "Objects" and entity.entityType ~= "GameObject" then
                passFilter = false
            end
        end
        
        -- Apply search filter
        if passFilter and EntitySelectionDialog.searchText and EntitySelectionDialog.searchText ~= "" then
            local searchLower = string.lower(EntitySelectionDialog.searchText)
            local nameLower = string.lower(entity.name or "")
            local entryStr = tostring(entity.entry)
            
            if not (string.find(nameLower, searchLower, 1, true) or string.find(entryStr, searchLower, 1, true)) then
                passFilter = false
            end
        end
        
        if passFilter then
            table.insert(EntitySelectionDialog.filteredEntities, entity)
        end
    end
    
    EntitySelectionDialog.UpdateDisplay()
end

-- Update the display
function EntitySelectionDialog.UpdateDisplay()
    if not EntitySelectionDialog.dialog then return end
    
    local content = EntitySelectionDialog.dialog.content
    
    -- Clear existing items
    for _, item in ipairs(EntitySelectionDialog.dialog.listItems) do
        item:Hide()
        item:SetParent(nil)
    end
    EntitySelectionDialog.dialog.listItems = {}
    
    -- Create new items
    for i, entity in ipairs(EntitySelectionDialog.filteredEntities) do
        local item = EntitySelectionDialog.CreateListItem(content, entity, i)
        table.insert(EntitySelectionDialog.dialog.listItems, item)
    end
    
    -- Update content height
    local totalHeight = #EntitySelectionDialog.filteredEntities * (EntitySelectionDialog.CONFIG.ITEM_HEIGHT + 2)
    content:SetHeight(math.max(totalHeight, 400))
    
    -- Update scroll bar
    if EntitySelectionDialog.dialog.updateScrollBar then
        EntitySelectionDialog.dialog.updateScrollBar()
    end
    
    -- Update result count
    if EntitySelectionDialog.dialog.resultCountLabel then
        local text = string.format("%d %s", 
            #EntitySelectionDialog.filteredEntities,
            #EntitySelectionDialog.filteredEntities == 1 and "entity" or "entities")
        EntitySelectionDialog.dialog.resultCountLabel:SetText(text)
    end
end

-- Refresh entities from server
function EntitySelectionDialog.RefreshEntities()
    print(string.format("[EntitySelectionDialog] Requesting entities with range: %d", EntitySelectionDialog.CONFIG.REFRESH_RANGE))
    -- Request nearby entities from server
    AIO.Handle("GameMasterSystem", "getNearbyEntities", EntitySelectionDialog.CONFIG.REFRESH_RANGE)
    
    -- Show loading state
    if EntitySelectionDialog.dialog and EntitySelectionDialog.dialog.resultCountLabel then
        EntitySelectionDialog.dialog.resultCountLabel:SetText("Loading...")
    end
end

-- Handle entity data from server
function EntitySelectionDialog.ReceiveEntities(entities)
    print(string.format("[EntitySelectionDialog] Received %d entities from server", entities and #entities or 0))
    EntitySelectionDialog.entities = entities or {}
    
    -- Debug: Log entity types
    if entities and #entities > 0 then
        for i, entity in ipairs(entities) do
            if i <= 5 then -- Log first 5 entities for debugging
                print(string.format("[EntitySelectionDialog] Entity %d: %s (Entry: %d, Type: %s)", 
                    i, entity.name or "Unknown", entity.entry or 0, entity.entityType or "nil"))
            end
        end
    end
    
    -- Sort by distance
    table.sort(EntitySelectionDialog.entities, function(a, b)
        return a.distance < b.distance
    end)
    
    EntitySelectionDialog.ApplyFilters()
end

-- Open the dialog
function EntitySelectionDialog.Open()
    print("[EntitySelectionDialog] Opening entity selection dialog")
    if not EntitySelectionDialog.dialog then
        print("[EntitySelectionDialog] Creating dialog for first time")
        EntitySelectionDialog.CreateDialog()
    end
    
    if EntitySelectionDialog.dialog then
        EntitySelectionDialog.dialog:Show()
        EntitySelectionDialog.RefreshEntities()
    else
        print("[EntitySelectionDialog] ERROR: Dialog not created!")
    end
end

-- Clean up
function EntitySelectionDialog.CleanUp()
    EntitySelectionDialog.entities = {}
    EntitySelectionDialog.filteredEntities = {}
    EntitySelectionDialog.searchText = ""
    EntitySelectionDialog.selectedEntity = nil
end

-- Register delete confirmation popup
StaticPopupDialogs["GM_CONFIRM_DELETE_ENTITY"] = {
    text = "Are you sure you want to delete %s from the world?",
    button1 = "Delete",
    button2 = "Cancel",
    OnAccept = function(self, data)
        if data and data.callback then
            data.callback()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Initialize
if not EntitySelectionDialog.initialized then
    EntitySelectionDialog.initialized = true
    -- print("[EntitySelectionDialog] Entity Selection Dialog module loaded")
end