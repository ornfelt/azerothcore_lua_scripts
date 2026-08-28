local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- EASING FUNCTIONS
-- ===================================
-- All take t (0-1), return eased t (0-1). Use with UIAnimCustom.

UIAnimEasing = {}

function UIAnimEasing.Linear(t) return t end

function UIAnimEasing.SmoothStep(t)
    return t * t * (3 - 2 * t)
end

function UIAnimEasing.EaseInQuad(t) return t * t end
function UIAnimEasing.EaseOutQuad(t) return t * (2 - t) end
function UIAnimEasing.EaseInOutQuad(t)
    if t < 0.5 then return 2 * t * t end
    return -1 + (4 - 2 * t) * t
end

function UIAnimEasing.EaseInCubic(t) return t * t * t end
function UIAnimEasing.EaseOutCubic(t)
    t = t - 1; return t * t * t + 1
end

function UIAnimEasing.EaseOutBack(t)
    local s = 1.70158
    t = t - 1
    return t * t * ((s + 1) * t + s) + 1
end

function UIAnimEasing.EaseOutBounce(t)
    if t < 1 / 2.75 then
        return 7.5625 * t * t
    elseif t < 2 / 2.75 then
        t = t - 1.5 / 2.75
        return 7.5625 * t * t + 0.75
    elseif t < 2.5 / 2.75 then
        t = t - 2.25 / 2.75
        return 7.5625 * t * t + 0.9375
    else
        t = t - 2.625 / 2.75
        return 7.5625 * t * t + 0.984375
    end
end

function UIAnimEasing.EaseOutElastic(t)
    if t == 0 or t == 1 then return t end
    return math.pow(2, -10 * t) * math.sin((t - 0.075) * (2 * math.pi) / 0.3) + 1
end

-- ===================================
-- CUSTOM PROPERTY ANIMATION ENGINE
-- ===================================

-- Animate any numeric property via getter/setter with a chosen easing.
-- @param frame    Frame to attach OnUpdate to
-- @param from     Start value
-- @param to       End value
-- @param duration Seconds
-- @param easing   Easing function from UIAnimEasing (default SmoothStep)
-- @param setter   function(value) called each tick
-- @param onFinish Optional callback
function UIAnimCustom(frame, from, to, duration, easing, setter, onFinish)
    easing = easing or UIAnimEasing.SmoothStep
    local elapsed = 0
    setter(from)
    frame:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = math.min(elapsed / duration, 1)
        local eased = easing(t)
        setter(Lerp(from, to, eased))
        if t >= 1 then
            setter(to)
            self:SetScript("OnUpdate", nil)
            if onFinish then onFinish(self) end
        end
    end)
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["AnimationsEasing"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: AnimationsEasing module loaded")
end
