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
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local GMCards = _G.GMCards

-- Player List Module
GMCards.PlayerList = GMCards.PlayerList or {}
local PlayerList = GMCards.PlayerList

-- Store Show Offline state persistently
PlayerList.showOfflineState = PlayerList.showOfflineState or false

-- List configuration
local LIST_CONFIG = {
    ROW_HEIGHT = 22,
    HEADER_HEIGHT = 28,
    MAX_VISIBLE_ROWS = 20,
    VIEW_MODE = "detailed", -- "compact" or "detailed"
    SORT_COLUMN = "name",
    SORT_ORDER = "ASC",
    COLUMNS = {
        -- Column definitions with widths (optimized to fit within 600px)
        { id = "checkbox", width = 20, text = "", sortable = false },
        { id = "status", width = 16, text = "", sortable = false },
        { id = "name", width = 100, text = "Name", sortable = true },
        { id = "level", width = 35, text = "Lvl", sortable = true },
        { id = "class", width = 60, text = "Class", sortable = true },
        { id = "race", width = 60, text = "Race", sortable = true },
        { id = "guild", width = 90, text = "Guild", sortable = true },
        { id = "zone", width = 110, text = "Zone/Last Seen", sortable = true },
        { id = "gold", width = 50, text = "Gold", sortable = true },
        { id = "actions", width = 45, text = "Actions", sortable = false }
    },
    COMPACT_COLUMNS = {
        -- Columns shown in compact mode (optimized widths)
        { id = "checkbox", width = 20, text = "", sortable = false },
        { id = "status", width = 16, text = "", sortable = false },
        { id = "name", width = 130, text = "Name", sortable = true },
        { id = "level", width = 35, text = "Lvl", sortable = true },
        { id = "class", width = 70, text = "Class", sortable = true },
        { id = "zone", width = 130, text = "Zone/Last Seen", sortable = true },
        { id = "actions", width = 45, text = "Actions", sortable = false }
    }
}

-- Helper function to convert hex color to RGB
local function hexToRGB(hex)
    if not hex then return 1, 1, 1 end
    hex = hex:gsub("#", "")
    local r = tonumber("0x" .. hex:sub(1, 2)) / 255
    local g = tonumber("0x" .. hex:sub(3, 4)) / 255
    local b = tonumber("0x" .. hex:sub(5, 6)) / 255
    return r or 1, g or 1, b or 1
end

-- Create the player list view container
function PlayerList.CreateListView(parent)
    -- Main container frame
    local listFrame = CreateFrame("Frame", nil, parent)
    listFrame:SetAllPoints()
    listFrame:Hide() -- Start hidden, will be shown when list view is selected
    
    -- Top toolbar with filters
    local toolbar = CreateFrame("Frame", nil, listFrame)
    toolbar:SetHeight(35)
    toolbar:SetPoint("TOPLEFT", 10, -10)
    toolbar:SetPoint("TOPRIGHT", -10, -10)
    
    -- Online/Offline filter checkbox using styled checkbox
    local showOfflineCheck = CreateStyledCheckbox(toolbar, "Show Offline")
    showOfflineCheck:SetWidth(120)  -- Must set width explicitly
    showOfflineCheck:SetPoint("LEFT", 5, 0)
    showOfflineCheck:SetChecked(PlayerList.showOfflineState)  -- Use persistent state
    
    -- View mode toggle button
    local viewToggle = CreateStyledButton(toolbar, "Detailed View", 100, 24)
    viewToggle:SetPoint("LEFT", showOfflineCheck, "RIGHT", 15, 0)
    viewToggle:SetScript("OnClick", function(self)
        if LIST_CONFIG.VIEW_MODE == "detailed" then
            LIST_CONFIG.VIEW_MODE = "compact"
            self:SetText("Compact View")
        else
            LIST_CONFIG.VIEW_MODE = "detailed"
            self:SetText("Detailed View")
        end
        PlayerList.RefreshDisplay()
    end)
    
    -- Class filter dropdown with fully styled dropdown
    local classFilterItems = {
        "All Classes",
        { isSeparator = true },
        { text = "Warrior", value = "Warrior" },
        { text = "Paladin", value = "Paladin" },
        { text = "Hunter", value = "Hunter" },
        { text = "Rogue", value = "Rogue" },
        { text = "Priest", value = "Priest" },
        { text = "Death Knight", value = "Death Knight" },
        { text = "Shaman", value = "Shaman" },
        { text = "Mage", value = "Mage" },
        { text = "Warlock", value = "Warlock" },
        { text = "Druid", value = "Druid" }
    }
    
    local classFilter = CreateFullyStyledDropdown(toolbar, 120, classFilterItems, "All Classes", function(value, item)
        -- Handle both string values and item tables
        local actualValue = value
        if type(item) == "table" and item.value then
            actualValue = item.value
        end
        
        if actualValue == "All Classes" then
            PlayerList.FilterByClass("all")
        else
            PlayerList.FilterByClass(actualValue)
        end
    end)
    classFilter:SetPoint("LEFT", viewToggle, "RIGHT", 10, 0)
    
    -- Search box
    local searchBox, searchEditBox = CreateStyledSearchBox(toolbar, 180, "Search players...", function(text)
        if text and text ~= "" then
            PlayerList.FilterPlayers(text:lower())
        else
            PlayerList.ShowAllPlayers()
        end
    end)
    searchBox:SetPoint("RIGHT", -5, 0)
    
    -- Selected count label
    local selectedLabel = toolbar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    selectedLabel:SetPoint("RIGHT", searchBox, "LEFT", -10, 0)
    selectedLabel:SetText("0 selected")
    selectedLabel:SetTextColor(0.7, 0.7, 0.7, 1)
    
    -- Table container
    local tableContainer = CreateStyledFrame(listFrame, UISTYLE_COLORS.OptionBg)
    tableContainer:SetPoint("TOPLEFT", toolbar, "BOTTOMLEFT", 0, -5)
    tableContainer:SetPoint("BOTTOMRIGHT", listFrame, "BOTTOMRIGHT", -10, 40)
    
    -- Create header row
    local headerRow = CreateFrame("Frame", nil, tableContainer)
    headerRow:SetHeight(LIST_CONFIG.HEADER_HEIGHT)
    headerRow:SetPoint("TOPLEFT", 2, -2)
    headerRow:SetPoint("TOPRIGHT", -20, -2)
    
    -- Header background
    local headerBg = headerRow:CreateTexture(nil, "BACKGROUND")
    headerBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    headerBg:SetVertexColor(0.2, 0.2, 0.2, 0.8)
    headerBg:SetAllPoints()
    
    -- Scroll frame for table content
    local scrollFrame = CreateFrame("ScrollFrame", nil, tableContainer)
    scrollFrame:SetPoint("TOPLEFT", headerRow, "BOTTOMLEFT", 0, -2)
    scrollFrame:SetPoint("BOTTOMRIGHT", tableContainer, "BOTTOMRIGHT", -20, 2)
    
    -- Content frame
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(scrollFrame:GetWidth())
    content:SetHeight(1) -- Will be adjusted based on content
    scrollFrame:SetScrollChild(content)
    
    -- Scrollbar
    local scrollBar = CreateStyledScrollBar(tableContainer, 16, 100)
    scrollBar:SetPoint("TOPRIGHT", headerRow, "BOTTOMRIGHT", 18, -2)
    scrollBar:SetPoint("BOTTOMRIGHT", tableContainer, "BOTTOMRIGHT", -2, 2)
    
    scrollBar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    
    -- Mouse wheel scrolling
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = scrollBar:GetValue()
        local min, max = scrollBar:GetMinMaxValues()
        local step = LIST_CONFIG.ROW_HEIGHT * 3
        
        if delta > 0 then
            scrollBar:SetValue(math.max(min, current - step))
        else
            scrollBar:SetValue(math.min(max, current + step))
        end
    end)
    
    -- Bottom bar with batch actions
    local bottomBar = CreateStyledFrame(listFrame, UISTYLE_COLORS.SectionBg)
    bottomBar:SetHeight(35)
    bottomBar:SetPoint("BOTTOMLEFT", 10, 5)
    bottomBar:SetPoint("BOTTOMRIGHT", -10, 5)
    
    -- Select all checkbox using styled checkbox
    local selectAllCheck = CreateStyledCheckbox(bottomBar, "Select All")
    selectAllCheck:SetWidth(100)  -- Must set width explicitly
    selectAllCheck:SetPoint("LEFT", 10, 0)
    
    -- Store the original OnClick handler from CreateStyledCheckbox
    local originalSelectAllClick = selectAllCheck:GetScript("OnClick")
    selectAllCheck:SetScript("OnClick", function(self)
        -- Call the original handler to toggle the visual state
        if originalSelectAllClick then
            originalSelectAllClick(self)
        end
        -- Then handle our custom logic
        PlayerList.SelectAll(self:GetChecked())
    end)
    
    -- Batch action buttons
    local batchSummon = CreateStyledButton(bottomBar, "Summon", 70, 24)
    batchSummon:SetPoint("LEFT", selectAllCheck, "RIGHT", 20, 0)
    batchSummon:SetScript("OnClick", function()
        PlayerList.BatchAction("summon")
    end)
    
    local batchMail = CreateStyledButton(bottomBar, "Mail", 60, 24)
    batchMail:SetPoint("LEFT", batchSummon, "RIGHT", 5, 0)
    batchMail:SetScript("OnClick", function()
        PlayerList.BatchAction("mail")
    end)
    
    local batchKick = CreateStyledButton(bottomBar, "Kick", 60, 24)
    batchKick:SetPoint("LEFT", batchMail, "RIGHT", 5, 0)
    batchKick:SetScript("OnClick", function()
        PlayerList.BatchAction("kick")
    end)
    
    -- Page info
    local pageInfo = bottomBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    pageInfo:SetPoint("RIGHT", -10, 0)
    pageInfo:SetText("Showing 1-10 of 10 players")
    pageInfo:SetTextColor(0.7, 0.7, 0.7, 1)
    
    -- Store references
    listFrame.toolbar = toolbar
    listFrame.showOfflineCheck = showOfflineCheck
    listFrame.viewToggle = viewToggle
    listFrame.classFilter = classFilter
    listFrame.searchBox = searchBox
    listFrame.searchEditBox = searchEditBox
    listFrame.selectedLabel = selectedLabel
    listFrame.tableContainer = tableContainer
    listFrame.headerRow = headerRow
    listFrame.scrollFrame = scrollFrame
    listFrame.content = content
    listFrame.scrollBar = scrollBar
    listFrame.bottomBar = bottomBar
    listFrame.selectAllCheck = selectAllCheck
    listFrame.pageInfo = pageInfo
    listFrame.rows = {}
    listFrame.headers = {}
    listFrame.selectedPlayers = {}
    listFrame.lastViewMode = LIST_CONFIG.VIEW_MODE  -- Store initial view mode
    
    -- Create column headers
    PlayerList.CreateHeaders(headerRow, listFrame)
    
    -- Handle offline checkbox change
    -- Store the original OnClick handler from CreateStyledCheckbox
    local originalOnClick = showOfflineCheck:GetScript("OnClick")
    showOfflineCheck:SetScript("OnClick", function(self)
        -- Call the original handler to toggle the visual state
        if originalOnClick then
            originalOnClick(self)
        end
        -- Then handle our custom logic
        local isChecked = self:GetChecked()
        print("[PlayerList] Show Offline checkbox toggled:", isChecked)
        
        -- Update persistent state
        PlayerList.showOfflineState = isChecked
        
        -- Request appropriate data
        PlayerList.RequestPlayerData()
    end)
    
    return listFrame
end

-- Create column headers
function PlayerList.CreateHeaders(headerRow, listFrame)
    local xOffset = 0
    local columns = LIST_CONFIG.VIEW_MODE == "compact" and LIST_CONFIG.COMPACT_COLUMNS or LIST_CONFIG.COLUMNS
    
    for i, column in ipairs(columns) do
        local header = CreateFrame("Button", nil, headerRow)
        header:SetHeight(LIST_CONFIG.HEADER_HEIGHT)
        header:SetWidth(column.width)
        header:SetPoint("LEFT", xOffset, 0)
        
        -- Header text
        local text = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("CENTER")
        text:SetText(column.text)
        text:SetTextColor(1, 1, 1, 1)
        
        -- Sort indicator
        if column.sortable then
            local sortIcon = header:CreateTexture(nil, "OVERLAY")
            sortIcon:SetSize(10, 10)
            sortIcon:SetPoint("RIGHT", -2, 0)
            sortIcon:Hide()
            header.sortIcon = sortIcon
            
            -- Click handler for sorting
            header:SetScript("OnClick", function()
                PlayerList.SortByColumn(column.id)
                PlayerList.UpdateSortIndicators(column.id)
            end)
            
            -- Highlight on hover
            header:SetScript("OnEnter", function(self)
                text:SetTextColor(1, 0.8, 0, 1)
            end)
            
            header:SetScript("OnLeave", function(self)
                text:SetTextColor(1, 1, 1, 1)
            end)
        end
        
        -- Column separator
        if i < #columns then
            local separator = header:CreateTexture(nil, "OVERLAY")
            separator:SetWidth(1)
            separator:SetHeight(LIST_CONFIG.HEADER_HEIGHT - 4)
            separator:SetPoint("RIGHT", 0, 0)
            separator:SetTexture("Interface\\Buttons\\WHITE8X8")
            separator:SetVertexColor(0.3, 0.3, 0.3, 0.5)
        end
        
        listFrame.headers[column.id] = header
        xOffset = xOffset + column.width
    end
end

-- Create a player row
function PlayerList.CreatePlayerRow(parent, playerData, index)
    local row = CreateFrame("Frame", nil, parent)
    row:SetHeight(LIST_CONFIG.ROW_HEIGHT)
    row:SetWidth(parent:GetWidth())
    row:SetPoint("TOPLEFT", 0, -(index - 1) * LIST_CONFIG.ROW_HEIGHT)
    
    -- Background (alternating colors)
    local bg = row:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetAllPoints()
    if index % 2 == 0 then
        bg:SetVertexColor(0.15, 0.15, 0.15, 0.3)
    else
        bg:SetVertexColor(0.1, 0.1, 0.1, 0.2)
    end
    
    -- Highlight on hover
    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
    highlight:SetVertexColor(1, 1, 1, 0.1)
    highlight:SetAllPoints()
    
    -- Class color accent strip
    local classStrip = row:CreateTexture(nil, "ARTWORK")
    classStrip:SetHeight(LIST_CONFIG.ROW_HEIGHT - 2)
    classStrip:SetWidth(3)
    classStrip:SetPoint("LEFT", 1, 0)
    classStrip:SetTexture("Interface\\Buttons\\WHITE8X8")
    local r, g, b = hexToRGB(playerData.classColor)
    classStrip:SetVertexColor(r, g, b, 0.8)
    
    -- Create clickable frame for row selection
    local rowButton = CreateFrame("Button", nil, row)
    rowButton:SetAllPoints()
    rowButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    
    -- Get columns based on view mode
    local columns = LIST_CONFIG.VIEW_MODE == "compact" and LIST_CONFIG.COMPACT_COLUMNS or LIST_CONFIG.COLUMNS
    local xOffset = 0
    
    -- Create cells for each column
    for _, column in ipairs(columns) do
        if column.id == "checkbox" then
            -- Selection checkbox using styled checkbox (smaller for table rows)
            local checkContainer = CreateFrame("Frame", nil, row)
            checkContainer:SetSize(column.width, LIST_CONFIG.ROW_HEIGHT)
            checkContainer:SetPoint("LEFT", xOffset, 0)
            
            local checkbox = CreateFrame("CheckButton", nil, checkContainer)
            checkbox:SetSize(14, 14)
            checkbox:SetPoint("CENTER")
            
            -- Style the checkbox
            checkbox:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
            checkbox:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
            checkbox:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
            checkbox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
            
            checkbox:SetScript("OnClick", function(self)
                PlayerList.ToggleSelection(playerData, self:GetChecked())
            end)
            row.checkbox = checkbox
            
        elseif column.id == "status" then
            -- Online/Offline indicator
            local statusIcon = row:CreateTexture(nil, "ARTWORK")
            statusIcon:SetSize(10, 10)
            statusIcon:SetPoint("CENTER", row, "LEFT", xOffset + column.width/2, 0)
            if playerData.online then
                statusIcon:SetTexture("Interface\\FriendsFrame\\StatusIcon-Online")
            else
                statusIcon:SetTexture("Interface\\FriendsFrame\\StatusIcon-Offline")
            end
            
        elseif column.id == "name" then
            -- Player name with class color
            local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            nameText:SetPoint("LEFT", xOffset + 5, 0)
            nameText:SetWidth(column.width - 10)
            nameText:SetJustifyH("LEFT")
            nameText:SetText(string.format("|cff%s%s|r", playerData.classColor or "FFFFFF", playerData.name))
            
        elseif column.id == "level" then
            -- Level
            local levelText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            levelText:SetPoint("CENTER", row, "LEFT", xOffset + column.width/2, 0)
            levelText:SetText(tostring(playerData.level or 1))
            levelText:SetTextColor(0.9, 0.9, 0.9, 1)
            
        elseif column.id == "class" then
            -- Class
            local classText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            classText:SetPoint("LEFT", xOffset + 5, 0)
            classText:SetWidth(column.width - 10)
            classText:SetJustifyH("LEFT")
            classText:SetText(playerData.class or "")
            classText:SetTextColor(0.8, 0.8, 0.8, 1)
            
        elseif column.id == "race" then
            -- Race (detailed view only)
            local raceText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            raceText:SetPoint("LEFT", xOffset + 5, 0)
            raceText:SetWidth(column.width - 10)
            raceText:SetJustifyH("LEFT")
            raceText:SetText(playerData.race or "")
            raceText:SetTextColor(0.7, 0.7, 0.7, 1)
            
        elseif column.id == "guild" then
            -- Guild (detailed view only)
            local guildText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            guildText:SetPoint("LEFT", xOffset + 5, 0)
            guildText:SetWidth(column.width - 10)
            guildText:SetJustifyH("LEFT")
            local guildName = playerData.guildName or "No Guild"
            if #guildName > 15 then
                guildName = string.sub(guildName, 1, 13) .. "..."
            end
            guildText:SetText(guildName)
            guildText:SetTextColor(0.6, 0.8, 0.6, 1)
            
        elseif column.id == "zone" then
            -- Zone or Last Seen
            local zoneText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            zoneText:SetPoint("LEFT", xOffset + 5, 0)
            zoneText:SetWidth(column.width - 10)
            zoneText:SetJustifyH("LEFT")
            if playerData.online then
                local zone = playerData.zone or "Unknown"
                if #zone > 18 then
                    zone = string.sub(zone, 1, 16) .. "..."
                end
                zoneText:SetText(zone)
                zoneText:SetTextColor(0.6, 0.8, 0.6, 1)
            else
                zoneText:SetText(playerData.lastSeen or "Offline")
                zoneText:SetTextColor(0.6, 0.6, 0.6, 1)
            end
            
        elseif column.id == "gold" then
            -- Gold (detailed view only)
            local goldText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            goldText:SetPoint("RIGHT", row, "LEFT", xOffset + column.width - 5, 0)
            goldText:SetJustifyH("RIGHT")
            local gold = playerData.gold or 0
            goldText:SetText(string.format("%dg", gold))
            goldText:SetTextColor(1, 0.85, 0, 1)
            
        elseif column.id == "actions" then
            -- Action buttons (smaller to fit)
            local manageBtn = CreateStyledButton(row, "...", column.width - 8, 16)
            manageBtn:SetPoint("CENTER", row, "LEFT", xOffset + column.width/2, 0)
            manageBtn:SetScript("OnClick", function()
                -- Open player management/inventory view
                PlayerList.OpenPlayerManagement(playerData)
            end)
        end
        
        xOffset = xOffset + column.width
    end
    
    -- Ban indicator overlay
    if playerData.isBanned then
        local banOverlay = row:CreateTexture(nil, "OVERLAY")
        banOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")
        banOverlay:SetVertexColor(1, 0, 0, 0.1)
        banOverlay:SetAllPoints()
        
        local banIcon = row:CreateTexture(nil, "OVERLAY")
        banIcon:SetSize(16, 16)
        banIcon:SetPoint("RIGHT", -70, 0)
        banIcon:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
    end
    
    -- Row click handlers
    rowButton:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            -- Toggle selection on left-click (no longer opens inventory)
            if IsControlKeyDown() then
                -- Multi-select with Ctrl
                local isSelected = row.checkbox:GetChecked()
                row.checkbox:SetChecked(not isSelected)
                PlayerList.ToggleSelection(playerData, not isSelected)
            else
                -- Single click toggles selection
                local wasSelected = row.checkbox:GetChecked()
                
                -- First, deselect all others
                if GMCards.playerListFrame and GMCards.playerListFrame.rows then
                    for _, otherRow in ipairs(GMCards.playerListFrame.rows) do
                        if otherRow ~= row and otherRow.checkbox then
                            otherRow.checkbox:SetChecked(false)
                            if otherRow.playerData then
                                PlayerList.ToggleSelection(otherRow.playerData, false)
                            end
                        end
                    end
                end
                
                -- Then toggle this one (if it was selected, deselect it; if not, select it)
                row.checkbox:SetChecked(not wasSelected)
                PlayerList.ToggleSelection(playerData, not wasSelected)
            end
        elseif button == "RightButton" then
            -- Show context menu
            if _G.GMMenus and _G.GMMenus.ShowContextMenu then
                _G.GMMenus.ShowContextMenu("player", self, playerData)
            end
        end
    end)
    
    -- Tooltip
    rowButton:SetScript("OnEnter", function(self)
        local lines = {
            playerData.name,
            string.format("Level %d %s %s", playerData.level or 1, playerData.race or "", playerData.class or ""),
            string.format("Guild: %s", playerData.guildName or "No Guild"),
        }
        
        if playerData.online then
            table.insert(lines, string.format("Zone: %s", playerData.zone or "Unknown"))
        else
            table.insert(lines, string.format("Last Seen: %s", playerData.lastSeen or "Unknown"))
        end
        
        table.insert(lines, string.format("Gold: %dg", playerData.gold or 0))
        
        if playerData.isBanned then
            table.insert(lines, string.format("|cffFF0000%s Banned|r", playerData.banType or ""))
        end
        
        table.insert(lines, " ")
        table.insert(lines, "Left-click to select/deselect")
        table.insert(lines, "Ctrl+Left-click to multi-select")
        table.insert(lines, "Right-click for management options")
        
        GMUtils.ShowTooltip(self, "ANCHOR_RIGHT", unpack(lines))
    end)
    
    rowButton:SetScript("OnLeave", function()
        GMUtils.HideTooltip()
    end)
    
    -- Store data reference
    row.playerData = playerData
    
    return row
end

-- Populate the list with player data
function PlayerList.PopulateList(playerData)
    if not GMCards.playerListFrame then
        return
    end
    
    local listFrame = GMCards.playerListFrame
    local content = listFrame.content
    
    -- Clear existing rows
    for _, row in ipairs(listFrame.rows) do
        row:Hide()
        row:SetParent(nil)
    end
    listFrame.rows = {}
    
    -- Only recreate headers if view mode changed
    local needsHeaderUpdate = false
    if listFrame.lastViewMode ~= LIST_CONFIG.VIEW_MODE then
        needsHeaderUpdate = true
        listFrame.lastViewMode = LIST_CONFIG.VIEW_MODE
    end
    
    -- Update headers only if needed
    if needsHeaderUpdate then
        -- Clear existing headers
        for _, header in pairs(listFrame.headers) do
            header:Hide()
            header:SetParent(nil)
        end
        wipe(listFrame.headers)
        
        -- Create new headers
        PlayerList.CreateHeaders(listFrame.headerRow, listFrame)
    end
    
    -- Apply current sort
    PlayerList.SortData(playerData)
    
    -- Create rows
    for i, player in ipairs(playerData) do
        local row = PlayerList.CreatePlayerRow(content, player, i)
        table.insert(listFrame.rows, row)
    end
    
    -- Update content height
    content:SetHeight(math.max(1, #playerData * LIST_CONFIG.ROW_HEIGHT))
    
    -- Update scrollbar range
    local maxScroll = math.max(0, content:GetHeight() - listFrame.scrollFrame:GetHeight())
    listFrame.scrollBar:SetMinMaxValues(0, maxScroll)
    listFrame.scrollBar:SetValue(0)
    
    -- Update page info
    local total = #playerData
    listFrame.pageInfo:SetText(string.format("Showing %d players", total))
    
    -- Store current data
    GMCards.currentPlayerData = playerData
end

-- Sort data by column
function PlayerList.SortData(data)
    local column = LIST_CONFIG.SORT_COLUMN
    local order = LIST_CONFIG.SORT_ORDER
    
    table.sort(data, function(a, b)
        -- Online players first
        if a.online ~= b.online then
            return a.online
        end
        
        local aVal, bVal
        
        if column == "name" then
            aVal = a.name or ""
            bVal = b.name or ""
        elseif column == "level" then
            aVal = a.level or 1
            bVal = b.level or 1
        elseif column == "class" then
            aVal = a.class or ""
            bVal = b.class or ""
        elseif column == "race" then
            aVal = a.race or ""
            bVal = b.race or ""
        elseif column == "guild" then
            aVal = a.guildName or ""
            bVal = b.guildName or ""
        elseif column == "zone" then
            aVal = a.zone or a.lastSeen or ""
            bVal = b.zone or b.lastSeen or ""
        elseif column == "gold" then
            aVal = a.gold or 0
            bVal = b.gold or 0
        else
            return false
        end
        
        -- Safe comparison to handle potential table values
        if type(aVal) == "number" and type(bVal) == "number" then
            if order == "ASC" then
                return aVal < bVal
            else
                return aVal > bVal
            end
        else
            -- String comparison (safe for potential table values)
            local strA = type(aVal) == "table" and tostring(aVal[1] or aVal.value or "") or tostring(aVal or "")
            local strB = type(bVal) == "table" and tostring(bVal[1] or bVal.value or "") or tostring(bVal or "")
            if order == "ASC" then
                return strA < strB
            else
                return strA > strB
            end
        end
    end)
end

-- Sort by column
function PlayerList.SortByColumn(columnId)
    if LIST_CONFIG.SORT_COLUMN == columnId then
        -- Toggle sort order
        LIST_CONFIG.SORT_ORDER = LIST_CONFIG.SORT_ORDER == "ASC" and "DESC" or "ASC"
    else
        -- New column, default to ascending
        LIST_CONFIG.SORT_COLUMN = columnId
        LIST_CONFIG.SORT_ORDER = "ASC"
    end
    
    if GMCards.currentPlayerData then
        PlayerList.PopulateList(GMCards.currentPlayerData)
    end
end

-- Update sort indicators
function PlayerList.UpdateSortIndicators(columnId)
    if not GMCards.playerListFrame then
        return
    end
    
    local headers = GMCards.playerListFrame.headers
    
    -- Hide all indicators
    for id, header in pairs(headers) do
        if header.sortIcon then
            header.sortIcon:Hide()
        end
    end
    
    -- Show current sort indicator
    local header = headers[columnId]
    if header and header.sortIcon then
        header.sortIcon:Show()
        if LIST_CONFIG.SORT_ORDER == "ASC" then
            header.sortIcon:SetTexture("Interface\\Buttons\\UI-SortArrow")
            header.sortIcon:SetTexCoord(0, 1, 1, 0) -- Flip vertically for up arrow
        else
            header.sortIcon:SetTexture("Interface\\Buttons\\UI-SortArrow")
            header.sortIcon:SetTexCoord(0, 1, 0, 1) -- Normal for down arrow
        end
    end
end

-- Filter players by search text
function PlayerList.FilterPlayers(searchText)
    if not GMCards.currentPlayerData then
        return
    end
    
    local filteredData = {}
    
    for _, player in ipairs(GMCards.currentPlayerData) do
        if player.name:lower():find(searchText, 1, true) or
           (player.class and player.class:lower():find(searchText, 1, true)) or
           (player.zone and player.zone:lower():find(searchText, 1, true)) or
           (player.guildName and player.guildName:lower():find(searchText, 1, true)) then
            table.insert(filteredData, player)
        end
    end
    
    PlayerList.PopulateList(filteredData)
end

-- Filter by class
function PlayerList.FilterByClass(classValue)
    if not GMCards.currentPlayerData then
        return
    end
    
    if classValue == "all" then
        PlayerList.PopulateList(GMCards.currentPlayerData)
    else
        local filteredData = {}
        for _, player in ipairs(GMCards.currentPlayerData) do
            if player.class == classValue then
                table.insert(filteredData, player)
            end
        end
        PlayerList.PopulateList(filteredData)
    end
end

-- Show all players (remove filter)
function PlayerList.ShowAllPlayers()
    if GMCards.currentPlayerData then
        PlayerList.PopulateList(GMCards.currentPlayerData)
    end
end

-- Toggle player selection
function PlayerList.ToggleSelection(playerData, selected)
    if not GMCards.playerListFrame then
        return
    end
    
    local selectedPlayers = GMCards.playerListFrame.selectedPlayers
    
    if selected then
        selectedPlayers[playerData.name] = playerData
    else
        selectedPlayers[playerData.name] = nil
    end
    
    -- Update selected count
    local count = 0
    for _ in pairs(selectedPlayers) do
        count = count + 1
    end
    
    GMCards.playerListFrame.selectedLabel:SetText(string.format("%d selected", count))
end

-- Select all players
function PlayerList.SelectAll(selected)
    if not GMCards.playerListFrame or not GMCards.playerListFrame.rows then
        return
    end
    
    GMCards.playerListFrame.selectedPlayers = {}
    
    for _, row in ipairs(GMCards.playerListFrame.rows) do
        if row.checkbox then
            row.checkbox:SetChecked(selected)
        end
        if selected and row.playerData then
            GMCards.playerListFrame.selectedPlayers[row.playerData.name] = row.playerData
        end
    end
    
    -- Update selected count
    local count = 0
    if selected then
        count = #GMCards.playerListFrame.rows
    end
    
    GMCards.playerListFrame.selectedLabel:SetText(string.format("%d selected", count))
end

-- Batch action on selected players
function PlayerList.BatchAction(action)
    if not GMCards.playerListFrame then
        return
    end
    
    local selectedPlayers = GMCards.playerListFrame.selectedPlayers
    local playerNames = {}
    
    for name, data in pairs(selectedPlayers) do
        table.insert(playerNames, name)
    end
    
    if #playerNames == 0 then
        print("No players selected")
        return
    end
    
    -- Send batch action to server
    if action == "summon" then
        -- Confirm summon action
        if #playerNames > 5 then
            -- Show confirmation for large batches
            StaticPopup_Show("CONFIRM_BATCH_SUMMON", #playerNames, nil, {
                playerNames = playerNames,
                action = function()
                    AIO.Handle("GameMasterSystem", "batchSummon", playerNames)
                end
            })
        else
            AIO.Handle("GameMasterSystem", "batchSummon", playerNames)
        end
    elseif action == "mail" then
        -- For mail, we need to open a dialog for single target
        if #playerNames == 1 then
            -- Single player - open mail dialog
            if GameMasterSystem.OpenMailDialog then
                GameMasterSystem.OpenMailDialog(playerNames[1])
            end
        else
            -- Multiple players - show error as mail needs individual handling
            print("|cffff0000Error:|r Mail can only be sent to one player at a time. Please select a single player.")
        end
    elseif action == "kick" then
        -- Confirm kick action
        if #playerNames > 5 then
            -- Show confirmation for large batches
            StaticPopup_Show("CONFIRM_BATCH_KICK", #playerNames, nil, {
                playerNames = playerNames,
                action = function()
                    AIO.Handle("GameMasterSystem", "batchKick", playerNames)
                end
            })
        else
            AIO.Handle("GameMasterSystem", "batchKick", playerNames)
        end
    end
end

-- Open player management/inventory view
function PlayerList.OpenPlayerManagement(playerData)
    -- Store selected player
    GMCards.selectedPlayer = playerData
    
    print(string.format("Managing player: %s", playerData.name))
    
    -- Request inventory data and open management view
    if playerData.online then
        AIO.Handle("GameMasterSystem", "getPlayerInventory", playerData.name)
    end
    
    -- Open the inventory/equipment modal if available
    if _G.PlayerInventory and _G.PlayerInventory.showInventoryModal then
        _G.PlayerInventory.showInventoryModal(playerData.name)
    elseif _G.GMMenus and _G.GMMenus.ShowPlayerManagement then
        -- Fallback to general management panel
        _G.GMMenus.ShowPlayerManagement(playerData)
    end
end

-- Refresh display (called when view mode changes)
function PlayerList.RefreshDisplay()
    if not GMCards.playerListFrame then
        return
    end
    
    -- Recreate headers with new column layout
    local headerRow = GMCards.playerListFrame.headerRow
    
    -- Clear existing headers
    for _, header in pairs(GMCards.playerListFrame.headers) do
        header:Hide()
        header:SetParent(nil)
    end
    GMCards.playerListFrame.headers = {}
    
    -- Create new headers
    PlayerList.CreateHeaders(headerRow, GMCards.playerListFrame)
    
    -- Repopulate list with current data
    if GMCards.currentPlayerData then
        PlayerList.PopulateList(GMCards.currentPlayerData)
    end
end

-- Centralized function to request player data based on Show Offline state
function PlayerList.RequestPlayerData()
    -- Clear current data to force a refresh
    if GMData.DataStore then
        GMData.DataStore.players = nil
    end
    if GMCards then
        GMCards.currentPlayerData = nil
    end
    
    -- Request data based on Show Offline state
    if PlayerList.showOfflineState then
        -- Show all players (online + offline)
        print("[PlayerList] Requesting all players (online + offline)")
        AIO.Handle("GameMasterSystem", "getAllPlayerData", 0, 100, "ASC")
    else
        -- Show only online players
        print("[PlayerList] Requesting online players only")
        AIO.Handle("GameMasterSystem", "refreshPlayerData")
    end
end

-- Toggle between grid and list view
function PlayerList.ToggleView(viewType)
    if not GMCards.playerGridFrame or not GMCards.playerListFrame then
        return
    end
    
    if viewType == "list" then
        GMCards.playerGridFrame:Hide()
        GMCards.playerListFrame:Show()
        GMCards.currentViewMode = "list"
        
        -- Populate list with current data
        if GMCards.currentPlayerData then
            PlayerList.PopulateList(GMCards.currentPlayerData)
        end
    else
        GMCards.playerListFrame:Hide()
        GMCards.playerGridFrame:Show()
        GMCards.currentViewMode = "grid"
    end
end

-- Get the current Show Offline state
function PlayerList.GetShowOfflineState()
    return PlayerList.showOfflineState
end

-- Set the Show Offline state (used when loading saved preferences)
function PlayerList.SetShowOfflineState(state)
    PlayerList.showOfflineState = state
    -- Update checkbox if it exists
    if GMCards.playerListFrame and GMCards.playerListFrame.showOfflineCheck then
        GMCards.playerListFrame.showOfflineCheck:SetChecked(state)
    end
end

-- Initialize the player list module
function PlayerList.Initialize()
    -- print("[GameMasterSystem] Player list module initialized")
end

-- Initialize on load
PlayerList.Initialize()