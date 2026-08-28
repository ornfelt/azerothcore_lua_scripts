-- GameMaster UI System - Transition Animations
-- Wrapper functions for animated tab switches, pagination, modals, and view toggles.
-- Uses UIStyle_16_Animations library functions exclusively.

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

local GMData = _G.GMData
local GMUtils = _G.GMUtils

-- ───────────────────────────────────────────────
-- Constants
-- ───────────────────────────────────────────────
local FADE_OUT_FAST   = 0.10
local FADE_IN_NORMAL  = 0.15
local FADE_OUT_NORMAL = 0.12
local FADE_IN_SLOW    = 0.20
local POP_IN_DUR      = 0.22
local POP_OUT_DUR     = 0.15
local COLOR_PULSE_DUR = 0.4

-- Safety: check if animation functions exist
local HAS_ANIM = type(UIAnimContentSwap) == "function"

-- ───────────────────────────────────────────────
-- Module
-- ───────────────────────────────────────────────
local GMTransitions = {}
_G.GMTransitions = GMTransitions

--- Animate a tab content crossfade.
-- Fades out the content area, runs swapFn (which hides old/shows new frames),
-- then fades the content area back in.
-- @param contentArea  The parent content frame to fade
-- @param swapFn       Function that performs the actual hide-old/show-new logic
function GMTransitions.fadeTabSwitch(contentArea, swapFn)
    if not HAS_ANIM or not contentArea then
        if swapFn then swapFn() end
        return
    end
    UIAnimContentSwap(contentArea, swapFn, FADE_OUT_FAST, FADE_IN_NORMAL)
end

--- Fade out content area before a pagination data request.
-- Cards already have staggered entrance animation, so this bridges the gap.
-- @param contentArea  The content frame to fade out
-- @param requestFn    Function that triggers the data request
function GMTransitions.fadePageChange(contentArea, requestFn)
    if not HAS_ANIM or not contentArea then
        if requestFn then requestFn() end
        return
    end
    UIAnimAlpha(contentArea, contentArea:GetAlpha(), 0.15, FADE_OUT_FAST, 0, function()
        if requestFn then requestFn() end
        -- Cards will fade in via their own stagger animation
        UIAnimAlpha(contentArea, 0.15, 1, FADE_IN_NORMAL)
    end)
end

--- Pop-in animation for modal/overlay frames.
-- @param frame  The modal frame to show
function GMTransitions.popInModal(frame)
    if not HAS_ANIM or not frame then
        if frame then frame:Show() end
        return
    end
    UIAnimPopIn(frame, POP_IN_DUR)
end

--- Pop-out animation for modal/overlay frames.
-- @param frame  The modal frame to hide
function GMTransitions.popOutModal(frame)
    if not HAS_ANIM or not frame then
        if frame then frame:Hide() end
        return
    end
    UIAnimPopOut(frame, POP_OUT_DUR)
end

--- Crossfade between two views (e.g., grid ↔ list).
-- Fades out the old view, then shows and fades in the new view.
-- @param oldFrame   Frame to hide
-- @param newFrame   Frame to show
-- @param onSwapped  Optional callback after new frame is visible
function GMTransitions.crossfadeViews(oldFrame, newFrame, onSwapped)
    if not HAS_ANIM or not oldFrame or not newFrame then
        if oldFrame then oldFrame:Hide() end
        if newFrame then newFrame:Show() end
        if onSwapped then onSwapped() end
        return
    end
    UIAnimHideFrame(oldFrame, FADE_OUT_NORMAL, function()
        UIAnimShowFrame(newFrame, FADE_IN_NORMAL, onSwapped)
    end)
end

--- Flash the page counter text with a brief color pulse.
-- @param fontString  The page display FontString
function GMTransitions.flashPageCounter(fontString)
    if not HAS_ANIM or not fontString then return end
    if type(UIAnimColorPulse) ~= "function" then return end

    local white = { 0.8, 0.8, 0.8 }
    local highlight = { 0.4, 0.7, 1.0 }
    UIAnimColorPulse(fontString, white, highlight, COLOR_PULSE_DUR, 1)
end

-- Transitions module initialized
