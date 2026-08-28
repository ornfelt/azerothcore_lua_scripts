local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- CLIENT-SIDE LOGGING SYSTEM
-- ===================================
-- Provides in-game UI for viewing and managing log messages
-- Uses UIStyleLibrary for consistent dark-themed UI

-- ===================================
-- CLIENT-SIDE CONFIGURATION (EMBEDDED)
-- ===================================
local LOGGING_CONFIG = {
    globalLogLevel = 4, -- Default to DEBUG, will be updated from server
    LOG_LEVELS = {
        OFF = 0,
        ERROR = 1,
        WARN = 2,
        INFO = 3,
        DEBUG = 4,
        TRACE = 5
    },
    LOG_LEVEL_NAMES = {
        [0] = "OFF",
        [1] = "ERROR", 
        [2] = "WARN",
        [3] = "INFO",
        [4] = "DEBUG",
        [5] = "TRACE"
    },
    formatting = {
        showTimestamp = true,
        showLogLevel = true,
        showFileName = true,
        timestampFormat = "[%H:%M:%S]",
        maxMessageLength = 0
    },
    client = {
        enableUINotifications = true,
        enableDebugOverlay = true,
        maxClientMessages = 100,
        enableHistory = true
    },
    performance = {
        enabled = true
    },
    filters = {
        blacklistedKeywords = {},
        whitelistedKeywords = {},
        moduleFilters = {}
    }
}

-- ===================================
-- CLIENT LOGGING STATE
-- ===================================
local ClientLogging = {
    messageHistory = {},
    debugOverlay = nil,
    notificationFrame = nil,
    isOverlayVisible = false,
    maxHistorySize = LOGGING_CONFIG.client.maxClientMessages or 100,
    initialized = false
}

-- ===================================
-- AIO HANDLERS FOR SERVER COMMUNICATION
-- ===================================
local LoggingSystemClient = AIO.AddHandlers("LoggingSystem", {})

-- Receive configuration from server
function LoggingSystemClient.ReceiveConfig(player, config)
    if config then
        -- Update client configuration with server data
        for key, value in pairs(config) do
            if LOGGING_CONFIG[key] then
                LOGGING_CONFIG[key] = value
            end
        end
        ClientLogging.maxHistorySize = LOGGING_CONFIG.client.maxClientMessages or 100
        print("Logging system configuration updated from server")
    end
end

-- Receive log message from server
function LoggingSystemClient.ReceiveLogMessage(player, data)
    if data and data.message then
        AddToHistory(data.level or LOGGING_CONFIG.LOG_LEVELS.INFO, data.message, data.source or "Server")
        ShowNotification(data.message, data.level or LOGGING_CONFIG.LOG_LEVELS.INFO)
    end
end

-- Receive statistics from server
function LoggingSystemClient.ReceiveStats(player, stats)
    if stats then
        local message = "Server Stats - "
        if stats.logging then
            message = message .. string.format("Messages: %d, Filtered: %d, Errors: %d", 
                stats.logging.messagesLogged or 0, 
                stats.logging.messagesFiltered or 0, 
                stats.logging.errorCount or 0)
        end
        print(message)
    end
end

-- Receive admin command response
function LoggingSystemClient.CommandResponse(player, response)
    if response then
        print("Logging System:", response)
    end
end

-- ===================================
-- SIMPLIFIED LOG FUNCTIONS FOR CLIENT
-- ===================================

-- Create a simplified Log system for client
if not Log then
    Log = {}
    
    -- Make Log callable
    setmetatable(Log, {
        __call = function(self, message, ...)
            ClientLog(LOGGING_CONFIG.LOG_LEVELS.INFO, message, ...)
        end
    })
end

-- Client-side logging function
local function ClientLog(level, message, ...)
    if not LOGGING_CONFIG.performance.enabled then
        return
    end
    
    if level > LOGGING_CONFIG.globalLogLevel then
        return
    end
    
    -- Handle multiple arguments
    local fullMessage = tostring(message)
    if ... then
        local args = {...}
        for i = 1, #args do
            args[i] = tostring(args[i])
        end
        fullMessage = fullMessage .. " " .. table.concat(args, " ")
    end
    
    -- Add to history
    AddToHistory(level, fullMessage, "Client")
    
    -- Show notification if appropriate
    ShowNotification(fullMessage, level)
    
    -- Send to server if it's an error or higher
    if level <= LOGGING_CONFIG.LOG_LEVELS.WARN then
        AIO.Handle("LoggingSystem", "LogToServer", level, fullMessage, "Client")
    end
end

-- Add client-side log level functions
Log.Error = function(message, ...) ClientLog(LOGGING_CONFIG.LOG_LEVELS.ERROR, message, ...) end
Log.Warn = function(message, ...) ClientLog(LOGGING_CONFIG.LOG_LEVELS.WARN, message, ...) end
Log.Info = function(message, ...) ClientLog(LOGGING_CONFIG.LOG_LEVELS.INFO, message, ...) end
Log.Debug = function(message, ...) ClientLog(LOGGING_CONFIG.LOG_LEVELS.DEBUG, message, ...) end
Log.Trace = function(message, ...) ClientLog(LOGGING_CONFIG.LOG_LEVELS.TRACE, message, ...) end

-- ===================================
-- UI NOTIFICATION SYSTEM (Using UIStyleLibrary)
-- ===================================

local function CreateNotificationFrame()
    if ClientLogging.notificationFrame then
        return ClientLogging.notificationFrame
    end
    
    -- Use UIStyleLibrary function
    local frame = CreateStyledFrame(UIParent, UISTYLE_COLORS.ButtonBg)
    frame:SetSize(400, 60)
    frame:SetPoint("TOP", UIParent, "TOP", 0, -100)
    frame:SetFrameStrata("TOOLTIP")
    frame:Hide()
    
    -- Text
    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.text:SetPoint("CENTER")
    frame.text:SetTextColor(1, 1, 1)
    
    -- Use UIStyleLibrary close button
    local closeButton = CreateStyledButton(frame, "X", 20, 20)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function() frame:Hide() end)
    closeButton:SetTooltip("Close")
    
    ClientLogging.notificationFrame = frame
    return frame
end

function ShowNotification(message, level)
    if not LOGGING_CONFIG.client.enableUINotifications then
        return
    end
    
    -- Only show notifications for ERROR and WARN levels
    if level > LOGGING_CONFIG.LOG_LEVELS.WARN then
        return
    end
    
    local frame = CreateNotificationFrame()
    frame.text:SetText(message)
    
    -- Set color based on level
    if level == LOGGING_CONFIG.LOG_LEVELS.ERROR then
        frame.text:SetTextColor(1, 0.3, 0.3) -- Red
    else -- WARN
        frame.text:SetTextColor(1, 0.8, 0.2) -- Orange
    end
    
    frame:Show()
    
    -- Auto-hide after 5 seconds
    C_Timer.After(5, function()
        if frame and frame:IsShown() then
            frame:Hide()
        end
    end)
end

-- ===================================
-- DEBUG OVERLAY SYSTEM (Using UIStyleLibrary)
-- ===================================

local function CreateDebugOverlay()
    if ClientLogging.debugOverlay then
        return ClientLogging.debugOverlay
    end
    
    -- Create named frame for UISpecialFrames (must be named during creation in 3.3.5)
    local frameName = "LoggingDebugOverlay"
    local frame = CreateFrame("Frame", frameName, UIParent)
    
    -- Apply UIStyleLibrary styling manually since we need a named frame
    frame:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    frame:SetBackdropColor(unpack(UISTYLE_COLORS.DarkGrey))
    frame:SetBackdropBorderColor(unpack(UISTYLE_COLORS.BorderGrey))
    
    frame:SetSize(600, 400)
    frame:SetPoint("CENTER", UIParent, "CENTER", 200, 0)
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()
    
    -- Add to UISpecialFrames for escape key closing
    tinsert(UISpecialFrames, frameName)
    
    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -10)
    frame.title:SetText("Debug Log Overlay")
    frame.title:SetTextColor(unpack(UISTYLE_COLORS.White))
    
    -- Use UIStyleLibrary close button
    local closeButton = CreateStyledButton(frame, "X", 24, 24)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
        ClientLogging.isOverlayVisible = false
    end)
    closeButton:SetTooltip("Close")
    
    -- Use UIStyleLibrary scrollable frame
    local scrollContainer, scrollContent, scrollBar = CreateScrollableFrame(frame, 560, 320)
    scrollContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -40)
    scrollContainer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 50)
    
    frame.scrollContainer = scrollContainer
    frame.scrollContent = scrollContent
    frame.scrollBar = scrollBar
    
    -- Use UIStyleLibrary buttons
    local clearButton = CreateStyledButton(frame, "Clear", 80, 24)
    clearButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
    clearButton:SetScript("OnClick", function()
        ClientLogging.messageHistory = {}
        UpdateDebugOverlay()
    end)
    clearButton:SetTooltip("Clear all log messages")
    
    local exportButton = CreateStyledButton(frame, "Export", 80, 24)
    exportButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
    exportButton:SetScript("OnClick", function()
        ExportToChat(20)
    end)
    exportButton:SetTooltip("Export last 20 messages to chat")
    
    local statsButton = CreateStyledButton(frame, "Stats", 80, 24)
    statsButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    statsButton:SetScript("OnClick", function()
        AIO.Handle("LoggingSystem", "GetStats")
    end)
    statsButton:SetTooltip("Get server statistics")
    
    ClientLogging.debugOverlay = frame
    return frame
end

-- ===================================
-- INTERACTIVE MESSAGE SYSTEM
-- ===================================

-- Global variables for message interaction
local selectedMessages = {}
local clipboardEditBox = nil
local currentFilter = nil

-- Create clipboard EditBox (hidden, used for copy operations)
local function CreateClipboardEditBox(parent)
    if clipboardEditBox then
        return clipboardEditBox
    end
    
    local editBox = CreateFrame("EditBox", nil, parent)
    editBox:SetSize(300, 100)
    editBox:SetPoint("CENTER", parent, "CENTER")
    editBox:SetMultiLine(true)
    editBox:SetAutoFocus(true)
    editBox:SetFontObject(GameFontNormalSmall)
    editBox:Hide()
    
    -- Style the EditBox
    editBox:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false, edgeSize = 1,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    editBox:SetBackdropColor(unpack(UISTYLE_COLORS.DarkGrey))
    editBox:SetBackdropBorderColor(unpack(UISTYLE_COLORS.Blue))
    
    -- Title text
    local title = editBox:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("BOTTOM", editBox, "TOP", 0, 5)
    title:SetText("Press Ctrl+C to copy, then click anywhere to close")
    title:SetTextColor(unpack(UISTYLE_COLORS.Gold))
    
    -- Auto-hide when clicking outside or pressing escape
    editBox:SetScript("OnEscapePressed", function(self)
        self:Hide()
    end)
    
    clipboardEditBox = editBox
    return editBox
end

-- Copy text to clipboard using EditBox trick
local function CopyToClipboard(text, parent)
    local editBox = CreateClipboardEditBox(parent)
    editBox:SetText(text)
    editBox:Show()
    editBox:SetFocus()
    editBox:HighlightText()
    
    -- Auto-hide after 10 seconds
    C_Timer.After(10, function()
        if editBox:IsShown() then
            editBox:Hide()
        end
    end)
end

-- Get level icon
local function GetLevelIcon(level)
    if level == 1 then return "[ERROR]" -- ERROR
    elseif level == 2 then return "[WARN]" -- WARN
    elseif level == 3 then return "[INFO]" -- INFO
    elseif level == 4 then return "[DEBUG]" -- DEBUG
    else return "[TRACE]" -- TRACE
    end
end

-- Check if message passes current filter
local function PassesFilter(entry)
    if not currentFilter then
        return true
    end
    
    if currentFilter.type == "level" then
        return entry.level == currentFilter.value
    elseif currentFilter.type == "source" then
        return entry.fileName == currentFilter.value
    end
    
    return true
end

-- Handle message click events
local function HandleMessageClick(messageFrame, button, entry, index)
    if button == "LeftButton" then
        -- Handle selection
        if IsShiftKeyDown() then
            -- Multi-select with shift
            if selectedMessages[index] then
                selectedMessages[index] = nil
                messageFrame:SetBackdropColor(0, 0, 0, 0) -- Clear selection
            else
                selectedMessages[index] = entry
                messageFrame:SetBackdropColor(unpack(UISTYLE_COLORS.Blue), 0.3) -- Highlight
            end
        elseif IsControlKeyDown() then
            -- Quick copy with Ctrl+click
            CopyToClipboard(entry.formattedMessage, ClientLogging.debugOverlay)
        else
            -- Single select
            selectedMessages = {} -- Clear other selections
            selectedMessages[index] = entry
            UpdateDebugOverlay() -- Refresh to show selection
        end
        
    elseif button == "RightButton" then
        -- Show context menu
        ShowMessageContextMenu(entry, index, messageFrame)
    end
end

-- Show context menu for message
function ShowMessageContextMenu(entry, index, anchorFrame)
    local menuItems = {
        {
            text = "[COPY] Copy Message",
            func = function()
                CopyToClipboard(entry.formattedMessage, ClientLogging.debugOverlay)
            end
        },
        {
            text = "[TEXT] Copy Text Only",
            func = function()
                CopyToClipboard(entry.message, ClientLogging.debugOverlay)
            end
        },
        { isSeparator = true },
        {
            text = "[FILTER] Filter",
            hasArrow = true,
            menuList = {
                {
                    text = "Show Only " .. LOGGING_CONFIG.LOG_LEVEL_NAMES[entry.level],
                    func = function()
                        currentFilter = {type = "level", value = entry.level}
                        UpdateDebugOverlay()
                    end
                },
                {
                    text = "Show Only " .. (entry.fileName or "Unknown"),
                    func = function()
                        currentFilter = {type = "source", value = entry.fileName}
                        UpdateDebugOverlay()
                    end
                },
                {
                    text = "Clear Filter",
                    func = function()
                        currentFilter = nil
                        UpdateDebugOverlay()
                    end
                }
            }
        },
        {
            text = "[CLEAR] Clear Before This",
            func = function()
                -- Remove messages before this index
                for i = 1, index - 1 do
                    table.remove(ClientLogging.messageHistory, 1)
                end
                UpdateDebugOverlay()
            end
        },
        { isSeparator = true },
        {
            text = "[EXPORT] Export Selected",
            func = function()
                local selectedText = {}
                for idx, selectedEntry in pairs(selectedMessages) do
                    table.insert(selectedText, selectedEntry.formattedMessage)
                end
                if #selectedText > 0 then
                    CopyToClipboard(table.concat(selectedText, "\n"), ClientLogging.debugOverlay)
                else
                    print("No messages selected")
                end
            end
        }
    }
    
    -- Use UIStyleLibrary context menu
    ShowFullyStyledContextMenu(menuItems, "cursor", "BOTTOMLEFT", "TOPLEFT", 0, 0)
end

function UpdateDebugOverlay()
    if not ClientLogging.debugOverlay or not ClientLogging.isOverlayVisible then
        return
    end
    
    local scrollContent = ClientLogging.debugOverlay.scrollContent
    
    -- Clear existing children
    local children = {scrollContent:GetChildren()}
    for _, child in ipairs(children) do
        child:Hide()
        child:SetParent(nil)
    end
    
    -- Add messages as interactive frames
    local yOffset = 0
    local lineHeight = 18 -- Slightly taller for better click area
    local startIndex = math.max(1, #ClientLogging.messageHistory - 50)
    local displayIndex = 0
    
    for i = startIndex, #ClientLogging.messageHistory do
        local entry = ClientLogging.messageHistory[i]
        if entry and PassesFilter(entry) then
            displayIndex = displayIndex + 1
            
            -- Create interactive message frame
            local messageFrame = CreateFrame("Button", nil, scrollContent)
            messageFrame:SetSize(scrollContent:GetWidth() - 10, lineHeight)
            messageFrame:SetPoint("TOPLEFT", scrollContent, "TOPLEFT", 5, -yOffset)
            messageFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            
            -- Background for hover and selection
            messageFrame:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8X8",
                tile = false
            })
            messageFrame:SetBackdropColor(0, 0, 0, 0) -- Transparent by default
            
            -- Highlight selected messages
            if selectedMessages[i] then
                messageFrame:SetBackdropColor(unpack(UISTYLE_COLORS.Blue), 0.3)
            end
            
            -- Hover effect
            messageFrame:SetScript("OnEnter", function(self)
                if not selectedMessages[i] then
                    self:SetBackdropColor(unpack(UISTYLE_COLORS.ButtonBg), 0.5)
                end
                
                -- Show tooltip with full message and details
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                GameTooltip:SetText(entry.message, 1, 1, 1, 1, true)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Level: " .. LOGGING_CONFIG.LOG_LEVEL_NAMES[entry.level], 0.7, 0.7, 0.7)
                GameTooltip:AddLine("Source: " .. (entry.fileName or "Unknown"), 0.7, 0.7, 0.7)
                GameTooltip:AddLine("Time: " .. date(LOGGING_CONFIG.formatting.timestampFormat, entry.timestamp), 0.7, 0.7, 0.7)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Left-click: Select | Ctrl+Left: Copy | Right-click: Menu", 0.5, 0.5, 0.5)
                GameTooltip:Show()
            end)
            
            messageFrame:SetScript("OnLeave", function(self)
                if not selectedMessages[i] then
                    self:SetBackdropColor(0, 0, 0, 0)
                end
                GameTooltip:Hide()
            end)
            
            -- Handle clicks
            messageFrame:SetScript("OnClick", function(self, button)
                HandleMessageClick(self, button, entry, i)
            end)
            
            -- Create text elements
            local iconText = messageFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            iconText:SetPoint("LEFT", messageFrame, "LEFT", 2, 0)
            iconText:SetText(GetLevelIcon(entry.level))
            
            local messageText = messageFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            messageText:SetPoint("LEFT", iconText, "RIGHT", 5, 0)
            messageText:SetPoint("RIGHT", messageFrame, "RIGHT", -5, 0)
            messageText:SetJustifyH("LEFT")
            
            -- Truncate long messages
            local displayMessage = entry.formattedMessage
            if string.len(displayMessage) > 80 then
                displayMessage = string.sub(displayMessage, 1, 77) .. "..."
            end
            messageText:SetText(displayMessage)
            
            -- Color based on level using UISTYLE_COLORS
            if entry.level == 1 then -- ERROR
                messageText:SetTextColor(unpack(UISTYLE_COLORS.Red))
            elseif entry.level == 2 then -- WARN
                messageText:SetTextColor(unpack(UISTYLE_COLORS.Gold))
            elseif entry.level == 3 then -- INFO
                messageText:SetTextColor(unpack(UISTYLE_COLORS.White))
            elseif entry.level == 4 then -- DEBUG
                messageText:SetTextColor(unpack(UISTYLE_COLORS.Blue))
            else -- TRACE
                messageText:SetTextColor(unpack(UISTYLE_COLORS.TextGrey))
            end
            
            yOffset = yOffset + lineHeight
        end
    end
    
    -- Show filter status
    if currentFilter then
        local filterFrame = CreateFrame("Frame", nil, scrollContent)
        filterFrame:SetSize(scrollContent:GetWidth() - 10, 20)
        filterFrame:SetPoint("TOPLEFT", scrollContent, "TOPLEFT", 5, -yOffset)
        
        filterFrame:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            tile = false
        })
        filterFrame:SetBackdropColor(unpack(UISTYLE_COLORS.Gold), 0.3)
        
        local filterText = filterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        filterText:SetPoint("CENTER")
        filterText:SetText("[FILTER] Filter Active: " .. (currentFilter.type == "level" and 
            LOGGING_CONFIG.LOG_LEVEL_NAMES[currentFilter.value] or currentFilter.value) .. 
            " (Right-click any message -> Filter -> Clear Filter)")
        filterText:SetTextColor(unpack(UISTYLE_COLORS.Gold))
        
        yOffset = yOffset + 25
    end
    
    scrollContent:SetHeight(math.max(1, yOffset))
end

function ShowDebugOverlay()
    local frame = CreateDebugOverlay()
    frame:Show()
    ClientLogging.isOverlayVisible = true
    UpdateDebugOverlay()
end

function ToggleDebugOverlay()
    if ClientLogging.isOverlayVisible then
        ClientLogging.debugOverlay:Hide()
        ClientLogging.isOverlayVisible = false
    else
        ShowDebugOverlay()
    end
end

-- ===================================
-- MESSAGE HISTORY SYSTEM
-- ===================================

function AddToHistory(level, message, fileName)
    if not LOGGING_CONFIG.client.enableHistory then
        return
    end
    
    -- Use WoW-compatible time functions
    local currentTime = GetTime() -- WoW function that returns seconds since login
    local timeString = date(LOGGING_CONFIG.formatting.timestampFormat) -- WoW's global date function
    
    local entry = {
        timestamp = currentTime,
        level = level,
        message = message,
        fileName = fileName,
        formattedMessage = string.format("%s [%s] %s: %s", 
            timeString, 
            fileName or "Unknown",
            LOGGING_CONFIG.LOG_LEVEL_NAMES[level] or "UNKNOWN", 
            message)
    }
    
    table.insert(ClientLogging.messageHistory, entry)
    
    -- Trim history if too large
    if #ClientLogging.messageHistory > ClientLogging.maxHistorySize then
        table.remove(ClientLogging.messageHistory, 1)
    end
    
    -- Update debug overlay if visible
    if ClientLogging.isOverlayVisible then
        UpdateDebugOverlay()
    end
end

function ExportToChat(count)
    count = count or 20
    local start = math.max(1, #ClientLogging.messageHistory - count + 1)
    
    print("=== Exporting last", count, "log messages ===")
    for i = start, #ClientLogging.messageHistory do
        local entry = ClientLogging.messageHistory[i]
        if entry then
            print(entry.formattedMessage)
        end
    end
    print("=== Export complete ===")
end

-- ===================================
-- SLASH COMMANDS
-- ===================================

SLASH_LOGDEBUG1 = "/logdebug"
SLASH_LOGDEBUG2 = "/ld"
SlashCmdList["LOGDEBUG"] = function(msg)
    local args = {}
    for word in msg:gmatch("%S+") do
        table.insert(args, word:lower())
    end
    
    if #args == 0 or args[1] == "toggle" then
        ToggleDebugOverlay()
        
    elseif args[1] == "show" then
        ShowDebugOverlay()
        
    elseif args[1] == "hide" then
        if ClientLogging.debugOverlay then
            ClientLogging.debugOverlay:Hide()
            ClientLogging.isOverlayVisible = false
        end
        
    elseif args[1] == "clear" then
        ClientLogging.messageHistory = {}
        selectedMessages = {} -- Clear selections too
        currentFilter = nil -- Clear filter
        if ClientLogging.isOverlayVisible then
            UpdateDebugOverlay()
        end
        print("Debug log history cleared")
        
    elseif args[1] == "export" then
        local count = tonumber(args[2]) or 20
        ExportToChat(count)
        
    elseif args[1] == "filter" then
        if args[2] == "clear" then
            currentFilter = nil
            if ClientLogging.isOverlayVisible then
                UpdateDebugOverlay()
            end
            print("Filter cleared")
        elseif args[2] == "level" and args[3] then
            local levelName = args[3]:upper()
            local levelNum = nil
            for num, name in pairs(LOGGING_CONFIG.LOG_LEVEL_NAMES) do
                if name == levelName then
                    levelNum = num
                    break
                end
            end
            if levelNum then
                currentFilter = {type = "level", value = levelNum}
                if ClientLogging.isOverlayVisible then
                    UpdateDebugOverlay()
                end
                print("Filtering by level:", levelName)
            else
                print("Invalid level. Use: ERROR, WARN, INFO, DEBUG, TRACE")
            end
        else
            print("Usage: /logdebug filter clear  or  /logdebug filter level ERROR")
        end
        
    elseif args[1] == "select" then
        if args[2] == "all" then
            selectedMessages = {}
            for i = 1, #ClientLogging.messageHistory do
                selectedMessages[i] = ClientLogging.messageHistory[i]
            end
            if ClientLogging.isOverlayVisible then
                UpdateDebugOverlay()
            end
            print("All messages selected")
        elseif args[2] == "clear" then
            selectedMessages = {}
            if ClientLogging.isOverlayVisible then
                UpdateDebugOverlay()
            end
            print("Selection cleared")
        else
            print("Usage: /logdebug select all  or  /logdebug select clear")
        end
        
    elseif args[1] == "stats" then
        AIO.Handle("LoggingSystem", "GetStats")
        
    elseif args[1] == "test" then
        Log.Error("Test error message from client")
        Log.Warn("Test warning message from client")
        Log.Info("Test info message from client")
        Log.Debug("Test debug message from client")
        Log.Trace("Test trace message from client")
        
    elseif args[1] == "admin" and args[2] then
        -- Admin commands (requires GM privileges on server)
        local command = args[2]
        local value = args[3]
        AIO.Handle("LoggingSystem", "AdminCommand", command, value)
        
    else
        print("Log Debug Commands:")
        print("/logdebug toggle - Toggle debug overlay")
        print("/logdebug show - Show debug overlay")
        print("/logdebug hide - Hide debug overlay")
        print("/logdebug clear - Clear message history")
        print("/logdebug export [count] - Export last N messages to chat")
        print("/logdebug filter clear - Clear active filter")
        print("/logdebug filter level ERROR - Filter by log level")
        print("/logdebug select all - Select all visible messages")
        print("/logdebug select clear - Clear selection")
        print("/logdebug stats - Get server statistics")
        print("/logdebug test - Send test messages")
        print("/logdebug admin <command> [value] - Admin commands (GM only)")
        print("  Admin commands: setlevel, getstats, clearstats, enable, disable")
        print("")
        print("Interactive Features (in overlay window):")
        print("* Hover over messages for detailed tooltip")
        print("* Left-click to select message")
        print("* Shift+Left-click for multi-select")
        print("* Ctrl+Left-click to quick copy message")
        print("* Right-click for context menu with copy/filter options")
        print("* Messages show icons: [ERROR] ERROR, [WARN] WARN, [INFO] INFO, [DEBUG] DEBUG, [TRACE] TRACE")
    end
end

-- ===================================
-- INITIALIZATION
-- ===================================

local function Initialize()
    if ClientLogging.initialized then
        return
    end
    
    ClientLogging.initialized = true
    
    -- Request configuration from server
    AIO.Handle("LoggingSystem", "GetConfig")
    
    print("Client-side logging system initialized")
    print("Use /logdebug or /ld to access debug tools")
end

-- Initialize when the addon loads
Initialize()

-- Also initialize on ADDON_LOADED event as backup
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "PLAYER_LOGIN" then
        Initialize()
        self:UnregisterAllEvents()
    end
end)