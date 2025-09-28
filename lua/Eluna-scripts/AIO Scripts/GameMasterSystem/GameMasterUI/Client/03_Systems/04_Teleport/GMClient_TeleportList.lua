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

local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Create Teleport namespace
GameMasterSystem.Teleport = GameMasterSystem.Teleport or {}
local Teleport = GameMasterSystem.Teleport

-- Local variables
local teleportModal = nil
local currentPage = 1
local pageSize = 20
local totalPages = 1
local teleportData = {}
local searchText = ""
local isSearching = false

-- Create the main teleport list modal
function Teleport.ShowTeleportList(targetPlayer)
    -- Close existing modal if open
    if teleportModal and teleportModal:IsShown() then
        teleportModal:Hide()
    end
    
    -- Store target player (if teleporting someone else)
    Teleport.targetPlayer = targetPlayer
    
    -- Reset state
    currentPage = 1
    searchText = ""
    isSearching = false
    
    -- Create main frame with a global name for UISpecialFrames
    local frameName = "GameMasterTeleportList" .. math.random(10000)
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
    
    teleportModal = dialogFrame  -- Store reference as teleportModal
    dialogFrame:SetSize(600, 650)
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
    if targetPlayer then
        title:SetText("Teleport " .. targetPlayer .. " to Location")
    else
        title:SetText("Teleport to Location")
    end
    title:SetTextColor(1, 1, 1)  -- White color for title
    
    -- Refresh button (R) - positioned left of close button
    local refreshBtn = CreateStyledButton(dialogFrame, "R", 24, 24)
    refreshBtn:SetPoint("TOPRIGHT", -32, -5)
    refreshBtn:SetScript("OnClick", function(self)
        -- Simple visual feedback - change color temporarily
        self.text:SetTextColor(0, 1, 0)  -- Green during refresh
        
        -- Use OnUpdate to restore color after a short time
        local elapsed = 0
        refreshBtn:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 0.5 then
                self.text:SetTextColor(1, 1, 1)  -- Back to white
                self:SetScript("OnUpdate", nil)  -- Remove the OnUpdate handler
            end
        end)
        
        -- Refresh the teleport data
        currentPage = 1  -- Reset to first page
        Teleport.RequestTeleportData()
    end)
    refreshBtn:SetTooltip("Refresh (Ctrl+R)", "Reload teleport locations from server")
    
    -- Close button
    local closeBtn = CreateStyledButton(dialogFrame, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        teleportModal:Hide()
    end)
    
    -- Enable keyboard input for Ctrl+R functionality
    dialogFrame:EnableKeyboard(true)
    dialogFrame:SetScript("OnKeyDown", function(self, key)
        if key == "R" and IsControlKeyDown() and not IsAltKeyDown() and not IsShiftKeyDown() then
            -- Trigger refresh button click for visual feedback
            if refreshBtn then
                refreshBtn:Click()
            end
        elseif key == "ESCAPE" then
            -- Let ESC key work normally to close the frame
            self:Hide()
        end
    end)
    
    -- Create controls frame for search and sort
    local controlsFrame = CreateFrame("Frame", nil, dialogFrame)
    controlsFrame:SetHeight(30)
    controlsFrame:SetPoint("TOPLEFT", dialogFrame, "TOPLEFT", 10, -40)
    controlsFrame:SetPoint("TOPRIGHT", dialogFrame, "TOPRIGHT", -10, -40)
    
    -- Search box (left side)
    local searchBox = CreateStyledSearchBox(controlsFrame, 300, "Search teleport locations...", function(text)
        Teleport.OnSearchTextChanged(text)
    end)
    searchBox:SetPoint("LEFT", 0, 0)
    teleportModal.searchBox = searchBox
    
    -- Sort dropdown (right side)
    local sortItems = {
        { text = "Newest First", value = "id_desc" },
        { text = "Oldest First", value = "id_asc" },
        { text = "Name (A-Z)", value = "name_asc" },
        { text = "Name (Z-A)", value = "name_desc" },
        { text = "Map ID", value = "map_asc" }
    }
    
    local sortDropdown = CreateFullyStyledDropdown(
        controlsFrame,
        140,
        sortItems,
        "Newest First",
        function(value)
            Teleport.sortOrder = value
            currentPage = 1  -- Reset to first page
            Teleport.RequestTeleportData()
        end
    )
    sortDropdown:SetPoint("RIGHT", 0, 0)
    teleportModal.sortDropdown = sortDropdown
    
    -- Initialize sort order
    Teleport.sortOrder = "id_desc"
    
    -- Result count and page info
    local infoFrame = CreateFrame("Frame", nil, dialogFrame)
    infoFrame:SetHeight(20)
    infoFrame:SetPoint("TOPLEFT", controlsFrame, "BOTTOMLEFT", 0, -5)
    infoFrame:SetPoint("TOPRIGHT", controlsFrame, "BOTTOMRIGHT", 0, -5)
    
    local resultCount = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resultCount:SetPoint("LEFT", 0, 0)
    resultCount:SetTextColor(0.7, 0.7, 0.7)
    resultCount:SetText("Loading...")
    teleportModal.resultCount = resultCount
    
    local pageInfo = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    pageInfo:SetPoint("RIGHT", 0, 0)
    pageInfo:SetTextColor(0.7, 0.7, 0.7)
    pageInfo:SetText("Page 1 / 1")
    teleportModal.pageInfo = pageInfo
    
    -- Create scrollable content area
    local contentFrame = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.OptionBg)
    contentFrame:SetPoint("TOPLEFT", infoFrame, "BOTTOMLEFT", 0, -5)
    contentFrame:SetPoint("BOTTOMRIGHT", dialogFrame, "BOTTOMRIGHT", -10, 50)
    
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(
        contentFrame,
        contentFrame:GetWidth() - 10,
        contentFrame:GetHeight() - 10
    )
    container:SetPoint("TOPLEFT", 5, -5)
    
    teleportModal.content = content
    teleportModal.updateScrollBar = updateScrollBar
    teleportModal.teleportButtons = {}
    
    -- Pagination controls
    local paginationFrame = CreateFrame("Frame", nil, dialogFrame)
    paginationFrame:SetHeight(30)
    paginationFrame:SetPoint("BOTTOMLEFT", dialogFrame, "BOTTOMLEFT", 10, 10)
    paginationFrame:SetPoint("BOTTOMRIGHT", dialogFrame, "BOTTOMRIGHT", -10, 10)
    
    -- Previous button
    local prevBtn = CreateStyledButton(paginationFrame, "< Previous", 80, 25)
    prevBtn:SetPoint("LEFT", 10, 0)
    prevBtn:SetScript("OnClick", function()
        if currentPage > 1 then
            currentPage = currentPage - 1
            Teleport.RequestTeleportData()
        end
    end)
    teleportModal.prevBtn = prevBtn
    
    -- Next button
    local nextBtn = CreateStyledButton(paginationFrame, "Next >", 80, 25)
    nextBtn:SetPoint("RIGHT", -10, 0)
    nextBtn:SetScript("OnClick", function()
        if currentPage < totalPages then
            currentPage = currentPage + 1
            Teleport.RequestTeleportData()
        end
    end)
    teleportModal.nextBtn = nextBtn
    
    -- Page jump controls
    local pageJumpFrame = CreateFrame("Frame", nil, paginationFrame)
    pageJumpFrame:SetPoint("CENTER")
    pageJumpFrame:SetSize(200, 25)
    
    local goToLabel = pageJumpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    goToLabel:SetPoint("LEFT", 0, 0)
    goToLabel:SetText("Go to page:")
    goToLabel:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    
    local pageInput = CreateFrame("EditBox", nil, pageJumpFrame)
    pageInput:SetSize(40, 20)
    pageInput:SetPoint("LEFT", goToLabel, "RIGHT", 5, 0)
    pageInput:SetFontObject("GameFontNormalSmall")
    pageInput:SetAutoFocus(false)
    pageInput:SetNumeric(true)
    pageInput:SetMaxLetters(4)
    pageInput:SetTextColor(1, 1, 1)
    
    -- Use consistent styling
    pageInput:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    pageInput:SetBackdropColor(UISTYLE_COLORS.OptionBg[1], UISTYLE_COLORS.OptionBg[2], UISTYLE_COLORS.OptionBg[3], 1)
    pageInput:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    
    -- Highlight on focus
    pageInput:SetScript("OnEditFocusGained", function(self)
        self:SetBackdropBorderColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
        self:HighlightText()
    end)
    
    pageInput:SetScript("OnEditFocusLost", function(self)
        self:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    end)
    
    local goBtn = CreateStyledButton(pageJumpFrame, "Go", 30, 20)
    goBtn:SetPoint("LEFT", pageInput, "RIGHT", 5, 0)
    goBtn:SetScript("OnClick", function()
        local page = tonumber(pageInput:GetText())
        if page and page >= 1 and page <= totalPages then
            currentPage = page
            Teleport.RequestTeleportData()
            pageInput:ClearFocus()
        end
    end)
    
    pageInput:SetScript("OnEnterPressed", function()
        goBtn:Click()
    end)
    
    teleportModal.pageInput = pageInput
    
    -- ESC key handled by UISpecialFrames
    
    -- Request initial data
    Teleport.RequestTeleportData()
    
    -- Show the modal
    teleportModal:Show()
    
    -- Auto-focus search box
    if searchBox.editBox then
        searchBox.editBox:SetFocus()
    end
    
    return teleportModal
end

-- Request teleport data from server
function Teleport.RequestTeleportData()
    if not teleportModal then return end
    
    -- Clear existing buttons
    Teleport.ClearTeleportButtons()
    
    -- Show loading state
    teleportModal.resultCount:SetText("Loading...")
    
    -- Send request to server with sort order
    local sortOrder = Teleport.sortOrder or "id_desc"
    if isSearching and searchText ~= "" then
        AIO.Handle("GameMasterSystem", "SearchTeleportLocations", searchText, currentPage, pageSize, sortOrder)
    else
        AIO.Handle("GameMasterSystem", "GetTeleportLocations", currentPage, pageSize, sortOrder)
    end
end

-- Handle search text changes
function Teleport.OnSearchTextChanged(text)
    searchText = text or ""
    isSearching = searchText ~= ""
    currentPage = 1 -- Reset to first page on search
    
    -- Debounce search using OnUpdate (WoW 3.3.5 compatible)
    if teleportModal.searchTimer then
        teleportModal.searchTimer:SetScript("OnUpdate", nil)
    end
    
    -- Create a frame for the timer if it doesn't exist
    if not teleportModal.searchTimer then
        teleportModal.searchTimer = CreateFrame("Frame")
    end
    
    local elapsed = 0
    teleportModal.searchTimer:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= 0.3 then -- 300ms debounce
            self:SetScript("OnUpdate", nil)
            Teleport.RequestTeleportData()
        end
    end)
end

-- Clear teleport buttons
function Teleport.ClearTeleportButtons()
    if not teleportModal or not teleportModal.teleportButtons then return end
    
    for _, btn in ipairs(teleportModal.teleportButtons) do
        btn:Hide()
        btn:SetParent(nil)
    end
    teleportModal.teleportButtons = {}
end

-- Populate teleport list with data
function Teleport.PopulateTeleportList(data, total, pages)
    if not teleportModal then return end
    
    -- Clear existing buttons
    Teleport.ClearTeleportButtons()
    
    -- Update pagination info
    totalPages = pages or 1
    teleportData = data or {}
    
    -- Update UI elements
    teleportModal.resultCount:SetText(string.format("%d locations found", total or 0))
    teleportModal.pageInfo:SetText(string.format("Page %d / %d", currentPage, totalPages))
    
    -- Update pagination buttons (WoW 3.3.5 compatible)
    if currentPage > 1 then
        teleportModal.prevBtn:Enable()
    else
        teleportModal.prevBtn:Disable()
    end
    
    if currentPage < totalPages then
        teleportModal.nextBtn:Enable()
    else
        teleportModal.nextBtn:Disable()
    end
    
    -- Create teleport buttons
    local yOffset = -5
    for i, location in ipairs(teleportData) do
        local btn = CreateStyledButton(teleportModal.content, "", 560, 30)
        btn:SetPoint("TOPLEFT", 10, yOffset)
        
        -- Alternate row colors for better readability
        if i % 2 == 0 then
            -- Even rows - slightly lighter
            btn:SetBackdropColor(0.15, 0.15, 0.15, 1)
            -- Update hover colors for even rows
            btn:SetScript("OnEnter", function(self)
                self:SetBackdropColor(0.22, 0.22, 0.22, 1)
                -- Show tooltip
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(location.name, 1, 1, 1)
                GameTooltip:AddLine(string.format("Map ID: %d", location.map), 0.8, 0.8, 0.8)
                GameTooltip:AddLine(string.format("Coordinates: %.2f, %.2f, %.2f", 
                    location.position_x, location.position_y, location.position_z), 0.7, 0.7, 0.7)
                GameTooltip:AddLine(string.format("Orientation: %.2f", location.orientation), 0.7, 0.7, 0.7)
                GameTooltip:AddLine(" ")
                if Teleport.targetPlayer then
                    GameTooltip:AddLine("Click to teleport " .. Teleport.targetPlayer .. " here", 0, 1, 0)
                else
                    GameTooltip:AddLine("Click to teleport here", 0, 1, 0)
                end
                GameTooltip:AddLine("Right-click for more options", 0.7, 0.7, 0.7)
                GameTooltip:Show()
            end)
            btn:SetScript("OnLeave", function(self)
                self:SetBackdropColor(0.15, 0.15, 0.15, 1)
                GameTooltip:Hide()
            end)
        else
            -- Odd rows - darker
            btn:SetBackdropColor(0.10, 0.10, 0.10, 1)
            -- Update hover colors for odd rows
            btn:SetScript("OnEnter", function(self)
                self:SetBackdropColor(0.18, 0.18, 0.18, 1)
                -- Show tooltip
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(location.name, 1, 1, 1)
                GameTooltip:AddLine(string.format("Map ID: %d", location.map), 0.8, 0.8, 0.8)
                GameTooltip:AddLine(string.format("Coordinates: %.2f, %.2f, %.2f", 
                    location.position_x, location.position_y, location.position_z), 0.7, 0.7, 0.7)
                GameTooltip:AddLine(string.format("Orientation: %.2f", location.orientation), 0.7, 0.7, 0.7)
                GameTooltip:AddLine(" ")
                if Teleport.targetPlayer then
                    GameTooltip:AddLine("Click to teleport " .. Teleport.targetPlayer .. " here", 0, 1, 0)
                else
                    GameTooltip:AddLine("Click to teleport here", 0, 1, 0)
                end
                GameTooltip:AddLine("Right-click for more options", 0.7, 0.7, 0.7)
                GameTooltip:Show()
            end)
            btn:SetScript("OnLeave", function(self)
                self:SetBackdropColor(0.10, 0.10, 0.10, 1)
                GameTooltip:Hide()
            end)
        end
        
        -- Location name (left side, truncate if too long)
        local nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nameText:SetPoint("LEFT", 10, 0)
        local displayName = location.name
        if string.len(displayName) > 25 then
            displayName = string.sub(displayName, 1, 22) .. "..."
        end
        nameText:SetText(displayName)
        nameText:SetTextColor(1, 1, 1)
        nameText:SetJustifyH("LEFT")
        nameText:SetWidth(180)
        
        -- Map ID (center-left)
        local mapText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        mapText:SetPoint("LEFT", nameText, "RIGHT", 10, 0)
        mapText:SetText(string.format("[%d]", location.map))
        mapText:SetTextColor(0.8, 0.8, 0.8)
        mapText:SetWidth(50)
        mapText:SetJustifyH("CENTER")
        
        -- Coordinates (right side, moved more to the left for visibility)
        local coordText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        coordText:SetPoint("RIGHT", -60, 0)
        coordText:SetText(string.format("%.0f, %.0f, %.0f", 
            location.position_x, location.position_y, location.position_z))
        coordText:SetTextColor(0.6, 0.6, 0.6)
        coordText:SetJustifyH("RIGHT")
        
        -- Click handlers
        btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        btn:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                Teleport.TeleportToLocation(location)
            elseif button == "RightButton" then
                -- Show context menu
                if Teleport.ShowContextMenu then
                    Teleport.ShowContextMenu(self, location)
                end
            end
        end)
        
        table.insert(teleportModal.teleportButtons, btn)
        yOffset = yOffset - 32
    end
    
    -- Update content height for scrolling
    teleportModal.content:SetHeight(math.max(500, #teleportData * 32 + 10))
    teleportModal.updateScrollBar()
end

-- Teleport to selected location
function Teleport.TeleportToLocation(location)
    if not location then return end
    
    -- Send teleport request to server
    if Teleport.targetPlayer then
        -- Teleporting another player
        AIO.Handle("GameMasterSystem", "TeleportPlayerToLocation", 
            Teleport.targetPlayer, location.id)
    else
        -- Teleporting self
        AIO.Handle("GameMasterSystem", "TeleportToLocation", location.id)
    end
    
    -- Close the modal
    if teleportModal then
        teleportModal:Hide()
    end
end

-- Handle server response with teleport data
function GameMasterSystem.ReceiveTeleportData(player, data, total, pages)
    Teleport.PopulateTeleportList(data, total, pages)
end

-- Export main function for external use
GameMasterSystem.ShowTeleportList = Teleport.ShowTeleportList

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterUI] Teleport list module loaded")
end