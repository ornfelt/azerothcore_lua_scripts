-- ===================================
-- LOGGING SYSTEM AIO SERVER HANDLER
-- ===================================
-- Handles client-server communication for the logging system

-- Only load on server side
if GetStateMapId and GetStateMapId() ~= -1 then
    return
end

local AIO = AIO or require("AIO")
local LoggingSystemHandler = AIO.AddHandlers("LoggingSystem", {})

-- Ensure core logging is loaded
if not Log then
    dofile(GetLuaEngine():GetScriptPath() .. "AIO_Server/00_LoggingSystem/LoggingCore.lua")
end

-- ===================================
-- SERVER-SIDE HANDLERS FOR CLIENT REQUESTS
-- ===================================

-- Handler for client requesting logging configuration
function LoggingSystemHandler.GetConfig(player)
    if not player then
        Log.Error("GetConfig called without player")
        return
    end
    
    Log.Debug("Sending logging configuration to client:", player:GetName())
    
    -- Send the essential configuration to the client
    local clientConfig = {
        globalLogLevel = LOGGING_CONFIG.globalLogLevel,
        LOG_LEVELS = LOGGING_CONFIG.LOG_LEVELS,
        LOG_LEVEL_NAMES = LOGGING_CONFIG.LOG_LEVEL_NAMES,
        formatting = {
            showTimestamp = LOGGING_CONFIG.formatting.showTimestamp,
            showLogLevel = LOGGING_CONFIG.formatting.showLogLevel,
            showFileName = LOGGING_CONFIG.formatting.showFileName,
            timestampFormat = LOGGING_CONFIG.formatting.timestampFormat,
            maxMessageLength = LOGGING_CONFIG.formatting.maxMessageLength
        },
        client = LOGGING_CONFIG.client,
        performance = {
            enabled = LOGGING_CONFIG.performance.enabled
        },
        filters = LOGGING_CONFIG.filters
    }
    
    AIO.Handle(player, "LoggingSystem", "ReceiveConfig", clientConfig)
end

-- Handler for client log messages that should be stored server-side
function LoggingSystemHandler.LogToServer(player, level, message, fileName)
    if not player then
        Log.Error("LogToServer called without player")
        return
    end
    
    -- Validate parameters
    if not level or not message then
        Log.Error("LogToServer called with invalid parameters from", player:GetName())
        return
    end
    
    -- Log the message using server-side logging with player context
    if Log.Server and Log.Server.Player then
        Log.Server.Player(level, player, "[CLIENT] " .. tostring(message))
    else
        -- Fallback to regular logging
        local levelName = LOGGING_CONFIG.LOG_LEVEL_NAMES[level] or "UNKNOWN"
        Log.Info(string.format("[CLIENT-%s] %s: %s", levelName, player:GetName(), tostring(message)))
    end
end

-- Handler for client requesting statistics
function LoggingSystemHandler.GetStats(player)
    if not player then
        Log.Error("GetStats called without player")
        return
    end
    
    local stats = Log.GetStats()
    local serverStats = {}
    
    if Log.Server and Log.Server.GetPerformanceReport then
        local perfReport = Log.Server.GetPerformanceReport()
        serverStats.performanceReport = perfReport
    end
    
    local combinedStats = {
        logging = stats,
        server = serverStats
    }
    
    AIO.Handle(player, "LoggingSystem", "ReceiveStats", combinedStats)
    Log.Debug("Sent logging statistics to client:", player:GetName())
end

-- Handler for admin commands from client
function LoggingSystemHandler.AdminCommand(player, command, ...)
    if not player then
        Log.Error("AdminCommand called without player")
        return
    end
    
    -- Check if player has GM privileges (adjust level as needed)
    local requiredGMLevel = 2
    if player:GetGMRank() < requiredGMLevel then
        Log.Warn("Non-GM player", player:GetName(), "attempted logging admin command:", command)
        AIO.Handle(player, "LoggingSystem", "CommandResponse", "Insufficient privileges")
        return
    end
    
    local args = {...}
    local response = ""
    
    if command == "setlevel" then
        local newLevel = tonumber(args[1])
        if newLevel and newLevel >= 0 and newLevel <= 5 then
            local oldLevel = LOGGING_CONFIG.globalLogLevel
            LOGGING_CONFIG.globalLogLevel = newLevel
            response = string.format("Log level changed from %s to %s", 
                LOGGING_CONFIG.LOG_LEVEL_NAMES[oldLevel], 
                LOGGING_CONFIG.LOG_LEVEL_NAMES[newLevel])
            Log.Info("GM", player:GetName(), "changed global log level to", newLevel)
        else
            response = "Invalid log level. Use 0-5 (OFF, ERROR, WARN, INFO, DEBUG, TRACE)"
        end
        
    elseif command == "getstats" then
        local stats = Log.GetStats()
        response = string.format("Messages: %d, Filtered: %d, Errors: %d", 
            stats.messagesLogged, stats.messagesFiltered, stats.errorCount)
            
    elseif command == "clearstats" then
        Log.ClearStats()
        if Log.Server and Log.Server.ClearPerformanceMetrics then
            Log.Server.ClearPerformanceMetrics()
        end
        response = "Logging statistics cleared"
        Log.Info("GM", player:GetName(), "cleared logging statistics")
        
    elseif command == "enable" then
        LOGGING_CONFIG.performance.enabled = true
        response = "Logging enabled"
        Log.Info("GM", player:GetName(), "enabled logging")
        
    elseif command == "disable" then
        LOGGING_CONFIG.performance.enabled = false
        response = "Logging disabled"
        print("GM", player:GetName(), "disabled logging") -- Use print since logging is disabled
        
    else
        response = "Unknown command: " .. tostring(command)
    end
    
    AIO.Handle(player, "LoggingSystem", "CommandResponse", response)
end

-- ===================================
-- PLAYER EVENT HANDLERS
-- ===================================

-- Send configuration when player logs in
local function OnPlayerLogin(event, player)
    if not player then
        return
    end
    
    -- Small delay to ensure client is ready
    player:RegisterEvent(function()
        LoggingSystemHandler.GetConfig(player)
        Log.Debug("Logging system initialized for player:", player:GetName())
    end, 2000, 1) -- 2 second delay, run once
end

-- ===================================
-- ADMIN COMMAND INTEGRATION
-- ===================================

local function OnAdminCommand(event, player, command)
    if not command:find("^log ") then
        return true -- Not our command, continue processing
    end
    
    local args = {}
    for word in command:gmatch("%S+") do
        table.insert(args, word)
    end
    
    if #args < 2 then
        player:SendBroadcastMessage("Usage: .log <setlevel|stats|clear|enable|disable> [value]")
        return false
    end
    
    local subCommand = args[2]:lower()
    local value = args[3]
    
    -- Handle the command through the AIO handler (reuse the logic)
    LoggingSystemHandler.AdminCommand(player, subCommand, value)
    
    return false -- Command handled, stop processing
end

-- ===================================
-- UTILITY FUNCTIONS
-- ===================================

-- Broadcast configuration changes to all online players
function BroadcastConfigUpdate()
    for _, player in ipairs(GetPlayersInWorld()) do
        if player then
            LoggingSystemHandler.GetConfig(player)
        end
    end
end

-- Send a log message to specific player's client
Log.SendToClient = function(player, level, message)
    if not player or not level or not message then
        Log.Error("SendToClient called with invalid parameters")
        return
    end
    
    AIO.Handle(player, "LoggingSystem", "ReceiveLogMessage", {
        level = level,
        message = tostring(message),
        timestamp = os.time(),
        source = "Server"
    })
end

-- Broadcast a log message to all online players' clients
Log.BroadcastToClients = function(level, message)
    if not level or not message then
        Log.Error("BroadcastToClients called with invalid parameters")
        return
    end
    
    for _, player in ipairs(GetPlayersInWorld()) do
        if player then
            Log.SendToClient(player, level, message)
        end
    end
end

-- ===================================
-- INITIALIZATION
-- ===================================

-- Register event handlers
RegisterPlayerEvent(3, OnPlayerLogin) -- PLAYER_EVENT_ON_LOGIN
RegisterPlayerEvent(42, OnAdminCommand) -- PLAYER_EVENT_ON_COMMAND

Log.Info("Logging System AIO server handler loaded")

-- Export handler for potential external use
return LoggingSystemHandler