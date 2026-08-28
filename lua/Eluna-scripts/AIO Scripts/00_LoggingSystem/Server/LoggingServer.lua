-- ===================================
-- SERVER-SIDE LOGGING EXTENSIONS
-- ===================================
-- Server-specific logging functionality including database logging and performance monitoring

-- Only load on server side
if GetStateMapId and GetStateMapId() ~= -1 then
    return
end

-- Ensure core logging is loaded
if not Log then
    dofile(GetLuaEngine():GetScriptPath() .. "AIO_Server/00_LoggingSystem/LoggingCore.lua")
end

-- ===================================
-- SERVER LOGGING STATE
-- ===================================
local ServerLogging = {
    databaseInitialized = false,
    performanceMetrics = {},
    lastCleanup = 0,
    cleanupInterval = 3600 -- 1 hour
}

-- ===================================
-- DATABASE LOGGING
-- ===================================

local function InitializeDatabaseLogging()
    if not LOGGING_CONFIG.server.enableDatabaseLogging or ServerLogging.databaseInitialized then
        return
    end
    
    local createTableQuery = string.format([[
        CREATE TABLE IF NOT EXISTS %s (
            id INT AUTO_INCREMENT PRIMARY KEY,
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            level VARCHAR(10) NOT NULL,
            file_name VARCHAR(255),
            line_number INT,
            message TEXT NOT NULL,
            player_guid INT DEFAULT NULL,
            map_id INT DEFAULT NULL,
            INDEX idx_timestamp (timestamp),
            INDEX idx_level (level),
            INDEX idx_file (file_name)
        )
    ]], LOGGING_CONFIG.server.logTableName)
    
    WorldDBQuery(createTableQuery)
    ServerLogging.databaseInitialized = true
    Log.Debug("Database logging initialized")
end

local function LogToDatabase(level, message, fileName, lineNumber, player)
    if not LOGGING_CONFIG.server.enableDatabaseLogging or not ServerLogging.databaseInitialized then
        return
    end
    
    -- Only log ERROR and WARN levels to database by default
    if level > LOGGING_CONFIG.LOG_LEVELS.WARN then
        return
    end
    
    local playerGuid = nil
    local mapId = nil
    
    if player then
        playerGuid = player:GetGUIDLow()
        mapId = player:GetMapId()
    end
    
    local insertQuery = string.format([[
        INSERT INTO %s (level, file_name, line_number, message, player_guid, map_id)
        VALUES ('%s', '%s', %d, '%s', %s, %s)
    ]], 
        LOGGING_CONFIG.server.logTableName,
        LOGGING_CONFIG.LOG_LEVEL_NAMES[level],
        fileName:gsub("'", "''"), -- Escape single quotes
        lineNumber,
        message:gsub("'", "''"), -- Escape single quotes
        playerGuid and tostring(playerGuid) or "NULL",
        mapId and tostring(mapId) or "NULL"
    )
    
    WorldDBExecute(insertQuery)
end

local function CleanupDatabaseLogs()
    if not LOGGING_CONFIG.server.enableDatabaseLogging or not ServerLogging.databaseInitialized then
        return
    end
    
    local currentTime = os.time()
    if currentTime - ServerLogging.lastCleanup < ServerLogging.cleanupInterval then
        return
    end
    
    -- Keep only the latest N entries
    local cleanupQuery = string.format([[
        DELETE FROM %s 
        WHERE id NOT IN (
            SELECT id FROM (
                SELECT id FROM %s 
                ORDER BY timestamp DESC 
                LIMIT %d
            ) AS temp
        )
    ]], 
        LOGGING_CONFIG.server.logTableName,
        LOGGING_CONFIG.server.logTableName,
        LOGGING_CONFIG.server.maxDatabaseEntries
    )
    
    WorldDBExecute(cleanupQuery)
    ServerLogging.lastCleanup = currentTime
    Log.Debug("Database log cleanup completed")
end

-- ===================================
-- PERFORMANCE MONITORING
-- ===================================

local function StartPerformanceTimer(operationName)
    if not LOGGING_CONFIG.server.enablePerformanceLogging then
        return nil
    end
    
    return {
        name = operationName,
        startTime = GetCurrTime(),
        startMemory = collectgarbage("count")
    }
end

local function EndPerformanceTimer(timer)
    if not timer or not LOGGING_CONFIG.server.enablePerformanceLogging then
        return
    end
    
    local endTime = GetCurrTime()
    local endMemory = collectgarbage("count")
    
    local duration = endTime - timer.startTime
    local memoryDiff = endMemory - timer.startMemory
    
    -- Store metrics
    if not ServerLogging.performanceMetrics[timer.name] then
        ServerLogging.performanceMetrics[timer.name] = {
            totalCalls = 0,
            totalTime = 0,
            maxTime = 0,
            minTime = math.huge,
            totalMemory = 0
        }
    end
    
    local metrics = ServerLogging.performanceMetrics[timer.name]
    metrics.totalCalls = metrics.totalCalls + 1
    metrics.totalTime = metrics.totalTime + duration
    metrics.maxTime = math.max(metrics.maxTime, duration)
    metrics.minTime = math.min(metrics.minTime, duration)
    metrics.totalMemory = metrics.totalMemory + memoryDiff
    
    -- Log if operation took longer than threshold (100ms)
    if duration > 100 then
        Log.Warn(string.format("Slow operation: %s took %.2fms (%.2fKB memory)", 
            timer.name, duration, memoryDiff))
    end
end

-- ===================================
-- SERVER-SPECIFIC LOG FUNCTIONS
-- ===================================

-- Extended Log function with server-specific features
Log.Server = {}

-- Log with player context
Log.Server.Player = function(level, player, message, ...)
    if not player then
        Log[LOGGING_CONFIG.LOG_LEVEL_NAMES[level]:lower():gsub("^%l", string.upper)](message, ...)
        return
    end
    
    local playerInfo = string.format("[Player: %s (%d)]", player:GetName(), player:GetGUIDLow())
    local fullMessage = playerInfo .. " " .. tostring(message)
    
    if ... then
        local args = {...}
        for i = 1, #args do
            args[i] = tostring(args[i])
        end
        fullMessage = fullMessage .. " " .. table.concat(args, " ")
    end
    
    -- Use the appropriate log level function
    local levelName = LOGGING_CONFIG.LOG_LEVEL_NAMES[level]
    if levelName and Log[levelName:lower():gsub("^%l", string.upper)] then
        Log[levelName:lower():gsub("^%l", string.upper)](fullMessage)
    end
    
    -- Log to database if enabled
    local fileName, lineNumber = Log.GetCallerInfo()
    LogToDatabase(level, fullMessage, fileName, lineNumber, player)
end

-- Convenience functions for player logging
Log.Server.PlayerError = function(player, message, ...)
    Log.Server.Player(LOGGING_CONFIG.LOG_LEVELS.ERROR, player, message, ...)
end

Log.Server.PlayerWarn = function(player, message, ...)
    Log.Server.Player(LOGGING_CONFIG.LOG_LEVELS.WARN, player, message, ...)
end

Log.Server.PlayerInfo = function(player, message, ...)
    Log.Server.Player(LOGGING_CONFIG.LOG_LEVELS.INFO, player, message, ...)
end

Log.Server.PlayerDebug = function(player, message, ...)
    Log.Server.Player(LOGGING_CONFIG.LOG_LEVELS.DEBUG, player, message, ...)
end

-- Performance logging
Log.Server.StartTimer = StartPerformanceTimer
Log.Server.EndTimer = EndPerformanceTimer

-- Convenience function for timing operations
Log.Server.TimeOperation = function(operationName, func, ...)
    local timer = StartPerformanceTimer(operationName)
    local results = {func(...)}
    EndPerformanceTimer(timer)
    return unpack(results)
end

-- Database query logging
Log.Server.LogQuery = function(query, params)
    if LOGGING_CONFIG.GetLogLevel() < LOGGING_CONFIG.LOG_LEVELS.TRACE then
        return
    end
    
    local logMessage = "SQL Query: " .. tostring(query)
    if params and #params > 0 then
        logMessage = logMessage .. " | Params: " .. table.concat(params, ", ")
    end
    
    Log.Trace(logMessage)
end

-- Get performance metrics report
Log.Server.GetPerformanceReport = function()
    local report = {}
    for name, metrics in pairs(ServerLogging.performanceMetrics) do
        local avgTime = metrics.totalCalls > 0 and (metrics.totalTime / metrics.totalCalls) or 0
        local avgMemory = metrics.totalCalls > 0 and (metrics.totalMemory / metrics.totalCalls) or 0
        
        table.insert(report, {
            operation = name,
            calls = metrics.totalCalls,
            totalTime = metrics.totalTime,
            avgTime = avgTime,
            maxTime = metrics.maxTime,
            minTime = metrics.minTime == math.huge and 0 or metrics.minTime,
            avgMemory = avgMemory
        })
    end
    
    -- Sort by total time descending
    table.sort(report, function(a, b) return a.totalTime > b.totalTime end)
    
    return report
end

-- Clear performance metrics
Log.Server.ClearPerformanceMetrics = function()
    ServerLogging.performanceMetrics = {}
end

-- ===================================
-- ADMIN COMMANDS
-- ===================================

local function OnLogCommand(event, player, command)
    local args = {}
    for word in command:gmatch("%S+") do
        table.insert(args, word)
    end

    -- Only handle if this is the "log" command
    if args[1] ~= "log" then
        return  -- Let other handlers process this command
    end

    if #args < 2 then
        player:SendBroadcastMessage("Usage: .log <level|stats|perf|clear>")
        return false
    end
    
    local subCommand = args[2]:lower()
    
    if subCommand == "level" then
        if #args < 3 then
            local currentLevel = LOGGING_CONFIG.globalLogLevel
            local levelName = LOGGING_CONFIG.LOG_LEVEL_NAMES[currentLevel]
            player:SendBroadcastMessage("Current log level: " .. levelName)
            return false
        end
        
        local newLevel = tonumber(args[3])
        if newLevel and newLevel >= 0 and newLevel <= 5 then
            LOGGING_CONFIG.globalLogLevel = newLevel
            player:SendBroadcastMessage("Log level set to: " .. LOGGING_CONFIG.LOG_LEVEL_NAMES[newLevel])
        else
            player:SendBroadcastMessage("Invalid log level. Use 0-5 (OFF, ERROR, WARN, INFO, DEBUG, TRACE)")
        end
        
    elseif subCommand == "stats" then
        local stats = Log.GetStats()
        player:SendBroadcastMessage(string.format("Logging Stats - Messages: %d, Filtered: %d, Errors: %d, Buffer: %d",
            stats.messagesLogged, stats.messagesFiltered, stats.errorCount, stats.bufferSize))
            
    elseif subCommand == "perf" then
        local report = Log.Server.GetPerformanceReport()
        player:SendBroadcastMessage("Top 5 Operations by Total Time:")
        for i = 1, math.min(5, #report) do
            local op = report[i]
            player:SendBroadcastMessage(string.format("%d. %s: %.2fms total, %.2fms avg (%d calls)",
                i, op.operation, op.totalTime, op.avgTime, op.calls))
        end
        
    elseif subCommand == "clear" then
        Log.ClearStats()
        Log.Server.ClearPerformanceMetrics()
        player:SendBroadcastMessage("Logging stats and performance metrics cleared")
        
    else
        player:SendBroadcastMessage("Unknown log command. Use: level, stats, perf, clear")
    end
    
    return false
end

-- ===================================
-- INITIALIZATION
-- ===================================

local function InitializeServerLogging()
    -- Initialize database logging if enabled
    if LOGGING_CONFIG.server.enableDatabaseLogging then
        InitializeDatabaseLogging()
    end
    
    -- Register admin command
    RegisterPlayerEvent(42, OnLogCommand) -- PLAYER_EVENT_ON_COMMAND
    
    Log.Info("Server-side logging extensions loaded")
end

-- Auto-initialize
InitializeServerLogging()

-- Set up periodic cleanup
local function OnServerUpdate()
    CleanupDatabaseLogs()
end

-- This would ideally be hooked to a server update event
-- For now, cleanup happens on demand