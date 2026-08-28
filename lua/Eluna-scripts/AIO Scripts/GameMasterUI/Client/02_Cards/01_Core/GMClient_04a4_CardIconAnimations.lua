local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

local GMCards = _G.GMCards

-- ============================================================
-- Icon animation constants
-- ============================================================

local ICON_ANIM = {
    GLOW = {
        SIZE_PAD = 6,
        HOVER_ALPHA = 0.35,
        DURATION = 0.2,
    },
    HOVER = {
        BORDER_DURATION = 0.15,
        GLOW_ALPHA = 0.3,
    },
    ACCENT = {
        IDLE_ALPHA = 0.7,
        HOVER_ALPHA = 1.0,
    },
}

-- ============================================================
-- Shared glow edge helpers (reuse from main animations file)
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
    edges[1]:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
    edges[1]:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)
    edges[1]:SetHeight(1)
    edges[2]:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 0)
    edges[2]:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", 0, 0)
    edges[2]:SetHeight(1)
    edges[3]:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
    edges[3]:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 0)
    edges[3]:SetWidth(1)
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

-- ============================================================
-- Icon Glow Halo (for Spell, Item cards)
-- ============================================================

function GMCards.setupIconGlow(card, glowColor)
    local iconAnchor = card.iconTexture or card.iconBackground
    if not iconAnchor then return end

    local color = glowColor or { 0.6, 0.4, 0.9 }

    if not card._iconGlow then
        card._iconGlow = card:CreateTexture(nil, "BORDER")
        card._iconGlow:SetTexture("Interface\\Buttons\\WHITE8X8")
        card._iconGlow:SetBlendMode("ADD")
    end
    local pad = ICON_ANIM.GLOW.SIZE_PAD
    card._iconGlow:ClearAllPoints()
    card._iconGlow:SetPoint("TOPLEFT", iconAnchor, "TOPLEFT", -pad, pad)
    card._iconGlow:SetPoint("BOTTOMRIGHT", iconAnchor, "BOTTOMRIGHT", pad, -pad)
    card._iconGlow:SetVertexColor(color[1], color[2], color[3], 0)
    card._iconGlow:Show()

    if not card._iconGlowDriver then
        card._iconGlowDriver = CreateFrame("Frame", nil, card)
        card._iconGlowDriver:SetSize(1, 1)
        card._iconGlowDriver:SetPoint("CENTER")
    end

    card._iconGlowColor = color
end

-- ============================================================
-- Hover effects for icon-based cards
-- ============================================================

function GMCards.setupIconHoverEffects(card)
    local origOnEnter = card:GetScript("OnEnter")
    local origOnLeave = card:GetScript("OnLeave")

    if not card._glowDriver then
        card._glowDriver = CreateFrame("Frame", nil, card)
        card._glowDriver:SetSize(1, 1)
        card._glowDriver:SetPoint("CENTER")
    end

    local edges = createGlowEdges(card)
    local borderGrey = UISTYLE_COLORS.BorderGrey
    local blue = UISTYLE_COLORS.Blue
    local skipBorderAnim = card.quality ~= nil

    card:SetScript("OnEnter", function(self)
        -- Border glow (skip color change for item cards)
        if not skipBorderAnim then
            UIAnimCustom(card._glowDriver, 0, 1, ICON_ANIM.HOVER.BORDER_DURATION,
                UIAnimEasing.EaseOutQuad, function(v)
                    card:SetBackdropBorderColor(
                        Lerp(borderGrey[1], blue[1], v),
                        Lerp(borderGrey[2], blue[2], v),
                        Lerp(borderGrey[3], blue[3], v), 1)
                    setGlowAlpha(edges, v * ICON_ANIM.HOVER.GLOW_ALPHA)
                end)
        else
            UIAnimCustom(card._glowDriver, 0, 1, ICON_ANIM.HOVER.BORDER_DURATION,
                UIAnimEasing.EaseOutQuad, function(v)
                    setGlowAlpha(edges, v * ICON_ANIM.HOVER.GLOW_ALPHA)
                end)
        end

        -- Icon glow fade in
        if card._iconGlow and card._iconGlowDriver then
            local c = card._iconGlowColor or { 0.6, 0.4, 0.9 }
            UIAnimCustom(card._iconGlowDriver, 0, ICON_ANIM.GLOW.HOVER_ALPHA,
                ICON_ANIM.GLOW.DURATION, UIAnimEasing.EaseOutQuad, function(v)
                    card._iconGlow:SetVertexColor(c[1], c[2], c[3], v)
                end)
        end

        -- Brighten accent line
        if card._accentLine and card._accentColor then
            local c = card._accentColor
            card._accentLine:SetVertexColor(c[1], c[2], c[3], ICON_ANIM.ACCENT.HOVER_ALPHA)
        end

        if origOnEnter then origOnEnter(self) end
    end)

    card:SetScript("OnLeave", function(self)
        if not skipBorderAnim then
            UIAnimCustom(card._glowDriver, 1, 0, ICON_ANIM.HOVER.BORDER_DURATION,
                UIAnimEasing.EaseOutQuad, function(v)
                    card:SetBackdropBorderColor(
                        Lerp(borderGrey[1], blue[1], v),
                        Lerp(borderGrey[2], blue[2], v),
                        Lerp(borderGrey[3], blue[3], v), 1)
                    setGlowAlpha(edges, v * ICON_ANIM.HOVER.GLOW_ALPHA)
                end)
        else
            UIAnimCustom(card._glowDriver, 1, 0, ICON_ANIM.HOVER.BORDER_DURATION,
                UIAnimEasing.EaseOutQuad, function(v)
                    setGlowAlpha(edges, v * ICON_ANIM.HOVER.GLOW_ALPHA)
                end)
        end

        -- Icon glow fade out
        if card._iconGlow and card._iconGlowDriver then
            local c = card._iconGlowColor or { 0.6, 0.4, 0.9 }
            UIAnimCustom(card._iconGlowDriver, ICON_ANIM.GLOW.HOVER_ALPHA, 0,
                ICON_ANIM.GLOW.DURATION, UIAnimEasing.EaseOutQuad, function(v)
                    card._iconGlow:SetVertexColor(c[1], c[2], c[3], v)
                end)
        end

        -- Dim accent line
        if card._accentLine and card._accentColor then
            local c = card._accentColor
            card._accentLine:SetVertexColor(c[1], c[2], c[3], ICON_ANIM.ACCENT.IDLE_ALPHA)
        end

        if origOnLeave then origOnLeave(self) end
    end)
end

-- Card Icon Animations module loaded
