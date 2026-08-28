# Global Logging System

A centralized logging system for TrinityCore Lua scripts with AIO support.

## Features

- **Global Log Function**: Available everywhere as `Log()`
- **Multiple Log Levels**: ERROR, WARN, INFO, DEBUG, TRACE
- **Automatic File Detection**: Shows which file generated the log
- **Performance-Friendly**: Minimal overhead when disabled
- **Server Extensions**: Database logging, performance monitoring
- **Client Extensions**: UI notifications, debug overlay
- **Configurable**: Per-module settings, filtering, formatting

## Quick Start

### Basic Usage

```lua
-- Simple logging (defaults to INFO level)
Log("Server started successfully")

-- Level-specific logging
Log.Error("Critical error occurred!")
Log.Warn("This is a warning")
Log.Info("Information message")
Log.Debug("Debug information")
Log.Trace("Detailed trace information")

-- Multiple arguments
Log.Info("Player", playerName, "joined with level", level)
```

### Server-Side Features

```lua
-- Player-specific logging
Log.Server.PlayerInfo(player, "Player performed action")
Log.Server.PlayerError(player, "Player encountered error")

-- Performance monitoring
local timer = Log.Server.StartTimer("DatabaseQuery")
-- ... do database work ...
Log.Server.EndTimer(timer)

-- Admin commands
-- .log level 4          -- Set to DEBUG level
-- .log stats            -- Show logging statistics
-- .log perf             -- Show performance metrics
-- .log clear            -- Clear stats and metrics
```

### Client-Side Features

```lua
-- UI notifications for errors/warnings
Log.Client.Notify("Important message", LOGGING_CONFIG.LOG_LEVELS.ERROR)

-- Debug overlay
Log.Client.ShowOverlay()   -- Show debug window
Log.Client.HideOverlay()   -- Hide debug window

-- Slash commands
-- /logdebug toggle       -- Toggle debug overlay
-- /logdebug clear        -- Clear message history
-- /logdebug export 50    -- Export last 50 messages to chat
```

## Configuration

Edit `LoggingConfig.lua` to customize behavior:

```lua
-- Global log level (0=OFF, 1=ERROR, 2=WARN, 3=INFO, 4=DEBUG, 5=TRACE)
globalLogLevel = 4,

-- Per-module log levels
moduleLogLevels = {
    ["GameMasterUI_Database"] = 2,  -- Only WARN and ERROR
    ["ProfessionServer_Handlers"] = 5,  -- All levels
},

-- Enable/disable features
server = {
    enableDatabaseLogging = false,
    enablePerformanceLogging = false,
},

client = {
    enableUINotifications = true,
    enableDebugOverlay = false,
}
```

## File Structure

```
00_LoggingSystem/
├── LoggingConfig.lua          # Main configuration
├── LoggingCore.lua            # Core Log function (loads first)
├── Server/
│   └── LoggingServer.lua      # Server-specific extensions
├── Client/
│   └── LoggingClient.lua      # Client-specific extensions
├── LoggingSystemTest.lua      # Test script
└── README.md                  # This file
```

## Integration with Existing Code

### Replace Existing Debug Functions

**Before:**
```lua
local function debugMsg(...)
    if config.debug then
        print("MyAddon Debug:", ...)
    end
end
```

**After:**
```lua
-- Simply use Log.Debug everywhere
Log.Debug("MyAddon information")

-- Or create a module-specific debug function
local debugMsg = CreateDebugFunction("MyAddon", LOGGING_CONFIG.LOG_LEVELS.DEBUG)
```

### Migration Examples

**Replace print statements:**
```lua
-- Before
print("Player login:", player:GetName())

-- After  
Log.Info("Player login:", player:GetName())
```

**Replace conditional debug:**
```lua
-- Before
if DEBUG then
    print("Debug info:", data)
end

-- After
Log.Debug("Debug info:", data)
```

## Benefits

1. **Centralized Control**: Change log levels globally or per-module
2. **Performance**: Automatic filtering reduces overhead
3. **Rich Information**: Automatic file names, timestamps, levels
4. **Debugging Tools**: Client overlay, server admin commands
5. **Future-Proof**: Easy to add new features without changing existing code

## Advanced Features

### Performance Monitoring
```lua
-- Automatic timing with reporting
Log.Server.TimeOperation("DatabaseQuery", function()
    return WorldDBQuery("SELECT * FROM creatures")
end)
```

### Filtering
```lua
-- Filter out sensitive information
LOGGING_CONFIG.filters.blacklistedKeywords = {"password", "token"}

-- Only show important messages
LOGGING_CONFIG.filters.whitelistedKeywords = {"ERROR", "CRITICAL"}
```

### Database Logging
Enable in config to store ERROR/WARN messages in database for analysis.

## Testing

Run the test script to verify everything works:
```lua
dofile("AIO_Server/00_LoggingSystem/LoggingSystemTest.lua")
```

## Best Practices

1. **Use appropriate log levels**: ERROR for critical issues, INFO for general information, DEBUG for development
2. **Include context**: Log player names, item IDs, or other relevant information
3. **Don't log secrets**: Never log passwords, tokens, or sensitive data
4. **Use performance logging**: Monitor slow operations with `StartTimer/EndTimer`
5. **Regular cleanup**: Use admin commands to clear old logs and stats

## Backward Compatibility

The system is designed to work alongside existing logging patterns. You can gradually migrate existing code while maintaining functionality.