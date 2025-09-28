local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- AIO handler for the RuneScape skill system skillHandler
local skillHandler = AIO.AddHandlers("RuneScapeSkillSystem", {})

-- SkillClient table to hold all functions
local SkillClient = {}

local progressionWindow
local mainFrameWidth = 500
local mainFrameHeight = 430

-- Create a frame pool for skill boxes
local skillBoxPool = {}
local activeSkillBoxes = {}

-- Settings table for storing user preferences
local SkillClientSettings = SkillClientSettings or {
    hideUnlockedMilestones = false,
    sortHighToLow = false,
}

function SkillClient.SortProgressionLevel(milestones)
    if milestones and #milestones > 0 then
        if SkillClientSettings.sortHighToLow then
            table.sort(milestones, function(a, b)
                return (a.level or 0) > (b.level or 0)
            end)
        else
            table.sort(milestones, function(a, b)
                return (a.level or 0) < (b.level or 0)
            end)
        end
    end
    return milestones
end

-- Basic RuneScape Skill Window using UIPanelDialogTemplate
function SkillClient.CreateSkillWindow()
    --local frame = CreateFrame("Frame", "RuneScapeSkillWindow", UIParent, "UIPanelDialogTemplate")
    local frame = CreateFrame("Frame", "RuneScapeSkillWindow", UIParent)
    -- Background texture
    frame.Background = frame:CreateTexture(nil, "BACKGROUND")
    frame.Background:SetSize(frame:GetSize())
    frame.Background:SetPoint("CENTER", frame, "CENTER")
    frame.Background:SetTexture("Interface\\Skill_RS\\UIFrameNeutral")
    frame.Background:SetTexCoord(0.2553711, 0.75146484, 0.15185547, 0.5756836)
    --frame.Background:SetVertexColor(0.6, 0.4, 0.2, 1)
    frame.Background:SetSize(mainFrameWidth, mainFrameHeight)

    frame:SetSize(mainFrameWidth, mainFrameHeight)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()

    -- Title text (shared for both tabs)
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -12)
    title:SetText("Skills")
    --title:SetFont(title:GetFont(), 16, "OUTLINE")
    frame.title = title

    -- Title background texture
    local titleBg = frame:CreateTexture(nil, "ARTWORK")
    titleBg:SetTexture("Interface\\Skill_RS\\UIFrameNeutral")
    titleBg:SetTexCoord(0.6430664, 0.9008789, 0.57958984, 0.65185547)
    titleBg:SetSize(180, 32) -- Adjust size as needed
    titleBg:SetPoint("TOP", frame.title, "TOP", 0, 8) -- Position behind the title
    frame.titleBg = titleBg

    -- Make sure the title is above the background
    frame.title:SetDrawLayer("OVERLAY")

    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -3)
    closeBtn:SetNormalTexture("Interface\\BankUI\\closeNormal")
    closeBtn:SetHighlightTexture("Interface\\BankUI\\closeHover")
    closeBtn:SetSize(16, 16)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
        -- Hide progression window if it exists and is shown
        if progressionWindow and progressionWindow:IsShown() then
            progressionWindow:Hide()
        end
    end)
    tinsert(UISpecialFrames, "RuneScapeSkillWindow")

    -- Custom tab buttons with backdrop styling
    local function StyleTabButton(btn, isActive)
        btn:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 8,
            edgeSize = 10,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        if isActive then
            btn:SetBackdropColor(0.2, 0.4, 0.8, 0.8)
            btn:SetBackdropBorderColor(1, 0.82, 0, 1)
        else
            btn:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
            btn:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
        end
    end

    local skillsTabBtn = CreateFrame("Button", nil, frame)
    skillsTabBtn:SetSize(80, 24)
    skillsTabBtn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 16, 25)
    skillsTabBtn:SetNormalFontObject(GameFontNormal)
    skillsTabBtn:SetText("Skills")
    StyleTabButton(skillsTabBtn, true)

    local settingsTabBtn = CreateFrame("Button", nil, frame)
    settingsTabBtn:SetSize(80, 24)
    settingsTabBtn:SetPoint("LEFT", skillsTabBtn, "RIGHT", 8, 0)
    settingsTabBtn:SetNormalFontObject(GameFontNormal)
    settingsTabBtn:SetText("Settings")
    StyleTabButton(settingsTabBtn, false)

    -- Skills content frame (holds all skill UI)
    local skillsContent = CreateFrame("Frame", nil, frame)
    skillsContent:SetAllPoints(frame)
    frame.skillsContent = skillsContent

    -- Settings content frame (holds settings UI, created once and reused)
    local settingsContent = CreateFrame("Frame", nil, frame)
    settingsContent:SetAllPoints(frame)
    settingsContent:Hide()
    frame.settingsContent = settingsContent

    ---- Build settings UI directly in settingsContent (not a separate window)
    local hideUnlockedCheckbox = CreateFrame("CheckButton", nil, settingsContent, "UICheckButtonTemplate")
    hideUnlockedCheckbox:SetPoint("TOPLEFT", 24, -36)
    hideUnlockedCheckbox.text = hideUnlockedCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    hideUnlockedCheckbox.text:SetPoint("LEFT", hideUnlockedCheckbox, "RIGHT", 2, 0)
    hideUnlockedCheckbox.text:SetText("Hide unlocked milestones")
    hideUnlockedCheckbox:SetChecked(SkillClientSettings.hideUnlockedMilestones)
    hideUnlockedCheckbox:SetScript("OnClick", function(self)
        SkillClientSettings.hideUnlockedMilestones = self:GetChecked()
        if progressionWindow and progressionWindow:IsShown() and progressionWindow._lastSkill then
            SkillClient.ShowProgression(progressionWindow._lastSkill, progressionWindow._lastMilestones, progressionWindow._lastExpInfo)
        end
    end)
    settingsContent.hideUnlockedCheckbox = hideUnlockedCheckbox

    -- Checkbox for sorting high to low
    local sortCheckbox = CreateFrame("CheckButton", nil, settingsContent, "UICheckButtonTemplate")
    sortCheckbox:SetPoint("TOPLEFT", 24, -64)
    sortCheckbox.text = sortCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sortCheckbox.text:SetPoint("LEFT", sortCheckbox, "RIGHT", 2, 0)
    sortCheckbox.text:SetText("Show highest level first")
    sortCheckbox:SetChecked(SkillClientSettings.sortHighToLow)
    sortCheckbox:SetScript("OnClick", function(self)
        SkillClientSettings.sortHighToLow = self:GetChecked()
        SkillClient.UpdateSkillButtons()
        -- Also update progression window if it's open
        if progressionWindow and progressionWindow:IsShown() and progressionWindow._lastSkill then
            SkillClient.ShowProgression(progressionWindow._lastSkill, progressionWindow._lastMilestones, progressionWindow._lastExpInfo)
        end
    end)
    settingsContent.sortHighToLowCheckbox = sortCheckbox


    -- Table to hold tab info and logic
    local tabs = {
        { btn = skillsTabBtn, content = skillsContent, title = "Skills" },
        { btn = settingsTabBtn, content = settingsContent, title = "Settings" },
        -- Add more tabs here
    }

    -- Function to switch tabs
    local function SwitchTab(selectedIdx)
        for idx, tab in ipairs(tabs) do
            if idx == selectedIdx then
                tab.content:Show()
                frame.title:SetText(tab.title)
                StyleTabButton(tab.btn, true)

                -- Show pagination controls only on the Skills tab (tab 1)
                if idx == 1 and frame.skillsContent.pageText then
                    if frame.skillsContent.prevPageBtn then
                        frame.skillsContent.prevPageBtn:Show()
                    end
                    if frame.skillsContent.nextPageBtn then
                        frame.skillsContent.nextPageBtn:Show()
                    end
                    frame.skillsContent.pageText:Show()
                end
            else
                tab.content:Hide()
                StyleTabButton(tab.btn, false)

                -- Hide pagination controls for non-Skills tabs
                if idx == 1 and frame.skillsContent.pageText then
                    if frame.skillsContent.prevPageBtn then
                        frame.skillsContent.prevPageBtn:Hide()
                    end
                    if frame.skillsContent.nextPageBtn then
                        frame.skillsContent.nextPageBtn:Hide()
                    end
                    frame.skillsContent.pageText:Hide()
                end
            end
        end
    end

    -- Assign tab switching
    skillsTabBtn:SetScript("OnClick", function()
        SwitchTab(1)
    end)
    settingsTabBtn:SetScript("OnClick", function()
        SwitchTab(2)
    end)

    -- Show first tab by default
    SwitchTab(1)

    return frame
end

local skillWindow = SkillClient.CreateSkillWindow()
-- Toggle the skill window: if open, close; if closed, open and request data
function SkillClient.ToggleSkillWindow()
    if skillWindow:IsShown() then
        skillWindow:Hide()
        -- Also hide progression window if open
        if progressionWindow:IsShown() then
            progressionWindow:Hide()
        end
    else
        -- Request skill data from the server when the window is shown
        AIO.Handle("RuneScapeSkillSystem", "RequestSkillData")
        skillWindow:Show()
    end
end

-- Expose for AIO handler if needed
_G.ToggleSkillWindow = SkillClient.ToggleSkillWindow

-- Register a slash command to toggle the RuneScape Skills window
SLASH_RUNESCAPESKILLS1 = "/skills"
SlashCmdList["RUNESCAPESKILLS"] = function()
    SkillClient.ToggleSkillWindow()
end

local skillsData = {}
local lastProgressionSkillId
local progressionWindowRequested = false

-- Sort skillsData alphabetically by skill name
function SkillClient.SortSkillsAlphabetically(skills)
    table.sort(skills, function(a, b)
        return (a.name or ""):lower() < (b.name or ""):lower()
    end)
end

-- Helper to clear skill buttons
function SkillClient.ClearSkillButtons()
    for _, btn in ipairs(activeSkillBoxes) do
        btn:Hide()
        btn:SetParent(nil)
        -- Return the button to the pool for reuse
        table.insert(skillBoxPool, btn)
    end
    -- Clear the active buttons table
    wipe(activeSkillBoxes)
end

-- Store skill buttons for later reference
local skillsPerRow = 3
local skillBoxSize = 150
local skillBoxHeight = 40
local skillBoxPadding = 10
local skillBoxFontSize = 10
local skillBoxYOffset = -50
local skillBoxXOffset = 16
local skillBoxYSpacing = skillBoxHeight + skillBoxPadding
local skillBoxXSpacing = skillBoxSize + skillBoxPadding
local skillsPerPage = 15
local currentPage = 1
local totalPages = 1

-- Helper to create a skill box
function SkillClient.CreateSkillBox(parent, skill, idx, onClick)
    local btn
    if #skillBoxPool > 0 then
        btn = table.remove(skillBoxPool)
        btn:SetParent(parent)
    else
        btn = CreateFrame("Button", nil, parent)

        -- Background texture (created first, lowest layer) should be
        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetTexture("Interface\\Skill_RS\\ArchaeologyParts")
        bg:SetTexCoord(0.0009765625, 0.62402344, -0.005859375, 0.30273438)
        bg:SetAllPoints(btn)
        btn.bg = bg

        -- Icon positioning
        local icon = btn:CreateTexture(nil, "ARTWORK")
        icon:SetSize(32, 32)
        icon:SetPoint("LEFT", btn, "LEFT", 2, -1)
        btn.icon = icon

        -- NameText
        local nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nameText:SetFont(nameText:GetFont(), skillBoxFontSize)
        nameText:SetPoint("TOPLEFT", icon, "TOPRIGHT", 8, -5)
        --nameText:SetPoint("RIGHT", btn, "RIGHT", -4, 0)
        nameText:SetJustifyH("LEFT")
        --nameText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
        btn.nameText = nameText

        -- LevelText
        local levelText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        levelText:SetFont(levelText:GetFont(), skillBoxFontSize)
        levelText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -2)
        --levelText:SetPoint("RIGHT", btn, "RIGHT", -4, 0)
        levelText:SetJustifyH("LEFT")
        --levelText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
        btn.levelText = levelText

        -- Setup mouse events for tooltips
        btn:EnableMouse(true)
        btn:SetScript("OnEnter", function(self)
            local skillData = self.skillData
            if not skillData then
                return
            end

            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(skillData.name or "?", 1, 1, 1)
            if skillData.description then
                GameTooltip:AddLine(skillData.description, 0.8, 0.8, 0.8, true)
            end
            GameTooltip:AddLine("Level: " .. (skillData.level or 1) .. "/" .. (skillData.max_level or 99), 1, 1, 0.5)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end

    -- Update button data and position
    btn.skillData = skill
    btn:SetSize(skillBoxSize, skillBoxHeight)
    local row = math.floor((idx - 1) / skillsPerRow)
    local col = (idx - 1) % skillsPerRow
    btn:SetPoint(
            "TOPLEFT",
            parent,
            "TOPLEFT",
            skillBoxXOffset + col * skillBoxXSpacing,
            skillBoxYOffset - row * skillBoxYSpacing
    )

    -- Update visual state
    btn.icon:SetTexture("Interface/Icons/" .. (skill.icon or "INV_Misc_QuestionMark"))
    btn.nameText:SetText(skill.name or "?")
    btn.levelText:SetText((skill.level or 1) .. "/" .. (skill.max_level or 99))

    -- Update highlight state based on selection
    if lastProgressionSkillId and skill.id == lastProgressionSkillId then
        btn.animating = true
        btn:SetScript("OnUpdate", function(_)
            local t = GetTime() % 2
            local pulse = 0.5 + 0.5 * math.sin(t * math.pi)
            btn.bg:SetVertexColor(1, 0.84 * pulse, 0.2 * pulse, 0.85)
        end)
    else
        btn.animating = false
        btn.bg:SetVertexColor(1, 1, 1, 1)
        btn:SetScript("OnUpdate", nil)
    end

    -- Update click handler
    btn:SetScript("OnClick", function()
        if progressionWindow:IsShown() and lastProgressionSkillId == skill.id then
            progressionWindow:Hide()
            lastProgressionSkillId = nil
            SkillClient.UpdateSkillButtons()
        else
            progressionWindowRequested = true
            if skill and skill.id then
                AIO.Handle("RuneScapeSkillSystem", "RequestSkillMilestones", skill.id)
            else
                print(
                        "RuneScapeSkillSystem Error: Attempted to request milestones for a skill with no ID. Skill Name: "
                                .. (skill and skill.name or "Unknown")
                )
            end
            if onClick then
                onClick(skill)
            end
        end
    end)

    -- Add to active buttons list
    table.insert(activeSkillBoxes, btn)
    return btn
end
-- Helper to update skill buttons for the current page
function SkillClient.UpdateSkillButtons()
    SkillClient.ClearSkillButtons()
    local startIdx = (currentPage - 1) * skillsPerPage + 1
    local endIdx = math.min(startIdx + skillsPerPage - 1, #skillsData)
    for i = startIdx, endIdx do
        local skill = skillsData[i]
        local btn = SkillClient.CreateSkillBox(skillWindow.skillsContent, skill, i - startIdx + 1, function(_)
            -- print("Clicked skill:", clickedSkill.name, "Level:", clickedSkill.level)
        end)
        btn:Show()
    end
    SkillClient.UpdatePaginationControls()
end

-- Pagination controls
function SkillClient.UpdatePaginationControls()
    if not skillWindow.skillsContent.nextPageBtn then
        -- Previous page button: just a fontstring, clickable
        local prevBtn = CreateFrame("Button", nil, skillWindow.skillsContent)
        prevBtn:SetSize(24, 24)
        prevBtn:SetPoint("BOTTOMLEFT", skillWindow, "BOTTOMLEFT", 16, 55)
        prevBtn.text = prevBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        prevBtn.text:SetAllPoints()
        prevBtn.text:SetText("<")
        prevBtn:SetNormalFontObject(GameFontNormalLarge)
        prevBtn:SetHighlightFontObject(GameFontHighlightLarge)
        prevBtn:SetScript("OnClick", function()
            if currentPage > 1 then
                currentPage = currentPage - 1
                SkillClient.UpdateSkillButtons()
            end
        end)
        prevBtn:SetScript("OnEnter", function(self)
            self.text:SetText("|cffffff00<|r")
        end)
        prevBtn:SetScript("OnLeave", function(self)
            self.text:SetText("<")
        end)
        skillWindow.skillsContent.prevPageBtn = prevBtn

        -- Next page button: just a fontstring, clickable
        local nextBtn = CreateFrame("Button", nil, skillWindow.skillsContent)
        nextBtn:SetSize(24, 24)
        nextBtn:SetPoint("BOTTOMRIGHT", skillWindow, "BOTTOMRIGHT", -16, 55)
        nextBtn.text = nextBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        nextBtn.text:SetAllPoints()
        nextBtn.text:SetText(">")
        nextBtn:SetNormalFontObject(GameFontNormalLarge)
        nextBtn:SetHighlightFontObject(GameFontHighlightLarge)
        nextBtn:SetScript("OnClick", function()
            if currentPage < totalPages then
                currentPage = currentPage + 1
                SkillClient.UpdateSkillButtons()
            end
        end)
        nextBtn:SetScript("OnEnter", function(self)
            self.text:SetText("|cffffff00>|r")
        end)
        nextBtn:SetScript("OnLeave", function(self)
            self.text:SetText(">")
        end)
        skillWindow.skillsContent.nextPageBtn = nextBtn

        local pageText = skillWindow.skillsContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        pageText:SetPoint("BOTTOM", skillWindow, "BOTTOM", 0, 59)
        skillWindow.skillsContent.pageText = pageText
    end

    skillWindow.skillsContent.pageText:SetText("Page " .. currentPage .. "/" .. totalPages)
    if currentPage > 1 then
        skillWindow.skillsContent.prevPageBtn:Enable()
        skillWindow.skillsContent.prevPageBtn.text:SetText("<")
    else
        skillWindow.skillsContent.prevPageBtn:Disable()
        skillWindow.skillsContent.prevPageBtn.text:SetText("|cff888888<|r")
    end
    if currentPage < totalPages then
        skillWindow.skillsContent.nextPageBtn:Enable()
        skillWindow.skillsContent.nextPageBtn.text:SetText(">")
    else
        skillWindow.skillsContent.nextPageBtn:Disable()
        skillWindow.skillsContent.nextPageBtn.text:SetText("|cff888888>|r")
    end
end

-- Add mouse wheel support for page switching
skillWindow.skillsContent:EnableMouseWheel(true)
skillWindow.skillsContent:SetScript("OnMouseWheel", function(_, delta)
    if delta > 0 and currentPage > 1 then
        currentPage = currentPage - 1
        SkillClient.UpdateSkillButtons()
    elseif delta < 0 and currentPage < totalPages then
        currentPage = currentPage + 1
        SkillClient.UpdateSkillButtons()
    end
end)
-- Helper function to calculate title width
local function GetTitleWidth(fontString)
    return fontString:GetStringWidth() + 40 -- Add padding
end
-- Helper to create the progression window
function SkillClient.CreateProgressionWindow()
    --local frame = CreateFrame("Frame", "SkillProgressionWindow", UIParent, "UIPanelDialogTemplate")
    local frame = CreateFrame("Frame", "SkillProgressionWindow", UIParent)
    frame:SetSize(320, 380)
    frame:SetPoint("LEFT", skillWindow, "RIGHT", 24, 0)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()

    --Background texture
    frame.Background = frame:CreateTexture(nil, "BACKGROUND")
    frame.Background:SetSize(frame:GetSize())
    frame.Background:SetPoint("CENTER", frame, "CENTER")
    frame.Background:SetTexture("Interface\\Skill_RS\\UIFrameNeutral")
    frame.Background:SetTexCoord(0.0034179688, 0.24658203, 0.14990234, 0.5776367)
    --frame.Background:SetVertexColor(0.5, 0.5, 0.5, 1)

    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -10)
    frame.title:SetText("Skill Progression")

    -- Title background texture
    local titleBg = frame:CreateTexture(nil, "ARTWORK")
    titleBg:SetTexture("Interface\\Skill_RS\\UIFrameNeutral")
    titleBg:SetTexCoord(0.6430664, 0.9008789, 0.57958984, 0.65185547)

    -- Set initial width based on default title
    local titleWidth = GetTitleWidth(frame.title)
    titleBg:SetSize(titleWidth, 32)
    titleBg:SetPoint("TOP", frame.title, "TOP", 0, 8)
    frame.titleBg = titleBg

    -- Method to update title
    function frame:SetTitle(text)
        self.title:SetText(text)
        -- Update background width after setting new text
        local newWidth = GetTitleWidth(self.title)
        self.titleBg:SetSize(newWidth, 32)
    end

    -- Scroll area for milestones
    local scrollFrame = CreateFrame("ScrollFrame", "SkillProgressionScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 16, -36)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 50)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(1, 1)
    scrollFrame:SetScrollChild(content)
    frame.content = content

    -- Creating the scrollFrame, adjust the scroll buttons position
    local scrollBar = _G[scrollFrame:GetName() .. "ScrollBar"]
    if scrollBar then
        -- Move the ScrollBar itself slightly right (centered at top)
        scrollBar:ClearAllPoints()
        scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -8, -18)
        scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", -8, 16)

        -- Adjust ScrollUp button to match new scrollbar position (centered)
        local scrollUpButton = _G[scrollFrame:GetName() .. "ScrollBarScrollUpButton"]
        if scrollUpButton then
            scrollUpButton:ClearAllPoints()
            scrollUpButton:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 8, -2)
        end

        -- Adjust ScrollDown button to match new scrollbar position
        local scrollDownButton = _G[scrollFrame:GetName() .. "ScrollBarScrollDownButton"]
        if scrollDownButton then
            scrollDownButton:ClearAllPoints()
            scrollDownButton:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 8, 0)
        end
    end

    -- Create XP Bar at bottom
    local xpBarHeight = 16
    local xpBarWidth = frame:GetWidth() - 32

    -- XP Bar background/container
    local xpBarBg = CreateFrame("Frame", nil, frame)
    xpBarBg:SetSize(xpBarWidth, xpBarHeight)
    xpBarBg:SetPoint("BOTTOM", 0, 16)
    xpBarBg:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 8,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    xpBarBg:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    frame.xpBarBg = xpBarBg

    -- XP Bar (Status Bar)
    local xpBar = CreateFrame("StatusBar", nil, xpBarBg)
    xpBar:SetPoint("TOPLEFT", 2, -2)
    xpBar:SetPoint("BOTTOMRIGHT", -2, 2)
    xpBar:SetStatusBarTexture("Interface/TargetingFrame/UI-StatusBar")
    xpBar:SetStatusBarColor(0.25, 0.78, 0.92) -- Light blue for XP
    xpBar:SetMinMaxValues(0, 1)
    xpBar:SetValue(0)
    frame.xpBar = xpBar

    -- XP Text
    local xpText = xpBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    xpText:SetPoint("CENTER", xpBar, "CENTER", 0, 0)
    xpText:SetTextColor(1, 1, 1)
    xpText:SetText("0/1000 XP")
    xpText:SetShadowOffset(1, -1)
    frame.xpText = xpText

    -- XP Label
    local xpLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    xpLabel:SetPoint("BOTTOM", xpBarBg, "TOP", 0, 4)
    xpLabel:SetText("Experience")
    frame.xpLabel = xpLabel

    return frame
end

progressionWindow = SkillClient.CreateProgressionWindow()

function skillHandler.UpdateSkills(_, skills)
    skillsData = skills
    SkillClient.SortSkillsAlphabetically(skills)
    -- Apply sorting before updating the UI
    totalPages = math.max(1, math.ceil(#skillsData / skillsPerPage))
    currentPage = math.min(currentPage, totalPages)
    SkillClient.UpdateSkillButtons()

    -- Refresh milestones if progression window is open
    if progressionWindow:IsShown() and lastProgressionSkillId then
        local updatedSkill
        for _, s in ipairs(skillsData) do
            if s.id == lastProgressionSkillId then
                updatedSkill = s
                break
            end
        end
        if updatedSkill then
            AIO.Handle("RuneScapeSkillSystem", "RequestSkillMilestones", lastProgressionSkillId)
            progressionWindow.title:SetText(updatedSkill.name .. " (Level " .. (updatedSkill.level or 1) .. ")")
            local currentExp = updatedSkill.currentExp or 0
            local nextLevelExp = updatedSkill.nextLevelExp or (currentExp + 1000)
            progressionWindow.xpText:SetText(
                    SkillClient.FormatNumber(currentExp) .. "/" .. SkillClient.FormatNumber(nextLevelExp) .. " XP"
            )
        end
    end
end

-- Helper function to format large numbers with commas
function SkillClient.FormatNumber(number)
    local _, _, minus, int, fraction = tostring(number):find("([-]?)(%d+)([.]?%d*)")
    int = int:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    return minus .. int .. fraction
end

-- Animation system for smoother XP bar updates
function SkillClient.AnimateXPBar(oldData, newData)
    -- If we don't have a progression window or it's not visible, do nothing
    if not progressionWindow or not progressionWindow:IsShown() then
        return
    end

    -- If we're at max level, just update immediately without animation
    if newData.isMaxLevel then
        progressionWindow.xpBar:SetValue(1)
        progressionWindow.xpBar:SetStatusBarColor(1, 0.84, 0) -- Gold for max level
        progressionWindow.xpText:SetText("MAX LEVEL")
        return
    end

    -- Calculate old progress
    local oldCurrentLevelXP = (oldData and oldData.currentLevelExp) or 0
    local oldNextLevelXP = (oldData and oldData.nextLevelExp) or (oldCurrentLevelXP + 1000)
    local oldCurrentXP = (oldData and oldData.currentExp) or oldCurrentLevelXP

    -- Calculate new progress
    local newCurrentLevelXP = newData.currentLevelExp or 0
    local newNextLevelXP = newData.nextLevelExp or (newCurrentLevelXP + 1000)
    local newCurrentXP = newData.currentExp or newCurrentLevelXP

    -- Calculate old and new progress values
    local oldLevelXPGained = oldCurrentXP - oldCurrentLevelXP
    local oldLevelXPNeeded = oldNextLevelXP - oldCurrentLevelXP
    local oldProgress = oldLevelXPNeeded > 0 and oldLevelXPGained / oldLevelXPNeeded or 0

    local newLevelXPGained = newCurrentXP - newCurrentLevelXP
    local newLevelXPNeeded = newNextLevelXP - newCurrentLevelXP
    local newProgress = newLevelXPNeeded > 0 and newLevelXPGained / newLevelXPNeeded or 0 -- Only animate if there's a change to animate
    if oldProgress == newProgress then
        return
    end

    -- Stop any existing animation by removing OnUpdate script
    if progressionWindow.animFrame then
        progressionWindow.animFrame:SetScript("OnUpdate", nil)
    end

    -- Create a smooth easing function
    local function easeOutQuad(t, b, c, d)
        t = t / d
        return -c * t * (t - 2) + b
    end

    -- Setup animation parameters
    local duration = 0.75 -- Animation duration in seconds
    local animStartTime = GetTime()
    local startProgress = progressionWindow.xpBar:GetValue() -- Start from current value
    local endProgress = newProgress

    -- Setup animation frame
    local animFrame = progressionWindow.animFrame or CreateFrame("Frame")
    progressionWindow.animFrame = animFrame

    -- Color function based on progress
    local function updateColor(progress)
        if progress >= 0.9 then
            progressionWindow.xpBar:SetStatusBarColor(1, 0.5, 0) -- Orange-gold for near level
        else
            progressionWindow.xpBar:SetStatusBarColor(0.25, 0.78, 0.92) -- Default blue
        end
    end

    -- Animation update function
    animFrame:SetScript("OnUpdate", function(self, _)
        local currentTime = GetTime()
        local elapsedTime = currentTime - animStartTime

        if elapsedTime >= duration then
            -- Animation complete - set final values
            progressionWindow.xpBar:SetValue(endProgress)
            updateColor(endProgress)

            -- Format the final display text
            local formattedCurrent = SkillClient.FormatNumber(newLevelXPGained)
            local formattedNeeded = SkillClient.FormatNumber(newLevelXPNeeded)
            progressionWindow.xpText:SetText(formattedCurrent .. "/" .. formattedNeeded .. " XP")

            -- Stop animation
            self:SetScript("OnUpdate", nil)
            return
        end

        -- Calculate progress using easing
        local animProgress = easeOutQuad(elapsedTime, 0, 1, duration)
        local currentValue = startProgress + (endProgress - startProgress) * animProgress

        -- Update bar value
        progressionWindow.xpBar:SetValue(currentValue)
        updateColor(currentValue)

        -- Calculate interpolated XP values for text display
        local interpolatedXPGained = math.floor(oldLevelXPGained + (newLevelXPGained - oldLevelXPGained) * animProgress)

        -- Format the text
        local formattedCurrent = SkillClient.FormatNumber(interpolatedXPGained)
        local formattedNeeded = SkillClient.FormatNumber(newLevelXPNeeded)
        progressionWindow.xpText:SetText(formattedCurrent .. "/" .. formattedNeeded .. " XP")
    end)

    -- Store reference to animation
    progressionWindow.xpBarAnim = animFrame
end

-- Animate a left-to-right color fill for milestone description text only
function SkillClient.AnimateMilestoneFill(lineBtn, color)
    if lineBtn.animFrame then
        lineBtn.animFrame:SetScript("OnUpdate", nil)
        lineBtn.animFrame:Hide()
    end

    local text = lineBtn.text:GetText()
    local total = #text
    local duration = 0.7
    local startTime = GetTime()

    -- Start with all gray
    lineBtn.text:SetTextColor(0.53, 0.53, 0.53, 1)
    lineBtn.text:Show()

    local animFrame = lineBtn.animFrame or CreateFrame("Frame", nil, lineBtn)
    lineBtn.animFrame = animFrame
    animFrame:Show()

    animFrame:SetScript("OnUpdate", function(self)
        local elapsed = GetTime() - startTime
        local progress = math.min(elapsed / duration, 1)
        local chars = math.floor(total * progress)
        if chars > 0 then
            local colored = text:sub(1, chars)
            local gray = text:sub(chars + 1)
            lineBtn.text:SetText(
                    "|cff"
                            .. string.format("%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
                            .. colored
                            .. "|r|cff888888"
                            .. gray
                            .. "|r"
            )
        else
            lineBtn.text:SetText("|cff888888" .. text .. "|r")
        end
        if progress >= 1 then
            self:SetScript("OnUpdate", nil)
            lineBtn.text:SetText(
                    "|cff" .. string.format("%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255) .. text .. "|r"
            )
        end
    end)
end

-- Helper to update progression window with milestones
function SkillClient.ShowProgression(skill, milestones, expInfo)
    lastProgressionSkillId = skill.id
    --progressionWindow.title:SetText(skill.name .. " (Level " .. skill.level .. ")")
    progressionWindow:SetTitle(skill.name .. " (Level " .. skill.level .. ")")

    local content = progressionWindow.content

    -- Save the current context for the checkbox handler
    progressionWindow._lastSkill = skill
    progressionWindow._lastMilestones = milestones
    progressionWindow._lastExpInfo = expInfo

    -- Remove the old checkbox UI if it exists
    if progressionWindow.hideUnlockedCheckbox then
        progressionWindow.hideUnlockedCheckbox:Hide()
    end

    -- Use the global setting for hideUnlocked
    local hideUnlocked = SkillClientSettings.hideUnlockedMilestones

    -- Clear previous milestone lines and remove unused frames
    if content.lines then
        for i = 1, #content.lines do
            content.lines[i]:Hide()
        end
    end
    content.lines = content.lines or {}

    -- Remove extra frames if there are more than needed
    local visibleMilestones = {}
    for _, milestone in ipairs(milestones or {}) do
        if not (hideUnlocked and milestone.unlocked) then
            table.insert(visibleMilestones, milestone)
        end
    end

    -- Sort milestones based on the sortHighToLow setting
    visibleMilestones = SkillClient.SortProgressionLevel(visibleMilestones)
    -- Remove unused frames
    for i = #visibleMilestones + 1, #content.lines do
        if content.lines[i] then
            content.lines[i]:Hide()
        end
    end

    -- Render visible milestones
    local y = -4
    for idx, milestone in ipairs(visibleMilestones) do
        local lineBtn = content.lines[idx]
        if not lineBtn then
            lineBtn = CreateFrame("Button", nil, content)
            content.lines[idx] = lineBtn
        end
        lineBtn:SetSize(progressionWindow:GetWidth() - 40, 18)
        lineBtn:SetPoint("TOPLEFT", 0, y)

        -- Create the font string for milestone text if it doesn't exist
        if not lineBtn.text then
            lineBtn.text = lineBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            lineBtn.text:SetPoint("LEFT", 24, 0)
            lineBtn.text:SetJustifyH("LEFT")
            lineBtn.text:SetJustifyV("TOP")
            lineBtn.text:SetWordWrap(false)

            --lineBtn.text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
            --    lineBtn.text:SetFont("Fonts\\FRIZQT__.TTF", 16, "THICKOUTLINE, MONOCHROME")

        end
        -- Add or update icon for reward
        if not lineBtn.icon then
            -- Create the icon background first, slightly larger and behind the icon
            lineBtn.iconBackground = lineBtn:CreateTexture(nil, "BACKGROUND")
            lineBtn.iconBackground:SetSize(20, 20)
            lineBtn.iconBackground:SetPoint("LEFT", lineBtn, "LEFT", 0, 0)
            lineBtn.iconBackground:SetTexture("Interface\\All\\ArtifactForge")
            --lineBtn.iconBackground:SetTexCoord(0.3154297, 0.22558594, 0.9301758, 0.8833008)
            lineBtn.iconBackground:SetTexCoord(0.21777344, 0.32128906, 0.9379883, 0.9926758)
            --lineBtn.iconBackground:SetVertexColor(0.5, 0.5, 0.5, 0.8)


            -- Create the icon on top of the background
            lineBtn.icon = lineBtn:CreateTexture(nil, "ARTWORK")
            lineBtn.icon:SetSize(18, 18)
            lineBtn.icon:SetPoint("CENTER", lineBtn.iconBackground, "CENTER", 0, 0)
            -- Create the lock icon above (OVERLAY)
            lineBtn.lockIcon = lineBtn:CreateTexture(nil, "OVERLAY")
            lineBtn.lockIcon:SetSize(18, 18)
            lineBtn.lockIcon:SetPoint("CENTER", lineBtn.icon, "CENTER", 0, 0)
            lineBtn.lockIcon:SetTexture("Interface\\All\\ArtifactForge")
            lineBtn.lockIcon:SetTexCoord(0.3544922, 0.4404297, 0.7114258, 0.75439453)
            lineBtn.lockIcon:SetVertexColor(1, 1, 1, 1)
        end

        -- Always update lock icon visibility based on milestone state
        if lineBtn.lockIcon then
            if not milestone.unlocked then
                lineBtn.lockIcon:Show()
                lineBtn.iconBackground:Hide()
                lineBtn.icon:SetSize(18, 18)
            else
                lineBtn.lockIcon:Hide()
                lineBtn.iconBackground:Show()
                lineBtn.icon:SetSize(15, 15)
            end
        end

        local iconSet = false
        if milestone.reward_type == "item" and milestone.reward_id and milestone.reward_id > 0 then
            local itemIcon = GetItemIcon and GetItemIcon(milestone.reward_id)
            lineBtn.icon:SetTexture(itemIcon or "Interface/Icons/INV_Misc_QuestionMark")
            iconSet = true
        elseif milestone.reward_type == "spell" and milestone.reward_id and milestone.reward_id > 0 then
            local spellIcon = select(3, GetSpellInfo(milestone.reward_id))
            lineBtn.icon:SetTexture(spellIcon or "Interface/Icons/INV_Misc_QuestionMark")
            iconSet = true
        elseif milestone.reward_type == "currency" then
            lineBtn.icon:SetTexture("Interface/Icons/INV_Misc_Coin_01")
            iconSet = true
        elseif milestone.reward_type == "custom" then
            lineBtn.icon:SetTexture("Interface/Icons/INV_Misc_QuestionMark")
            iconSet = true
        else
            lineBtn.icon:SetTexture("Interface/Icons/INV_Misc_QuestionMark")
            iconSet = true
        end
        if iconSet then
            if not milestone.unlocked then
                lineBtn.icon:SetVertexColor(0.5, 0.5, 0.5, 0.7)
            else
                lineBtn.icon:SetVertexColor(1, 1, 1, 1)
            end
        else
            lineBtn.icon:SetVertexColor(1, 1, 1, 0)
        end
        -- Icon tooltip
        if not lineBtn.iconBtn then
            lineBtn.iconBtn = CreateFrame("Button", nil, lineBtn)
            lineBtn.iconBtn:SetAllPoints(lineBtn.icon)
            lineBtn.iconBtn:SetFrameLevel(lineBtn:GetFrameLevel() + 1)
        end
        lineBtn.iconBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if milestone.reward_type == "item" and milestone.reward_id and milestone.reward_id > 0 then
                if GameTooltip.SetHyperlink then
                    GameTooltip:SetHyperlink("item:" .. milestone.reward_id)
                else
                    GameTooltip:SetText("Item ID: " .. milestone.reward_id, 1, 1, 1)
                end
                if milestone.reward_amount and milestone.reward_amount > 1 then
                    GameTooltip:AddLine("Amount: " .. milestone.reward_amount, 1, 1, 0.5)
                end
            elseif milestone.reward_type == "spell" and milestone.reward_id and milestone.reward_id > 0 then
                if GameTooltip.SetHyperlink then
                    GameTooltip:SetHyperlink("spell:" .. milestone.reward_id)
                else
                    GameTooltip:SetText("Spell ID: " .. milestone.reward_id, 1, 1, 1)
                end
            elseif milestone.reward_type == "currency" then
                GameTooltip:SetText("Currency Reward", 1, 1, 1)
            elseif milestone.reward_type == "custom" then
                GameTooltip:SetText("Custom Reward", 1, 0.8, 1)
            else
                GameTooltip:SetText("No Reward", 1, 1, 1)
            end
            GameTooltip:Show()
        end)
        lineBtn.iconBtn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        -- Milestone text
        local displayText = "Level " .. milestone.level .. ": " .. (milestone.description or "")
        lineBtn.text:SetText(displayText)
        lineBtn.text:SetWidth(progressionWindow:GetWidth() - 80)
        lineBtn.text:SetHeight(18)
        -- Text tooltip
        lineBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(milestone.description or "", 1, 1, 1)
            GameTooltip:Show()
        end)
        lineBtn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        -- Animate color fill for newly unlocked milestones
        if milestone.unlocked and not lineBtn.hasAnimated then
            local milestoneColors = {
                major = { r = 1, g = 0.84, b = 0, a = 1 },
                minor = { r = 0.4, g = 1, b = 0.4, a = 1 },
            }
            local fillColor = milestoneColors[milestone.milestone_type] or { r = 1, g = 1, b = 1, a = 1 }
            SkillClient.AnimateMilestoneFill(lineBtn, fillColor)
            lineBtn.hasAnimated = true
        else
            local milestoneColors = {
                major = { 1, 0.84, 0, 1 },
                minor = { 0.4, 1, 0.4, 1 },
            }
            if milestone.unlocked then
                local color = milestoneColors[milestone.milestone_type] or { 1, 1, 1, 1 }
                lineBtn.text:SetTextColor(unpack(color))
            else
                --lineBtn.text:SetTextColor(0.53, 0.53, 0.53, 1) -- Gray for locked milestones
            --    adjust this text font looks bad here to something more readable
                lineBtn.text:SetTextColor(0.65, 0.65, 0.65, 1)
            end

        end
        lineBtn:Show()
        y = y - 18
    end
    -- Hide any extra lines if milestones list shrank
    for i = #visibleMilestones + 1, #content.lines do
        if content.lines[i] then
            content.lines[i]:Hide()
        end
    end
    content:SetHeight(math.abs(y) + 18)

    -- Update XP Bar if we have experience info
    if expInfo then
        -- If max level, show special display
        if expInfo.isMaxLevel then
            progressionWindow.xpBar:SetValue(1)
            progressionWindow.xpBar:SetStatusBarColor(1, 0.84, 0) -- Gold for max level
            progressionWindow.xpText:SetText("MAX LEVEL")
        else
            -- Calculate current level progress
            local currentLevelXP = expInfo.currentLevelExp or 0
            local nextLevelXP = expInfo.nextLevelExp or (currentLevelXP + 1000) -- Fallback
            local currentXP = expInfo.currentExp or 0

            -- Calculate XP needed for this level
            local levelXPNeeded = nextLevelXP - currentLevelXP
            -- Fix negative experience by ensuring we never show negative values
            local levelXPGained = math.max(0, currentXP - currentLevelXP)

            -- Calculate percentage and set the bar
            local progress = levelXPNeeded > 0 and levelXPGained / levelXPNeeded or 0
            progressionWindow.xpBar:SetValue(progress)

            -- Format the display text
            local formattedCurrent = SkillClient.FormatNumber(levelXPGained)
            local formattedNeeded = SkillClient.FormatNumber(levelXPNeeded)
            progressionWindow.xpText:SetText(formattedCurrent .. "/" .. formattedNeeded .. " XP")

            -- Color the bar based on progress
            if progress >= 0.9 then
                progressionWindow.xpBar:SetStatusBarColor(1, 0.5, 0) -- Orange-gold for near level
            else
                progressionWindow.xpBar:SetStatusBarColor(0.25, 0.78, 0.92) -- Default blue
            end
        end

        -- Set up tooltip for more detailed XP info
        progressionWindow.xpBarBg:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(skill.name .. " Experience", 1, 1, 1)

            if not expInfo.isMaxLevel then
                GameTooltip:AddLine("Current Level: " .. skill.level, 1, 0.82, 0)
                GameTooltip:AddLine("Total XP: " .. SkillClient.FormatNumber(expInfo.currentExp), 1, 1, 1)

                local levelXPNeeded = (expInfo.nextLevelExp or 0) - (expInfo.currentLevelExp or 0)
                local levelXPGained = (expInfo.currentExp or 0) - (expInfo.currentLevelExp or 0)
                local remaining = levelXPNeeded - levelXPGained

                GameTooltip:AddLine("XP to next level: " .. SkillClient.FormatNumber(remaining), 0.25, 0.78, 0.92)
                local progress = math.floor((levelXPGained / levelXPNeeded) * 100)
                GameTooltip:AddLine("Progress: " .. progress .. "%", 0.5, 0.5, 0.8)
            else
                GameTooltip:AddLine("Maximum level reached!", 1, 0.84, 0)
                GameTooltip:AddLine("Total XP: " .. SkillClient.FormatNumber(expInfo.currentExp), 1, 1, 1)
            end

            GameTooltip:Show()
        end)
        progressionWindow.xpBarBg:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    else
        -- No XP info available
        progressionWindow.xpBar:SetValue(0)
        progressionWindow.xpText:SetText("No XP Data")
    end
    tinsert(UISpecialFrames, "SkillProgressionWindow") -- Allow ESC to close the window
    if skillWindow:IsShown() then
        progressionWindow:Show()
    else
        progressionWindow:Hide()
    end
end

-- Handler to receive milestones from server
function skillHandler.UpdateSkillMilestones(_, skillId, milestones, expInfo)
    progressionWindowRequested = false -- Reset the flag after use

    -- Find the skill in skillsData
    local skill
    for _, s in ipairs(skillsData) do
        if s.id == skillId then
            skill = s
            break
        end
    end
    if skill then
        -- Store the previous selected skill ID
        local previousSkillId = lastProgressionSkillId

        -- Show progression for the new skill
        SkillClient.ShowProgression(skill, milestones, expInfo)

        -- If the selected skill has changed, update skill button highlights
        if previousSkillId ~= lastProgressionSkillId then
            SkillClient.UpdateSkillButtons()
        end
    end
end

-- Store current XP data for skills to track changes
local skillXPData = {}

-- Dedicated handler just for XP updates (more efficient than full milestone updates)
function skillHandler.UpdateSkillXP(_, xpInfo)
    if not xpInfo or not xpInfo.skillId then
        return
    end

    -- Store the old XP data for animation
    local oldXPData = skillXPData[xpInfo.skillId] or {}

    -- Find and update skill data
    local skill, skillIndex
    for i, s in ipairs(skillsData) do
        if s.id == xpInfo.skillId then
            skill = s
            skillIndex = i
            break
        end
    end

    if not skill then
        return
    end

    -- Update local skill data
    skillsData[skillIndex].level = xpInfo.level or skill.level
    skillsData[skillIndex].experience = xpInfo.currentExp or skill.experience

    -- Update UI if progression window is visible and showing this skill
    if progressionWindow:IsShown() and lastProgressionSkillId == xpInfo.skillId then
        SkillClient.AnimateXPBar(oldXPData, xpInfo)
    end

    -- Store the new XP data
    skillXPData[xpInfo.skillId] = xpInfo
end
