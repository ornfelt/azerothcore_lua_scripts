-- GameMaster UI System - UI Creation
-- This file handles all UI creation using UIStyleLibrary functions
-- Load order: 03 (Fourth)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end
local GameMasterSystem = _G.GameMasterSystem

local GMData = _G.GMData
local GMConfig = _G.GMConfig
local GMUI = _G.GMUI
local HotkeyManager = _G.GMHotkeyManager

-- Create the main frame as a side-docked panel
function GMUI.createMainFrame()
    local GMSettings = _G.GMSettings

    local screenHeight = GetScreenHeight()
    local panelWidth = GMSettings and GMSettings.current and GMSettings.current.width or 400
    local panelHeight = screenHeight * 0.9
    local position = GMSettings and GMSettings.current and GMSettings.current.position or "RIGHT"
    local opacity = GMSettings and GMSettings.current and GMSettings.current.opacity or 1.0

    local frame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    frame:SetSize(panelWidth, panelHeight)

    -- Anchor to screen edge based on position setting
    if position == "LEFT" then
        frame:SetPoint("LEFT", UIParent, "LEFT", 0, 0)
    else
        frame:SetPoint("RIGHT", UIParent, "RIGHT", 0, 0)
    end

    frame:EnableMouse(true)
    frame:SetFrameStrata("MEDIUM")
    frame:SetAlpha(opacity)

    -- Add to special frames for ESC key support
    tinsert(UISpecialFrames, frame:GetName() or "GameMasterMainFrame")
    _G["GameMasterMainFrame"] = frame

    -- Title text (left-aligned)
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
    title:SetText("Staff System")
    title:SetTextColor(1, 1, 1)

    -- Report button in title bar
    local titleReportBtn = CreateStyledButton(frame, "!", 24, 24)
    titleReportBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -86, -5)
    titleReportBtn:SetScript("OnClick", function(self)
        self.text:SetTextColor(1, 0.5, 0)
        local elapsed = 0
        titleReportBtn:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 0.3 then
                self.text:SetTextColor(1, 1, 1)
                self:SetScript("OnUpdate", nil)
            end
        end)
        if GMReportDialog then
            GMReportDialog.Show()
        end
    end)
    titleReportBtn:SetTooltip("Report Issue", "Report a bug or suggest improvement")

    -- Settings (cogwheel) button
    local settingsBtn = CreateStyledButton(frame, "*", 24, 24)
    settingsBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -59, -5)
    settingsBtn:SetScript("OnClick", function()
        if _G.GMSettingsModal then
            _G.GMSettingsModal.Show()
        end
    end)
    settingsBtn:SetTooltip("Settings", "Open panel settings")

    -- Refresh button in title bar
    local titleRefreshBtn = CreateStyledButton(frame, "R", 24, 24)
    titleRefreshBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -32, -5)
    titleRefreshBtn:SetScript("OnClick", function(self)
        self.text:SetTextColor(0, 1, 0)
        local elapsed = 0
        titleRefreshBtn:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 0.5 then
                self.text:SetTextColor(1, 1, 1)
                self:SetScript("OnUpdate", nil)
            end
        end)
        if GMData.activeTab then
            if GMData.activeTab == 6 then
                if GMCards and GMCards.PlayerList and GMCards.PlayerList.RequestPlayerData then
                    GMCards.PlayerList.RequestPlayerData()
                else
                    AIO.Handle("GameMasterSystem", "refreshPlayerData")
                end
            else
                GMUI.requestDataForTab(GMData.activeTab)
            end
        end
    end)
    titleRefreshBtn:SetTooltip("Refresh (Ctrl+R)", "Reload current data from server")

    -- Close button
    local closeButton = CreateStyledButton(frame, "X", 24, 24)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        if GMUI.slideOut then
            GMUI.slideOut()
        else
            frame:Hide()
        end
    end)

    -- Named buttons for override key bindings (Ctrl+R, Ctrl+F)
    local refreshBtnName = "GMUIRefreshHotkeyBtn"
    local refreshProxy = CreateFrame("Button", refreshBtnName, frame)
    refreshProxy:Hide()
    refreshProxy:SetScript("OnClick", function()
        local StateMachine = _G.GMStateMachine
        if StateMachine and StateMachine.isModalOpen() then return end
        if titleRefreshBtn then titleRefreshBtn:Click() end
    end)

    local searchBtnName = "GMUISearchFocusHotkeyBtn"
    local searchProxy = CreateFrame("Button", searchBtnName, frame)
    searchProxy:Hide()
    searchProxy:SetScript("OnClick", function()
        local StateMachine = _G.GMStateMachine
        if StateMachine and StateMachine.isModalOpen() then return end
        GMUI.focusSearchBox()
    end)

    -- Bind Ctrl+R / Ctrl+F when frame is shown, clear when hidden
    frame:SetScript("OnShow", function(self)
        SetOverrideBindingClick(self, true, "CTRL-R", refreshBtnName)
        SetOverrideBindingClick(self, true, "CTRL-F", searchBtnName)
    end)
    frame:SetScript("OnHide", function(self)
        ClearOverrideBindings(self)
    end)

    -- Store references
    GMData.frames.mainFrame = frame
    GMData.frames.titleRefreshBtn = titleRefreshBtn
    GMData.frames.titleReportBtn = titleReportBtn
    GMData.frames.settingsBtn = settingsBtn

    return frame
end

-- Create content container system
function GMUI.createContentContainer(parent)
    -- Main content area (borderless internal container — no edge file to avoid
    -- the blue/cyan ghost line that WoW 3.3.5 gamma renders on thin borders)
    local contentArea = CreateFrame("Frame", nil, parent)
    contentArea:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, -95)
    contentArea:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -8, 40)
    local contentBg = contentArea:CreateTexture(nil, "BACKGROUND")
    contentBg:SetAllPoints()
    contentBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    contentBg:SetVertexColor(
        UISTYLE_COLORS.OptionBg[1],
        UISTYLE_COLORS.OptionBg[2],
        UISTYLE_COLORS.OptionBg[3],
        UISTYLE_COLORS.OptionBg[4] or 1
    )

    -- Mouse wheel scrolling with throttle
    contentArea:EnableMouseWheel(true)

    if not GMData.mouseWheelThrottle then
        GMData.mouseWheelThrottle = {
            lastScroll = 0,
            throttleDelay = 0.05,
            pendingDirection = nil
        }
    end

    contentArea:SetScript("OnMouseWheel", function(self, delta)
        local now = GetTime()
        local throttle = GMData.mouseWheelThrottle

        throttle.pendingDirection = delta > 0 and "up" or "down"

        if now - throttle.lastScroll < throttle.throttleDelay then
            return
        end

        throttle.lastScroll = now
        local direction = throttle.pendingDirection

        local state = GMUtils.GetTabState(GMData.activeTab)

        local dynPageSize = 8
        local mf = GMData.frames and GMData.frames.mainFrame
        if mf and GMConfig.config.getPageSize then
            dynPageSize = GMConfig.config.getPageSize(mf:GetWidth())
        end

        if direction == "up" then
            local currentOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
            if currentOffset > 0 then
                state.currentOffset = math.max(0, currentOffset - dynPageSize)
                GMData.currentOffset = state.currentOffset
                GMUI.requestDataForTab(GMData.activeTab)
            end
        else
            if state.hasMoreData then
                local currentOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
                state.currentOffset = currentOffset + dynPageSize
                GMData.currentOffset = state.currentOffset
                GMUI.requestDataForTab(GMData.activeTab)
            end
        end

        throttle.pendingDirection = nil
    end)

    GMData.dynamicContentFrames = {}

    GMData.frames.contentArea = contentArea


    return contentArea
end

-- Create search functionality (full-width below tab bar)
function GMUI.createSearchBox(parent)
    local searchWidth = parent:GetWidth() - 120
    local searchBox = CreateStyledSearchBox(parent, searchWidth, "Search...", function(text)
        GMData.currentSearchQuery = text

        GMUtils.ResetTabState(GMData.activeTab)
        local state = GMUtils.GetTabState(GMData.activeTab)
        state.searchQuery = text
        GMData.currentOffset = 0

        if GMData.activeTab then
            GMUI.requestDataForTab(GMData.activeTab)
        end
    end)

    searchBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -68)

    GMData.frames.searchBox = searchBox
    return searchBox
end

-- Clear search functionality
function GMUI.clearSearch()
    GMData.currentSearchQuery = ""

    GMUtils.ResetTabState(GMData.activeTab)
    GMData.currentOffset = 0

    if GMData.frames.searchBox and GMData.frames.searchBox.editBox then
        GMData.frames.searchBox.editBox:SetText("")
        GMData.frames.searchBox.editBox:ClearFocus()
    end

    if GMData.activeTab then
        GMUI.requestDataForTab(GMData.activeTab)
    end
end

-- Focus search box functionality (Ctrl+F)
function GMUI.focusSearchBox()
    if GMData.frames.searchBox and GMData.frames.searchBox.editBox then
        GMData.frames.searchBox.editBox:SetFocus()
        GMData.frames.searchBox.editBox:HighlightText()
    end
end

-- Create sort dropdown (compact, inline with search row)
function GMUI.createSortDropdown(parent)
    local sortLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sortLabel:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -80, -72)
    sortLabel:SetText("Sort:")
    sortLabel:SetTextColor(0.8, 0.8, 0.8)

    local function getSortDisplayText(sortOrder)
        return (sortOrder == "DESC") and "Desc" or "Asc"
    end

    local sortDropdown
    local sortItems = {
        {
            text = "Ascending",
            value = "ASC",
            func = function()
                GMData.sortOrder = "ASC"
                if sortDropdown then
                    sortDropdown.text:SetText("Asc")
                end
                if GameMasterSystem.refreshData then
                    GameMasterSystem.refreshData()
                end
            end
        },
        {
            text = "Descending",
            value = "DESC",
            func = function()
                GMData.sortOrder = "DESC"
                if sortDropdown then
                    sortDropdown.text:SetText("Desc")
                end
                if GameMasterSystem.refreshData then
                    GameMasterSystem.refreshData()
                end
            end
        }
    }

    local sortMenuFrame
    sortDropdown, sortMenuFrame = CreateFullyStyledDropdown(
        parent,
        60,
        sortItems,
        getSortDisplayText(GMData.sortOrder),
        function(value, item)
            if GMConfig.config.debug then
                -- Debug: Sort order changed
            end
        end
    )

    sortDropdown:SetPoint("LEFT", sortLabel, "RIGHT", 5, 0)

    GMData.frames.sortDropdown = sortDropdown
    GMData.frames.sortMenuFrame = sortMenuFrame
    GMData.frames.sortLabel = sortLabel

    return sortDropdown, sortMenuFrame
end

-- Create compact pagination controls (prev/next + page display only)
function GMUI.createPaginationControls(parent)
    local container = CreateFrame("Frame", nil, parent)
    container:SetHeight(35)
    container:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 8, 5)
    container:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -8, 5)

    -- Previous button (<)
    local prevButton = CreateStyledButton(container, "<", 30, 22)
    prevButton:SetPoint("LEFT", container, "LEFT", 10, 0)
    prevButton:SetScript("OnClick", function()
        local state = GMUtils.GetTabState(GMData.activeTab)
        local currentOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
        if currentOffset > 0 then
            local mf = GMData.frames and GMData.frames.mainFrame
            local ps = (mf and GMConfig.config.getPageSize) and GMConfig.config.getPageSize(mf:GetWidth()) or 8
            state.currentOffset = math.max(0, currentOffset - ps)
            GMData.currentOffset = state.currentOffset
            local ca = GMData.frames.contentArea
            if _G.GMTransitions and ca then
                _G.GMTransitions.fadePageChange(ca, function()
                    GMUI.requestDataForTab(GMData.activeTab)
                end)
            else
                GMUI.requestDataForTab(GMData.activeTab)
            end
        end
    end)

    -- Page display: "Page N / M"
    local pageDisplay = container:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    pageDisplay:SetPoint("LEFT", prevButton, "RIGHT", 8, 0)
    pageDisplay:SetText("Page 1 / 1")
    pageDisplay:SetTextColor(0.8, 0.8, 0.8)

    -- Next button (>)
    local nextButton = CreateStyledButton(container, ">", 30, 22)
    nextButton:SetPoint("LEFT", pageDisplay, "RIGHT", 8, 0)
    nextButton:SetScript("OnClick", function()
        local state = GMUtils.GetTabState(GMData.activeTab)
        if state.hasMoreData then
            local currentOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
            local mf = GMData.frames and GMData.frames.mainFrame
            local ps = (mf and GMConfig.config.getPageSize) and GMConfig.config.getPageSize(mf:GetWidth()) or 8
            state.currentOffset = currentOffset + ps
            GMData.currentOffset = state.currentOffset
            local ca = GMData.frames.contentArea
            if _G.GMTransitions and ca then
                _G.GMTransitions.fadePageChange(ca, function()
                    GMUI.requestDataForTab(GMData.activeTab)
                end)
            else
                GMUI.requestDataForTab(GMData.activeTab)
            end
        end
    end)

    -- Pagination info (items count)
    local paginationInfo = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    paginationInfo:SetPoint("BOTTOM", container, "TOP", 0, 4)
    paginationInfo:SetTextColor(0.7, 0.7, 0.7)

    -- Store references
    GMData.frames.prevButton = prevButton
    GMData.frames.nextButton = nextButton
    GMData.frames.pageDisplay = pageDisplay
    GMData.frames.paginationInfo = paginationInfo
    GMData.frames.paginationContainer = container

    return container
end

-- Initialize complete UI
function GMUI.initializeUI()
    -- Create main frame
    local mainFrame = GMUI.createMainFrame()

    -- Create tab bar (replaces category dropdown)
    if _G.GMTabBar then
        _G.GMTabBar.Create(mainFrame)
    end

    -- Create content container
    local contentArea = GMUI.createContentContainer(mainFrame)

    -- Create sort dropdown
    GMUI.createSortDropdown(mainFrame)

    -- Create animation dropdown for card models
    if _G.GMCards and _G.GMCards.AnimationData then
        _G.GMCards.AnimationData.createCardAnimDropdown(mainFrame)
    end

    -- Create search box (full width, below tab bar)
    GMUI.createSearchBox(mainFrame)

    if GMConfig.config.debug then
        -- Debug: UI initialized with side panel layout
    end

    -- Create pagination controls
    GMUI.createPaginationControls(mainFrame)

    -- Set initial active tab
    GMData.activeTab = 1

    -- Hide main frame initially
    mainFrame:Hide()

    -- Create the always-visible side tab
    if GMUI.createSideTab and not GMData.frames.sideTab then
        GMUI.createSideTab()
    end

    -- Hook show/hide to update side tab arrow and position
    if GMData.frames.sideTab then
        mainFrame:HookScript("OnShow", function()
            GMUI.updateSideTabArrow()
            GMUI.repositionSideTab()
        end)
        mainFrame:HookScript("OnHide", function()
            GMUI.updateSideTabArrow()
            GMUI.repositionSideTab()
        end)
    end

    return mainFrame
end

-- Show/hide functions (use slide animation when available)
function GMUI.show()
    if GMData.frames.mainFrame then
        if GMUI.slideIn then
            GMUI.slideIn()
        else
            local GMSettings = _G.GMSettings
            local position = GMSettings and GMSettings.current
                and GMSettings.current.position or "RIGHT"
            GMData.frames.mainFrame:ClearAllPoints()
            if position == "LEFT" then
                GMData.frames.mainFrame:SetPoint("LEFT", UIParent, "LEFT", 0, 0)
            else
                GMData.frames.mainFrame:SetPoint("RIGHT", UIParent, "RIGHT", 0, 0)
            end
            GMData.frames.mainFrame:Show()
        end
    end
end

function GMUI.hide()
    if GMData.frames.mainFrame then
        if GMUI.slideOut then
            GMUI.slideOut()
        else
            GMData.frames.mainFrame:Hide()
        end
    end
end

-- Update pagination button states
function GMUI.updatePaginationButtons()
    -- Skip pagination updates for GM Powers and Reputation tabs
    if GMData.activeTab == 7 or GMData.activeTab == 8 or GMData.activeTab == 9 then
        if GMData.frames.paginationContainer then
            GMData.frames.paginationContainer:Hide()
        end
        return
    end

    -- Show pagination for other tabs
    if GMData.frames.paginationContainer then
        GMData.frames.paginationContainer:Show()
    end

    -- Get current tab state
    local state = GMUtils.GetTabState(GMData.activeTab)
    local currentOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0

    if GMData.frames.prevButton then
        if currentOffset > 0 then
            GMData.frames.prevButton:Enable()
        else
            GMData.frames.prevButton:Disable()
        end
    end

    if GMData.frames.nextButton then
        if state.hasMoreData then
            GMData.frames.nextButton:Enable()
        else
            GMData.frames.nextButton:Disable()
        end
    end

    -- Update compact page display
    if GMData.frames.pageDisplay then
        local totalPages = tonumber(GMUtils.safeGetValue(state.totalPages)) or 1
        local totalCount = tonumber(GMUtils.safeGetValue(state.totalCount)) or 0
        if totalCount > 0 then
            GMData.frames.pageDisplay:SetText("Page " .. state.currentPage .. " / " .. totalPages)
        else
            GMData.frames.pageDisplay:SetText("Page " .. state.currentPage .. " / ?")
        end
        -- Brief color flash on page change
        if _G.GMTransitions then
            _G.GMTransitions.flashPageCounter(GMData.frames.pageDisplay)
        end
    end

    -- Update pagination info display
    if GMData.frames.paginationInfo then
        local text = ""

        if state.paginationInfo and state.paginationInfo.totalCount then
            local paginationTotalCount = tonumber(GMUtils.safeGetValue(state.paginationInfo.totalCount)) or 0
            if paginationTotalCount > 0 then
                local info = state.paginationInfo
                local pgOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
                local pageSize = tonumber(GMUtils.safeGetValue(state.pageSize)) or 8
                text = string.format("Showing %d-%d of %d items",
                    info.startIndex or (pgOffset + 1),
                    info.endIndex or math.min(pgOffset + pageSize, paginationTotalCount),
                    paginationTotalCount
                )
            end
        end

        if text == "" and state.totalCount then
            local totalCount = tonumber(GMUtils.safeGetValue(state.totalCount)) or 0
            if totalCount > 0 then
                local pgOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
                local pageSize = tonumber(GMUtils.safeGetValue(state.pageSize)) or 8
                local startIdx = pgOffset + 1
                local endIdx = math.min(pgOffset + pageSize, totalCount)
                text = string.format("Showing %d-%d of %d items", startIdx, endIdx, totalCount)
            end
        end

        if text == "" then
            text = string.format("Page %d", state.currentPage)
            if state.hasMoreData then
                text = text .. " (more available)"
            end
        end

        GMData.frames.paginationInfo:SetText(text)
        GMData.frames.paginationInfo:Show()
    end
end

-- Create styled card for items
function GMUI.createStyledCard(parent, index, size)
    local card = CreateStyledCard(parent, size, {
        texture = nil,
        quality = "common",
        count = nil,
        onClick = nil,
        onRightClick = nil
    })

    card.nameText = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    card.nameText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    card.nameText:SetWidth(size - 10)
    card.nameText:SetJustifyH("CENTER")

    return card
end

-- Update content for active tab
function GMUI.updateContentForActiveTab()

    if not GMData.activeTab then
        GMUtils.debug("No active tab set")
        return
    end

    local activeFrame = GMUI.getOrCreateContentFrame(GMData.activeTab)

    if not activeFrame then
        GMUtils.debug("Could not get content frame for tab:", GMData.activeTab)
        return
    end

    GMUI.clearContentFrame(activeFrame)

    if activeFrame.cards then
        wipe(activeFrame.cards)
    end

    local dataType = GMUI.getDataTypeForTab(GMData.activeTab)

    if not dataType then
        GMUtils.debug("Unknown data type for tab:", GMData.activeTab)
        return
    end

    -- Special handling for GM Powers tab
    if GMData.activeTab == 7 and dataType == "gmpowers" then
        if not GMPowers or not GMPowers.frames or not GMPowers.frames.panel then
            if GMPowers and GMPowers.CreatePanel then
                GMPowers.CreatePanel(activeFrame)
            else
                GMUI.showEmptyState(activeFrame, "GM Powers module not loaded")
                return
            end
        end

        if GMPowers.frames.panel then
            GMPowers.frames.panel:SetParent(activeFrame)
            GMPowers.frames.panel:Show()
            AIO.Handle("GameMasterSystem", "getGMPowersState")
        end

        if GMData.frames.prevButton then GMData.frames.prevButton:Hide() end
        if GMData.frames.nextButton then GMData.frames.nextButton:Hide() end
        if GMData.frames.refreshButton then GMData.frames.refreshButton:Hide() end
        if GMData.frames.paginationInfo then GMData.frames.paginationInfo:Hide() end

        return
    end

    -- Special handling for Reputation tab
    if GMData.activeTab == 8 and dataType == "reputation" then
        if not GMReputation or not GMReputation.frames or not GMReputation.frames.panel then
            if GMReputation and GMReputation.CreatePanel then
                GMReputation.CreatePanel(activeFrame)
            else
                GMUI.showEmptyState(activeFrame, "Reputation module not loaded")
                return
            end
        end

        if GMReputation.frames.panel then
            GMReputation.frames.panel:SetParent(activeFrame)
            GMReputation.frames.panel:Show()
            AIO.Handle("GameMasterSystem", "getOnlinePlayersForReputation")
        end

        if GMData.frames.prevButton then GMData.frames.prevButton:Hide() end
        if GMData.frames.nextButton then GMData.frames.nextButton:Hide() end
        if GMData.frames.refreshButton then GMData.frames.refreshButton:Hide() end
        if GMData.frames.paginationInfo then GMData.frames.paginationInfo:Hide() end

        return
    end

    -- Special handling for Quest tab
    if GMData.activeTab == 9 and dataType == "quests" then
        if not GMQuests or not GMQuests.frames or not GMQuests.frames.panel then
            if GMQuests and GMQuests.CreatePanel then
                GMQuests.CreatePanel(activeFrame)
            else
                GMUI.showEmptyState(activeFrame, "Quest module not loaded")
                return
            end
        end

        if GMQuests.frames.panel then
            GMQuests.frames.panel:SetParent(activeFrame)
            GMQuests.frames.panel:Show()
        end

        if GMData.frames.prevButton then GMData.frames.prevButton:Hide() end
        if GMData.frames.nextButton then GMData.frames.nextButton:Hide() end
        if GMData.frames.refreshButton then GMData.frames.refreshButton:Hide() end
        if GMData.frames.paginationInfo then GMData.frames.paginationInfo:Hide() end
        if GMData.frames.paginationContainer then GMData.frames.paginationContainer:Hide() end

        return
    end

    -- Show pagination controls for regular data tabs
    if GMData.frames.prevButton then GMData.frames.prevButton:Show() end
    if GMData.frames.nextButton then GMData.frames.nextButton:Show() end
    if GMData.frames.refreshButton then GMData.frames.refreshButton:Show() end

    local data = GMData.DataStore and GMData.DataStore[dataType]

    if GMConfig.config.debug and dataType == "players" then
        print("[PlayerList Debug] DataType is 'players'")
        print("[PlayerList Debug] GMData.DataStore exists:", GMData.DataStore ~= nil)
        if GMData.DataStore then
            print("[PlayerList Debug] GMData.DataStore.players exists:", GMData.DataStore.players ~= nil)
            if GMData.DataStore.players then
                print("[PlayerList Debug] Number of players in DataStore:", #GMData.DataStore.players)
            end
        end
        print("[PlayerList Debug] data variable:", data ~= nil)
        if data then
            print("[PlayerList Debug] data length:", #data)
        end
    end

    -- Special handling for player tab
    if GMData.activeTab == 6 and dataType == "players" then
        if not _G.GMCards then
            GMUtils.debug("GMCards module not loaded for player tab")
            GMUI.showEmptyState(activeFrame, "Player cards module not loaded")
            return
        end

        data = data or {}
        if GMConfig.config.debug then
            print("[PlayerList] Handling player tab with", #data, "players")
        end

        GMCards.currentViewMode = "list"
        GMCards.currentPlayerData = data

        local needsCreation = false
        if not GMCards.playerListFrame then
            needsCreation = true
        elseif GMCards.playerListFrame:GetParent() ~= activeFrame then
            if GMCards.playerListFrame.preserveOnClear then
                if GMConfig.config.debug then
                    print("[PlayerList] Re-parenting preserved list frame")
                end
                GMCards.playerListFrame:SetParent(activeFrame)
                GMCards.playerListFrame:SetAllPoints()
            else
                if GMConfig.config.debug then
                    print("[PlayerList] List frame has wrong parent, recreating")
                end
                GMCards.playerListFrame:Hide()
                GMCards.playerListFrame:SetParent(nil)
                GMCards.playerListFrame = nil
                needsCreation = true
            end
        end

        if needsCreation then
            if GMConfig.config.debug then
                print("[PlayerList] Creating list frame")
            end
            if GMCards.PlayerList and GMCards.PlayerList.CreateListView then
                GMCards.playerListFrame = GMCards.PlayerList.CreateListView(activeFrame)
                if GMConfig.config.debug then
                    print("[PlayerList] List frame created successfully")
                end
            else
                GMUtils.debug("[PlayerList] ERROR: PlayerList module not found!")
                GMUI.showEmptyState(activeFrame, "Player list module not loaded")
                return
            end
        else
            if GMConfig.config.debug then
                print("[PlayerList] Reusing existing list frame")
            end
        end

        if GMCards.playerListFrame then
            if GMConfig.config.debug then
                print("[PlayerList] Showing and populating list frame")
            end
            GMCards.playerListFrame:Show()
            if GMCards.PlayerList and GMCards.PlayerList.PopulateList then
                GMCards.PlayerList.PopulateList(data)
                if GMConfig.config.debug then
                    print("[PlayerList] List populated with", #data, "players")
                end
            else
                GMUtils.debug("[PlayerList] ERROR: PopulateList function not found!")
            end
        else
            GMUtils.debug("[PlayerList] ERROR: playerListFrame is nil after creation attempt!")
            GMUI.showEmptyState(activeFrame, "Failed to create player list")
        end
        return
    end

    -- For other tabs: check for empty data
    if not data or #data == 0 then
        GMUtils.debug("No data available for:", dataType)
        GMUI.showEmptyState(activeFrame, "No " .. dataType .. " found")
        return
    end

    -- Normal card generation
    if _G.GMCards and _G.GMCards.generateCards then
        local cardType = GMUI.getCardTypeForDataType(dataType)
        local cards = _G.GMCards.generateCards(activeFrame, data, cardType)
        activeFrame.cards = cards

        if cards and #cards > 0 and GMConfig.config.debug then
            -- Debug: Cards visibility check
        end
    else
        GMUtils.debug("GMCards.generateCards not available")
    end
end

-- Clear content frame
function GMUI.clearContentFrame(frame)
    if not frame then return end

    if frame.cards then
        for _, card in ipairs(frame.cards) do
            if card and card.Hide then
                card:Hide()
            end
        end
    end

    local children = {frame:GetChildren()}
    for _, child in ipairs(children) do
        if child and child ~= frame then
            child:Hide()
            if not (child.preserveOnClear or (child.modelFrame and child.modelFrame:IsObjectType("Model"))) then
                child:SetParent(nil)
            end
        end
    end
end

-- Get data type for tab index
function GMUI.getDataTypeForTab(tabIndex)
    local dataTypeMap = {
        [1] = "npcs",
        [2] = "gameobjects",
        [3] = "spells",
        [4] = "spellvisuals",
        [5] = "items",
        [6] = "players",
        [7] = "gmpowers",
        [8] = "reputation",
        [9] = "quests",
    }

    if tabIndex >= 100 then
        return "items"
    end

    return dataTypeMap[tabIndex]
end

-- Get card type for data type
function GMUI.getCardTypeForDataType(dataType)
    local cardTypeMap = {
        npcs = "NPC",
        gameobjects = "GameObject",
        spells = "Spell",
        spellvisuals = "SpellVisual",
        items = "Item",
        players = "Player"
    }

    return cardTypeMap[dataType] or "Item"
end

-- Show empty state
function GMUI.showEmptyState(frame, message)
    if not frame then
        GMUtils.debug("showEmptyState called with nil frame")
        return
    end

    local success, err = pcall(function()
        local emptyText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        emptyText:SetPoint("CENTER", frame, "CENTER", 0, 0)
        emptyText:SetText(message or "No data available")
        emptyText:SetTextColor(0.5, 0.5, 0.5)
    end)

    if not success then
        GMUtils.debug("showEmptyState error:", err)
    end
end

-- Get or create content frame for a tab
function GMUI.getOrCreateContentFrame(tabIndex)
    if not GMData.frames.contentArea then
        return nil
    end

    GMData.frames.contentArea:Show()

    if GMData.dynamicContentFrames[tabIndex] then
        return GMData.dynamicContentFrames[tabIndex]
    end

    local contentFrame = CreateFrame("Frame", nil, GMData.frames.contentArea)
    contentFrame:SetAllPoints(GMData.frames.contentArea)
    contentFrame:Hide()

    if GMConfig.config.debug then
        local bg = contentFrame:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\WHITE8X8")
        bg:SetVertexColor(0.1, 0.1, 0.1, 0.3)
    end

    GMData.dynamicContentFrames[tabIndex] = contentFrame

    return contentFrame
end

-- Get category name for tab index
function GMUI.getCategoryNameForTab(tabIndex)
    local mainCategories = {
        [1] = "Creatures",
        [2] = "Objects",
        [3] = "Spells",
        [4] = "Spell Visuals",
        [5] = "Items",
        [6] = "Player Management",
        [7] = "GM Powers",
        [8] = "Reputation",
        [9] = "Quests"
    }

    if mainCategories[tabIndex] then
        return mainCategories[tabIndex]
    end

    if GMConfig.CardTypes and GMConfig.CardTypes.Item and GMConfig.CardTypes.Item.categories then
        for categoryName, category in pairs(GMConfig.CardTypes.Item.categories) do
            if category.subCategories then
                for _, subCategory in ipairs(category.subCategories) do
                    if subCategory.index == tabIndex then
                        return "Items > " .. categoryName .. " > " .. subCategory.name
                    end
                end
            end
        end
    end

    return "Unknown Category"
end

-- Handle tab switching
function GMUI.switchToTab(tabIndex)
    if GMConfig.config.debug then
        print("[Tab Switch] Switching to tab:", tabIndex)
    end

    -- Sync tab bar highlight
    if _G.GMTabBar then
        _G.GMTabBar.SetActive(tabIndex)
    end

    -- Store current tab's search query
    if GMData.activeTab then
        local oldState = GMUtils.GetTabState(GMData.activeTab)
        oldState.searchQuery = GMData.currentSearchQuery
    end

    -- Update active tab
    GMData.activeTab = tabIndex

    -- Restore new tab's state
    local state = GMUtils.GetTabState(tabIndex)
    GMData.currentOffset = tonumber(GMUtils.safeGetValue(state.currentOffset)) or 0
    GMData.hasMoreData = state.hasMoreData
    GMData.currentSearchQuery = state.searchQuery or ""
    GMData.paginationInfo = state.paginationInfo

    -- Maintain search box state
    if GMData.frames.searchBox and GMData.frames.searchBox.editBox then
        local currentText = GMData.frames.searchBox.editBox:GetText()
        if currentText ~= GMData.currentSearchQuery then
            GMData.frames.searchBox.editBox:SetText(GMData.currentSearchQuery or "")
        end
    end

    -- Animated tab content crossfade
    local contentArea = GMData.frames.contentArea
    local function doTabSwap()
        for idx, frame in pairs(GMData.dynamicContentFrames) do
            if frame then
                GMUI.clearContentFrame(frame)
                frame:Hide()
            end
        end
        local activeFrame = GMUI.getOrCreateContentFrame(tabIndex)
        if activeFrame then
            activeFrame:Show()
            if contentArea then contentArea:Show() end
        else
            GMUtils.debug("ERROR: Could not create content frame for tab:", tabIndex)
        end

        -- Show/hide sort dropdown based on tab
        local isCardTab = tabIndex == 1 or tabIndex == 2 or tabIndex == 3
            or tabIndex == 4 or tabIndex == 5 or tabIndex >= 100
        if GMData.frames.sortDropdown and GMData.frames.sortLabel then
            if isCardTab then
                GMData.frames.sortDropdown:Show()
                GMData.frames.sortLabel:Show()
            else
                GMData.frames.sortDropdown:Hide()
                GMData.frames.sortLabel:Hide()
            end
        end

        -- Show/hide animation dropdown (NPC tab only)
        if GMData.frames.animDropdown and GMData.frames.animLabel then
            if tabIndex == 1 then
                GMData.frames.animDropdown:Show()
                GMData.frames.animLabel:Show()
            else
                GMData.frames.animDropdown:Hide()
                GMData.frames.animLabel:Hide()
            end
        end

        -- Show/hide main search box (Quest tab has its own search)
        if GMData.frames.searchBox then
            if tabIndex == 7 or tabIndex == 8 or tabIndex == 9 then
                GMData.frames.searchBox:Hide()
            else
                GMData.frames.searchBox:Show()
            end
        end

        -- Show refresh button for all tabs
        if GMData.frames.refreshButton then
            GMData.frames.refreshButton:Show()
        end

        -- Request data for this tab
        GMUI.requestDataForTab(tabIndex)

        -- For Player Management, show the frame immediately while async data loads
        if tabIndex == 6 then
            GMUI.updateContentForActiveTab()
        end
    end

    if _G.GMTransitions and contentArea then
        _G.GMTransitions.fadeTabSwitch(contentArea, doTabSwap)
    else
        doTabSwap()
    end
end

-- Request data for specific tab
function GMUI.requestDataForTab(tabIndex)
    -- Special case for GM Powers and Reputation
    if tabIndex == 7 or tabIndex == 8 or tabIndex == 9 then
        GMUI.updateContentForActiveTab()
        return
    end

    local state = GMUtils.GetTabState(tabIndex)
    local offset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(state.currentOffset) or state.currentOffset
    offset = tonumber(offset) or 0

    -- Compute dynamic page size from current panel width
    local pageSize
    local mainFrame = GMData.frames and GMData.frames.mainFrame
    if mainFrame and GMConfig.config.getPageSize then
        pageSize = GMConfig.config.getPageSize(mainFrame:GetWidth())
    else
        pageSize = tonumber(GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(state.pageSize) or state.pageSize) or GMConfig.config.PAGE_SIZE or 8
    end

    local sortOrder = GMData.sortOrder or "ASC"

    local lastRequestedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(GMData.lastRequestedOffset) or GMData.lastRequestedOffset
    lastRequestedOffset = tonumber(lastRequestedOffset) or 0

    if offset > 0 and offset >= lastRequestedOffset and not GMData.hasMoreData then
        if GMConfig.config.debug then
            print("Preventing redundant request - already at end of data")
        end
        return
    end

    GMData.lastRequestedOffset = offset

    if tabIndex == 1 then
        if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
            AIO.Handle("GameMasterSystem", "searchNPCData", GMData.currentSearchQuery, offset, pageSize, sortOrder)
        else
            AIO.Handle("GameMasterSystem", "getNPCData", offset, pageSize, sortOrder)
        end
    elseif tabIndex == 2 then
        if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
            AIO.Handle("GameMasterSystem", "searchGameObjectData", GMData.currentSearchQuery, offset, pageSize, sortOrder)
        else
            AIO.Handle("GameMasterSystem", "getGameObjectData", offset, pageSize, sortOrder)
        end
    elseif tabIndex == 3 then
        if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
            AIO.Handle("GameMasterSystem", "searchSpellData", GMData.currentSearchQuery, offset, pageSize, sortOrder)
        else
            AIO.Handle("GameMasterSystem", "getSpellData", offset, pageSize, sortOrder)
        end
    elseif tabIndex == 4 then
        if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
            AIO.Handle("GameMasterSystem", "searchSpellVisualData", GMData.currentSearchQuery, offset, pageSize, sortOrder)
        else
            AIO.Handle("GameMasterSystem", "getSpellVisualData", offset, pageSize, sortOrder)
        end
    elseif tabIndex == 5 then
        if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
            AIO.Handle("GameMasterSystem", "searchItemData", GMData.currentSearchQuery, offset, pageSize, sortOrder)
        else
            AIO.Handle("GameMasterSystem", "getItemData", offset, pageSize, sortOrder)
        end
    elseif tabIndex == 6 then
        if GMCards and GMCards.PlayerList then
            if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
                GMCards.PlayerList.FilterPlayers(GMData.currentSearchQuery:lower())
            else
                if GMCards.PlayerList.ShowAllPlayers then
                    GMCards.PlayerList.ShowAllPlayers()
                else
                    GMCards.PlayerList.FilterPlayers("")
                end
            end
        else
            AIO.Handle("GameMasterSystem", "refreshPlayerData")
        end
    elseif tabIndex >= 100 then
        local inventoryType = GMUI.getInventoryTypeForTab(tabIndex)
        if inventoryType then
            if GMData.currentSearchQuery and GMData.currentSearchQuery ~= "" then
                AIO.Handle("GameMasterSystem", "searchItemData", GMData.currentSearchQuery, offset, pageSize, sortOrder, inventoryType)
            else
                AIO.Handle("GameMasterSystem", "getItemData", offset, pageSize, sortOrder, inventoryType)
            end
        end
    end
end

-- Get inventory type for subcategory tab
function GMUI.getInventoryTypeForTab(tabIndex)
    if GMConfig.CardTypes and GMConfig.CardTypes.Item and GMConfig.CardTypes.Item.categories then
        for categoryName, category in pairs(GMConfig.CardTypes.Item.categories) do
            if category.subCategories then
                for _, subCategory in ipairs(category.subCategories) do
                    if subCategory.index == tabIndex then
                        return subCategory.value
                    end
                end
            end
        end
    end
    return nil
end

-- Refresh layout for elements that can't use two-point anchoring
function GMUI.refreshLayout()
    local mainFrame = GMData.frames and GMData.frames.mainFrame
    if not mainFrame then return end

    local panelWidth = mainFrame:GetWidth()

    -- Update search box width
    if GMData.frames.searchBox then
        GMData.frames.searchBox:SetWidth(panelWidth - 120)
    end

    -- Re-request data if page size changed (different column count at new width)
    if GMConfig.config.getPageSize and GMData.activeTab then
        local newPageSize = GMConfig.config.getPageSize(panelWidth)
        local prevPageSize = GMData._lastPageSize
        GMData._lastPageSize = newPageSize
        if prevPageSize and prevPageSize ~= newPageSize then
            -- Reset offset since grid shape changed
            local state = GMUtils.GetTabState(GMData.activeTab)
            state.currentOffset = 0
            GMData.currentOffset = 0
            GMUI.requestDataForTab(GMData.activeTab)
        end
    end
end

-- UI module loaded
