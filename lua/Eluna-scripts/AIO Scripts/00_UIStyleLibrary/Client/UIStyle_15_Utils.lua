local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY UTILS MODULE
-- ===================================
-- Utility functions and helpers

--[[
Creates an advanced timer that can be started, stopped, and reset
@param interval - Timer interval in seconds
@param callback - Function to call on each tick
@param repeating - Whether the timer repeats (defaults to true)
@return Timer object with methods:
  - .Start() - Start the timer
  - .Stop() - Stop the timer
  - .Reset() - Reset and restart the timer
  - .SetInterval(seconds) - Change the interval

Note: Basic CreateTimer is in Core module for immediate availability
]]
function CreateAdvancedTimer(interval, callback, repeating)
    -- Backward compatibility: if callback is a function and repeating is nil,
    -- assume the old 2-parameter format (delay, callback)
    if type(callback) == "function" and repeating == nil then
        -- Old format: CreateTimer(delay, callback) for one-time timer
        repeating = false
    else
        -- New format: CreateTimer(interval, callback, repeating)
        repeating = repeating ~= false
    end
    
    local timer = CreateFrame("Frame")
    timer.interval = interval or 1
    timer.callback = callback
    timer.repeating = repeating
    timer.elapsed = 0
    timer.running = false
    
    timer:SetScript("OnUpdate", function(self, delta)
        if not self.running then return end
        
        self.elapsed = self.elapsed + delta
        if self.elapsed >= self.interval then
            self.elapsed = 0
            
            if self.callback then
                self.callback()
            end
            
            if not self.repeating then
                self.running = false
            end
        end
    end)
    
    timer.Start = function(self)
        self.running = true
        self.elapsed = 0
    end
    
    timer.Stop = function(self)
        self.running = false
    end
    
    timer.Reset = function(self)
        self.elapsed = 0
        self.running = true
    end
    
    timer.SetInterval = function(self, seconds)
        self.interval = seconds
    end
    
    timer.SetCallback = function(self, func)
        self.callback = func
    end
    
    -- Backward compatibility: add Cancel method (alias for Stop)
    timer.Cancel = function(self)
        self:Stop()
    end
    
    -- For backward compatibility with old CreateTimer: auto-start one-time timers
    if not repeating and type(callback) == "function" then
        timer:Start()
    end
    
    return timer
end

--[[
Formats a number with thousand separators
@param value - Number to format
@return Formatted string (e.g., "1,234,567")
]]
function FormatNumber(value)
    local formatted = tostring(value)
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

--[[
Formats time in seconds to a readable string
@param seconds - Time in seconds
@return Formatted string (e.g., "1h 23m 45s")
]]
function FormatTime(seconds)
    if not seconds or seconds < 0 then
        return "0s"
    end
    
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if hours > 0 then
        return string.format("%dh %dm %ds", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, secs)
    else
        return string.format("%ds", secs)
    end
end

--[[
Clamps a value between min and max
@param value - Value to clamp
@param min - Minimum value
@param max - Maximum value
@return Clamped value
]]
function Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

--[[
Linear interpolation between two values
@param from - Start value
@param to - End value
@param t - Interpolation factor (0-1)
@return Interpolated value
]]
function Lerp(from, to, t)
    return from + (to - from) * t
end

--[[
Smoothstep interpolation for smooth transitions
@param from - Start value
@param to - End value
@param t - Interpolation factor (0-1)
@return Smoothly interpolated value
]]
function SmoothStep(from, to, t)
    t = Clamp(t, 0, 1)
    t = t * t * (3 - 2 * t)
    return Lerp(from, to, t)
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Utils"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Utils module loaded")
end