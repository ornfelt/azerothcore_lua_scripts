-- GameMaster UI System - Quest Management Tab
-- Search, add, complete, remove, reset, fail quests for target players
-- Includes active quest log and completed quest history viewers

local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end
if not GM_RequireNamespace() then return end

local GameMasterSystem = _G.GameMasterSystem
_G.GMQuests = _G.GMQuests or {}
local GMQuests = _G.GMQuests

GMQuests.state = {
    selectedTargetName = "Self",
    selectedQuestId = nil,
    selectedQuestTitle = nil,
    searchResults = {},
    questLog = {},
    completedQuests = {},
    completedOffset = 0,
    completedHasMore = false,
    viewMode = "active",  -- "active" or "completed"
}

GMQuests.frames = {}

local COMPLETED_PAGE_SIZE = 50

-- Status colors for quest display
local STATUS_COLORS = {
    [0] = {0.6, 0.6, 0.6},  -- Not Started (grey)
    [1] = {0, 1, 0},         -- Complete (green)
    [3] = {1, 1, 0},         -- Incomplete (yellow)
    [5] = {1, 0, 0},         -- Failed (red)
    [6] = {0.5, 0, 1},       -- Rewarded (purple)
}

-- Helper: get target name from input
local function GetTargetName()
    if GMQuests.frames.targetInput then
        local text = GMQuests.frames.targetInput:GetText()
        if text and text ~= "" then return text end
    end
    return "Self"
end

-- Helper: create a scrollable list frame
local function CreateScrollList(parent, height)
    local container = CreateFrame("Frame", nil, parent)
    container:SetHeight(height)

    local scrollFrame = CreateFrame("ScrollFrame", nil, container)
    scrollFrame:SetAllPoints()

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(1)
    scrollChild:SetHeight(1)
    scrollFrame:SetScrollChild(scrollChild)

    -- Defer width: container uses two-point anchoring so width is 0 at creation.
    -- OnSizeChanged fires once the layout engine resolves the container's dimensions.
    container:SetScript("OnSizeChanged", function(self)
        local w = self:GetWidth()
        if w and w > 14 then
            scrollChild:SetWidth(w - 14)
        end
    end)

    -- Scroll bar
    local scrollBar = CreateFrame("Slider", nil, container)
    scrollBar:SetWidth(12)
    scrollBar:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, -2)
    scrollBar:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 2)
    scrollBar:SetMinMaxValues(0, 1)
    scrollBar:SetValueStep(1)
    scrollBar:SetValue(0)
    scrollBar:SetOrientation("VERTICAL")

    local bg = scrollBar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0.1, 0.1, 0.1, 0.5)

    local thumb = scrollBar:CreateTexture(nil, "OVERLAY")
    thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
    thumb:SetVertexColor(0.4, 0.4, 0.4, 0.8)
    thumb:SetSize(12, 30)
    scrollBar:SetThumbTexture(thumb)

    scrollBar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)

    container:EnableMouseWheel(true)
    container:SetScript("OnMouseWheel", function(self, delta)
        local current = scrollBar:GetValue()
        local min, max = scrollBar:GetMinMaxValues()
        local step = 20
        local newVal = current - (delta * step)
        newVal = math.max(min, math.min(max, newVal))
        scrollBar:SetValue(newVal)
    end)

    container.scrollFrame = scrollFrame
    container.scrollChild = scrollChild
    container.scrollBar = scrollBar

    return container
end

-- Helper: update scroll bar max value
local function UpdateScrollMax(listContainer)
    if not listContainer or not listContainer.scrollChild or not listContainer.scrollFrame then return end
    local childHeight = listContainer.scrollChild:GetHeight()
    local frameHeight = listContainer:GetHeight()
    local maxScroll = math.max(0, childHeight - frameHeight)
    listContainer.scrollBar:SetMinMaxValues(0, maxScroll)
end

-- Create main panel
-- Request the active quest log for the currently-selected target.
function GMQuests.RefreshActiveLog()
    local targetName = GMQuests.state.selectedTargetName or "Self"
    GMQuests.state.viewMode = "active"
    AIO.Handle("GameMasterSystem", "getPlayerQuestLog", targetName)
end

function GMQuests.CreatePanel(parent)
    local panel = CreateFrame("Frame", nil, parent)
    panel:SetAllPoints(parent)

    local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", panel, "TOP", 0, -10)
    title:SetText("Quest Management")
    title:SetTextColor(1, 1, 1)

    GMQuests.CreateTargetSection(panel)
    GMQuests.CreateSearchSection(panel)
    GMQuests.CreateSelectedQuestSection(panel)
    GMQuests.CreateQuestLogSection(panel)

    GMQuests.frames.panel = panel
    panel:Show()

    GMQuests.RefreshActiveLog()
    return panel
end

-- Target player section (same pattern as Reputation)
function GMQuests.CreateTargetSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 40
    section:SetSize(sectionWidth, 60)
    section:SetPoint("TOP", parent, "TOP", 0, -40)
    section:Show()

    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)
    sectionTitle:SetText("Target Player")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)

    local inputContainer = CreateFrame("Frame", nil, section)
    inputContainer:SetSize(sectionWidth - 30, 26)
    inputContainer:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -30)
    inputContainer:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    inputContainer:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
    inputContainer:SetBackdropBorderColor(UISTYLE_COLORS.ButtonBorder[1], UISTYLE_COLORS.ButtonBorder[2], UISTYLE_COLORS.ButtonBorder[3], 1)

    local targetInput = CreateFrame("EditBox", nil, inputContainer)
    targetInput:SetPoint("LEFT", 8, 0)
    targetInput:SetPoint("RIGHT", -28, 0)
    targetInput:SetHeight(20)
    targetInput:SetFontObject("GameFontNormalSmall")
    targetInput:SetTextColor(1, 1, 1)
    targetInput:SetAutoFocus(false)
    targetInput:SetMaxLetters(50)
    targetInput:SetText("Self")

    local clearBtn = CreateFrame("Button", nil, inputContainer)
    clearBtn:SetSize(20, 20)
    clearBtn:SetPoint("RIGHT", -4, 0)
    local clearText = clearBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    clearText:SetPoint("CENTER", 0, 0)
    clearText:SetText("X")
    clearText:SetTextColor(0.6, 0.6, 0.6)
    clearBtn:SetScript("OnEnter", function() clearText:SetTextColor(1, 0.3, 0.3) end)
    clearBtn:SetScript("OnLeave", function() clearText:SetTextColor(0.6, 0.6, 0.6) end)
    clearBtn:SetScript("OnClick", function()
        targetInput:SetText("Self")
        GMQuests.state.selectedTargetName = "Self"
        targetInput:ClearFocus()
        GMQuests.RefreshActiveLog()
    end)

    targetInput:SetScript("OnEnterPressed", function(self)
        local text = self:GetText()
        if text == "" then
            self:SetText("Self")
            GMQuests.state.selectedTargetName = "Self"
        else
            GMQuests.state.selectedTargetName = text
        end
        self:ClearFocus()
        GMQuests.RefreshActiveLog()
    end)
    targetInput:SetScript("OnEscapePressed", function(self)
        self:SetText(GMQuests.state.selectedTargetName or "Self")
        self:ClearFocus()
    end)

    GMQuests.frames.targetSection = section
    GMQuests.frames.targetInput = targetInput
end

-- Quest search section
function GMQuests.CreateSearchSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 40
    section:SetSize(sectionWidth, 175)
    section:SetPoint("TOP", GMQuests.frames.targetSection, "BOTTOM", 0, -8)
    section:Show()

    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)
    sectionTitle:SetText("Quest Search")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)

    -- Search input + button row
    local searchContainer = CreateFrame("Frame", nil, section)
    searchContainer:SetSize(sectionWidth - 30, 26)
    searchContainer:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -30)
    searchContainer:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    searchContainer:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
    searchContainer:SetBackdropBorderColor(UISTYLE_COLORS.ButtonBorder[1], UISTYLE_COLORS.ButtonBorder[2], UISTYLE_COLORS.ButtonBorder[3], 1)

    local searchInput = CreateFrame("EditBox", nil, searchContainer)
    searchInput:SetPoint("LEFT", 8, 0)
    searchInput:SetPoint("RIGHT", -60, 0)
    searchInput:SetHeight(20)
    searchInput:SetFontObject("GameFontNormalSmall")
    searchInput:SetTextColor(1, 1, 1)
    searchInput:SetAutoFocus(false)
    searchInput:SetMaxLetters(100)
    searchInput:SetText("")

    local searchBtn = CreateStyledButton(searchContainer, "Search", 55, 22)
    searchBtn:SetPoint("RIGHT", searchContainer, "RIGHT", -2, 0)

    local function DoSearch()
        local text = searchInput:GetText()
        if text == "" then return end
        searchInput:ClearFocus()
        AIO.Handle("GameMasterSystem", "searchQuests", text, 0, 50)
    end

    searchBtn:SetScript("OnClick", DoSearch)
    searchInput:SetScript("OnEnterPressed", function(self) DoSearch() self:ClearFocus() end)
    searchInput:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    -- Search results scrollable list
    local resultsList = CreateScrollList(section, 110)
    resultsList:SetPoint("TOPLEFT", searchContainer, "BOTTOMLEFT", 0, -5)
    resultsList:SetPoint("TOPRIGHT", searchContainer, "BOTTOMRIGHT", 0, -5)

    GMQuests.frames.searchSection = section
    GMQuests.frames.searchInput = searchInput
    GMQuests.frames.resultsList = resultsList
end

-- Selected quest info + action buttons section
function GMQuests.CreateSelectedQuestSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 40
    section:SetSize(sectionWidth, 105)
    section:SetPoint("TOP", GMQuests.frames.searchSection, "BOTTOM", 0, -8)
    section:Show()

    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)
    sectionTitle:SetText("Selected Quest")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)

    -- Quest info display
    local questInfo = section:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    questInfo:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -28)
    questInfo:SetWidth(sectionWidth - 30)
    questInfo:SetJustifyH("LEFT")
    questInfo:SetText("No quest selected")
    questInfo:SetTextColor(0.7, 0.7, 0.7)

    -- Status display
    local statusInfo = section:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusInfo:SetPoint("TOPLEFT", questInfo, "BOTTOMLEFT", 0, -4)
    statusInfo:SetWidth(sectionWidth - 30)
    statusInfo:SetJustifyH("LEFT")
    statusInfo:SetText("")
    statusInfo:SetTextColor(0.7, 0.7, 0.7)

    -- Action buttons row
    local btnWidth = (sectionWidth - 50) / 5
    local btnY = -65
    local btnHeight = 25

    local addBtn = CreateStyledButton(section, "Add", btnWidth, btnHeight)
    addBtn:SetPoint("TOPLEFT", section, "TOPLEFT", 15, btnY)
    addBtn:SetScript("OnClick", function()
        if not GMQuests.state.selectedQuestId then return end
        AIO.Handle("GameMasterSystem", "addQuestToPlayer", GetTargetName(), GMQuests.state.selectedQuestId)
    end)

    local completeBtn = CreateStyledButton(section, "Complete", btnWidth, btnHeight)
    completeBtn:SetPoint("LEFT", addBtn, "RIGHT", 5, 0)
    completeBtn:SetScript("OnClick", function()
        if not GMQuests.state.selectedQuestId then return end
        AIO.Handle("GameMasterSystem", "completePlayerQuest", GetTargetName(), GMQuests.state.selectedQuestId)
    end)

    local failBtn = CreateStyledButton(section, "Fail", btnWidth, btnHeight)
    failBtn:SetPoint("LEFT", completeBtn, "RIGHT", 5, 0)
    failBtn:SetScript("OnClick", function()
        if not GMQuests.state.selectedQuestId then return end
        AIO.Handle("GameMasterSystem", "failPlayerQuest", GetTargetName(), GMQuests.state.selectedQuestId)
    end)

    local removeBtn = CreateStyledButton(section, "Remove", btnWidth, btnHeight)
    removeBtn:SetPoint("LEFT", failBtn, "RIGHT", 5, 0)
    removeBtn:SetScript("OnClick", function()
        if not GMQuests.state.selectedQuestId then return end
        AIO.Handle("GameMasterSystem", "removePlayerQuest", GetTargetName(), GMQuests.state.selectedQuestId)
    end)

    local resetBtn = CreateStyledButton(section, "Reset", btnWidth, btnHeight)
    resetBtn:SetPoint("LEFT", removeBtn, "RIGHT", 5, 0)
    resetBtn:SetScript("OnClick", function()
        if not GMQuests.state.selectedQuestId then return end
        AIO.Handle("GameMasterSystem", "resetPlayerQuest", GetTargetName(), GMQuests.state.selectedQuestId)
    end)

    GMQuests.frames.selectedSection = section
    GMQuests.frames.questInfo = questInfo
    GMQuests.frames.statusInfo = statusInfo
    GMQuests.frames.addBtn = addBtn
    GMQuests.frames.completeBtn = completeBtn
    GMQuests.frames.failBtn = failBtn
    GMQuests.frames.removeBtn = removeBtn
    GMQuests.frames.resetBtn = resetBtn
end

-- Quest log section (active + completed toggle)
function GMQuests.CreateQuestLogSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    -- Fill remaining space below the selected-quest section down to the panel's bottom.
    section:SetPoint("TOPLEFT", GMQuests.frames.selectedSection, "BOTTOMLEFT", 0, -8)
    section:SetPoint("TOPRIGHT", GMQuests.frames.selectedSection, "BOTTOMRIGHT", 0, -8)
    section:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 20, 12)
    section:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -20, 12)
    section:Show()

    -- Toggle buttons row
    local sectionWidth = parent:GetWidth() - 40
    local halfWidth = (sectionWidth - 40) / 2

    local activeBtn = CreateStyledButton(section, "Active Quests", halfWidth, 22)
    activeBtn:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)

    local completedBtn = CreateStyledButton(section, "Completed History", halfWidth, 22)
    completedBtn:SetPoint("LEFT", activeBtn, "RIGHT", 5, 0)

    -- Quest log scrollable list — anchor bottom too so the list grows with the section.
    local questLogList = CreateScrollList(section, 110)
    questLogList:SetPoint("TOPLEFT", activeBtn, "BOTTOMLEFT", 0, -5)
    questLogList:SetPoint("TOPRIGHT", completedBtn, "BOTTOMRIGHT", 0, -5)
    questLogList:SetPoint("BOTTOMLEFT", section, "BOTTOMLEFT", 15, 35)
    questLogList:SetPoint("BOTTOMRIGHT", section, "BOTTOMRIGHT", -15, 35)

    -- Pagination for completed quests
    local prevBtn = CreateStyledButton(section, "<", 30, 20)
    prevBtn:SetPoint("BOTTOMLEFT", section, "BOTTOMLEFT", 15, 8)
    prevBtn:Hide()

    local pageLabel = section:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    pageLabel:SetPoint("LEFT", prevBtn, "RIGHT", 5, 0)
    pageLabel:SetText("")
    pageLabel:SetTextColor(0.7, 0.7, 0.7)

    local nextBtn = CreateStyledButton(section, ">", 30, 20)
    nextBtn:SetPoint("LEFT", pageLabel, "RIGHT", 5, 0)
    nextBtn:Hide()

    -- Load button
    local loadBtn = CreateStyledButton(section, "Load", 50, 20)
    loadBtn:SetPoint("BOTTOMRIGHT", section, "BOTTOMRIGHT", -15, 8)

    local function SetViewMode(mode)
        GMQuests.state.viewMode = mode
        if mode == "active" then
            activeBtn.text:SetTextColor(1, 0.82, 0)
            completedBtn.text:SetTextColor(1, 1, 1)
            prevBtn:Hide()
            nextBtn:Hide()
            pageLabel:SetText("")
            GMQuests.PopulateQuestLogList()
        else
            activeBtn.text:SetTextColor(1, 1, 1)
            completedBtn.text:SetTextColor(1, 0.82, 0)
            GMQuests.state.completedOffset = 0
            AIO.Handle("GameMasterSystem", "getPlayerCompletedQuests", GetTargetName(), 0, COMPLETED_PAGE_SIZE)
        end
    end

    activeBtn:SetScript("OnClick", function() SetViewMode("active") end)
    completedBtn:SetScript("OnClick", function() SetViewMode("completed") end)

    loadBtn:SetScript("OnClick", function()
        if GMQuests.state.viewMode == "active" then
            AIO.Handle("GameMasterSystem", "getPlayerQuestLog", GetTargetName())
        else
            AIO.Handle("GameMasterSystem", "getPlayerCompletedQuests",
                GetTargetName(), GMQuests.state.completedOffset, COMPLETED_PAGE_SIZE)
        end
    end)

    prevBtn:SetScript("OnClick", function()
        local newOffset = math.max(0, GMQuests.state.completedOffset - COMPLETED_PAGE_SIZE)
        GMQuests.state.completedOffset = newOffset
        AIO.Handle("GameMasterSystem", "getPlayerCompletedQuests", GetTargetName(), newOffset, COMPLETED_PAGE_SIZE)
    end)

    nextBtn:SetScript("OnClick", function()
        if GMQuests.state.completedHasMore then
            GMQuests.state.completedOffset = GMQuests.state.completedOffset + COMPLETED_PAGE_SIZE
            AIO.Handle("GameMasterSystem", "getPlayerCompletedQuests",
                GetTargetName(), GMQuests.state.completedOffset, COMPLETED_PAGE_SIZE)
        end
    end)

    -- Default to active view
    activeBtn.text:SetTextColor(1, 0.82, 0)

    GMQuests.frames.questLogSection = section
    GMQuests.frames.questLogList = questLogList
    GMQuests.frames.activeBtn = activeBtn
    GMQuests.frames.completedBtn = completedBtn
    GMQuests.frames.prevBtn = prevBtn
    GMQuests.frames.nextBtn = nextBtn
    GMQuests.frames.pageLabel = pageLabel
    GMQuests.frames.loadBtn = loadBtn
end

-- Select a quest (from search or log)
function GMQuests.SelectQuest(questId, questTitle)
    GMQuests.state.selectedQuestId = questId
    GMQuests.state.selectedQuestTitle = questTitle

    if GMQuests.frames.questInfo then
        GMQuests.frames.questInfo:SetText(string.format("[%d] %s", questId, questTitle or "Unknown"))
        GMQuests.frames.questInfo:SetTextColor(1, 1, 1)
    end

    -- Request status from server
    AIO.Handle("GameMasterSystem", "getQuestStatus", GetTargetName(), questId)
end

-- Populate search results list
function GMQuests.PopulateSearchResults(quests)
    GMQuests.state.searchResults = quests or {}
    local list = GMQuests.frames.resultsList
    if not list or not list.scrollChild then return end

    -- Clear existing rows
    local children = {list.scrollChild:GetChildren()}
    for _, child in ipairs(children) do child:Hide(); child:SetParent(nil) end

    local rowHeight = 18
    local yOffset = 0

    for i, quest in ipairs(quests) do
        local row = CreateFrame("Button", nil, list.scrollChild)
        row:SetHeight(rowHeight)
        row:SetPoint("TOPLEFT", list.scrollChild, "TOPLEFT", 0, -yOffset)
        row:SetPoint("RIGHT", list.scrollChild, "RIGHT", 0, 0)

        -- Alternating background
        if i % 2 == 0 then
            local bg = row:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetTexture("Interface\\Buttons\\WHITE8X8")
            bg:SetVertexColor(0.15, 0.15, 0.15, 0.5)
        end

        local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("LEFT", row, "LEFT", 4, 0)
        text:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        text:SetJustifyH("LEFT")
        text:SetText(string.format("[%d] %s (Lv %d)", quest.id, quest.title, quest.level))
        text:SetTextColor(0.9, 0.9, 0.9)

        row:SetScript("OnEnter", function() text:SetTextColor(1, 0.82, 0) end)
        row:SetScript("OnLeave", function() text:SetTextColor(0.9, 0.9, 0.9) end)
        row:SetScript("OnClick", function()
            GMQuests.SelectQuest(quest.id, quest.title)
        end)

        yOffset = yOffset + rowHeight
    end

    list.scrollChild:SetHeight(math.max(1, yOffset))
    UpdateScrollMax(list)
end

-- Populate quest log list (active quests)
function GMQuests.PopulateQuestLogList()
    local list = GMQuests.frames.questLogList
    if not list or not list.scrollChild then return end

    local children = {list.scrollChild:GetChildren()}
    for _, child in ipairs(children) do child:Hide(); child:SetParent(nil) end

    local quests = GMQuests.state.questLog
    local rowHeight = 18
    local yOffset = 0

    for i, quest in ipairs(quests) do
        local row = CreateFrame("Button", nil, list.scrollChild)
        row:SetHeight(rowHeight)
        row:SetPoint("TOPLEFT", list.scrollChild, "TOPLEFT", 0, -yOffset)
        row:SetPoint("RIGHT", list.scrollChild, "RIGHT", 0, 0)

        if i % 2 == 0 then
            local bg = row:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetTexture("Interface\\Buttons\\WHITE8X8")
            bg:SetVertexColor(0.15, 0.15, 0.15, 0.5)
        end

        local color = STATUS_COLORS[quest.status] or {0.7, 0.7, 0.7}
        local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("LEFT", row, "LEFT", 4, 0)
        text:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        text:SetJustifyH("LEFT")
        text:SetText(string.format("[%d] %s - %s", quest.id, quest.title, quest.statusLabel or ""))
        text:SetTextColor(color[1], color[2], color[3])

        local origColor = {color[1], color[2], color[3]}
        row:SetScript("OnEnter", function() text:SetTextColor(1, 0.82, 0) end)
        row:SetScript("OnLeave", function() text:SetTextColor(origColor[1], origColor[2], origColor[3]) end)
        row:SetScript("OnClick", function()
            GMQuests.SelectQuest(quest.id, quest.title)
        end)

        yOffset = yOffset + rowHeight
    end

    list.scrollChild:SetHeight(math.max(1, yOffset))
    UpdateScrollMax(list)
end

-- Populate completed quests list
function GMQuests.PopulateCompletedList()
    local list = GMQuests.frames.questLogList
    if not list or not list.scrollChild then return end

    local children = {list.scrollChild:GetChildren()}
    for _, child in ipairs(children) do child:Hide(); child:SetParent(nil) end

    local quests = GMQuests.state.completedQuests
    local rowHeight = 18
    local yOffset = 0

    for i, quest in ipairs(quests) do
        local row = CreateFrame("Button", nil, list.scrollChild)
        row:SetHeight(rowHeight)
        row:SetPoint("TOPLEFT", list.scrollChild, "TOPLEFT", 0, -yOffset)
        row:SetPoint("RIGHT", list.scrollChild, "RIGHT", 0, 0)

        if i % 2 == 0 then
            local bg = row:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetTexture("Interface\\Buttons\\WHITE8X8")
            bg:SetVertexColor(0.15, 0.15, 0.15, 0.5)
        end

        local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("LEFT", row, "LEFT", 4, 0)
        text:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        text:SetJustifyH("LEFT")
        text:SetText(string.format("[%d] %s", quest.id, quest.title))
        text:SetTextColor(0.5, 0, 1)

        row:SetScript("OnEnter", function() text:SetTextColor(1, 0.82, 0) end)
        row:SetScript("OnLeave", function() text:SetTextColor(0.5, 0, 1) end)
        row:SetScript("OnClick", function()
            GMQuests.SelectQuest(quest.id, quest.title)
        end)

        yOffset = yOffset + rowHeight
    end

    list.scrollChild:SetHeight(math.max(1, yOffset))
    UpdateScrollMax(list)

    -- Update pagination UI
    local offset = GMQuests.state.completedOffset
    if GMQuests.frames.prevBtn then
        if offset > 0 then GMQuests.frames.prevBtn:Show() else GMQuests.frames.prevBtn:Hide() end
    end
    if GMQuests.frames.nextBtn then
        if GMQuests.state.completedHasMore then GMQuests.frames.nextBtn:Show() else GMQuests.frames.nextBtn:Hide() end
    end
    if GMQuests.frames.pageLabel then
        local page = math.floor(offset / COMPLETED_PAGE_SIZE) + 1
        GMQuests.frames.pageLabel:SetText("Page " .. page)
    end
end

-- AIO Handlers
-- NOTE: Client-side AIO handlers ALWAYS receive the sender as the first argument.
-- See AIO_Server/AIO.lua:660 and the comment in GMClient_08a_DataHandlers.lua:25.
-- Previous versions of this file read the payload from the sender slot, which is why
-- search results, status updates, and action feedback never appeared.

GameMasterSystem.receiveQuestSearchResults = function(player, data)
    if data and data.quests then
        GMQuests.PopulateSearchResults(data.quests)
    end
end

GameMasterSystem.receiveQuestStatus = function(player, data)
    if not data then return end
    local statusText
    if data.rewarded then
        statusText = "Status: Rewarded (completed)"
    elseif data.hasQuest then
        statusText = "Status: " .. (data.statusLabel or "Unknown")
    else
        statusText = "Status: Not in quest log"
    end

    if GMQuests.frames.statusInfo then
        GMQuests.frames.statusInfo:SetText(statusText .. "  |  Target: " .. (data.targetName or "Self"))
        local color = STATUS_COLORS[data.status] or {0.7, 0.7, 0.7}
        if data.rewarded then color = STATUS_COLORS[6] end
        GMQuests.frames.statusInfo:SetTextColor(color[1], color[2], color[3])
    end
end

GameMasterSystem.receivePlayerQuestLog = function(player, data)
    if not data then return end
    GMQuests.state.questLog = data.quests or {}
    if GMQuests.state.viewMode == "active" then
        GMQuests.PopulateQuestLogList()
    end
end

GameMasterSystem.receiveCompletedQuests = function(player, data)
    if not data then return end
    GMQuests.state.completedQuests = data.quests or {}
    GMQuests.state.completedHasMore = data.hasMore or false
    GMQuests.state.completedOffset = data.offset or 0
    if GMQuests.state.viewMode == "completed" then
        GMQuests.PopulateCompletedList()
    end
end

-- After a quest-mutating action the server calls SaveToDB but the async
-- write to character_queststatus hasn't committed yet. Wait 400ms on the
-- client before re-requesting the log + status (the server-side
-- getPlayerQuestLog also SaveToDB+waits, so total gap is ~600ms — plenty).
local ACTION_REFRESH_DELAY = 0.4

GameMasterSystem.receiveQuestActionResult = function(player, data)
    if not data then return end
    if not data.success then
        if CreateStyledToast then
            CreateStyledToast("Quest action failed: " .. (data.message or "Unknown error"), 3, 0.5)
        end
        return
    end

    if CreateStyledToast then
        CreateStyledToast(data.message or "Action completed", 2, 0.5)
    end

    local targetName = GMQuests.state.selectedTargetName or "Self"
    local questId = GMQuests.state.selectedQuestId

    local function doRefresh()
        AIO.Handle("GameMasterSystem", "getPlayerQuestLog", targetName)
        if questId then
            AIO.Handle("GameMasterSystem", "getQuestStatus", targetName, questId)
        end
        if GMQuests.state.viewMode == "completed" then
            AIO.Handle("GameMasterSystem", "getPlayerCompletedQuests",
                targetName, GMQuests.state.completedOffset or 0, COMPLETED_PAGE_SIZE)
        end
    end

    if GMUtils and GMUtils.delay then
        GMUtils.delay(ACTION_REFRESH_DELAY, doRefresh)
    else
        doRefresh()
    end
end

GameMasterSystem.questError = function(player, message)
    if CreateStyledToast then
        CreateStyledToast("Quest: " .. tostring(message), 3, 0.5)
    end
end
