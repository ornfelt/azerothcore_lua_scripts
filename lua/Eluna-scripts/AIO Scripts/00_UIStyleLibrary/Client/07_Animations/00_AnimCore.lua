local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- ANIMATIONS CORE MODULE
-- ===================================
-- Core animation utilities: stop, alpha, fade, show/hide, content swap, flash.
-- Uses SmoothStep from UIStyle_15_Utils for easing.

-- Cancel any running OnUpdate animation on a frame.
function UIAnimStop(frame)
    frame:SetScript("OnUpdate", nil)
end

-- Fade a frame's alpha from `from` to `to` over `duration` seconds.
-- @param frame    Frame to animate
-- @param from     Starting alpha (0-1)
-- @param to       Target alpha (0-1)
-- @param duration Seconds for the transition
-- @param delay    Optional seconds to wait before starting
-- @param onFinish Optional callback when animation completes
function UIAnimAlpha(frame, from, to, duration, delay, onFinish)
    local elapsed = -(delay or 0)
    frame:SetAlpha(from)
    frame:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0 then return end
        local t = math.min(elapsed / duration, 1)
        self:SetAlpha(SmoothStep(from, to, t))
        if t >= 1 then
            self:SetAlpha(to)
            self:SetScript("OnUpdate", nil)
            if onFinish then onFinish(self) end
        end
    end)
end

-- Convenience: fade in (alpha 0 → 1).
function UIAnimFadeIn(frame, duration, delay)
    UIAnimAlpha(frame, 0, 1, duration or 0.2, delay)
end

-- Convenience: fade out (alpha 1 → 0), optionally hiding the frame on finish.
function UIAnimFadeOut(frame, duration, delay, hideOnFinish)
    UIAnimAlpha(frame, 1, 0, duration or 0.2, delay, function(self)
        if hideOnFinish then self:Hide() end
    end)
end

-- Create an additive glow texture with a pulsing alpha animation.
-- @param parent Frame to create the texture on
-- @param anchor Region to center the glow on
-- @param size   Base icon size (padding added internally)
-- @param color  Optional {r, g, b} table (defaults to golden)
-- @return glow (texture), pulse (AnimationGroup)
function CreatePulsingGlow(parent, anchor, size, color)
    local GLOW_PADDING   = 14
    local GLOW_BASE_ALPHA = 0.6
    local PULSE_CHANGE   = -0.4
    local PULSE_DURATION = 1.2
    color = color or { 1, 0.85, 0.3 }

    local glow = parent:CreateTexture(nil, "BORDER")
    glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    glow:SetSize(size + GLOW_PADDING, size + GLOW_PADDING)
    glow:SetPoint("CENTER", anchor, "CENTER", 0, 0)
    glow:SetBlendMode("ADD")
    glow:SetVertexColor(color[1], color[2], color[3], 1)
    glow:SetAlpha(GLOW_BASE_ALPHA)
    glow:Hide()

    local pulse = glow:CreateAnimationGroup()
    pulse:SetLooping("BOUNCE")
    local anim = pulse:CreateAnimation("Alpha")
    anim:SetChange(PULSE_CHANGE)
    anim:SetDuration(PULSE_DURATION)

    return glow, pulse
end

-- ===================================
-- HIGH-LEVEL ANIMATION PATTERNS
-- ===================================

-- Show a hidden frame with a fade-in animation.
-- Safe to call on an already-visible frame (resets alpha and replays).
-- @param frame    Frame to show
-- @param duration Fade duration in seconds (default 0.25)
-- @param onFinish Optional callback after fade completes
function UIAnimShowFrame(frame, duration, onFinish)
    frame:SetAlpha(0)
    frame:Show()
    UIAnimAlpha(frame, 0, 1, duration or 0.25, 0, onFinish)
end

-- Hide a visible frame with a fade-out animation.
-- Ignores duplicate calls while already fading out.
-- @param frame    Frame to hide
-- @param duration Fade duration in seconds (default 0.2)
-- @param onHidden Optional callback after frame is hidden
function UIAnimHideFrame(frame, duration, onHidden)
    if frame._uiAnimHiding then return end
    frame._uiAnimHiding = true
    UIAnimAlpha(frame, frame:GetAlpha(), 0, duration or 0.2, 0, function(self)
        self:Hide()
        self._uiAnimHiding = false
        if onHidden then onHidden(self) end
    end)
end

-- Fade a frame's content out, run a swap function, then fade back in.
-- Useful for tab switches, page transitions, or content reloads.
-- @param frame    Frame whose alpha to animate (e.g. content panel)
-- @param swapFn   Function called at the midpoint (content hidden) to swap content
-- @param fadeOut  Fade-out duration in seconds (default 0.1)
-- @param fadeIn   Fade-in duration in seconds (default 0.15)
function UIAnimContentSwap(frame, swapFn, fadeOut, fadeIn)
    UIAnimAlpha(frame, 1, 0, fadeOut or 0.1, 0, function()
        if swapFn then swapFn() end
        UIAnimAlpha(frame, 0, 1, fadeIn or 0.15)
    end)
end

-- Create a flash overlay Frame for burst visual feedback (e.g. learn/unlock).
-- Returns a Frame (hidden by default) — call UIAnimFlash() to trigger it.
-- @param parent   Parent frame to attach the flash to
-- @param anchor   Region to match size/position (e.g. an icon texture)
-- @param color    Optional {r, g, b} (default white)
-- @return flashFrame
function CreateFlashOverlay(parent, anchor, color)
    local f = CreateFrame("Frame", nil, parent)
    f:SetAllPoints(anchor)
    f:SetFrameLevel(parent:GetFrameLevel() + 3)
    local tex = f:CreateTexture(nil, "OVERLAY")
    tex:SetTexture("Interface\\Buttons\\WHITE8X8")
    tex:SetBlendMode("ADD")
    tex:SetAllPoints(f)
    if color then
        tex:SetVertexColor(color[1], color[2], color[3], 1)
    end
    f:SetAlpha(0)
    f:Hide()
    return f
end

-- Trigger a flash effect on a frame created by CreateFlashOverlay.
-- @param flashFrame Frame from CreateFlashOverlay
-- @param peakAlpha  Starting flash brightness (default 0.8)
-- @param duration   Fade-out duration in seconds (default 0.4)
function UIAnimFlash(flashFrame, peakAlpha, duration)
    flashFrame:SetAlpha(peakAlpha or 0.8)
    flashFrame:Show()
    UIAnimAlpha(flashFrame, peakAlpha or 0.8, 0, duration or 0.4, 0, function(self)
        self:Hide()
    end)
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["AnimationsCore"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: AnimationsCore module loaded")
end
