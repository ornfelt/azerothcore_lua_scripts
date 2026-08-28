local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- ANIMATION DECORATORS ADVANCED MODULE
-- ===================================
-- Smooth edge glow, pulse ring, border breathe, icon highlight.

-- ===================================
-- SMOOTH EDGE GLOW (gradient-based)
-- ===================================

-- Animate edge glow with smooth gradient transitions.
-- Uses SetGradientAlpha so the glow smoothly travels across edges
-- rather than flashing entire edges on/off.
-- Requires a container from CreateEdgeGlow (reuses same structure).
-- @param container  Frame from CreateEdgeGlow
-- @param speed      Loops per second (default 0.5)
-- @param continuous Loop forever if true
function UIAnimSmoothEdgeGlow(container, speed, continuous)
    speed = speed or 0.5
    local edges = container._edges
    local color = container._edgeColor or { 1, 0.82, 0 }
    local r, g, b = color[1], color[2], color[3]
    container:Show()
    for _, e in ipairs(edges) do e:SetAlpha(1) end

    local function GlowAt(x, p)
        local d = math.abs(x - p)
        d = math.min(d, 1 - d)
        local v = math.max(0, 1 - d * 3.5)
        return v * v * 0.85
    end

    local elapsed = 0
    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local p = (elapsed * speed) % 1

        edges[1]:SetGradientAlpha("HORIZONTAL",
            r, g, b, GlowAt(0.0, p), r, g, b, GlowAt(0.25, p))
        edges[2]:SetGradientAlpha("VERTICAL",
            r, g, b, GlowAt(0.25, p), r, g, b, GlowAt(0.5, p))
        edges[3]:SetGradientAlpha("HORIZONTAL",
            r, g, b, GlowAt(0.75, p), r, g, b, GlowAt(0.5, p))
        edges[4]:SetGradientAlpha("VERTICAL",
            r, g, b, GlowAt(0.0, p), r, g, b, GlowAt(0.75, p))

        if not continuous and elapsed >= (1 / speed) then
            self:SetScript("OnUpdate", nil)
            for _, e in ipairs(edges) do
                e:SetAlpha(0)
                e:SetGradientAlpha("HORIZONTAL", r, g, b, 0, r, g, b, 0)
            end
            self:Hide()
        end
    end)
    return container
end

-- ===================================
-- PULSE RING (expanding border ring)
-- ===================================

-- Create an expanding ring outline that radiates outward from a frame.
-- @param parent    Frame to pulse from
-- @param color     Optional {r, g, b} (default gold)
-- @param thickness Ring edge thickness (default 2)
-- @return ring frame
function CreatePulseRing(parent, color, thickness)
    color = color or { 1, 0.82, 0 }
    thickness = thickness or 2

    local ring = CreateFrame("Frame", nil, parent)
    ring:SetSize(parent:GetWidth(), parent:GetHeight())
    ring:SetPoint("CENTER", parent, "CENTER", 0, 0)
    ring:SetFrameLevel(parent:GetFrameLevel() + 2)

    local function MakeRingEdge(p1, a1, p2, a2, isVert)
        local e = ring:CreateTexture(nil, "OVERLAY")
        e:SetTexture("Interface\\Buttons\\WHITE8X8")
        e:SetBlendMode("ADD")
        if isVert then e:SetWidth(thickness) else e:SetHeight(thickness) end
        e:SetPoint(p1, ring, a1, 0, 0)
        e:SetPoint(p2, ring, a2, 0, 0)
        e:SetVertexColor(color[1], color[2], color[3], 1)
        return e
    end

    ring._ringEdges = {
        MakeRingEdge("TOPLEFT", "TOPLEFT", "TOPRIGHT", "TOPRIGHT", false),
        MakeRingEdge("TOPRIGHT", "TOPRIGHT", "BOTTOMRIGHT", "BOTTOMRIGHT", true),
        MakeRingEdge("BOTTOMLEFT", "BOTTOMLEFT", "BOTTOMRIGHT", "BOTTOMRIGHT", false),
        MakeRingEdge("TOPLEFT", "TOPLEFT", "BOTTOMLEFT", "BOTTOMLEFT", true),
    }
    ring:SetAlpha(0)
    ring:Hide()
    return ring
end

-- Trigger a single pulse ring expansion.
-- @param ring     Frame from CreatePulseRing
-- @param duration Expansion time (default 0.8)
-- @param maxScale How far the ring expands (default 1.6)
function UIAnimPulseRing(ring, duration, maxScale)
    duration = duration or 0.8
    maxScale = maxScale or 1.6
    ring:Show()
    ring:SetScale(1)
    ring:SetAlpha(0.8)

    local elapsed = 0
    ring:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t = math.min(elapsed / duration, 1)
        local eased = UIAnimEasing.EaseOutCubic(t)
        self:SetScale(Lerp(1, maxScale, eased))
        self:SetAlpha(Lerp(0.8, 0, eased))

        if t >= 1 then
            self:SetScript("OnUpdate", nil)
            self:Hide()
            self:SetScale(1)
        end
    end)
end

-- ===================================
-- BORDER BREATHE (synchronized glow)
-- ===================================

-- Create a border that breathes — all 4 edges glow in unison with optional color shift.
-- @param parent    Frame to add border to
-- @param color     Optional {r, g, b} base color (default gold)
-- @param thickness Edge thickness (default 2)
-- @return container frame
function CreateBorderBreathe(parent, color, thickness)
    color = color or { 1, 0.82, 0 }
    thickness = thickness or 2

    local container = CreateFrame("Frame", nil, parent)
    container:SetAllPoints(parent)
    container:SetFrameLevel(parent:GetFrameLevel() + 1)

    local edges = {}
    local function MakeEdge(p1, a1, p2, a2, isVert)
        local e = container:CreateTexture(nil, "OVERLAY")
        e:SetTexture("Interface\\Buttons\\WHITE8X8")
        e:SetBlendMode("ADD")
        if isVert then e:SetWidth(thickness) else e:SetHeight(thickness) end
        e:SetPoint(p1, container, a1, 0, 0)
        e:SetPoint(p2, container, a2, 0, 0)
        e:SetVertexColor(color[1], color[2], color[3], 1)
        e:SetAlpha(0)
        return e
    end

    edges[1] = MakeEdge("TOPLEFT", "TOPLEFT", "TOPRIGHT", "TOPRIGHT", false)
    edges[2] = MakeEdge("TOPRIGHT", "TOPRIGHT", "BOTTOMRIGHT", "BOTTOMRIGHT", true)
    edges[3] = MakeEdge("BOTTOMLEFT", "BOTTOMLEFT", "BOTTOMRIGHT", "BOTTOMRIGHT", false)
    edges[4] = MakeEdge("TOPLEFT", "TOPLEFT", "BOTTOMLEFT", "BOTTOMLEFT", true)

    container._breatheEdges = edges
    container._breatheColor = color
    container:Hide()
    return container
end

-- Animate border breathing — all edges pulse in unison with optional color shift.
-- @param container  Frame from CreateBorderBreathe
-- @param speed      Breaths per second (default 0.8)
-- @param colorB     Optional second {r, g, b} to shift towards at peak
-- @param continuous Loop forever if true
function UIAnimBorderBreathe(container, speed, colorB, continuous)
    speed = speed or 0.8
    local edges = container._breatheEdges
    local colorA = container._breatheColor
    colorB = colorB or colorA
    container:Show()

    local elapsed = 0
    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local wave = (math.sin(elapsed * speed * math.pi * 2) + 1) / 2
        wave = wave * wave * (3 - 2 * wave)
        local r = Lerp(colorA[1], colorB[1], wave)
        local g = Lerp(colorA[2], colorB[2], wave)
        local b = Lerp(colorA[3], colorB[3], wave)
        local alpha = Lerp(0.15, 0.8, wave)

        for _, edge in ipairs(edges) do
            edge:SetVertexColor(r, g, b, 1)
            edge:SetAlpha(alpha)
        end

        if not continuous and elapsed >= (1 / speed) then
            self:SetScript("OnUpdate", nil)
            for _, e in ipairs(edges) do e:SetAlpha(0) end
            self:Hide()
        end
    end)
    return container
end

-- ===================================
-- ICON HIGHLIGHT WIPE
-- ===================================

-- Create a vertical highlight bar that wipes across a frame.
-- @param parent Frame to add highlight to
-- @param color  Optional {r, g, b} (default white)
-- @return container frame
function CreateIconHighlight(parent, color)
    color = color or { 1, 1, 1 }

    local container = CreateFrame("Frame", nil, parent)
    container:SetAllPoints(parent)
    container:SetFrameLevel(parent:GetFrameLevel() + 3)

    local bar = container:CreateTexture(nil, "OVERLAY")
    bar:SetTexture("Interface\\Buttons\\WHITE8X8")
    bar:SetBlendMode("ADD")
    bar:SetWidth(10)
    bar:SetPoint("TOP", container, "TOP", 0, 0)
    bar:SetPoint("BOTTOM", container, "BOTTOM", 0, 0)
    bar:SetVertexColor(color[1], color[2], color[3], 1)
    bar:Hide()

    container._highlightBar = bar
    container:Hide()
    return container
end

-- Animate a highlight wipe across the frame.
-- @param container  Frame from CreateIconHighlight
-- @param duration   Wipe duration (default 0.5)
-- @param continuous Loop forever if true
function UIAnimIconHighlight(container, duration, continuous)
    duration = duration or 0.5
    local bar = container._highlightBar
    container:Show()
    bar:Show()

    local w = container:GetWidth()
    local elapsed = 0

    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local t
        if continuous then t = (elapsed / duration) % 1
        else t = math.min(elapsed / duration, 1) end

        local eased = UIAnimEasing.EaseInOutQuad(t)
        local x = Lerp(-10, w, eased)
        bar:ClearAllPoints()
        bar:SetPoint("TOPLEFT", self, "TOPLEFT", x, 0)
        bar:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", x, 0)

        local fadeAlpha
        if t < 0.15 then fadeAlpha = t / 0.15
        elseif t > 0.85 then fadeAlpha = (1 - t) / 0.15
        else fadeAlpha = 1.0 end
        bar:SetAlpha(fadeAlpha * 0.6)

        if not continuous and t >= 1 then
            self:SetScript("OnUpdate", nil)
            bar:Hide()
            self:Hide()
        end
    end)
    return container
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["AnimationsDecorAdvanced"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: AnimationsDecorAdvanced module loaded")
end
