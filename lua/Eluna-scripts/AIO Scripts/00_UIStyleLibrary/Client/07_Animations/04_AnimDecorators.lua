local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- ANIMATION DECORATORS MODULE
-- ===================================
-- Border trace, edge glow, corner flare, background cycle, icon sparkles.

-- ===================================
-- BORDER TRACE (traveling light)
-- ===================================

-- Create a comet of light dots that travel around a frame's border.
-- @param parent   Frame to trace around
-- @param color    Optional {r, g, b} (default gold)
-- @param dotCount Trail length (default 16)
-- @return container frame
function CreateBorderTrace(parent, color, dotCount)
    color = color or { 1, 0.82, 0 }
    dotCount = dotCount or 16

    local container = CreateFrame("Frame", nil, parent)
    container:SetAllPoints(parent)
    container:SetFrameLevel(parent:GetFrameLevel() + 2)

    local dots = {}
    for i = 1, dotCount do
        local d = container:CreateTexture(nil, "OVERLAY")
        d:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask")
        d:SetBlendMode("ADD")
        d:SetSize(6, 6)
        d:SetVertexColor(color[1], color[2], color[3], 1)
        d:SetAlpha(0)
        dots[i] = d
    end

    container._traceDots = dots
    container:Hide()
    return container
end

-- Animate a border trace container.
-- @param container Frame from CreateBorderTrace
-- @param speed     Loops per second (default 0.8)
-- @param continuous If true, loops forever; otherwise plays once
function UIAnimBorderTrace(container, speed, continuous)
    speed = speed or 0.8
    local dots = container._traceDots
    local count = #dots
    container:Show()

    local function GetBorderXY(t, w, h)
        t = t % 1
        local perim = 2 * (w + h)
        local d = t * perim
        if d <= w then return d, 0
        elseif d <= w + h then return w, -(d - w)
        elseif d <= 2 * w + h then return w - (d - w - h), -h
        else return 0, -h + (d - 2 * w - h) end
    end

    local elapsed = 0
    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local w, h = self:GetWidth(), self:GetHeight()
        local headT = elapsed * speed

        for i, dot in ipairs(dots) do
            local trailOffset = (i - 1) * 0.015
            local x, y = GetBorderXY(headT - trailOffset, w, h)
            dot:ClearAllPoints()
            dot:SetPoint("CENTER", self, "TOPLEFT", x, y)
            dot:SetAlpha(math.max(0, (1 - (i - 1) / count) * 0.9))
        end

        if not continuous and elapsed >= (1 / speed) then
            self:SetScript("OnUpdate", nil)
            for _, dot in ipairs(dots) do dot:SetAlpha(0) end
            self:Hide()
        end
    end)
    return container
end

-- ===================================
-- EDGE GLOW (sequential border pulse)
-- ===================================

-- Create 4 edge glow textures (top/right/bottom/left) on a frame.
-- @param parent    Frame to add edges to
-- @param color     Optional {r, g, b} (default gold)
-- @param thickness Edge thickness in pixels (default 2)
-- @return container frame
function CreateEdgeGlow(parent, color, thickness)
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

    container._edges = edges
    container._edgeColor = color
    container:Hide()
    return container
end

-- Animate edge glow — edges light up in sequence around the frame.
-- @param container  Frame from CreateEdgeGlow
-- @param speed      Cycles per second (default 1.0)
-- @param continuous Loop forever if true
function UIAnimEdgeGlow(container, speed, continuous)
    speed = speed or 1.0
    local edges = container._edges
    container:Show()

    local elapsed = 0
    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        for i, edge in ipairs(edges) do
            local phase = (i - 1) / 4
            local t = ((elapsed * speed) - phase) % 1
            local brightness
            if t < 0.15 then brightness = t / 0.15
            else brightness = math.max(0, 1 - (t - 0.15) / 0.55) end
            edge:SetAlpha(brightness * 0.8)
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
-- CORNER FLARE (cascading corner glow)
-- ===================================

-- Create 4 corner glow textures that cascade in sequence.
-- @param parent Frame to attach to
-- @param color  Optional {r, g, b} (default gold)
-- @param size   Corner glow size (default 24)
-- @return container frame
function CreateCornerFlare(parent, color, size)
    color = color or { 1, 0.82, 0 }
    size = size or 24

    local container = CreateFrame("Frame", nil, parent)
    container:SetAllPoints(parent)
    container:SetFrameLevel(parent:GetFrameLevel() + 2)

    local points = {
        { "TOPLEFT", "TOPLEFT" },
        { "TOPRIGHT", "TOPRIGHT" },
        { "BOTTOMRIGHT", "BOTTOMRIGHT" },
        { "BOTTOMLEFT", "BOTTOMLEFT" },
    }

    local corners = {}
    for i, pt in ipairs(points) do
        local c = container:CreateTexture(nil, "OVERLAY")
        c:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
        c:SetBlendMode("ADD")
        c:SetSize(size, size)
        c:SetPoint(pt[1], container, pt[2], 0, 0)
        c:SetVertexColor(color[1], color[2], color[3], 1)
        c:SetAlpha(0)
        corners[i] = c
    end

    container._corners = corners
    container:Hide()
    return container
end

-- Animate corner flares — corners glow in cascade sequence.
-- @param container  Frame from CreateCornerFlare
-- @param speed      Cycles per second (default 1.5)
-- @param continuous Loop forever if true
function UIAnimCornerFlare(container, speed, continuous)
    speed = speed or 1.5
    local corners = container._corners
    container:Show()

    local elapsed = 0
    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        for i, corner in ipairs(corners) do
            local phase = (i - 1) * 0.25
            local t = ((elapsed * speed) - phase) % 1
            local alpha
            if t < 0.2 then alpha = (t / 0.2) * 0.7
            else alpha = math.max(0, 0.7 * (1 - (t - 0.2) / 0.5)) end
            corner:SetAlpha(alpha)
        end

        if not continuous and elapsed >= (1 / speed) then
            self:SetScript("OnUpdate", nil)
            for _, c in ipairs(corners) do c:SetAlpha(0) end
            self:Hide()
        end
    end)
    return container
end

-- ===================================
-- BACKGROUND COLOR CYCLE
-- ===================================

-- Create a background color cycle on a frame with a backdrop.
-- Uses SetBackdropColor directly (BACKGROUND-layer textures are hidden behind backdrops).
-- @param parent Frame with a backdrop (e.g. from CreateStyledFrame)
-- @param colors Array of {r, g, b} tables (default 4-color palette)
-- @return container frame
function CreateBackgroundCycle(parent, colors)
    colors = colors or {
        { 0.15, 0.1, 0.22 },
        { 0.22, 0.1, 0.12 },
        { 0.1, 0.18, 0.22 },
        { 0.12, 0.22, 0.1 },
    }

    local container = CreateFrame("Frame", nil, parent)
    container:SetAllPoints(parent)
    container._bgParent = parent
    container._bgColors = colors
    container:Hide()
    return container
end

-- Animate background color cycling via SetBackdropColor.
-- @param container     Frame from CreateBackgroundCycle
-- @param cycleDuration Seconds per color transition (default 2.0)
-- @param continuous    Loop forever if true
function UIAnimBackgroundCycle(container, cycleDuration, continuous)
    cycleDuration = cycleDuration or 2.0
    local bgParent = container._bgParent
    local colors = container._bgColors
    local count = #colors
    container:Show()

    local elapsed = 0
    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local totalT = elapsed / cycleDuration
        local idx = math.floor(totalT % count) + 1
        local nextIdx = (idx % count) + 1
        local blend = totalT % 1
        blend = blend * blend * (3 - 2 * blend)

        local c1, c2 = colors[idx], colors[nextIdx]
        bgParent:SetBackdropColor(
            Lerp(c1[1], c2[1], blend),
            Lerp(c1[2], c2[2], blend),
            Lerp(c1[3], c2[3], blend), 1)

        if not continuous and elapsed >= cycleDuration * count then
            self:SetScript("OnUpdate", nil)
            self:Hide()
        end
    end)
    return container
end

-- ===================================
-- ICON SPARKLES (edge particle spawns)
-- ===================================

-- Create a sparkle emitter around a frame's edges.
-- Sparks spawn on random edges and drift outward while fading.
-- @param parent     Frame to sparkle around
-- @param sparkCount Max concurrent sparks (default 10)
-- @return container frame
function CreateIconSparkles(parent, sparkCount)
    sparkCount = sparkCount or 10

    local container = CreateFrame("Frame", nil, parent)
    container:SetAllPoints(parent)
    container:SetFrameLevel(parent:GetFrameLevel() + 3)

    local sparks = {}
    for i = 1, sparkCount do
        local s = container:CreateTexture(nil, "OVERLAY")
        s:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask")
        s:SetBlendMode("ADD")
        s:SetSize(4, 4)
        s:SetAlpha(0)
        sparks[i] = { tex = s, life = 1, maxLife = 1, x = 0, y = 0, vx = 0, vy = 0 }
    end

    container._sparks = sparks
    container:Hide()
    return container
end

-- Animate icon sparkles.
-- @param container  Frame from CreateIconSparkles
-- @param color      Optional {r, g, b} (default gold)
-- @param duration   Total effect time (nil = use continuous)
-- @param continuous Loop forever if true
function UIAnimIconSparkles(container, color, duration, continuous)
    color = color or { 1, 0.85, 0.3 }
    local sparks = container._sparks
    local count = #sparks
    container:Show()

    local w, h = container:GetWidth(), container:GetHeight()
    local elapsed = 0
    local spawnTimer = 0
    local spawnInterval = 0.12
    local spawnIdx = 0

    container:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        spawnTimer = spawnTimer + dt

        if spawnTimer >= spawnInterval then
            spawnTimer = spawnTimer - spawnInterval
            spawnIdx = (spawnIdx % count) + 1
            local s = sparks[spawnIdx]
            local side = math.random(4)
            if side == 1 then s.x = math.random() * w; s.y = 0
            elseif side == 2 then s.x = w; s.y = -math.random() * h
            elseif side == 3 then s.x = math.random() * w; s.y = -h
            else s.x = 0; s.y = -math.random() * h end
            s.vx = (math.random() - 0.5) * 20
            s.vy = (math.random() - 0.5) * 20
            s.life = 0
            s.maxLife = 0.4 + math.random() * 0.4
            s.tex:SetVertexColor(color[1], color[2], color[3], 1)
            s.tex:SetSize(3 + math.random(3), 3 + math.random(3))
        end

        for _, s in ipairs(sparks) do
            if s.life < s.maxLife then
                s.life = s.life + dt
                s.x = s.x + s.vx * dt
                s.y = s.y + s.vy * dt
                local t = s.life / s.maxLife
                s.tex:ClearAllPoints()
                s.tex:SetPoint("CENTER", self, "TOPLEFT", s.x, s.y)
                s.tex:SetAlpha((1 - t) * 0.8)
            else
                s.tex:SetAlpha(0)
            end
        end

        if not continuous and duration and elapsed >= duration then
            self:SetScript("OnUpdate", nil)
            for _, s in ipairs(sparks) do s.tex:SetAlpha(0) end
            self:Hide()
        end
    end)
    return container
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["AnimationsDecorators"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: AnimationsDecorators module loaded")
end
