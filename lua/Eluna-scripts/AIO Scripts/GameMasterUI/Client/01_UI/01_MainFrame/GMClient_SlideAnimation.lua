-- GameMaster UI System - Slide Animation
-- Handles slide-in/slide-out animation for the main panel

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

local GMData = _G.GMData
local GMUI = _G.GMUI

-- Animation config
local SLIDE_DURATION = 0.25 -- seconds
local ANIMATION_STATE = {
    isAnimating = false,
    direction = nil, -- "in" or "out"
    elapsed = 0,
    startOffset = 0,
    endOffset = 0,
}

-- Ease-out quadratic: fast start, gentle stop
local function easeOut(t)
    return 1 - (1 - t) * (1 - t)
end

-- Get the off-screen offset based on panel position and width
local function getOffScreenOffset(frame)
    local GMSettings = _G.GMSettings
    local position = GMSettings and GMSettings.current
        and GMSettings.current.position or "RIGHT"
    local width = frame:GetWidth()

    if position == "LEFT" then
        return -width -- slide off to the left
    else
        return width -- slide off to the right
    end
end

-- Reanchor frame at a given x offset from its docked edge
local function setSlideOffset(frame, offset)
    local GMSettings = _G.GMSettings
    local position = GMSettings and GMSettings.current
        and GMSettings.current.position or "RIGHT"

    frame:ClearAllPoints()
    if position == "LEFT" then
        frame:SetPoint("LEFT", UIParent, "LEFT", offset, 0)
    else
        frame:SetPoint("RIGHT", UIParent, "RIGHT", offset, 0)
    end
end

-- Reset animation state (called on Hide as safety net)
local function resetAnimationState(frame)
    if ANIMATION_STATE.isAnimating then
        frame:SetScript("OnUpdate", nil)
        ANIMATION_STATE.isAnimating = false
        ANIMATION_STATE.direction = nil
    end
end

-- OnUpdate driver for the animation
local function onAnimationUpdate(frame, delta)
    local anim = ANIMATION_STATE
    anim.elapsed = anim.elapsed + delta

    local progress = anim.elapsed / SLIDE_DURATION
    if progress >= 1 then
        progress = 1
    end

    local eased = easeOut(progress)
    local currentOffset = anim.startOffset
        + (anim.endOffset - anim.startOffset) * eased
    setSlideOffset(frame, currentOffset)

    -- Move the side tab with the panel during animation
    if GMUI.updateSideTabPosition then
        GMUI.updateSideTabPosition()
    end

    if progress >= 1 then
        frame:SetScript("OnUpdate", nil)
        anim.isAnimating = false

        if anim.direction == "out" then
            frame:Hide()
        end

        -- Reanchor side tab and update arrow after animation completes
        if GMUI.repositionSideTab then
            GMUI.repositionSideTab()
        end
        if GMUI.updateSideTabArrow then
            GMUI.updateSideTabArrow()
        end
    end
end

-- Hook OnHide to clean up stuck animation state.
-- Hidden frames don't receive OnUpdate in WoW, so without
-- this the animation state can get stuck if Hide() is called
-- externally (e.g. UISpecialFrames ESC handler).
function GMUI.hookSlideOnHide(frame)
    frame:HookScript("OnHide", function(self)
        resetAnimationState(self)
    end)
end

-- Slide the panel in (show with animation)
function GMUI.slideIn()
    local frame = GMData.frames.mainFrame
    if not frame then return end

    -- Cancel any running animation
    resetAnimationState(frame)

    local offScreen = getOffScreenOffset(frame)

    -- Position off-screen first, then show
    setSlideOffset(frame, offScreen)
    frame:Show()

    -- Set up animation state
    ANIMATION_STATE.isAnimating = true
    ANIMATION_STATE.direction = "in"
    ANIMATION_STATE.elapsed = 0
    ANIMATION_STATE.startOffset = offScreen
    ANIMATION_STATE.endOffset = 0

    frame:SetScript("OnUpdate", onAnimationUpdate)
end

-- Slide the panel out (hide with animation)
function GMUI.slideOut()
    local frame = GMData.frames.mainFrame
    if not frame then return end

    -- If frame is already hidden, nothing to do
    if not frame:IsShown() then
        resetAnimationState(frame)
        return
    end

    -- Cancel any running animation
    resetAnimationState(frame)

    local offScreen = getOffScreenOffset(frame)

    ANIMATION_STATE.isAnimating = true
    ANIMATION_STATE.direction = "out"
    ANIMATION_STATE.elapsed = 0
    ANIMATION_STATE.startOffset = 0
    ANIMATION_STATE.endOffset = offScreen

    frame:SetScript("OnUpdate", onAnimationUpdate)
end

-- Check if animation is currently running
function GMUI.isSlideAnimating()
    return ANIMATION_STATE.isAnimating
end
