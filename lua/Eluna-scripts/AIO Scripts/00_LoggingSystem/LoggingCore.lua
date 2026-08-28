-- ===================================
-- GLOBAL LOGGING SYSTEM CORE
-- ===================================
-- Core logging functionality that provides the global Log function
-- This module must be loaded before all other modules that use logging

-- Load configuration first (if not already loaded)
if not LOGGING_CONFIG then
    dofile(GetLuaEngine():GetScriptPath() .. "AIO_Server/00_LoggingSystem/LoggingConfig.lua")
end

-- ===================================
-- INTERNAL LOGGING STATE
-- ===================================
local LoggingSystem = {
    messageBuffer = {},
    lastFlushTime = 0,
    isInitialized = false,
    stats = {
        messagesLogged = 0,
        messagesFiltered = 0,
        errorCount = 0
    }
}

-- ===================================
-- UTILITY FUNCTIONS
-- ===================================

local function GetCurrentTimestamp()
    if not LOGGING_CONFIG.formatting.showTimestamp then
        return ""
    end
    return os.date(LOGGING_CONFIG.formatting.timestampFormat) .. " "
end

local function GetCallerInfo()
    if not debug then
        return "Unknown", 0
    end
    
    -- Look up the call stack to find the actual caller (skip internal logging functions)
    for i = 3, 10 do
        local info = debug.getinfo(i, "Sl")
        if not info then break end
        
        -- Skip internal logging functions
        local source = info.short_src or info.source or ""
        if not source:match("LoggingCore%.lua$") and not source:match("LoggingServer%.lua$") and not source:match("LoggingClient%.lua$") then
            local fileName = source:match("([^/\\]+)%.lua$") or source:match("([^/\\]+)$") or "Unknown"
            return fileName, info.currentline or 0
        end
    end
    
    return "Unknown", 0
end

local function FormatMessage(level, message, fileName, lineNumber)
    if not message then
        return ""
    end
    
    local parts = {}
    
    -- Timestamp
    if LOGGING_CONFIG.formatting.showTimestamp then
        table.insert(parts, GetCurrentTimestamp())
    end
    
    -- Log level with color (server-side only)
    if LOGGING_CONFIG.formatting.showLogLevel then
        local levelName = LOGGING_CONFIG.LOG_LEVEL_NAMES[level] or "UNKNOWN"
        local colorCode = ""
        local resetCode = ""
        
        -- Only apply colors on server side and if AIO is not available (pure server environment)
        if not AIO and LOGGING_CONFIG.formatting.colors[level] then
            colorCode = LOGGING_CONFIG.formatting.colors[level]
            resetCode = "|r"
        end
        
        table.insert(parts, string.format("[%s%s%s]", colorCode, levelName, resetCode))
    end
    
    -- File name
    if LOGGING_CONFIG.formatting.showFileName and fileName and fileName ~= "Unknown" then
        table.insert(parts, string.format("[%s", fileName))
        
        -- Line number
        if LOGGING_CONFIG.formatting.showLineNumber and lineNumber > 0 then
            table.insert(parts, string.format(":%d]", lineNumber))
        else
            table.insert(parts, "]")
        end
    end
    
    -- The actual message
    local finalMessage = tostring(message)
    
    -- Truncate if needed
    if LOGGING_CONFIG.formatting.maxMessageLength > 0 and #finalMessage > LOGGING_CONFIG.formatting.maxMessageLength then
        finalMessage = finalMessage:sub(1, LOGGING_CONFIG.formatting.maxMessageLength) .. "..."
    end
    
    table.insert(parts, finalMessage)
    
    return table.concat(parts, " ")
end

local function ShouldLog(level, fileName)
    -- Quick performance check
    if not LOGGING_CONFIG.performance.enabled or level == LOGGING_CONFIG.LOG_LEVELS.OFF then
        return false
    end
    
    return LOGGING_CONFIG.IsLogLevelEnabled(level, fileName)
end

local function OutputMessage(formattedMessage, level)
    -- Always use print for output - it works on both server and client
    print(formattedMessage)
    
    -- Update statistics
    LoggingSystem.stats.messagesLogged = LoggingSystem.stats.messagesLogged + 1
    if level == LOGGING_CONFIG.LOG_LEVELS.ERROR then
        LoggingSystem.stats.errorCount = LoggingSystem.stats.errorCount + 1
    end
end

local function FlushBuffer()
    if #LoggingSystem.messageBuffer == 0 then
        return
    end
    
    for _, message in ipairs(LoggingSystem.messageBuffer) do
        print(message)
    end
    
    LoggingSystem.messageBuffer = {}
    LoggingSystem.lastFlushTime = os.time()
end

local function LogMessage(level, message, ...)
    -- Handle multiple arguments
    if ... then
        local args = {...}
        for i = 1, #args do
            args[i] = tostring(args[i])
        end
        message = tostring(message) .. " " .. table.concat(args, " ")
    end
    
    -- Get caller information
    local fileName, lineNumber = GetCallerInfo()
    
    -- Check if we should log this message
    if not ShouldLog(level, fileName) then
        LoggingSystem.stats.messagesFiltered = LoggingSystem.stats.messagesFiltered + 1
        return
    end
    
    -- Check filters
    if LOGGING_CONFIG.ShouldFilterMessage(message, fileName) then
        LoggingSystem.stats.messagesFiltered = LoggingSystem.stats.messagesFiltered + 1
        return
    end
    
    -- Format the message
    local formattedMessage = FormatMessage(level, message, fileName, lineNumber)
    
    -- Handle buffering
    if LOGGING_CONFIG.performance.enableBuffering then
        table.insert(LoggingSystem.messageBuffer, formattedMessage)
        
        -- Auto-flush if buffer is full or time threshold reached
        local currentTime = os.time()
        if #LoggingSystem.messageBuffer >= LOGGING_CONFIG.performance.bufferSize or 
           (currentTime - LoggingSystem.lastFlushTime) >= LOGGING_CONFIG.performance.flushInterval then
            FlushBuffer()
        end
    else
        OutputMessage(formattedMessage, level)
    end
end

-- ===================================
-- GLOBAL LOG FUNCTION
-- ===================================

-- Create Log as a table that can be called as a function
Log = {}

-- Make Log callable by setting a metatable
setmetatable(Log, {
    __call = function(self, message, ...)
        -- Default to INFO level when called directly
        LogMessage(LOGGING_CONFIG.LOG_LEVELS.INFO, message, ...)
    end
})

-- Add level-specific functions to Log table
Log.Error = function(message, ...)
    LogMessage(LOGGING_CONFIG.LOG_LEVELS.ERROR, message, ...)
end

Log.Warn = function(message, ...)
    LogMessage(LOGGING_CONFIG.LOG_LEVELS.WARN, message, ...)
end

Log.Info = function(message, ...)
    LogMessage(LOGGING_CONFIG.LOG_LEVELS.INFO, message, ...)
end

Log.Debug = function(message, ...)
    LogMessage(LOGGING_CONFIG.LOG_LEVELS.DEBUG, message, ...)
end

Log.Trace = function(message, ...)
    LogMessage(LOGGING_CONFIG.LOG_LEVELS.TRACE, message, ...)
end

-- ===================================
-- UTILITY FUNCTIONS
-- ===================================

-- Make GetCallerInfo available through Log object
Log.GetCallerInfo = GetCallerInfo

Log.SetLogLevel = function(level, fileName)
    if fileName then
        LOGGING_CONFIG.moduleLogLevels[fileName] = level
    else
        LOGGING_CONFIG.globalLogLevel = level
    end
end

Log.GetLogLevel = function(fileName)
    return LOGGING_CONFIG.GetLogLevel(fileName)
end

Log.Flush = function()
    FlushBuffer()
end

Log.GetStats = function()
    return {
        messagesLogged = LoggingSystem.stats.messagesLogged,
        messagesFiltered = LoggingSystem.stats.messagesFiltered,
        errorCount = LoggingSystem.stats.errorCount,
        bufferSize = #LoggingSystem.messageBuffer
    }
end

Log.ClearStats = function()
    LoggingSystem.stats = {
        messagesLogged = 0,
        messagesFiltered = 0,
        errorCount = 0
    }
end

Log.Enable = function()
    LOGGING_CONFIG.performance.enabled = true
end

Log.Disable = function()
    LOGGING_CONFIG.performance.enabled = false
end

Log.IsEnabled = function()
    return LOGGING_CONFIG.performance.enabled
end

-- ===================================
-- BACKWARDS COMPATIBILITY
-- ===================================

-- For modules that might use debugMsg pattern
function CreateDebugFunction(moduleName, defaultLevel)
    defaultLevel = defaultLevel or LOGGING_CONFIG.LOG_LEVELS.DEBUG
    
    return function(message, ...)
        local fileName = moduleName or GetCallerInfo()
        if ShouldLog(defaultLevel, fileName) then
            LogMessage(defaultLevel, message, ...)
        end
    end
end

-- ===================================
-- INITIALIZATION
-- ===================================

local function Initialize()
    if LoggingSystem.isInitialized then
        return
    end
    
    LoggingSystem.isInitialized = true
    LoggingSystem.lastFlushTime = os.time()
    
    -- Set up periodic buffer flush if enabled
    if LOGGING_CONFIG.performance.enableBuffering then
        -- This would need to be implemented with a timer system in actual use
        -- For now, we rely on the auto-flush logic in LogMessage
    end
    
    Log.Info("Logging system initialized")
end

-- Initialize immediately
Initialize()

-- ===================================
-- EXPORT FOR REQUIRE SYSTEMS
-- ===================================

-- Support both direct usage and require() pattern
if _G.package then
    return Log
end