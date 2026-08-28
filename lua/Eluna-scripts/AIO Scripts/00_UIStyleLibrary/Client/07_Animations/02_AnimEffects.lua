local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- ANIMATION EFFECTS MODULE
-- ===================================
-- Scale, slide, shake, color pulse, typewriter, width/height, number, chain, stagger, spring, rubber band.

-- ===================================
-- SCALE ANIMATIONS
-- ===================================

-- Scale a frame from one size to another (centered).
-- @param frame    Frame to scale
-- @param from     Start scale (e.g. 0.8)
-- @param to       End scale (e.g. 1.0)
-- @param duration Seconds
-- @param easing   Optional easing function
-- @param onFinish Optional callback
function UIAnimScale(frame, from, to, duration, easing, onFinish)
    -- Use a helper frame so we don't clobber the target's OnUpdate
    local driver = frame._uiAnimScaleDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame)
        frame._uiAnimScaleDriver = driver
    end
    UIAnimCustom(driver, from, to, duration, easing, function(v)
        frame:SetScale(v)
    end, onFinish)
end

-- Pop-in: scale from small to full with overshoot.
-- @param frame    Frame to animate
-- @param duration Optional (default 0.3)
function UIAnimPopIn(frame, duration)
    frame:SetAlpha(0)
    frame:Show()
    frame:SetScale(0.7)
    UIAnimScale(frame, 0.7, 1.0, duration or 0.3, UIAnimEasing.EaseOutBack)
    UIAnimAlpha(frame, 0, 1, (duration or 0.3) * 0.6)
end

-- Shrink-out: scale down and fade, then hide.
-- @param frame    Frame to animate
-- @param duration Optional (default 0.2)
function UIAnimPopOut(frame, duration)
    local dur = duration or 0.2
    UIAnimScale(frame, frame:GetScale(), 0.7, dur, UIAnimEasing.EaseInQuad, function(self)
        frame:Hide()
        frame:SetScale(1)
    end)
    UIAnimAlpha(frame, frame:GetAlpha(), 0, dur)
end

-- ===================================
-- SLIDE ANIMATIONS
-- ===================================

-- Slide a frame in from an offset by re-anchoring each tick.
-- Captures the frame's current anchor points and offsets them.
-- @param frame     Frame to slide
-- @param direction "LEFT", "RIGHT", "TOP", "BOTTOM"
-- @param distance  Pixels to slide from (default 30)
-- @param duration  Seconds (default 0.25)
-- @param easing    Optional easing function
function UIAnimSlideIn(frame, direction, distance, duration, easing)
    distance = distance or 30
    duration = duration or 0.25
    easing   = easing or UIAnimEasing.EaseOutCubic

    local driver = frame._uiAnimSlideDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame:GetParent() or UIParent)
        frame._uiAnimSlideDriver = driver
    end

    local xMul, yMul = 0, 0
    if direction == "LEFT"   then xMul = -1
    elseif direction == "RIGHT"  then xMul = 1
    elseif direction == "TOP"    then yMul = 1
    elseif direction == "BOTTOM" then yMul = -1
    end

    -- Snapshot current anchors
    local anchors = {}
    for i = 1, frame:GetNumPoints() do
        anchors[i] = { frame:GetPoint(i) }
    end

    frame:Show()
    frame:SetAlpha(0)

    local elapsed = 0
    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = math.min(elapsed / duration, 1)
        local eased = easing(t)
        local remain = (1 - eased) * distance

        frame:ClearAllPoints()
        for _, a in ipairs(anchors) do
            frame:SetPoint(a[1], a[2], a[3], (a[4] or 0) + xMul * remain, (a[5] or 0) + yMul * remain)
        end
        frame:SetAlpha(eased)

        if t >= 1 then
            frame:ClearAllPoints()
            for _, a in ipairs(anchors) do
                frame:SetPoint(a[1], a[2], a[3], a[4], a[5])
            end
            frame:SetAlpha(1)
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- ===================================
-- SHAKE ANIMATION
-- ===================================

-- Shake a frame briefly (error feedback, hit effect).
-- @param frame     Frame to shake
-- @param intensity Pixel displacement (default 4)
-- @param duration  Total shake time in seconds (default 0.3)
-- @param speed     Shakes per second (default 30)
function UIAnimShake(frame, intensity, duration, speed)
    intensity = intensity or 4
    duration  = duration or 0.3
    speed     = speed or 30

    local driver = frame._uiAnimShakeDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame:GetParent() or UIParent)
        frame._uiAnimShakeDriver = driver
    end

    local elapsed = 0
    local origPoints = {}
    for i = 1, frame:GetNumPoints() do
        origPoints[i] = { frame:GetPoint(i) }
    end

    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed >= duration then
            -- Restore original position
            frame:ClearAllPoints()
            for _, p in ipairs(origPoints) do
                frame:SetPoint(p[1], p[2], p[3], p[4], p[5])
            end
            self:SetScript("OnUpdate", nil)
            return
        end
        local decay = 1 - (elapsed / duration)
        local amp = intensity * decay
        local xOff = math.sin(elapsed * speed * math.pi * 2) * amp
        local yOff = math.cos(elapsed * speed * math.pi * 2 * 0.7) * amp * 0.5

        frame:ClearAllPoints()
        for _, p in ipairs(origPoints) do
            frame:SetPoint(p[1], p[2], p[3], (p[4] or 0) + xOff, (p[5] or 0) + yOff)
        end
    end)
end

-- ===================================
-- COLOR PULSE ANIMATION
-- ===================================

-- Pulse a texture or fontstring's color between two colors.
-- @param region   Texture or FontString
-- @param colorA   {r, g, b} start color
-- @param colorB   {r, g, b} end color
-- @param duration Full cycle duration in seconds (default 1.0)
-- @param cycles   Number of cycles (default infinite via -1)
-- @return driver frame (call driver:SetScript("OnUpdate", nil) to stop)
function UIAnimColorPulse(region, colorA, colorB, duration, cycles)
    duration = duration or 1.0
    cycles   = cycles or -1
    local driver = CreateFrame("Frame", nil, UIParent)
    local elapsed = 0
    local count = 0

    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = (elapsed % duration) / duration
        -- Ping-pong: 0→1→0
        local wave = math.abs(2 * t - 1)
        wave = wave * wave * (3 - 2 * wave)  -- SmoothStep

        local r = Lerp(colorA[1], colorB[1], wave)
        local g = Lerp(colorA[2], colorB[2], wave)
        local b = Lerp(colorA[3], colorB[3], wave)

        if region.SetTextColor then
            region:SetTextColor(r, g, b)
        elseif region.SetVertexColor then
            region:SetVertexColor(r, g, b)
        end

        if cycles > 0 and elapsed >= duration then
            elapsed = elapsed - duration
            count = count + 1
            if count >= cycles then
                self:SetScript("OnUpdate", nil)
            end
        end
    end)
    return driver
end

-- ===================================
-- TYPEWRITER TEXT ANIMATION
-- ===================================

-- Reveal text character-by-character on a FontString.
-- @param fontString FontString region
-- @param text       Full text to reveal
-- @param charsPerSec Characters per second (default 30)
-- @param onFinish   Optional callback when complete
-- @return driver frame
function UIAnimTypewriter(fontString, text, charsPerSec, onFinish)
    charsPerSec = charsPerSec or 30
    local driver = CreateFrame("Frame", nil, UIParent)
    local elapsed = 0
    local totalChars = string.len(text)
    fontString:SetText("")

    driver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local chars = math.floor(elapsed * charsPerSec)
        if chars >= totalChars then
            fontString:SetText(text)
            self:SetScript("OnUpdate", nil)
            if onFinish then onFinish() end
            return
        end
        fontString:SetText(string.sub(text, 1, chars))
    end)
    return driver
end

-- ===================================
-- PROGRESS / WIDTH ANIMATION
-- ===================================

-- Animate a frame's width (useful for progress bars, reveals).
-- @param frame    Frame or StatusBar
-- @param from     Start width
-- @param to       End width
-- @param duration Seconds
-- @param easing   Optional easing function
-- @param onFinish Optional callback
function UIAnimWidth(frame, from, to, duration, easing, onFinish)
    local driver = frame._uiAnimWidthDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame)
        frame._uiAnimWidthDriver = driver
    end
    UIAnimCustom(driver, from, to, duration, easing, function(v)
        frame:SetWidth(v)
    end, onFinish)
end

-- Animate a frame's height.
-- @param frame    Frame
-- @param from     Start height
-- @param to       End height
-- @param duration Seconds
-- @param easing   Optional easing function
-- @param onFinish Optional callback
function UIAnimHeight(frame, from, to, duration, easing, onFinish)
    local driver = frame._uiAnimHeightDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame)
        frame._uiAnimHeightDriver = driver
    end
    UIAnimCustom(driver, from, to, duration, easing, function(v)
        frame:SetHeight(v)
    end, onFinish)
end

-- ===================================
-- NUMBER COUNTER
-- ===================================

-- Animate a number counting up or down on a FontString.
-- @param fontString FontString to update
-- @param from       Start number
-- @param to         End number
-- @param duration   Seconds (default 1.0)
-- @param format     Optional format string (default "%d")
-- @param easing     Optional easing function
-- @param onFinish   Optional callback
-- @return driver frame
function UIAnimNumber(fontString, from, to, duration, format, easing, onFinish)
    duration = duration or 1.0
    format   = format or "%d"
    local driver = CreateFrame("Frame", nil, UIParent)
    UIAnimCustom(driver, from, to, duration, easing, function(v)
        fontString:SetText(string.format(format, v))
    end, onFinish)
    return driver
end

-- ===================================
-- ANIMATION SEQUENCING
-- ===================================

-- Chain multiple animations in sequence.
-- Each entry: { fn = function(onDone), duration = seconds }
-- fn receives an onDone callback to call when the step finishes.
-- If duration is provided, onDone is called automatically after that time.
-- @param steps Array of { fn, duration } tables
-- @param onFinish Optional callback when all steps complete
function UIAnimChain(steps, onFinish)
    local idx = 0
    local function RunNext()
        idx = idx + 1
        if idx > #steps then
            if onFinish then onFinish() end
            return
        end
        local step = steps[idx]
        if step.duration then
            step.fn(function() end)
            C_Timer.After(step.duration, RunNext)
        else
            step.fn(RunNext)
        end
    end
    RunNext()
end

-- Stagger: run the same animation on multiple frames with a delay between each.
-- @param frames   Array of frames
-- @param delay    Seconds between each start (default 0.05)
-- @param animFn   function(frame, index) that applies the animation
function UIAnimStagger(frames, delay, animFn)
    delay = delay or 0.05
    for i, frame in ipairs(frames) do
        C_Timer.After((i - 1) * delay, function()
            animFn(frame, i)
        end)
    end
end

-- ===================================
-- SPRING PHYSICS ANIMATION
-- ===================================

-- Animate a value using spring physics (damped harmonic oscillator).
-- Produces natural overshoot and settle behavior.
-- @param frame     Frame to attach driver to
-- @param from      Start value
-- @param to        Target value
-- @param stiffness Spring stiffness (default 180)
-- @param damping   Damping coefficient (default 12)
-- @param setter    function(value) called each tick
-- @param onSettle  Optional callback when settled (velocity near zero)
-- @return driver frame
function UIAnimSpring(frame, from, to, stiffness, damping, setter, onSettle)
    stiffness = stiffness or 180
    damping   = damping or 12
    local driver = CreateFrame("Frame", nil, frame)
    local pos = from
    local vel = 0

    setter(from)
    driver:SetScript("OnUpdate", function(self, dt)
        dt = math.min(dt, 0.05) -- clamp to avoid instability on lag spikes
        local force = -stiffness * (pos - to)
        local damp  = -damping * vel
        vel = vel + (force + damp) * dt
        pos = pos + vel * dt
        setter(pos)

        if math.abs(pos - to) < 0.001 and math.abs(vel) < 0.01 then
            pos = to
            setter(to)
            self:SetScript("OnUpdate", nil)
            if onSettle then onSettle() end
        end
    end)
    return driver
end

-- ===================================
-- RUBBER BAND (OVERSHOOT + SETTLE)
-- ===================================

-- Scale a frame with rubber-band spring physics.
-- @param frame     Frame to animate
-- @param from      Start scale
-- @param to        Target scale
-- @param stiffness Optional (default 200)
-- @param damping   Optional (default 10)
function UIAnimRubberBand(frame, from, to, stiffness, damping)
    local driver = frame._uiAnimRubberDriver
    if not driver then
        driver = CreateFrame("Frame", nil, frame)
        frame._uiAnimRubberDriver = driver
    end
    frame:SetScale(from)
    UIAnimSpring(driver, from, to, stiffness or 200, damping or 10, function(v)
        frame:SetScale(v)
    end)
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["AnimationsEffects"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: AnimationsEffects module loaded")
end
