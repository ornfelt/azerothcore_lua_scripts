local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in DatabaseErrorDialog! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI
local GMConfig = _G.GMConfig

-- ============================================================================
-- Database Error Display System
-- ============================================================================

-- Create or get the error notification frame
local errorFrame = nil
local ERROR_DISPLAY_TIME = 10  -- seconds to display error

-- Colors
local COLOR_RED = "|cFFFF0000"
local COLOR_YELLOW = "|cFFFFFF00"
local COLOR_WHITE = "|cFFFFFFFF"
local COLOR_GRAY = "|cFF999999"
local COLOR_END = "|r"

-- Create styled error frame
local function CreateDatabaseErrorFrame()
    if errorFrame then
        return errorFrame
    end

    local frame = CreateFrame("Frame", "GMDatabaseErrorFrame", UIParent)
    frame:SetSize(500, 400)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetFrameStrata("DIALOG")
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()

    -- Background
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetColorTexture(0, 0, 0, 0.9)

    -- Border
    frame.border = frame:CreateTexture(nil, "BORDER")
    frame.border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Border")
    frame.border:SetAllPoints()

    -- Title bar background
    frame.titleBg = frame:CreateTexture(nil, "ARTWORK")
    frame.titleBg:SetPoint("TOPLEFT", 5, -5)
    frame.titleBg:SetPoint("TOPRIGHT", -5, -5)
    frame.titleBg:SetHeight(30)
    frame.titleBg:SetColorTexture(0.5, 0, 0, 0.8)

    -- Title text
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", frame.titleBg, "TOP", 0, -8)
    frame.title:SetText(COLOR_RED .. "Database Error" .. COLOR_END)

    -- Error type text
    frame.errorType = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.errorType:SetPoint("TOPLEFT", frame.titleBg, "BOTTOMLEFT", 10, -10)
    frame.errorType:SetPoint("TOPRIGHT", frame.titleBg, "BOTTOMRIGHT", -10, -10)
    frame.errorType:SetJustifyH("LEFT")
    frame.errorType:SetTextColor(1, 0.8, 0, 1)

    -- Context message
    frame.context = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.context:SetPoint("TOPLEFT", frame.errorType, "BOTTOMLEFT", 0, -5)
    frame.context:SetPoint("TOPRIGHT", frame.errorType, "BOTTOMRIGHT", 0, -5)
    frame.context:SetJustifyH("LEFT")
    frame.context:SetTextColor(0.9, 0.9, 0.9, 1)

    -- Scroll frame for table list
    frame.scrollFrame = CreateFrame("ScrollFrame", "GMDatabaseErrorScrollFrame", frame, "UIPanelScrollFrameTemplate")
    frame.scrollFrame:SetPoint("TOPLEFT", frame.context, "BOTTOMLEFT", 0, -10)
    frame.scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 50)

    -- Content frame inside scroll
    frame.content = CreateFrame("Frame", nil, frame.scrollFrame)
    frame.content:SetSize(440, 200)
    frame.scrollFrame:SetScrollChild(frame.content)

    -- Close button
    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.closeButton:SetSize(100, 25)
    frame.closeButton:SetPoint("BOTTOM", frame, "BOTTOM", -60, 15)
    frame.closeButton:SetText("Close")
    frame.closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    -- Retry button
    frame.retryButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.retryButton:SetSize(100, 25)
    frame.retryButton:SetPoint("BOTTOM", frame, "BOTTOM", 60, 15)
    frame.retryButton:SetText("Retry")
    frame.retryButton:SetScript("OnClick", function()
        frame:Hide()
        -- Retry functionality would trigger a refresh of the current view
        if GMUI and GMUI.RefreshCurrentView then
            GMUI.RefreshCurrentView()
        end
    end)

    errorFrame = frame
    return frame
end

-- Clear content frame
local function ClearContentFrame(frame)
    if not frame or not frame.content then return end

    local children = {frame.content:GetChildren()}
    for _, child in ipairs(children) do
        child:Hide()
        child:SetParent(nil)
    end
end

-- Create table info display
local function CreateTableInfoDisplay(parent, yOffset, tableInfo, index)
    local container = CreateFrame("Frame", nil, parent)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, yOffset)
    container:SetSize(420, 80)

    -- Table name (red, bold)
    local nameText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    nameText:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
    nameText:SetText(string.format(COLOR_RED .. "%d. %s" .. COLOR_END, index, tableInfo.name))
    nameText:SetJustifyH("LEFT")

    -- Suggestion (yellow, wrapped)
    local suggestionText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    suggestionText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -5)
    suggestionText:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, -5)
    suggestionText:SetJustifyH("LEFT")
    suggestionText:SetJustifyV("TOP")
    suggestionText:SetWordWrap(true)
    suggestionText:SetText(COLOR_YELLOW .. tableInfo.suggestion .. COLOR_END)

    -- Get actual height needed
    local textHeight = suggestionText:GetStringHeight()
    container:SetHeight(30 + textHeight + 10)

    return container, container:GetHeight()
end

-- Display database error
function GameMasterSystem.ShowDatabaseError(player, errorData)
    if not errorData then return end

    local frame = CreateDatabaseErrorFrame()
    ClearContentFrame(frame)

    -- Set error type
    local errorTypeText = "Unknown Error"
    if errorData.errorType == "missing_table" then
        errorTypeText = "Missing Database Table(s)"
    elseif errorData.errorType == "missing_required" then
        errorTypeText = COLOR_RED .. "CRITICAL: Missing Required Tables" .. COLOR_END
    elseif errorData.errorType == "missing_optional" then
        errorTypeText = COLOR_YELLOW .. "Missing Optional Tables" .. COLOR_END
    elseif errorData.errorType == "query_failed" then
        errorTypeText = "Database Query Failed"
    elseif errorData.errorType == "invalid_query" then
        errorTypeText = "Invalid Database Query"
    end
    frame.errorType:SetText(errorTypeText)

    -- Set context message
    local contextText = errorData.context or "A database operation failed"
    if errorData.timestamp then
        contextText = contextText .. COLOR_GRAY .. " (" .. errorData.timestamp .. ")" .. COLOR_END
    end
    frame.context:SetText(contextText)

    -- Display missing tables
    local yOffset = -10
    local contentHeight = 10

    if errorData.missingTables and #errorData.missingTables > 0 then
        for index, tableInfo in ipairs(errorData.missingTables) do
            local tableDisplay, height = CreateTableInfoDisplay(frame.content, yOffset, tableInfo, index)
            yOffset = yOffset - height - 15
            contentHeight = contentHeight + height + 15
        end
    else
        -- No specific tables, show general error
        local errorText = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        errorText:SetPoint("TOPLEFT", frame.content, "TOPLEFT", 10, -10)
        errorText:SetPoint("TOPRIGHT", frame.content, "TOPRIGHT", -10, -10)
        errorText:SetJustifyH("LEFT")
        errorText:SetWordWrap(true)
        errorText:SetText(COLOR_RED .. (errorData.message or "An unknown database error occurred") .. COLOR_END)
        contentHeight = errorText:GetStringHeight() + 20
    end

    -- Update content height for scrolling
    frame.content:SetHeight(math.max(contentHeight, frame.scrollFrame:GetHeight()))

    -- Show the frame
    frame:Show()

    -- Auto-hide after delay (but not for critical errors)
    if errorData.errorType ~= "missing_required" then
        CreateLuaEvent(function()
            if frame:IsShown() then
                UIFrameFadeOut(frame, 1.0, 1.0, 0.0)
                CreateLuaEvent(function() frame:Hide() end, 1000, 1)
            end
        end, ERROR_DISPLAY_TIME * 1000, 1)
    end
end

-- Simplified error message for compatibility
function GameMasterSystem.ShowSimpleDatabaseError(player, tableName, suggestion)
    local errorData = {
        errorType = "missing_table",
        context = "Database operation failed",
        missingTables = {
            {
                name = tableName,
                suggestion = suggestion or "Check your database setup"
            }
        },
        timestamp = date("%Y-%m-%d %H:%M:%S")
    }
    GameMasterSystem.ShowDatabaseError(player, errorData)
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Database error dialog module loaded")
end
