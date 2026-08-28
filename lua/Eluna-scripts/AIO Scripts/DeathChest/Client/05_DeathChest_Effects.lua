local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local DC = DeathChestUI
local ui = DC.ui

-- ============================================================
-- Configuration
-- ============================================================
local LOOT_TIME      = 0.28   -- Single-item loot animation
local MULTI_GAP      = 0.07   -- Stagger between rows (multi-loot)
local MIN_MULTI_TIME = 0.6    -- Minimum total time for multi-loot
local SPARKLE_COUNT  = 6      -- Star particles per burst
local SPARKLE_LIFE   = 0.45   -- Particle lifetime (seconds)
local SPARKLE_SPEED  = 55     -- Base particle velocity (px/s)
local WISP_COUNT     = 2      -- Spirit wisps per loot
local WISP_LIFE      = 0.55   -- Wisp lifetime
local WISP_RISE      = 38     -- Wisp rise speed (px/s)
local REVEAL_GAP_MIN = 0.03   -- Min stagger on chest-open reveal
local REVEAL_GAP_MAX = 0.07   -- Max stagger on chest-open reveal

local revealGen = 0
local effectGen = 0

-- ============================================================
-- Animation Engine (single OnUpdate drives tweens + particles)
-- ============================================================
local animFrame = CreateFrame("Frame", nil, UIParent)
animFrame:Hide()

local tweens    = {}
local particles = {}
local tweenSeq  = 0

local function Tween(dur, fn, done)
    tweenSeq = tweenSeq + 1
    tweens[tweenSeq] = { elapsed = 0, dur = dur, fn = fn, done = done }
    animFrame:Show()
end

animFrame:SetScript("OnUpdate", function(self, dt)
    for id, t in pairs(tweens) do
        t.elapsed = t.elapsed + dt
        local p = math.min(t.elapsed / t.dur, 1)
        t.fn(p)
        if p >= 1 then
            if t.done then t.done() end
            tweens[id] = nil
        end
    end

    for i = #particles, 1, -1 do
        local p = particles[i]
        p.life = p.life + dt
        if p.life >= p.maxLife then
            p.tex:SetAlpha(0)
            p.tex:Hide()
            table.remove(particles, i)
        else
            local frac = p.life / p.maxLife
            local x, y
            if p.wisp then
                x = p.ox + math.sin(p.life * 7 + p.phase) * 5
                y = p.oy + WISP_RISE * p.life
                p.tex:SetAlpha(0.55 * (1 - frac))
            else
                x = p.ox + p.vx * p.life
                y = p.oy + p.vy * p.life - 55 * p.life * p.life
                p.tex:SetAlpha(0.85 * (1 - frac * frac))
                p.tex:SetSize(p.size * (1 - frac * 0.4), p.size * (1 - frac * 0.4))
            end
            p.tex:ClearAllPoints()
            p.tex:SetPoint("CENTER", p.anchor, "CENTER", x, y)
        end
    end

    if not next(tweens) and #particles == 0 then self:Hide() end
end)

local function ClearAnimations()
    tweens = {}
    for i = #particles, 1, -1 do
        particles[i].tex:SetAlpha(0)
        particles[i].tex:Hide()
    end
    particles = {}
    animFrame:Hide()
end

-- ============================================================
-- Quality Color Helper
-- ============================================================
local function GetQualityRGB(frame)
    if frame.itemLink then
        local _, _, rarity = GetItemInfo(frame.itemLink)
        if rarity and DC.QUALITY_COLORS[rarity] then
            local c = DC.QUALITY_COLORS[rarity]
            return c[1], c[2], c[3]
        end
    end
    return 1, 0.82, 0
end

-- ============================================================
-- Sparkle + Wisp Burst
-- ============================================================
local function EnsureParticleTextures(row)
    if row._particleTex then return end
    row._particleTex = {}
    for i = 1, SPARKLE_COUNT + WISP_COUNT do
        local tex = row:CreateTexture(nil, "OVERLAY")
        tex:SetBlendMode("ADD")
        tex:SetAlpha(0)
        tex:Hide()
        row._particleTex[i] = tex
    end
end

local function BurstParticles(row, r, g, b)
    EnsureParticleTextures(row)
    local anchor = row.icon or row

    for i = 1, SPARKLE_COUNT do
        local tex = row._particleTex[i]
        tex:SetTexture("Interface\\Cooldown\\star4")
        local angle = (i / SPARKLE_COUNT) * 6.283 + math.random() * 0.8
        local spd = SPARKLE_SPEED * (0.5 + math.random())
        local sz = 7 + math.random() * 9

        tex:SetVertexColor(r, g, b)
        tex:SetSize(sz, sz)
        tex:ClearAllPoints()
        tex:SetPoint("CENTER", anchor, "CENTER")
        tex:SetAlpha(0.85)
        tex:Show()

        particles[#particles + 1] = {
            tex = tex, anchor = anchor,
            ox = 0, oy = 0,
            vx = math.cos(angle) * spd,
            vy = math.sin(angle) * spd + 25,
            life = 0,
            maxLife = SPARKLE_LIFE * (0.6 + math.random() * 0.6),
            size = sz, wisp = false,
        }
    end

    for i = 1, WISP_COUNT do
        local tex = row._particleTex[SPARKLE_COUNT + i]
        tex:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
        tex:SetVertexColor(0.4, 0.65, 1.0)
        tex:SetSize(14, 14)
        tex:ClearAllPoints()
        tex:SetPoint("CENTER", anchor, "CENTER")
        tex:SetAlpha(0.55)
        tex:Show()

        particles[#particles + 1] = {
            tex = tex, anchor = anchor,
            ox = -4 + math.random() * 8, oy = 0,
            vx = 0, vy = WISP_RISE,
            life = 0, maxLife = WISP_LIFE,
            size = 14, wisp = true,
            phase = math.random() * 6.283,
        }
    end

    animFrame:Show()
end

-- ============================================================
-- Quality Glow Pulse (icon border flashes in rarity color)
-- ============================================================
local function EnsureGlow(row)
    if row._lootGlow then return end
    local anchor = row.icon or row
    local glow = row:CreateTexture(nil, "OVERLAY")
    glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    glow:SetBlendMode("ADD")
    local sz = row.icon and (DC.ICON_SIZE + 18) or 24
    glow:SetSize(sz, sz)
    glow:SetPoint("CENTER", anchor, "CENTER")
    glow:SetAlpha(0)
    row._lootGlow = glow
end

local function FlashGlow(row, r, g, b)
    EnsureGlow(row)
    local glow = row._lootGlow
    glow:SetVertexColor(r, g, b)
    glow:SetAlpha(0.9)
    glow:Show()
    Tween(0.35, function(t) glow:SetAlpha(0.9 * (1 - t)) end)
end

-- ============================================================
-- Loot Sound
-- ============================================================
local function PlayLootSound()
    PlaySound("LOOTWINDOWCOINSOUND")
end

-- ============================================================
-- Single Item / Gold Loot
-- ============================================================
function DeathChestUI.LootWithEffect(frame, onComplete)
    if DC.state.casting then return end
    DC.state.casting = true
    effectGen = effectGen + 1
    local gen = effectGen
    DC.SetButtonsEnabled(false)

    local r, g, b = GetQualityRGB(frame)
    PlayLootSound()
    FlashGlow(frame, r, g, b)
    BurstParticles(frame, r, g, b)

    Tween(LOOT_TIME, function(t)
        if effectGen ~= gen then return end
        frame:SetAlpha(1 - t * 0.7)
    end, function()
        if effectGen ~= gen then return end
        frame:SetAlpha(0.3)
        DC.state.casting = false
        DC.SetButtonsEnabled(true)
        if onComplete then onComplete() end
    end)
end

-- ============================================================
-- Multi-Item Loot (Take All / Take Category)
-- ============================================================
function DeathChestUI.LootMultiEffect(onComplete)
    if DC.state.casting then return end
    DC.state.casting = true
    effectGen = effectGen + 1
    local gen = effectGen
    DC.SetButtonsEnabled(false)

    local rows = {}
    for _, row in ipairs(ui.itemRows) do
        if row:IsShown() and row:GetAlpha() > 0.3 then
            rows[#rows + 1] = row
        end
    end

    PlayLootSound()

    local delay = 0
    for _, row in ipairs(rows) do
        local r = row
        C_Timer.After(delay, function()
            if effectGen ~= gen then return end
            local cr, cg, cb = GetQualityRGB(r)
            FlashGlow(r, cr, cg, cb)
            BurstParticles(r, cr, cg, cb)
            Tween(LOOT_TIME, function(t)
                if effectGen ~= gen then return end
                r:SetAlpha(1 - t * 0.7)
            end)
        end)
        delay = delay + MULTI_GAP
    end

    local total = math.max(delay + LOOT_TIME + 0.1, MIN_MULTI_TIME)
    C_Timer.After(total, function()
        if effectGen ~= gen then return end
        DC.state.casting = false
        DC.SetButtonsEnabled(true)
        if onComplete then onComplete() end
    end)
end

-- ============================================================
-- Stagger Reveal (chest open — items materialize with glow)
-- ============================================================
function DeathChestUI.StaggerReveal()
    revealGen = revealGen + 1
    local gen = revealGen
    local delay = 0
    local first = true

    for _, row in ipairs(ui.itemRows) do
        if row:IsShown() then
            local r = row
            if first then
                r:SetAlpha(1)
                local cr, cg, cb = GetQualityRGB(r)
                FlashGlow(r, cr, cg, cb)
                first = false
            else
                C_Timer.After(delay, function()
                    if revealGen ~= gen then return end
                    UIAnimFadeIn(r, 0.25)
                    local cr, cg, cb = GetQualityRGB(r)
                    FlashGlow(r, cr, cg, cb)
                end)
            end
            delay = delay + REVEAL_GAP_MIN
                + math.random() * (REVEAL_GAP_MAX - REVEAL_GAP_MIN)
        end
    end
end

-- ============================================================
-- Cancel + Button Management
-- ============================================================
function DeathChestUI.CancelCastBar()
    if not DC.state.casting then return end
    DC.state.casting = false
    effectGen = effectGen + 1
    ClearAnimations()
    DC.SetButtonsEnabled(true)
end

function DeathChestUI.SetButtonsEnabled(enabled)
    if enabled then ui.takeAllBtn:Enable() else ui.takeAllBtn:Disable() end
    if ui.quickTakeBtns then
        for _, btn in ipairs(ui.quickTakeBtns) do
            if enabled then btn:Enable() else btn:Disable() end
        end
        if enabled and DC.UpdateQuickTakeButtons then
            DC.UpdateQuickTakeButtons()
        end
    end
    ui.goldFrame:EnableMouse(enabled)
end
