-- GameMaster UI System - Report Dialog
-- This file handles the bug report dialog for submitting issues to GitHub

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

local GMUtils = _G.GMUtils
local GMConfig = _G.GMConfig

-- Create Report Dialog namespace
GMReportDialog = GMReportDialog or {}
local GMReportDialog = GMReportDialog

-- GitHub repository configuration (from config or fallback)
local GITHUB_REPO = GMConfig and GMConfig.config and GMConfig.config.githubRepo or "yourusername/yourrepo"
local GITHUB_ISSUES_URL = "https://github.com/" .. GITHUB_REPO .. "/issues/new"

-- Report categories
local REPORT_CATEGORIES = {
    "Bug Report",
    "Feature Request",
    "UI Issue",
    "Performance Issue",
    "Other"
}

-- Store dialog state
local dialogState = {
    frame = nil,
    titleBox = nil,
    descBox = nil,
    categoryDropdown = nil,
    selectedCategory = 1,
    includeErrors = true,
    recentErrors = {}
}

-- Function to capture recent errors (hook into error handler if available)
function GMReportDialog.CaptureError(errorMsg)
    table.insert(dialogState.recentErrors, 1, {
        time = date("%H:%M:%S"),
        message = errorMsg
    })
    -- Keep only last 10 errors
    while #dialogState.recentErrors > 10 do
        table.remove(dialogState.recentErrors)
    end
end

-- URL encoding function
local function urlEncode(str)
    if str then
        str = string.gsub(str, "\n", "\r\n")
        str = string.gsub(str, "([^%w%-%_%.%~])",
            function(c) return string.format("%%%02X", string.byte(c)) end)
    end
    return str
end

-- Generate system information
local function getSystemInfo()
    local info = {}
    table.insert(info, "=== System Information ===")
    table.insert(info, "Addon Version: GameMasterUI v1.0") -- Update version as needed
    table.insert(info, "Player: " .. (UnitName("player") or "Unknown"))
    table.insert(info, "Realm: " .. (GetRealmName() or "Unknown"))
    table.insert(info, "Level: " .. (UnitLevel("player") or "Unknown"))
    table.insert(info, "Class: " .. (UnitClass("player") or "Unknown"))
    table.insert(info, "Client Locale: " .. (GetLocale() or "Unknown"))
    table.insert(info, "")
    return table.concat(info, "\n")
end

-- Generate error log section
local function getErrorLog()
    if #dialogState.recentErrors == 0 then
        return ""
    end
    
    local log = {}
    table.insert(log, "=== Recent Errors ===")
    for i, error in ipairs(dialogState.recentErrors) do
        table.insert(log, string.format("[%s] %s", error.time, error.message))
    end
    table.insert(log, "")
    return table.concat(log, "\n")
end

-- Generate GitHub issue URL
local function generateIssueURL(title, description, category)
    local body = {}
    
    -- Add category tag
    table.insert(body, "**Category:** " .. category)
    table.insert(body, "")
    
    -- Add description
    table.insert(body, "**Description:**")
    table.insert(body, description or "No description provided")
    table.insert(body, "")
    
    -- Add system info
    table.insert(body, getSystemInfo())
    
    -- Add error log if enabled and available
    if dialogState.includeErrors and #dialogState.recentErrors > 0 then
        table.insert(body, getErrorLog())
    end
    
    -- Add template sections
    table.insert(body, "**Steps to Reproduce:**")
    table.insert(body, "1. ")
    table.insert(body, "2. ")
    table.insert(body, "3. ")
    table.insert(body, "")
    table.insert(body, "**Expected Behavior:**")
    table.insert(body, "")
    table.insert(body, "**Actual Behavior:**")
    table.insert(body, "")
    
    local fullBody = table.concat(body, "\n")
    
    -- Construct the URL with parameters
    local url = GITHUB_ISSUES_URL .. "?"
    if title and title ~= "" then
        url = url .. "title=" .. urlEncode(title)
    end
    url = url .. "&body=" .. urlEncode(fullBody)
    
    -- Add labels based on category
    if category == "Bug Report" then
        url = url .. "&labels=bug"
    elseif category == "Feature Request" then
        url = url .. "&labels=enhancement"
    elseif category == "UI Issue" then
        url = url .. "&labels=ui"
    elseif category == "Performance Issue" then
        url = url .. "&labels=performance"
    end
    
    return url
end

-- Create the copy URL dialog
local function createCopyDialog(url)
    -- Create a simple frame for copying using UIStyleLibrary
    local copyFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    copyFrame:SetSize(600, 200)
    copyFrame:SetPoint("CENTER")
    copyFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    copyFrame:SetFrameLevel(100)
    
    -- Title
    local title = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", copyFrame, "TOP", 0, -10)
    title:SetText("Copy GitHub Issue URL")
    -- Don't set text color - use default white from GameFontNormalLarge
    
    -- Instructions
    local instructions = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    instructions:SetPoint("TOP", title, "BOTTOM", 0, -10)
    instructions:SetText("Select the URL below and press Ctrl+C to copy, then paste in your browser:")
    instructions:SetTextColor(0.8, 0.8, 0.8)
    
    -- Create scrollable container for URL using UIStyleLibrary
    local urlContainer, urlContent, urlScrollBar, updateUrlScroll = CreateScrollableFrame(copyFrame, 560, 60)
    urlContainer:SetPoint("CENTER", copyFrame, "CENTER", 0, -10)
    
    -- Create EditBox for URL inside scrollable content
    local editBox = CreateFrame("EditBox", nil, urlContent)
    editBox:SetPoint("TOPLEFT", 5, -5)
    editBox:SetPoint("TOPRIGHT", -5, -5)
    editBox:SetMultiLine(true)
    editBox:SetMaxLetters(2000)
    editBox:SetFontObject("GameFontNormalSmall")
    editBox:SetTextColor(0.9, 0.9, 0.9, 1)
    editBox:SetAutoFocus(false)
    editBox:SetText(url)
    
    -- Calculate height based on URL length
    local urlLines = math.ceil(string.len(url) / 80) -- Approximate 80 chars per line
    local editBoxHeight = math.max(50, urlLines * 12 + 10)
    editBox:SetHeight(editBoxHeight)
    urlContent:SetHeight(editBoxHeight + 10)
    updateUrlScroll()
    
    -- Focus and select all text for easy copying
    editBox:SetFocus()
    editBox:HighlightText()
    
    -- Prevent editing but keep selectable
    editBox:SetScript("OnTextChanged", function(self)
        self:SetText(url)
        self:HighlightText()
    end)
    
    -- Handle escape to clear focus
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    -- Close button (standard height 24 per style guide)
    local closeBtn = CreateStyledButton(copyFrame, "Close", 80, 24)
    closeBtn:SetPoint("BOTTOM", copyFrame, "BOTTOM", 0, 10)
    closeBtn:SetScript("OnClick", function()
        copyFrame:Hide()
    end)
    
    -- Add success message
    local successMsg = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    successMsg:SetPoint("BOTTOM", closeBtn, "TOP", 0, 5)
    successMsg:SetText("URL ready to copy - Press Ctrl+C")
    successMsg:SetTextColor(UISTYLE_COLORS.Green[1], UISTYLE_COLORS.Green[2], UISTYLE_COLORS.Green[3])
    
    -- ESC to close
    tinsert(UISpecialFrames, copyFrame:GetName() or "GMReportCopyFrame")
    
    copyFrame:Show()
end

-- Create the main report dialog
function GMReportDialog.CreateDialog()
    if dialogState.frame then
        return dialogState.frame
    end
    
    -- Create main frame
    local frame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    frame:SetSize(500, 400)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetFrameStrata("DIALOG")
    frame:SetFrameLevel(100)  -- Ensure proper layering
    frame:Hide()
    
    -- Make draggable
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    
    -- Title
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText("Report Issue")
    -- Don't set text color - let it use default white from GameFontNormalLarge
    
    -- Close button
    local closeBtn = CreateStyledButton(frame, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    -- Calculate centered positions
    local centerX = 250  -- Half of 500 width
    local contentWidth = 420  -- Width for content elements
    local leftMargin = (500 - contentWidth) / 2  -- 40 pixels margin on each side
    
    -- Category label (centered)
    local categoryLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    categoryLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", leftMargin, -40)
    categoryLabel:SetText("Category:")
    
    -- Category dropdown using CreateFullyStyledDropdown for better compatibility
    local categoryDropdown, categoryMenuFrame = CreateFullyStyledDropdown(
        frame, 
        contentWidth - 80,  -- width (leave room for label)
        REPORT_CATEGORIES,  -- items
        REPORT_CATEGORIES[1],  -- default value
        function(value)  -- onSelect callback
            for i, category in ipairs(REPORT_CATEGORIES) do
                if category == value then
                    dialogState.selectedCategory = i
                    break
                end
            end
        end
    )
    categoryDropdown:SetPoint("LEFT", categoryLabel, "RIGHT", UISTYLE_PADDING, 0)
    
    -- Title label
    local titleLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleLabel:SetPoint("TOPLEFT", categoryLabel, "BOTTOMLEFT", 0, -20)
    titleLabel:SetText("Title:")
    
    -- Title input - single line works fine with UIStyleLibrary (centered)
    local titleBox = CreateStyledEditBox(frame, contentWidth, false, 100, false)
    titleBox:SetPoint("TOPLEFT", titleLabel, "BOTTOMLEFT", 0, -5)
    -- EditBox already has SetAutoFocus(false) by default in UIStyleLibrary
    
    -- Description label
    local descLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    descLabel:SetPoint("TOPLEFT", titleBox, "BOTTOMLEFT", 0, -10)
    descLabel:SetText("Description:")
    
    -- Description input using proper scrollable frame (centered)
    local descContainer, descContent, descScrollBar, updateDescScroll = CreateScrollableFrame(frame, contentWidth, 120)
    descContainer:SetPoint("TOPLEFT", descLabel, "BOTTOMLEFT", 0, -5)
    
    -- Create the EditBox inside the scrollable content
    local descEditBox = CreateFrame("EditBox", nil, descContent)
    descEditBox:SetPoint("TOPLEFT", 5, -5)
    descEditBox:SetPoint("TOPRIGHT", -5, -5)
    descEditBox:SetMultiLine(true)
    descEditBox:SetMaxLetters(500)
    descEditBox:SetFontObject("GameFontHighlight")
    descEditBox:SetTextColor(1, 1, 1, 1)
    descEditBox:SetAutoFocus(false)
    
    -- Make EditBox expand as text is added
    descEditBox:SetScript("OnTextChanged", function(self)
        local text = self:GetText()
        local lines = 1
        for _ in string.gmatch(text, "\n") do
            lines = lines + 1
        end
        -- Estimate height based on lines (15 pixels per line)
        local height = math.max(110, lines * 15 + 10)
        self:SetHeight(height)
        descContent:SetHeight(height + 10)
        updateDescScroll()
    end)
    
    -- Initial height
    descEditBox:SetHeight(110)
    descContent:SetHeight(120)
    
    -- Handle escape key to clear focus
    descEditBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    -- Create container wrapper with methods for compatibility
    local descBox = {
        GetText = function() return descEditBox:GetText() end,
        SetText = function(self, text) 
            descEditBox:SetText(text or "")
            descEditBox:GetScript("OnTextChanged")(descEditBox)
        end,
        editBox = descEditBox
    }
    
    -- Include errors checkbox using UIStyleLibrary
    local errorCheckbox = CreateStyledCheckbox(frame, "Include recent errors in report")
    errorCheckbox:SetPoint("TOPLEFT", descContainer, "BOTTOMLEFT", 0, -10)
    errorCheckbox:SetChecked(dialogState.includeErrors)
    errorCheckbox:SetTooltip("Include Errors", "Adds the last 10 Lua errors to the report if available")
    errorCheckbox:SetScript("OnClick", function(self)
        dialogState.includeErrors = self:GetChecked()
    end)
    
    -- Error count indicator
    local errorCount = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    errorCount:SetPoint("LEFT", errorCheckbox, "RIGHT", 10, 0)
    errorCount:SetTextColor(0.7, 0.7, 0.7)
    
    -- Submit button (standard height 24 per style guide)
    local submitBtn = CreateStyledButton(frame, "Generate Report URL", 150, 24)
    submitBtn:SetPoint("BOTTOM", frame, "BOTTOM", -80, 20)
    submitBtn:SetTooltip("Generate URL", "Creates a GitHub issue URL with your report details")
    submitBtn:SetScript("OnClick", function()
        local reportTitle = titleBox:GetText()  -- Container has GetText method
        local reportDesc = descBox:GetText()    -- Container has GetText method
        local category = REPORT_CATEGORIES[dialogState.selectedCategory]
        
        if not reportTitle or reportTitle == "" then
            print("|cFFFF0000[Report] Please enter a title for your report|r")
            return
        end
        
        local url = generateIssueURL(reportTitle, reportDesc, category)
        createCopyDialog(url)
        
        -- Log to server (optional)
        AIO.Handle("GameMasterSystem", "LogReportAttempt", {
            title = reportTitle,
            category = category,
            hasDescription = (reportDesc and reportDesc ~= "")
        })
    end)
    
    -- Cancel button (standard height 24 per style guide)
    local cancelBtn = CreateStyledButton(frame, "Cancel", 100, 24)
    cancelBtn:SetPoint("BOTTOM", frame, "BOTTOM", 80, 20)
    cancelBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    -- Update error count on show
    frame:SetScript("OnShow", function(self)
        errorCount:SetText("(" .. #dialogState.recentErrors .. " errors logged)")
        titleBox:SetText("")  -- Container has SetText method
        descBox:SetText("")    -- Container has SetText method
    end)
    
    -- Store references
    dialogState.frame = frame
    dialogState.titleBox = titleBox
    dialogState.descBox = descBox
    dialogState.categoryDropdown = categoryDropdown
    dialogState.categoryMenuFrame = categoryMenuFrame
    
    -- ESC to close
    tinsert(UISpecialFrames, frame:GetName() or "GMReportDialog")
    
    return frame
end

-- Show the dialog
function GMReportDialog.Show()
    if not dialogState.frame then
        GMReportDialog.CreateDialog()
    end
    dialogState.frame:Show()
end

-- Hide the dialog
function GMReportDialog.Hide()
    if dialogState.frame then
        dialogState.frame:Hide()
    end
end

-- Initialize on load
local function Initialize()
    -- Don't create the dialog immediately, wait until it's needed
    -- This avoids any loading order issues
end

-- Register for initialization (just to hook into the system, actual creation happens on first use)
if GMUtils and GMUtils.RegisterInitializer then
    GMUtils.RegisterInitializer(Initialize)
end