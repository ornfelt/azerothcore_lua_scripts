local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

--[[
    GameMasterUI Hotkey Manager - Client Core

    Provides centralized hotkey management with context-aware handling:
    - Ctrl+R: Refresh current data
    - Ctrl+F: Focus search
    - Ctrl+C: Copy to clipboard
    - Extensible for new hotkeys

    Features:
    - Priority-based handler resolution
    - Context detection (modal > dialog > main frame)
    - Automatic conflict resolution
    - Registration/unregistration API

    Architecture:
    - Registry Pattern: Components register/unregister handlers
    - Priority System: Higher priority wins (modal=100, dialog=50, main=0)
    - Event Delegation: Single OnKeyDown handler routes to correct component
]]--

-- Preserve existing state if module is reloaded
local HotkeyManager = _G.GMHotkeyManager or {}
_G.GMHotkeyManager = HotkeyManager

-- Get module references
local GMConfig = _G.GMConfig

-- Registered handlers: [key][modifierKey] = {handler, priority, context, id}[]
local handlers = HotkeyManager._handlers or {}
HotkeyManager._handlers = handlers

-- Handler ID counter for unique identification
local handlerIdCounter = HotkeyManager._handlerIdCounter or 0
HotkeyManager._handlerIdCounter = handlerIdCounter

-- Debug mode
local DEBUG = false

-- =====================================================
-- Utility Functions
-- =====================================================

--[[
    Generate unique handler ID
]]--
local function generateHandlerId()
    handlerIdCounter = handlerIdCounter + 1
    HotkeyManager._handlerIdCounter = handlerIdCounter
    return handlerIdCounter
end

--[[
    Create modifier key string for indexing
    @param modifiers table {ctrl=bool, alt=bool, shift=bool}
    @return string Modifier key like "ctrl" or "ctrl-shift"
]]--
local function getModifierKey(modifiers)
    local parts = {}
    if modifiers.ctrl then table.insert(parts, "ctrl") end
    if modifiers.alt then table.insert(parts, "alt") end
    if modifiers.shift then table.insert(parts, "shift") end
    return table.concat(parts, "-")
end

--[[
    Get current modifier state
    @return table {ctrl=bool, alt=bool, shift=bool}
]]--
local function getCurrentModifiers()
    return {
        ctrl = IsControlKeyDown(),
        alt = IsAltKeyDown(),
        shift = IsShiftKeyDown()
    }
end

--[[
    Check if two modifier states match
]]--
local function modifiersMatch(required, current)
    return (required.ctrl == current.ctrl) and
           (required.alt == current.alt) and
           (required.shift == current.shift)
end

-- =====================================================
-- Registration API
-- =====================================================

--[[
    Register a hotkey handler

    @param config table Configuration with:
        - key: string Key name (e.g., "R", "F", "ESCAPE")
        - modifiers: table {ctrl=bool, alt=bool, shift=bool}
        - context: string Unique context identifier (e.g., "inventory_modal")
        - priority: number Higher = takes precedence (modal=100, dialog=50, main=0)
        - handler: function Callback to execute

    @return number Handler ID for later unregistration
]]--
function HotkeyManager.register(config)
    if not config or not config.key or not config.handler then
        print("[HotkeyManager] ERROR: Invalid registration config")
        return nil
    end

    local key = string.upper(config.key)
    local modifiers = config.modifiers or {ctrl=false, alt=false, shift=false}
    local modKey = getModifierKey(modifiers)
    local priority = config.priority or 0
    local context = config.context or "unknown"
    local handler = config.handler
    local id = generateHandlerId()

    -- Initialize key table if needed
    if not handlers[key] then
        handlers[key] = {}
    end

    -- Initialize modifier table if needed
    if not handlers[key][modKey] then
        handlers[key][modKey] = {}
    end

    -- Add handler
    table.insert(handlers[key][modKey], {
        id = id,
        handler = handler,
        priority = priority,
        context = context,
        modifiers = modifiers
    })

    -- Sort by priority (highest first)
    table.sort(handlers[key][modKey], function(a, b)
        return a.priority > b.priority
    end)

    if DEBUG then
        print(string.format("[HotkeyManager] Registered: %s+%s (context=%s, priority=%d, id=%d)",
            modKey ~= "" and modKey or "none", key, context, priority, id))
    end

    return id
end

--[[
    Unregister a hotkey handler by ID

    @param handlerId number ID returned from register()
]]--
function HotkeyManager.unregister(handlerId)
    if not handlerId then return end

    -- Search through all keys and modifiers
    for key, modTable in pairs(handlers) do
        for modKey, handlerList in pairs(modTable) do
            for i, handler in ipairs(handlerList) do
                if handler.id == handlerId then
                    table.remove(handlerList, i)
                    if DEBUG then
                        print(string.format("[HotkeyManager] Unregistered: id=%d (context=%s)",
                            handlerId, handler.context))
                    end
                    return
                end
            end
        end
    end
end

--[[
    Unregister all handlers for a specific context

    @param context string Context identifier to clear
]]--
function HotkeyManager.unregisterContext(context)
    if not context then return end

    local count = 0
    for key, modTable in pairs(handlers) do
        for modKey, handlerList in pairs(modTable) do
            local i = 1
            while i <= #handlerList do
                if handlerList[i].context == context then
                    table.remove(handlerList, i)
                    count = count + 1
                else
                    i = i + 1
                end
            end
        end
    end

    if DEBUG and count > 0 then
        print(string.format("[HotkeyManager] Unregistered %d handler(s) for context: %s", count, context))
    end
end

-- =====================================================
-- Event Handling
-- =====================================================

--[[
    Handle key press events
    This should be called from frame OnKeyDown scripts

    @param key string Key that was pressed
    @return boolean True if handled, false if not
]]--
function HotkeyManager.handleKeyPress(key)
    if not key then return false end

    key = string.upper(key)

    -- Get current modifiers
    local currentMods = getCurrentModifiers()
    local modKey = getModifierKey(currentMods)

    -- Check if we have handlers for this key
    if not handlers[key] then
        return false
    end

    -- Check if we have handlers for this modifier combination
    if not handlers[key][modKey] then
        return false
    end

    local handlerList = handlers[key][modKey]

    if #handlerList == 0 then
        return false
    end

    -- Get highest priority handler (already sorted)
    local topHandler = handlerList[1]

    if DEBUG then
        print(string.format("[HotkeyManager] Handling: %s+%s (context=%s, priority=%d)",
            modKey ~= "" and modKey or "none", key, topHandler.context, topHandler.priority))
    end

    -- Execute handler with pcall for error safety
    local success, err = pcall(topHandler.handler)

    if not success then
        print(string.format("[HotkeyManager] ERROR in handler (context=%s): %s",
            topHandler.context, tostring(err)))
        return false
    end

    return true
end

-- =====================================================
-- Convenience Functions
-- =====================================================

--[[
    Register standard modal hotkeys (Ctrl+R refresh, Ctrl+F focus search)

    This is a convenience function for registering the common hotkey pattern
    used across modals. It registers:
    - Ctrl+R: Refresh/reload data
    - Ctrl+F: Focus search box

    @param config table Configuration with:
        - modal: frame Modal frame (must have hotkeyHandlerIds table)
        - context: string Unique context identifier (e.g., "teleport_list")
        - priority: number Priority level (modal=100, dialog=50, main=0)
        - onRefresh: function Handler for Ctrl+R (refresh action)
        - onFocusSearch: function Handler for Ctrl+F (focus search)

    @return boolean Success status

    Example:
        HotkeyManager.registerModalHotkeys({
            modal = myModal,
            context = "my_modal",
            priority = 100,
            onRefresh = function() refreshBtn:Click() end,
            onFocusSearch = function() searchBox.editBox:SetFocus() end
        })
]]--
function HotkeyManager.registerModalHotkeys(config)
    if not config or not config.modal or not config.context then
        print("[HotkeyManager] ERROR: Invalid config for registerModalHotkeys")
        return false
    end

    local modal = config.modal
    local context = config.context
    local priority = config.priority or 100
    local onRefresh = config.onRefresh
    local onFocusSearch = config.onFocusSearch

    -- Ensure modal has hotkeyHandlerIds table
    if not modal.hotkeyHandlerIds then
        modal.hotkeyHandlerIds = {}
    end

    -- Register Ctrl+R (Refresh) if handler provided
    if onRefresh then
        local refreshId = HotkeyManager.register({
            key = "R",
            modifiers = {ctrl = true, alt = false, shift = false},
            context = context,
            priority = priority,
            handler = onRefresh
        })

        if refreshId then
            table.insert(modal.hotkeyHandlerIds, refreshId)
        end
    end

    -- Register Ctrl+F (Focus search) if handler provided
    if onFocusSearch then
        local focusSearchId = HotkeyManager.register({
            key = "F",
            modifiers = {ctrl = true, alt = false, shift = false},
            context = context,
            priority = priority,
            handler = onFocusSearch
        })

        if focusSearchId then
            table.insert(modal.hotkeyHandlerIds, focusSearchId)
        end
    end

    return true
end

--[[
    Enable debug output
]]--
function HotkeyManager.enableDebug()
    DEBUG = true
    print("[HotkeyManager] Debug mode enabled")
end

--[[
    Disable debug output
]]--
function HotkeyManager.disableDebug()
    DEBUG = false
    print("[HotkeyManager] Debug mode disabled")
end

--[[
    Print all registered handlers (for debugging)
]]--
function HotkeyManager.printHandlers()
    print("=== HotkeyManager: Registered Handlers ===")

    local count = 0
    for key, modTable in pairs(handlers) do
        for modKey, handlerList in pairs(modTable) do
            if #handlerList > 0 then
                print(string.format("  %s+%s:", modKey ~= "" and modKey or "none", key))
                for _, handler in ipairs(handlerList) do
                    print(string.format("    - context=%s, priority=%d, id=%d",
                        handler.context, handler.priority, handler.id))
                    count = count + 1
                end
            end
        end
    end

    print(string.format("Total: %d handler(s) registered", count))
end

--[[
    Clear all registered handlers (use with caution)
]]--
function HotkeyManager.clearAll()
    handlers = {}
    HotkeyManager._handlers = handlers
    if DEBUG then
        print("[HotkeyManager] All handlers cleared")
    end
end

-- =====================================================
-- Module Initialization
-- =====================================================

if DEBUG then
    print("[HotkeyManager] Module loaded")
end
