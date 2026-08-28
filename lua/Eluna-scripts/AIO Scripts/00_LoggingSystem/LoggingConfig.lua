-- ===================================
-- GLOBAL LOGGING SYSTEM CONFIGURATION
-- ===================================
-- Configuration for the centralized logging system
-- This file controls logging behavior across all modules

LOGGING_CONFIG = {
    -- ===================================
    -- GLOBAL LOG LEVEL CONTROL
    -- ===================================
    -- Set the global log level threshold
    -- 0 = OFF, 1 = ERROR, 2 = WARN, 3 = INFO, 4 = DEBUG, 5 = TRACE
    globalLogLevel = 3,
    
    -- ===================================
    -- LOG LEVELS
    -- ===================================
    LOG_LEVELS = {
        OFF = 0,
        ERROR = 1,
        WARN = 2,
        INFO = 3,
        DEBUG = 4,
        TRACE = 5
    },
    
    -- Level names for display
    LOG_LEVEL_NAMES = {
        [0] = "OFF",
        [1] = "ERROR", 
        [2] = "WARN",
        [3] = "INFO",
        [4] = "DEBUG",
        [5] = "TRACE"
    },
    
    -- ===================================
    -- MODULE-SPECIFIC LOG LEVELS
    -- ===================================
    -- Override log levels for specific modules/files
    -- Key = file name (without .lua extension), Value = log level
    moduleLogLevels = {
        -- Examples:
        -- ["GameMasterUI_Database"] = 2, -- Only WARN and ERROR
        -- ["ProfessionServer_Handlers"] = 5, -- All levels including TRACE
        -- ["UIStyle_00_Core"] = 1, -- Only ERROR
    },
    
    -- ===================================
    -- OUTPUT FORMATTING
    -- ===================================
    formatting = {
        -- Include timestamp in log messages
        showTimestamp = true,
        
        -- Include log level in messages
        showLogLevel = true,
        
        -- Include calling file name
        showFileName = true,
        
        -- Include line number (may impact performance)
        showLineNumber = false,
        
        -- Timestamp format (Lua date format string)
        timestampFormat = "[%Y-%m-%d %H:%M:%S]",
        
        -- Maximum message length (0 = no limit)
        maxMessageLength = 0,
        
        -- Color codes for different log levels (server-side only)
        colors = {
            [1] = "|cFFFF4444", -- ERROR - Red
            [2] = "|cFFFFAA00", -- WARN - Orange  
            [3] = "|cFFFFFFFF", -- INFO - White
            [4] = "|cFF44AAFF", -- DEBUG - Blue
            [5] = "|cFF888888", -- TRACE - Gray
        }
    },
    
    -- ===================================
    -- PERFORMANCE SETTINGS
    -- ===================================
    performance = {
        -- Enable/disable logging completely for performance
        enabled = true,
        
        -- Buffer log messages for batch output (reduces spam)
        enableBuffering = false,
        
        -- Buffer size before auto-flush
        bufferSize = 10,
        
        -- Auto-flush buffer interval (seconds)
        flushInterval = 5,
        
        -- Skip expensive operations in log formatting
        fastMode = false
    },
    
    -- ===================================
    -- SERVER-SPECIFIC SETTINGS
    -- ===================================
    server = {
        -- Enable database logging for ERROR level messages
        enableDatabaseLogging = false,
        
        -- Database table name for log storage
        logTableName = "custom_lua_logs",
        
        -- Maximum log entries to keep in database
        maxDatabaseEntries = 1000,
        
        -- Enable performance metric logging
        enablePerformanceLogging = false
    },
    
    -- ===================================
    -- CLIENT-SPECIFIC SETTINGS
    -- ===================================
    client = {
        -- Show log messages as UI notifications for ERROR/WARN
        enableUINotifications = true,
        
        -- Enable debug overlay for development
        enableDebugOverlay = false,
        
        -- Maximum messages to keep in client memory
        maxClientMessages = 100,
        
        -- Enable message history for debugging
        enableHistory = true
    },
    
    -- ===================================
    -- FILTER SETTINGS
    -- ===================================
    filters = {
        -- Keywords to filter out from all log messages
        blacklistedKeywords = {
            -- "password", "token", "secret"
        },
        
        -- Only show messages containing these keywords (empty = show all)
        whitelistedKeywords = {
            -- "GameMaster", "Important"
        },
        
        -- Filter by module patterns (supports Lua patterns)
        moduleFilters = {
            -- Hide all messages from test files
            -- [".*[Tt]est.*"] = false,
        }
    }
}

-- ===================================
-- UTILITY FUNCTIONS
-- ===================================

function LOGGING_CONFIG.GetLogLevel(fileName)
    if not fileName then
        return LOGGING_CONFIG.globalLogLevel
    end
    
    -- Remove .lua extension and path for lookup
    local moduleName = fileName:match("([^/\\]+)%.lua$") or fileName
    
    return LOGGING_CONFIG.moduleLogLevels[moduleName] or LOGGING_CONFIG.globalLogLevel
end

function LOGGING_CONFIG.IsLogLevelEnabled(level, fileName)
    local threshold = LOGGING_CONFIG.GetLogLevel(fileName)
    return LOGGING_CONFIG.performance.enabled and level <= threshold
end

function LOGGING_CONFIG.ShouldFilterMessage(message, fileName)
    if not message then return true end
    
    -- Check blacklisted keywords
    for _, keyword in ipairs(LOGGING_CONFIG.filters.blacklistedKeywords) do
        if message:lower():find(keyword:lower()) then
            return true
        end
    end
    
    -- Check whitelisted keywords (if any defined)
    if #LOGGING_CONFIG.filters.whitelistedKeywords > 0 then
        local hasWhitelistedKeyword = false
        for _, keyword in ipairs(LOGGING_CONFIG.filters.whitelistedKeywords) do
            if message:lower():find(keyword:lower()) then
                hasWhitelistedKeyword = true
                break
            end
        end
        if not hasWhitelistedKeyword then
            return true
        end
    end
    
    -- Check module filters
    if fileName then
        for pattern, enabled in pairs(LOGGING_CONFIG.filters.moduleFilters) do
            if fileName:match(pattern) and not enabled then
                return true
            end
        end
    end
    
    return false
end