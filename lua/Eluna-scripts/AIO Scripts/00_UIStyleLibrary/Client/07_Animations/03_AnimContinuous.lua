local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- CONTINUOUS / LOOPING ANIMATIONS
-- ===================================
-- Breathe, pulse scale, spin, rotate, shine sweep.

-- Breathe: continuous alpha pulse between two values.
-- @param frame    Frame to animate
-- @param minAlpha Lowest alpha (default 0.3)
-- @param maxAlpha Highest alpha (default 1.0)
-- @param duration Full cycle time in seconds (default 1.5)
-- @return driver frame (call UIAnimStop(driver) to stop)
function UIAnimBreathe(frame, minAlpha, maxAlpha, duration)
    minAlpha = minAlpha or 0.3
    maxAlpha = maxAlpha or 1.0
    duration = duration or 1.5
    local driver = frame._uiAnimBreatheDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame)
        frame._uiAnimBreatheDriver = driver
    end
    local elapsed = 0
    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = (elapsed % duration) / duration
        local wave = 0.5 - 0.5 * math.cos(t * 2 * math.pi)
        frame:SetAlpha(Lerp(minAlpha, maxAlpha, wave))
    end)
    return driver
end

-- PulseScale: continuous scale bounce between two values.
-- @param frame    Frame to pulse
-- @param minScale Smallest scale (default 0.9)
-- @param maxScale Largest scale (default 1.1)
-- @param duration Full cycle time in seconds (default 1.0)
-- @return driver frame
function UIAnimPulseScale(frame, minScale, maxScale, duration)
    minScale = minScale or 0.9
    maxScale = maxScale or 1.1
    duration = duration or 1.0
    local driver = frame._uiAnimPulseScaleDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame)
        frame._uiAnimPulseScaleDriver = driver
    end
    local elapsed = 0
    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = (elapsed % duration) / duration
        local wave = 0.5 - 0.5 * math.cos(t * 2 * math.pi)
        frame:SetScale(Lerp(minScale, maxScale, wave))
    end)
    return driver
end

-- ===================================
-- TEXTURE ROTATION
-- ===================================

-- Spin a texture continuously or to a target angle.
-- @param texture  Texture to rotate
-- @param speed    Radians per second (default 2*PI = 1 full rotation/sec)
-- @param duration Optional total duration (nil = infinite)
-- @return driver frame
function UIAnimSpin(texture, speed, duration)
    speed = speed or (2 * math.pi)
    local driver = CreateFrame("Frame", nil, UIParent)
    local elapsed = 0
    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        texture:SetRotation(elapsed * speed)
        if duration and elapsed >= duration then
            self:SetScript("OnUpdate", nil)
        end
    end)
    return driver
end

-- Rotate a texture from one angle to another.
-- @param texture  Texture to rotate
-- @param fromRad  Start angle in radians
-- @param toRad    End angle in radians
-- @param duration Seconds
-- @param easing   Optional easing function
-- @param onFinish Optional callback
function UIAnimRotateTo(texture, fromRad, toRad, duration, easing, onFinish)
    local driver = CreateFrame("Frame", nil, UIParent)
    UIAnimCustom(driver, fromRad, toRad, duration, easing, function(v)
        texture:SetRotation(v)
    end, onFinish)
    return driver
end

-- ===================================
-- HIGHLIGHT SWEEP (SHINE EFFECT)
-- ===================================

-- Create a diagonal shine sweep across a frame.
-- @param parent   Frame to add the sweep to
-- @param duration Sweep duration in seconds (default 0.6)
-- @param color    Optional {r, g, b} (default white)
-- @return sweepFrame (call UIAnimSweep to trigger)
function CreateShineSweep(parent, color)
    color = color or { 1, 1, 1 }
    local mask = CreateFrame("Frame", nil, parent)
    mask:SetAllPoints(parent)
    mask:SetFrameLevel(parent:GetFrameLevel() + 2)

    local shine = mask:CreateTexture(nil, "OVERLAY")
    shine:SetTexture("Interface\\Buttons\\WHITE8X8")
    shine:SetBlendMode("ADD")
    shine:SetWidth(20)
    shine:SetHeight(parent:GetHeight() or 60)
    shine:SetVertexColor(color[1], color[2], color[3], 0.5)
    shine:SetPoint("LEFT", mask, "LEFT", -20, 0)
    shine:Hide()

    mask._shine = shine
    mask:Hide()
    return mask
end

-- Trigger a shine sweep animation.
-- @param sweepFrame Frame from CreateShineSweep
-- @param duration   Sweep time in seconds (default 0.4)
function UIAnimSweep(sweepFrame, duration)
    duration = duration or 0.4
    local shine = sweepFrame._shine
    if not shine then return end

    sweepFrame:Show()
    shine:Show()
    local w = sweepFrame:GetWidth()
    local elapsed = 0

    sweepFrame:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = math.min(elapsed / duration, 1)
        local eased = UIAnimEasing.EaseOutQuad(t)
        shine:ClearAllPoints()
        shine:SetPoint("LEFT", sweepFrame, "LEFT", Lerp(-20, w + 20, eased), 0)
        shine:SetAlpha(Lerp(0.6, 0, eased * eased))

        if t >= 1 then
            shine:Hide()
            self:Hide()
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["AnimationsContinuous"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: AnimationsContinuous module loaded")
end
