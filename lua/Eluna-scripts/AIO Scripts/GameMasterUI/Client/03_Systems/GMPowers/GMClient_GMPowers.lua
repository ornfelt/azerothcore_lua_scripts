-- GameMaster UI System - GM Powers Control Panel
-- This file handles GM power toggles and controls
-- Load order: Systems

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Module loading (debug message removed)

if not GM_RequireNamespace() then return end
local GameMasterSystem = _G.GameMasterSystem

-- Create GMPowers namespace
_G.GMPowers = _G.GMPowers or {}
local GMPowers = _G.GMPowers
local GMData = _G.GMData
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- GM Powers state tracking
GMPowers.state = {
    gmMode = false,
    flyMode = false,
    godMode = false,
    noCooldowns = false,
    instantCast = false,
    invisible = false,
    waterWalk = false,
    taxiCheat = false,
    speeds = {
        walk = 1.0,
        run = 1.0,
        swim = 1.0,
        fly = 1.0
    }
}

-- UI Elements storage
GMPowers.frames = {}

-- Online player names cache (for autocomplete)
GMPowers.onlinePlayerNames = {}

-- Create the GM Powers panel with scrollable content
function GMPowers.CreatePanel(parent)
    local panel = CreateFrame("Frame", nil, parent)
    panel:SetAllPoints(parent)

    -- Scrollable container filling the panel
    local pw = parent:GetWidth()
    local ph = parent:GetHeight()
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(panel, pw, ph)
    container:ClearAllPoints()
    container:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, 0)
    container:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, 0)
    -- Transparent backdrop — individual sections have their own backgrounds
    container:SetBackdropColor(0, 0, 0, 0)
    container:SetBackdropBorderColor(0, 0, 0, 0)

    -- No title — the tab dropdown already says "GM Powers"

    -- Store scroll references for GMPowersActions to use
    GMPowers.frames.scrollContent = content
    GMPowers.frames.updateScrollBar = updateScrollBar

    GMPowers.CreateToggleSection(content)
    GMPowers.CreateSpeedSection(content)
    -- Action sections appended in GMClient_GMPowersActions.lua

    GMPowers.frames.panel = panel
    panel:Show()

    return panel
end

-- Create toggle controls section (4 columns × 2 rows)
function GMPowers.CreateToggleSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 30
    section:SetSize(sectionWidth, 65)
    section:SetPoint("TOP", parent, "TOP", 0, -4)
    section:Show()

    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 10, -5)
    sectionTitle:SetText("Toggle Controls")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)

    local toggles = {
        {id = "gmMode",     text = "GM Mode",     tip = "Enable Game Master mode",       row = 0, col = 0},
        {id = "flyMode",    text = "Fly Mode",    tip = "Allow flying without a mount",   row = 0, col = 1},
        {id = "godMode",    text = "God Mode",    tip = "Become unkillable",              row = 0, col = 2},
        {id = "invisible",  text = "Invisible",   tip = "Invisible to players",           row = 0, col = 3},
        {id = "noCooldowns",text = "No CDs",      tip = "Remove spell cooldowns on cast", row = 1, col = 0},
        {id = "instantCast",text = "Instant",     tip = "Remove cast times (partial)",    row = 1, col = 1},
        {id = "waterWalk",  text = "Water Walk",  tip = "Walk on water surfaces",         row = 1, col = 2},
        {id = "taxiCheat",  text = "Taxi Cheat",  tip = "Unlock all flight paths",        row = 1, col = 3},
    }

    local cols = 4
    local gap = 6
    local pad = 10
    local buttonWidth = (sectionWidth - (pad * 2) - (gap * (cols - 1))) / cols
    local buttonHeight = 18
    local startY = -20

    for _, toggle in ipairs(toggles) do
        local btn = CreateStyledButton(section, toggle.text, buttonWidth, buttonHeight)
        btn:SetPoint("TOPLEFT", section, "TOPLEFT",
            pad + toggle.col * (buttonWidth + gap),
            startY - (toggle.row * (buttonHeight + gap)))
        btn.toggleId = toggle.id
        btn:SetTooltip(toggle.text, toggle.tip)
        GMPowers.UpdateToggleColor(btn, GMPowers.state[toggle.id])
        btn:SetScript("OnClick", function(self)
            GMPowers.TogglePower(self.toggleId)
        end)
        GMPowers.frames["toggle_" .. toggle.id] = btn
        btn:Show()
    end

    GMPowers.frames.toggleSection = section
end

-- Create speed controls section — compact inline sliders (2 columns × 2 rows)
function GMPowers.CreateSpeedSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 30
    section:SetSize(sectionWidth, 85)
    section:SetPoint("TOP", GMPowers.frames.toggleSection, "BOTTOM", 0, -4)
    section:Show()

    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 10, -5)
    sectionTitle:SetText("Speed Controls")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)

    local speedTypes = {
        {type = "walk", label = "Walk", min = 0, max = 10, default = 1, row = 0, col = 0},
        {type = "run",  label = "Run",  min = 0, max = 10, default = 1, row = 0, col = 1},
        {type = "swim", label = "Swim", min = 0, max = 10, default = 1, row = 1, col = 0},
        {type = "fly",  label = "Fly",  min = 0, max = 10, default = 1, row = 1, col = 1},
    }

    -- Layout: [Label 32px][4px][====slider====][4px][value 34px][4px][R 24px]
    local pad = 10
    local colGap = 12
    local colWidth = (sectionWidth - pad * 2 - colGap) / 2
    local labelW, valueW, resetW, gap = 32, 34, 24, 4
    local sliderW = colWidth - labelW - valueW - resetW - (gap * 3)
    local sliderH = 10
    local ySpacing = 22
    local startY = -20

    for _, si in ipairs(speedTypes) do
        local xBase = pad + si.col * (colWidth + colGap)
        local yPos = startY - (si.row * ySpacing)

        -- Label (left-aligned)
        local label = section:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("TOPLEFT", section, "TOPLEFT", xBase, yPos)
        label:SetWidth(labelW)
        label:SetJustifyH("LEFT")
        label:SetText(si.label)
        label:SetTextColor(1, 1, 1)

        -- Raw slider track (inline, no container overhead)
        local slider = CreateFrame("Slider", nil, section)
        slider:SetSize(sliderW, sliderH)
        slider:SetPoint("LEFT", label, "RIGHT", gap, 0)
        slider:SetOrientation("HORIZONTAL")
        slider:SetMinMaxValues(si.min, si.max)
        slider:SetValueStep(0.1)
        slider:SetValue(GMPowers.state.speeds[si.type])
        slider:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
        })
        slider:SetBackdropColor(
            UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
        slider:SetBackdropBorderColor(
            UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

        local thumb = slider:CreateTexture(nil, "OVERLAY")
        thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
        thumb:SetVertexColor(0.6, 0.6, 0.6, 1)
        thumb:SetSize(8, sliderH - 2)
        slider:SetThumbTexture(thumb)

        -- Value text (right of slider)
        local valueText = section:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        valueText:SetPoint("LEFT", slider, "RIGHT", gap, 0)
        valueText:SetWidth(valueW)
        valueText:SetJustifyH("RIGHT")
        valueText:SetTextColor(
            UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
        valueText:SetText(string.format("%.1fx", GMPowers.state.speeds[si.type]))

        slider:SetScript("OnValueChanged", function(self, value)
            valueText:SetText(string.format("%.1fx", value))
            GMPowers.state.speeds[si.type] = value
        end)
        slider:SetScript("OnMouseUp", function(self)
            GMPowers.UpdateSpeed(si.type, self:GetValue())
        end)
        slider:SetScript("OnEnter", function() thumb:SetVertexColor(0.8, 0.8, 0.8, 1) end)
        slider:SetScript("OnLeave", function() thumb:SetVertexColor(0.6, 0.6, 0.6, 1) end)

        -- Mousewheel fine control on slider
        slider:EnableMouseWheel(true)
        slider:SetScript("OnMouseWheel", function(self, delta)
            local cur = self:GetValue()
            local step = 0.1
            self:SetValue(cur + delta * step)
            GMPowers.UpdateSpeed(si.type, self:GetValue())
        end)

        -- Reset button
        local resetBtn = CreateStyledButton(section, "R", resetW, 14)
        resetBtn:SetPoint("LEFT", valueText, "RIGHT", gap, 0)
        resetBtn:SetTooltip("Reset", "Reset to default")
        resetBtn:SetScript("OnClick", function()
            slider:SetValue(si.default)
            GMPowers.state.speeds[si.type] = si.default
            GMPowers.UpdateSpeed(si.type, si.default)
        end)
        resetBtn:Show()

        GMPowers.frames["slider_" .. si.type] = slider
        GMPowers.frames["resetBtn_" .. si.type] = resetBtn
    end

    local resetAllBtn = CreateStyledButton(section, "Reset All", 80, 16)
    resetAllBtn:SetPoint("BOTTOM", section, "BOTTOM", 0, 4)
    resetAllBtn:SetTooltip("Reset All", "Reset all speeds to default")
    resetAllBtn:SetScript("OnClick", function()
        for _, si in ipairs(speedTypes) do
            local slider = GMPowers.frames["slider_" .. si.type]
            if slider then
                slider:SetValue(si.default)
                GMPowers.state.speeds[si.type] = si.default
                GMPowers.UpdateSpeed(si.type, si.default)
            end
        end
        GMPowers.ShowStatusMessage("All speeds reset", "success")
    end)
    resetAllBtn:Show()

    GMPowers.frames.speedSection = section
end

-- Toggle a GM power
function GMPowers.TogglePower(powerId)
    -- Toggle local state
    GMPowers.state[powerId] = not GMPowers.state[powerId]
    
    -- Update button color
    local btn = GMPowers.frames["toggle_" .. powerId]
    if btn then
        GMPowers.UpdateToggleColor(btn, GMPowers.state[powerId])
    end
    
    -- Handle special cases that use chat commands
    if powerId == "noCooldowns" then
        -- Use .cheat cooldown command
        SendChatMessage(".cheat cooldown", "SAY")
        -- Show status message with fade
        GMPowers.ShowStatusMessage(GMPowers.state[powerId] and "Cooldown cheat enabled" or "Cooldown cheat disabled", "success")
    elseif powerId == "instantCast" then
        -- Use .cheat casttime command
        SendChatMessage(".cheat casttime", "SAY")
        -- Show status message with fade
        GMPowers.ShowStatusMessage(GMPowers.state[powerId] and "Cast time cheat enabled" or "Cast time cheat disabled", "success")
    elseif powerId == "invisible" then
        -- Use .gm visible command (note: on/off is reversed for invisibility)
        if GMPowers.state[powerId] then
            SendChatMessage(".gm visible off", "SAY")  -- off = invisible
            -- Invisibility requires GM mode, so update that state too
            GMPowers.state.gmMode = true
            local gmBtn = GMPowers.frames["toggle_gmMode"]
            if gmBtn then
                GMPowers.UpdateToggleColor(gmBtn, true)
            end
        else
            SendChatMessage(".gm visible on", "SAY")   -- on = visible
        end
        -- Show status message with fade
        GMPowers.ShowStatusMessage(GMPowers.state[powerId] and "Invisibility enabled" or "Invisibility disabled", "success")
        -- Also send to server to sync state
        AIO.Handle("GameMasterSystem", "toggleGMPower", powerId, GMPowers.state[powerId])
    else
        -- For other powers, send to server as before
        AIO.Handle("GameMasterSystem", "toggleGMPower", powerId, GMPowers.state[powerId])
    end
end

-- Show status message as toast notification
function GMPowers.ShowStatusMessage(message, messageType)
    -- Use toast notification instead of status text
    CreateStyledToast(message, 3, 0.5, "TOP")
end

-- Update toggle button color
function GMPowers.UpdateToggleColor(button, isActive)
    if not button then
        print("[GMPowers] UpdateToggleColor: button is nil")
        return
    end
    
    if isActive then
        button:SetBackdropColor(0, 0.7, 0, 0.8) -- Green when active
        if button.text then
            button.text:SetTextColor(0, 1, 0)
        end
    else
        button:SetBackdropColor(0.2, 0.2, 0.2, 0.8) -- Dark grey when inactive
        if button.text then
            button.text:SetTextColor(1, 1, 1)
        end
    end
    
    -- Override the hover handlers to maintain the color
    if isActive then
        button:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0, 0.8, 0, 0.9)
        end)
        button:SetScript("OnLeave", function(self)
            self:SetBackdropColor(0, 0.7, 0, 0.8)
        end)
    else
        button:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.3, 0.3, 0.3, 0.9)
        end)
        button:SetScript("OnLeave", function(self)
            self:SetBackdropColor(0.2, 0.2, 0.2, 0.8)
        end)
    end
end

-- Update speed value
function GMPowers.UpdateSpeed(speedType, value)
    AIO.Handle("GameMasterSystem", "setGMSpeed", speedType, value)
end

-- Handle server responses
function GMPowers.HandleServerUpdate(powerId, state)
    GMPowers.state[powerId] = state
    
    -- Update UI
    local btn = GMPowers.frames["toggle_" .. powerId]
    if btn then
        GMPowers.UpdateToggleColor(btn, state)
    end
end

-- Handle speed updates from server
function GMPowers.HandleSpeedUpdate(speedType, value)
    GMPowers.state.speeds[speedType] = value
    
    -- Update slider
    local slider = GMPowers.frames["slider_" .. speedType]
    if slider then
        slider:SetValue(value)
    end
end

-- Handle status messages from server
function GMPowers.HandleStatusMessage(message, messageType)
    -- Use toast notification
    CreateStyledToast(message, 3, 0.5, "TOP")
end

-- Initialize GM Powers state from server
function GMPowers.Initialize(initialState)
    if initialState then
        GMPowers.state = initialState
        
        -- Update all UI elements
        for powerId, state in pairs(initialState) do
            if type(state) == "boolean" then
                local btn = GMPowers.frames["toggle_" .. powerId]
                if btn then
                    GMPowers.UpdateToggleColor(btn, state)
                end
            end
        end
        
        -- Update speed sliders
        if initialState.speeds then
            for speedType, value in pairs(initialState.speeds) do
                local slider = GMPowers.frames["slider_" .. speedType]
                if slider then
                    slider:SetValue(value)
                end
            end
        end
    end
end

-- Register AIO handlers
local handlers = AIO.AddHandlers("GMPowers", {})

handlers.HandleServerUpdate = function(player, powerId, state)
    GMPowers.HandleServerUpdate(powerId, state)
end

handlers.HandleSpeedUpdate = function(player, speedType, value)
    GMPowers.HandleSpeedUpdate(speedType, value)
end

handlers.HandleStatusMessage = function(player, message, messageType)
    GMPowers.HandleStatusMessage(message, messageType)
end

handlers.Initialize = function(player, initialState)
    GMPowers.Initialize(initialState)
end

handlers.ReceiveOnlinePlayerNames = function(player, names)
    GMPowers.onlinePlayerNames = names or {}
end

-- Export
_G.GMPowers = GMPowers
-- print("[GMPowers] Module loaded successfully")