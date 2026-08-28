local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

local GMCards = _G.GMCards
local GMConfig = _G.GMConfig

-- ============================================================
-- Animation constants
-- ============================================================

local ANIM = {
    ENTRANCE = {
        SLIDE_PX = 8,
        DURATION = 0.25,
        STAGGER = 0.05,
    },
    HOVER = {
        BORDER_DURATION = 0.15,
        GLOW_ALPHA = 0.3,
        SPIN_SPEED = 35,         -- degrees/sec
        SPIN_DECEL = 0.92,       -- multiplier per frame for deceleration
    },
    BREATH = {
        NPC_AMP = 0.02,
        NPC_PERIOD = 3,
        GO_AMP = 0.01,
        GO_PERIOD = 5,
    },
    FLASH = {
        LEFT_ALPHA = 0.6,
        LEFT_DURATION = 0.2,
        RIGHT_ALPHA = 0.3,
        RIGHT_DURATION = 0.15,
    },
    ACCENT = {
        HEIGHT = 2,
        IDLE_ALPHA = 0.7,
        HOVER_ALPHA = 1.0,
        NPC_COLOR = { 0.31, 0.69, 0.89 },       -- Blue
        GO_COLOR = { 0.31, 0.89, 0.31 },         -- Green
        SPELL_COLOR = { 0.6, 0.4, 0.9 },         -- Purple/Arcane
        SPELLVIS_COLOR = { 0.31, 0.69, 0.89 },   -- Blue (like NPC)
        PLAYER_COLOR = { 0.8, 0.8, 0.8 },        -- Light grey default
    },
    SHADOW = {
        SIZE = 1,
        ALPHA = 0.3,
    },
}

-- ============================================================
-- 5. Top Accent Line + Depth Shadow (visual only, no timing)
-- ============================================================

-- Resolve accent color from entity type or custom color table
local function resolveAccentColor(entityType, customColor)
    if customColor then return customColor end
    local map = {
        NPC = ANIM.ACCENT.NPC_COLOR,
        GameObject = ANIM.ACCENT.GO_COLOR,
        Spell = ANIM.ACCENT.SPELL_COLOR,
        SpellVisual = ANIM.ACCENT.SPELLVIS_COLOR,
        Player = ANIM.ACCENT.PLAYER_COLOR,
    }
    return map[entityType] or ANIM.ACCENT.NPC_COLOR
end

function GMCards.setupCardVisuals(card, entityType, customColor)
    local color = resolveAccentColor(entityType, customColor)

    -- Top accent line
    if not card._accentLine then
        card._accentLine = card:CreateTexture(nil, "ARTWORK")
        card._accentLine:SetTexture("Interface\\Buttons\\WHITE8X8")
    end
    card._accentLine:ClearAllPoints()
    card._accentLine:SetPoint("TOPLEFT", card, "TOPLEFT", 1, -1)
    card._accentLine:SetPoint("TOPRIGHT", card, "TOPRIGHT", -1, -1)
    card._accentLine:SetHeight(ANIM.ACCENT.HEIGHT)
    card._accentLine:SetVertexColor(color[1], color[2], color[3], ANIM.ACCENT.IDLE_ALPHA)
    card._accentLine:Show()

    -- Bottom shadow
    if not card._shadowBottom then
        card._shadowBottom = card:CreateTexture(nil, "BACKGROUND")
        card._shadowBottom:SetTexture("Interface\\Buttons\\WHITE8X8")
    end
    card._shadowBottom:ClearAllPoints()
    card._shadowBottom:SetPoint("TOPLEFT", card, "BOTTOMLEFT", 1, 0)
    card._shadowBottom:SetPoint("TOPRIGHT", card, "BOTTOMRIGHT", 1, 0)
    card._shadowBottom:SetHeight(ANIM.SHADOW.SIZE)
    card._shadowBottom:SetVertexColor(0, 0, 0, ANIM.SHADOW.ALPHA)
    card._shadowBottom:Show()

    -- Right shadow
    if not card._shadowRight then
        card._shadowRight = card:CreateTexture(nil, "BACKGROUND")
        card._shadowRight:SetTexture("Interface\\Buttons\\WHITE8X8")
    end
    card._shadowRight:ClearAllPoints()
    card._shadowRight:SetPoint("TOPLEFT", card, "TOPRIGHT", 0, -1)
    card._shadowRight:SetPoint("BOTTOMLEFT", card, "BOTTOMRIGHT", 0, 0)
    card._shadowRight:SetWidth(ANIM.SHADOW.SIZE)
    card._shadowRight:SetVertexColor(0, 0, 0, ANIM.SHADOW.ALPHA)
    card._shadowRight:Show()

    -- Store entity type and accent color for hover
    card._entityType = entityType
    card._accentColor = color
end

-- ============================================================
-- 1. Staggered Entrance Fade + Slide
-- ============================================================

function GMCards.animateCardEntrance(card, index)
    if not card._animFrame then
        card._animFrame = CreateFrame("Frame", nil, card)
        card._animFrame:SetSize(1, 1)
        card._animFrame:SetPoint("CENTER")
    end

    local delay = (index - 1) * ANIM.ENTRANCE.STAGGER
    local slideOffset = ANIM.ENTRANCE.SLIDE_PX

    -- Start invisible and offset
    card:SetAlpha(0)
    local origPoints = { card:GetPoint(1) }

    local elapsed = 0
    card._animFrame:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < delay then return end

        local t = math.min((elapsed - delay) / ANIM.ENTRANCE.DURATION, 1)
        local eased = UIAnimEasing.EaseOutCubic(t)

        card:SetAlpha(eased)

        if t >= 1 then
            card:SetAlpha(1)
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- ============================================================
-- 4. Click Feedback Flash
-- ============================================================

local function ensureFlashOverlay(card, color)
    local key = color and "_flashBlue" or "_flashWhite"
    if not card[key] then
        local c = color or { 1, 1, 1 }
        card[key] = CreateFlashOverlay(card, card, c)
        card[key]:SetFrameLevel(card:GetFrameLevel() + 10)
    end
    return card[key]
end

function GMCards.setupClickFlash(card)
    card._origOnMouseUp = card:GetScript("OnMouseUp")

    card:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            local flash = ensureFlashOverlay(card)
            UIAnimFlash(flash, ANIM.FLASH.LEFT_ALPHA, ANIM.FLASH.LEFT_DURATION)
        elseif button == "RightButton" then
            local flash = ensureFlashOverlay(card, { 0.31, 0.69, 0.89 })
            UIAnimFlash(flash, ANIM.FLASH.RIGHT_ALPHA, ANIM.FLASH.RIGHT_DURATION)
        end
        -- Call original handler
        if card._origOnMouseUp then
            card._origOnMouseUp(self, button)
        end
    end)
end

-- ============================================================
-- 2. Hover Border Glow + Model Spin
-- ============================================================

local function createGlowEdges(card)
    if card._glowEdges then return card._glowEdges end

    local edges = {}
    for i = 1, 4 do
        local tex = card:CreateTexture(nil, "ARTWORK")
        tex:SetTexture("Interface\\Buttons\\WHITE8X8")
        tex:SetBlendMode("ADD")
        tex:SetVertexColor(0.31, 0.69, 0.89, 0)
        edges[i] = tex
    end
    -- Top
    edges[1]:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
    edges[1]:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)
    edges[1]:SetHeight(1)
    -- Bottom
    edges[2]:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 0)
    edges[2]:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", 0, 0)
    edges[2]:SetHeight(1)
    -- Left
    edges[3]:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
    edges[3]:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 0)
    edges[3]:SetWidth(1)
    -- Right
    edges[4]:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)
    edges[4]:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", 0, 0)
    edges[4]:SetWidth(1)

    card._glowEdges = edges
    return edges
end

local function setGlowAlpha(edges, alpha)
    for _, tex in ipairs(edges) do
        tex:SetVertexColor(0.31, 0.69, 0.89, alpha)
    end
end

function GMCards.setupHoverEffects(card)
    local origOnEnter = card:GetScript("OnEnter")
    local origOnLeave = card:GetScript("OnLeave")

    -- Glow driver frame for border animation
    if not card._glowDriver then
        card._glowDriver = CreateFrame("Frame", nil, card)
        card._glowDriver:SetSize(1, 1)
        card._glowDriver:SetPoint("CENTER")
    end

    local edges = createGlowEdges(card)
    local borderGrey = UISTYLE_COLORS.BorderGrey
    local blue = UISTYLE_COLORS.Blue

    -- Model spin state
    local spinState = { speed = 0, active = false, baseRotation = 0 }

    card:SetScript("OnEnter", function(self)
        -- Border color transition to blue
        UIAnimCustom(card._glowDriver, 0, 1, ANIM.HOVER.BORDER_DURATION,
            UIAnimEasing.EaseOutQuad, function(v)
                card:SetBackdropBorderColor(
                    Lerp(borderGrey[1], blue[1], v),
                    Lerp(borderGrey[2], blue[2], v),
                    Lerp(borderGrey[3], blue[3], v), 1)
                setGlowAlpha(edges, v * ANIM.HOVER.GLOW_ALPHA)
            end)

        -- Brighten accent line
        if card._accentLine and card._accentColor then
            local c = card._accentColor
            card._accentLine:SetVertexColor(c[1], c[2], c[3], ANIM.ACCENT.HOVER_ALPHA)
        end

        -- Start model spin + freeze animation for smooth rotation
        if card.modelFrame then
            spinState.active = true
            spinState.speed = ANIM.HOVER.SPIN_SPEED
            spinState.baseRotation = card.modelFrame._currentRotation or math.rad(30)
            card._breathPaused = true
            card.modelFrame._spinActive = true
            pcall(function()
                card.modelFrame:SetSequence(0)
                card.modelFrame:SetSequenceTime(0, 0)
            end)
        end

        if origOnEnter then origOnEnter(self) end
    end)

    card:SetScript("OnLeave", function(self)
        -- Border color back to grey
        UIAnimCustom(card._glowDriver, 1, 0, ANIM.HOVER.BORDER_DURATION,
            UIAnimEasing.EaseOutQuad, function(v)
                card:SetBackdropBorderColor(
                    Lerp(borderGrey[1], blue[1], v),
                    Lerp(borderGrey[2], blue[2], v),
                    Lerp(borderGrey[3], blue[3], v), 1)
                setGlowAlpha(edges, v * ANIM.HOVER.GLOW_ALPHA)
            end)

        -- Dim accent line
        if card._accentLine and card._accentColor then
            local c = card._accentColor
            card._accentLine:SetVertexColor(c[1], c[2], c[3], ANIM.ACCENT.IDLE_ALPHA)
        end

        -- Decelerate model spin
        spinState.active = false
        card._breathPaused = false

        if origOnLeave then origOnLeave(self) end
    end)

    -- Model spin OnUpdate on the model frame itself
    if card.modelFrame then
        local model = card.modelFrame
        model._currentRotation = model._currentRotation or math.rad(30)

        model:SetScript("OnUpdate", function(self, dt)
            if spinState.speed < 0.1 and not spinState.active then
                if spinState.speed > 0 then
                    spinState.speed = 0
                    model._spinActive = false
                    -- Restore custom animation or default idle
                    local animId = model._activeAnimId
                    if animId then
                        model._animElapsed = 0
                        pcall(function() model:SetSequence(animId) end)
                    else
                        pcall(function() model:SetSequence(0) end)
                    end
                end
                return
            end

            if not spinState.active then
                spinState.speed = spinState.speed * ANIM.HOVER.SPIN_DECEL
            end

            -- Lock at frame 0 of stand sequence each tick
            pcall(function() model:SetSequenceTime(0, 0) end)

            local radPerSec = math.rad(spinState.speed)
            model._currentRotation = model._currentRotation + radPerSec * dt
            pcall(function()
                model:SetRotation(model._currentRotation)
            end)
        end)
    end
end

-- ============================================================
-- 3. Idle Model Breathing
-- ============================================================

function GMCards.setupBreathing(card, entityType)
    if not card.modelFrame then return end

    if not card._breathFrame then
        card._breathFrame = CreateFrame("Frame", nil, card)
        card._breathFrame:SetSize(1, 1)
        card._breathFrame:SetPoint("CENTER")
    end

    local amp = (entityType == "NPC") and ANIM.BREATH.NPC_AMP or ANIM.BREATH.GO_AMP
    local period = (entityType == "NPC") and ANIM.BREATH.NPC_PERIOD or ANIM.BREATH.GO_PERIOD
    local baseZ = card.modelFrame.isGameObject and -0.5 or 0
    local elapsed = 0

    card._breathFrame:SetScript("OnUpdate", function(self, dt)
        if card._breathPaused then return end
        if not card.modelFrame or not card.modelFrame:IsVisible() then return end

        elapsed = elapsed + dt
        local offset = amp * math.sin((elapsed / period) * 2 * math.pi)
        pcall(function()
            card.modelFrame:SetPosition(0, 0, baseZ + offset)
        end)
    end)
end

-- Icon glow/hover functions moved to GMClient_04a4_CardIconAnimations.lua

-- ============================================================
-- Cleanup for card pooling
-- ============================================================

function GMCards.cleanupCardAnimations(card)
    -- Stop entrance animation
    if card._animFrame then
        card._animFrame:SetScript("OnUpdate", nil)
    end

    -- Stop breathing
    if card._breathFrame then
        card._breathFrame:SetScript("OnUpdate", nil)
    end
    card._breathPaused = nil

    -- Stop glow driver
    if card._glowDriver then
        card._glowDriver:SetScript("OnUpdate", nil)
    end

    -- Hide glow edges
    if card._glowEdges then
        setGlowAlpha(card._glowEdges, 0)
    end

    -- Hide accent + shadows
    if card._accentLine then card._accentLine:Hide() end
    if card._shadowBottom then card._shadowBottom:Hide() end
    if card._shadowRight then card._shadowRight:Hide() end

    -- Hide flash overlays
    if card._flashWhite then card._flashWhite:Hide() end
    if card._flashBlue then card._flashBlue:Hide() end

    -- Hide icon glow
    if card._iconGlow then card._iconGlow:Hide() end
    if card._iconGlowDriver then card._iconGlowDriver:SetScript("OnUpdate", nil) end
    card._iconGlowColor = nil

    -- Reset model spin and animation driver
    if card.modelFrame then
        card.modelFrame._currentRotation = nil
        card.modelFrame._spinActive = false
        card.modelFrame._activeAnimId = nil
        if card.modelFrame._animDriver then
            card.modelFrame._animDriver:SetScript("OnUpdate", nil)
        end
    end

    -- Reset border color
    card:SetBackdropBorderColor(
        UISTYLE_COLORS.BorderGrey[1],
        UISTYLE_COLORS.BorderGrey[2],
        UISTYLE_COLORS.BorderGrey[3], 1)

    -- Clear stored state
    card._origOnMouseUp = nil
    card._entityType = nil
    card._accentColor = nil
end

-- Card Animations module loaded
