-- GameMaster UI System - Shortcut Bar
-- Compact vertical strip of toggle buttons beside the side tab
-- Provides quick access to GM powers without opening the main panel

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- Namespace
_G.GMShortcutBar = {}
local GMShortcutBar = _G.GMShortcutBar
local GMData = _G.GMData
local GMSettings = _G.GMSettings

-- Power definitions: order matches the main GMPowers toggle grid
local POWER_DEFS = {
    { id = "gmMode",      label = "GM",  tip = "Toggle GM Mode" },
    { id = "flyMode",     label = "Fly", tip = "Toggle Fly Mode" },
    { id = "godMode",     label = "God", tip = "Toggle God Mode" },
    { id = "invisible",   label = "Inv", tip = "Toggle Invisibility" },
    { id = "noCooldowns", label = "CD",  tip = "Toggle No Cooldowns" },
    { id = "instantCast", label = "Ins", tip = "Toggle Instant Cast" },
    { id = "waterWalk",   label = "WW",  tip = "Toggle Water Walk" },
    { id = "taxiCheat",   label = "Tx",  tip = "Toggle Taxi Cheat" },
}

-- Tool definitions: action buttons (not toggles) with WoW icon textures
local TOOL_DEFS = {
    { id = "editNearby",
      icon = "Interface\\Icons\\INV_Misc_Wrench_01",
      tip = "|cFFFFFFFFEdit Nearby Entities|r",
      desc = "Open the entity selection dialog\n"
          .. "to move, edit, or inspect nearby\n"
          .. "creatures and game objects.",
      action = function()
          if not _G.EntitySelectionDialog then
              print("[ERROR] EntitySelectionDialog not loaded!")
              return
          end
          local SM = _G.GMStateMachine
          if SM then
              if not SM.canOpenModal() then
                  print("[EntitySelectionDialog] Cannot open - system busy")
                  return
              end
              if not SM.openEntitySelection("nearby", nil) then
                  _G.EntitySelectionDialog.Open()
              end
          else
              _G.EntitySelectionDialog.Open()
          end
      end
    },
}

local BTN_SIZE = 22
local BTN_GAP = 2
local TAB_WIDTH = 16  -- matches side tab width
local SEPARATOR_H = 6
local TOOL_BTN_SIZE = 24  -- slightly larger for icon clarity
local TOOL_BORDER = 1     -- border thickness around icon

-- Stored references
GMShortcutBar.buttons = {}
GMShortcutBar.toolButtons = {}
GMShortcutBar.container = nil
GMShortcutBar.cogButton = nil
GMShortcutBar.hooksInstalled = false

----------------------------------------------------------------
-- Button color helpers (inverted black/white scheme)
----------------------------------------------------------------
local function onButtonEnter(self)
    if self.isActive then
        self.bg:SetVertexColor(0.85, 0.85, 0.85, 1)
        self.label:SetTextColor(0, 0, 0, 1)
    else
        self.bg:SetVertexColor(0.15, 0.15, 0.15, 1)
        self.label:SetTextColor(1, 1, 1, 1)
    end
end

local function onButtonLeave(self)
    if self.isActive then
        self.bg:SetVertexColor(1, 1, 1, 0.9)
        self.label:SetTextColor(0, 0, 0, 1)
    else
        self.bg:SetVertexColor(0, 0, 0, 0.9)
        self.label:SetTextColor(1, 1, 1, 0.8)
    end
end

local function setButtonActive(btn, active)
    if not btn or not btn.bg or not btn.label then return end
    btn.isActive = active
    if active then
        btn.bg:SetVertexColor(1, 1, 1, 0.9)
        btn.label:SetTextColor(0, 0, 0, 1)
    else
        btn.bg:SetVertexColor(0, 0, 0, 0.9)
        btn.label:SetTextColor(1, 1, 1, 0.8)
    end
end

----------------------------------------------------------------
-- Tool button hover helpers (icon-based with border highlight)
----------------------------------------------------------------
local function onToolEnter(self)
    self.border:SetVertexColor(0.45, 0.65, 1.0, 0.9)
    self.icon:SetVertexColor(1, 1, 1, 1)
end

local function onToolLeave(self)
    self.border:SetVertexColor(0.25, 0.28, 0.35, 0.7)
    self.icon:SetVertexColor(0.85, 0.85, 0.85, 0.9)
end

----------------------------------------------------------------
-- Public API
----------------------------------------------------------------

function GMShortcutBar.UpdateButtonState(powerId)
    local GMPowers = _G.GMPowers
    local btn = GMShortcutBar.buttons[powerId]
    if not btn or not GMPowers then return end
    setButtonActive(btn, GMPowers.state[powerId])
end

function GMShortcutBar.SyncAllStates()
    for _, def in ipairs(POWER_DEFS) do
        GMShortcutBar.UpdateButtonState(def.id)
    end
end

function GMShortcutBar.Toggle()
    local container = GMShortcutBar.container
    if not container then return end
    local visible = not container:IsShown()
    if visible then container:Show() else container:Hide() end
    GMSettings.Set("shortcutBarVisible", visible)
end

----------------------------------------------------------------
-- Hooks on GMPowers (installed once)
----------------------------------------------------------------
local function installHooks()
    if GMShortcutBar.hooksInstalled then return end
    local GMPowers = _G.GMPowers
    if not GMPowers then return end
    GMShortcutBar.hooksInstalled = true

    -- Wrap HandleServerUpdate
    local origServerUpdate = GMPowers.HandleServerUpdate
    GMPowers.HandleServerUpdate = function(powerId, state)
        origServerUpdate(powerId, state)
        GMShortcutBar.UpdateButtonState(powerId)
    end

    -- Wrap Initialize
    local origInit = GMPowers.Initialize
    GMPowers.Initialize = function(initialState)
        origInit(initialState)
        GMShortcutBar.SyncAllStates()
    end

    -- Wrap TogglePower (updates shortcut bar after main panel toggle)
    local origToggle = GMPowers.TogglePower
    GMPowers.TogglePower = function(powerId)
        origToggle(powerId)
        GMShortcutBar.SyncAllStates()
    end
end

----------------------------------------------------------------
-- Creation
----------------------------------------------------------------
function GMShortcutBar.Create()
    if GMShortcutBar.container then return end  -- already created
    local sideTab = GMData.frames.sideTab
    if not sideTab then return end

    -- Container for power buttons + separator + tool buttons
    local container = CreateFrame("Frame", "GMShortcutBarContainer", sideTab)
    local powerH = #POWER_DEFS * (BTN_SIZE + BTN_GAP) - BTN_GAP
    local toolH = #TOOL_DEFS * (TOOL_BTN_SIZE + BTN_GAP) - BTN_GAP
    local containerW = math.max(BTN_SIZE, TOOL_BTN_SIZE)
    local totalH = powerH + SEPARATOR_H + toolH
    container:SetSize(containerW, totalH)
    container:SetFrameStrata("HIGH")
    container:Hide() -- hidden by default until toggled
    GMShortcutBar.container = container

    -- Create power buttons (raw frames matching side tab style)
    for i, def in ipairs(POWER_DEFS) do
        local btn = CreateFrame("Button", nil, container)
        btn:SetSize(BTN_SIZE, BTN_SIZE)
        btn:SetPoint("TOP", container, "TOP", 0, -((i - 1) * (BTN_SIZE + BTN_GAP)))

        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\WHITE8X8")
        btn.bg = bg

        local label = btn:CreateFontString(nil, "OVERLAY")
        label:SetFont("Fonts\\FRIZQT__.TTF", 8)
        label:SetPoint("CENTER", btn, "CENTER", 0, 0)
        label:SetText(def.label)
        btn.label = label

        btn.powerId = def.id
        btn:SetScript("OnEnter", onButtonEnter)
        btn:SetScript("OnLeave", onButtonLeave)
        setButtonActive(btn, false)
        btn:SetScript("OnClick", function(self)
            local GMPowers = _G.GMPowers
            if GMPowers and GMPowers.TogglePower then
                GMPowers.TogglePower(self.powerId)
            end
        end)
        btn:Show()
        GMShortcutBar.buttons[def.id] = btn
    end

    -- Separator between power toggles and tool actions
    local sepY = -(powerH + 2)
    local sep = container:CreateTexture(nil, "ARTWORK")
    sep:SetSize(containerW - 2, 1)
    sep:SetPoint("TOP", container, "TOP", 0, sepY)
    sep:SetTexture("Interface\\Buttons\\WHITE8X8")
    sep:SetVertexColor(0.35, 0.40, 0.55, 0.5)

    -- Create icon-based tool buttons
    local toolStartY = -(powerH + SEPARATOR_H)
    for i, def in ipairs(TOOL_DEFS) do
        local tbtn = CreateFrame("Button", nil, container)
        tbtn:SetSize(TOOL_BTN_SIZE, TOOL_BTN_SIZE)
        tbtn:SetPoint("TOP", container, "TOP", 0,
            toolStartY - ((i - 1) * (TOOL_BTN_SIZE + BTN_GAP)))

        -- Dark background
        local bg = tbtn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\WHITE8X8")
        bg:SetVertexColor(0.06, 0.07, 0.10, 0.95)
        tbtn.bg = bg

        -- Border (1px inset frame via 4 edge textures)
        local border = tbtn:CreateTexture(nil, "BORDER")
        border:SetPoint("TOPLEFT", TOOL_BORDER, -TOOL_BORDER)
        border:SetPoint("BOTTOMRIGHT", -TOOL_BORDER, TOOL_BORDER)
        border:SetTexture("Interface\\Buttons\\WHITE8X8")
        border:SetVertexColor(0.25, 0.28, 0.35, 0.7)
        tbtn.border = border

        -- WoW icon texture (cropped to remove default icon frame)
        local icon = tbtn:CreateTexture(nil, "ARTWORK")
        icon:SetSize(TOOL_BTN_SIZE - 4, TOOL_BTN_SIZE - 4)
        icon:SetPoint("CENTER")
        icon:SetTexture(def.icon)
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        icon:SetVertexColor(0.85, 0.85, 0.85, 0.9)
        tbtn.icon = icon

        tbtn:SetScript("OnEnter", function(self)
            onToolEnter(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(def.tip)
            if def.desc then
                GameTooltip:AddLine(def.desc, 0.7, 0.7, 0.7, true)
            end
            GameTooltip:Show()
        end)
        tbtn:SetScript("OnLeave", function(self)
            onToolLeave(self)
            GameTooltip:Hide()
        end)
        tbtn:SetScript("OnClick", function()
            def.action()
        end)
        tbtn:Show()
        GMShortcutBar.toolButtons[def.id] = tbtn
    end

    -- Cog toggle button — matches side tab style (black bg, white text)
    local cogBtn = CreateFrame("Button", nil, sideTab)
    cogBtn:SetSize(TAB_WIDTH, TAB_WIDTH)
    cogBtn:SetFrameStrata("HIGH")

    local cogBg = cogBtn:CreateTexture(nil, "BACKGROUND")
    cogBg:SetAllPoints()
    cogBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    cogBg:SetVertexColor(0, 0, 0, 0.9)
    cogBtn.bg = cogBg

    local cogText = cogBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    cogText:SetPoint("CENTER", cogBtn, "CENTER", 0, 0)
    cogText:SetText("*")
    cogText:SetTextColor(1, 1, 1, 0.8)

    cogBtn:SetScript("OnEnter", function(self)
        self.bg:SetVertexColor(0.15, 0.15, 0.15, 1)
    end)
    cogBtn:SetScript("OnLeave", function(self)
        self.bg:SetVertexColor(0, 0, 0, 0.9)
    end)
    cogBtn:SetScript("OnClick", function()
        GMShortcutBar.Toggle()
    end)
    cogBtn:Show()
    GMShortcutBar.cogButton = cogBtn

    -- Install hooks on GMPowers
    installHooks()

    -- Restore persisted visibility
    if GMSettings and GMSettings.current.shortcutBarVisible then
        container:Show()
    end

    -- Initial position and state sync
    GMShortcutBar.Reposition()
    GMShortcutBar.SyncAllStates()
end

----------------------------------------------------------------
-- Positioning — anchors bar + cog relative to the side tab
----------------------------------------------------------------
function GMShortcutBar.Reposition()
    local sideTab = GMData.frames.sideTab
    local container = GMShortcutBar.container
    local cogBtn = GMShortcutBar.cogButton
    if not sideTab or not cogBtn then return end

    local pos = GMSettings and GMSettings.current
        and GMSettings.current.position or "RIGHT"

    -- Anchor cog button below the side tab
    cogBtn:ClearAllPoints()
    cogBtn:SetPoint("TOP", sideTab, "BOTTOM", 0, -BTN_GAP)

    -- Anchor container next to the side tab (opposite side from screen edge)
    if container then
        container:ClearAllPoints()
        if pos == "LEFT" then
            container:SetPoint("TOPLEFT", sideTab, "TOPRIGHT", BTN_GAP, 0)
        else
            container:SetPoint("TOPRIGHT", sideTab, "TOPLEFT", -BTN_GAP, 0)
        end
    end
end
