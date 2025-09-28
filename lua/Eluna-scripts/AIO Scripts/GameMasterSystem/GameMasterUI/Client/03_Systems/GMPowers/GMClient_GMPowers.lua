-- GameMaster UI System - GM Powers Control Panel
-- This file handles GM power toggles and controls
-- Load order: Systems

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- print("[GMPowers] Module loading...")

-- Verify namespace exists
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

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

-- Create the GM Powers panel
function GMPowers.CreatePanel(parent)
    print("[GMPowers] Creating panel...")
    
    -- Main container frame
    local panel = CreateFrame("Frame", nil, parent)
    panel:SetAllPoints(parent)
    
    -- Title
    local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", panel, "TOP", 0, -10)
    title:SetText("GM Powers Control Panel")
    title:SetTextColor(1, 1, 1)  -- White for main title
    
    print("[GMPowers] Creating sections...")
    
    -- Create sections with consistent spacing
    GMPowers.CreateToggleSection(panel)
    GMPowers.CreateSpeedSection(panel)
    GMPowers.CreateActionSection(panel)
    
    GMPowers.frames.panel = panel
    GMPowers.frames.title = title
    panel:Show()
    
    print("[GMPowers] Panel created successfully")
    return panel
end

-- Create toggle controls section
function GMPowers.CreateToggleSection(parent)
    print("[GMPowers] Creating toggle section...")
    
    -- Section frame
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 40
    section:SetSize(sectionWidth, 120)
    section:SetPoint("TOP", parent, "TOP", 0, -40)
    section:Show()
    
    -- Section title
    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)
    sectionTitle:SetText("Toggle Controls")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)  -- Light grey for section headers
    
    -- Toggle buttons configuration
    local toggles = {
        {id = "gmMode", text = "GM Mode", row = 0, col = 0},
        {id = "flyMode", text = "Fly Mode", row = 0, col = 1},
        {id = "godMode", text = "God Mode", row = 0, col = 2},
        {id = "invisible", text = "Invisibility", row = 0, col = 3},
        {id = "noCooldowns", text = "No Cooldowns", row = 1, col = 0},
        {id = "instantCast", text = "Instant Cast", row = 1, col = 1},
        {id = "waterWalk", text = "Water Walk", row = 1, col = 2},
        {id = "taxiCheat", text = "Taxi Cheat", row = 1, col = 3}
    }
    
    -- Calculate centered button layout
    local buttonWidth = 105
    local buttonHeight = 30
    local buttonsPerRow = 4
    local xSpacing = buttonWidth + 8  -- Small gap between buttons
    local ySpacing = 35
    local totalButtonsWidth = (buttonsPerRow * buttonWidth) + ((buttonsPerRow - 1) * 8)
    local startX = (sectionWidth - totalButtonsWidth) / 2  -- Center horizontally
    local startY = -35
    
    for _, toggle in ipairs(toggles) do
        local btn = CreateStyledButton(section, toggle.text, buttonWidth, buttonHeight)
        btn:SetPoint("TOPLEFT", section, "TOPLEFT", 
            startX + (toggle.col * xSpacing), 
            startY - (toggle.row * ySpacing))
        
        -- Store toggle ID on button
        btn.toggleId = toggle.id
        
        -- Set initial color based on state
        GMPowers.UpdateToggleColor(btn, GMPowers.state[toggle.id])
        
        -- Click handler
        btn:SetScript("OnClick", function(self)
            GMPowers.TogglePower(self.toggleId)
        end)
        
        -- Store reference
        GMPowers.frames["toggle_" .. toggle.id] = btn
        btn:Show()
    end
    
    GMPowers.frames.toggleSection = section
    print("[GMPowers] Toggle section created")
end

-- Create speed controls section
function GMPowers.CreateSpeedSection(parent)
    print("[GMPowers] Creating speed section...")
    
    -- Section frame
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 40
    section:SetSize(sectionWidth, 180)  -- Increased height to accommodate Reset All button
    section:SetPoint("TOP", GMPowers.frames.toggleSection, "BOTTOM", 0, -10)
    section:Show()
    
    -- Section title
    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)
    sectionTitle:SetText("Speed Controls")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)  -- Light grey for section headers
    
    -- Speed types arranged in 2x2 grid
    local speedTypes = {
        {type = "walk", label = "Walk", min = 0, max = 10, default = 1, row = 0, col = 0},
        {type = "run", label = "Run", min = 0, max = 10, default = 1, row = 0, col = 1},
        {type = "swim", label = "Swim", min = 0, max = 10, default = 1, row = 1, col = 0},
        {type = "fly", label = "Fly", min = 0, max = 10, default = 1, row = 1, col = 1}
    }
    
    -- Calculate layout for 2x2 grid
    local sliderWidth = 180
    local sliderHeight = 20
    local resetBtnWidth = 45
    local totalItemWidth = sliderWidth + resetBtnWidth + 10  -- slider + gap + button
    local xSpacing = totalItemWidth + 20
    local ySpacing = 55
    local totalWidth = (2 * totalItemWidth) + 20  -- 2 columns + gap
    local startX = (sectionWidth - totalWidth) / 2
    local startY = -35
    
    for _, speedInfo in ipairs(speedTypes) do
        local xPos = startX + (speedInfo.col * xSpacing)
        local yPos = startY - (speedInfo.row * ySpacing)
        
        -- Create styled slider with label and value display
        local sliderContainer = CreateStyledSlider(
            section,
            sliderWidth,
            sliderHeight,
            speedInfo.min,
            speedInfo.max,
            0.1,  -- Fine control
            GMPowers.state.speeds[speedInfo.type]
        )
        
        -- Position the slider container
        sliderContainer:SetPoint("TOPLEFT", section, "TOPLEFT", xPos, yPos)
        
        -- Set the label text
        sliderContainer:SetLabel(speedInfo.label)
        
        -- Set value format to show multiplier
        sliderContainer:SetValueText("%.1fx")
        
        -- Get the actual slider component
        local slider = sliderContainer.slider
        
        -- Handle value changes (update state but don't send to server yet)
        sliderContainer:SetOnValueChanged(function(value)
            GMPowers.state.speeds[speedInfo.type] = value
        end)
        
        -- Send to server when mouse is released
        if slider then
            slider:SetScript("OnMouseUp", function(self)
                local value = self:GetValue()
                GMPowers.UpdateSpeed(speedInfo.type, value)
            end)
        end
        
        -- Individual reset button
        local resetBtn = CreateStyledButton(section, "R", resetBtnWidth, 22)
        resetBtn:SetPoint("LEFT", sliderContainer, "RIGHT", 8, 0)
        resetBtn:SetTooltip("Reset", "Reset to default speed")
        resetBtn:SetScript("OnClick", function()
            if slider then
                slider:SetValue(speedInfo.default)
                GMPowers.state.speeds[speedInfo.type] = speedInfo.default
                GMPowers.UpdateSpeed(speedInfo.type, speedInfo.default)
            end
        end)
        resetBtn:Show()
        
        -- Store references
        GMPowers.frames["slider_" .. speedInfo.type] = slider
        GMPowers.frames["sliderContainer_" .. speedInfo.type] = sliderContainer
        GMPowers.frames["resetBtn_" .. speedInfo.type] = resetBtn
    end
    
    -- Add "Reset All Speeds" button at bottom center with more spacing
    local resetAllBtn = CreateStyledButton(section, "Reset All Speeds", 120, 25)
    resetAllBtn:SetPoint("BOTTOM", section, "BOTTOM", 0, 15)  -- More space from bottom
    resetAllBtn:SetTooltip("Reset All", "Reset all speeds to default")
    resetAllBtn:SetScript("OnClick", function()
        for _, speedInfo in ipairs(speedTypes) do
            local slider = GMPowers.frames["slider_" .. speedInfo.type]
            if slider then
                slider:SetValue(speedInfo.default)
                GMPowers.state.speeds[speedInfo.type] = speedInfo.default
                GMPowers.UpdateSpeed(speedInfo.type, speedInfo.default)
            end
        end
        GMPowers.ShowStatusMessage("All speeds reset to default", "success")
    end)
    resetAllBtn:Show()
    
    GMPowers.frames.speedSection = section
    print("[GMPowers] Speed section created")
end

-- Create quick action buttons section
function GMPowers.CreateActionSection(parent)
    print("[GMPowers] Creating action section...")
    
    -- Section frame
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 40
    section:SetSize(sectionWidth, 100)  -- Adjusted for 2 rows
    section:SetPoint("TOP", GMPowers.frames.speedSection, "BOTTOM", 0, -10)
    section:Show()
    
    -- Section title
    local sectionTitle = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionTitle:SetPoint("TOPLEFT", section, "TOPLEFT", 15, -10)
    sectionTitle:SetText("Quick Actions")
    sectionTitle:SetTextColor(0.9, 0.9, 0.9)  -- Light grey for section headers
    
    -- Action buttons arranged in 2x3 grid
    local actions = {
        {id = "resetCooldowns", text = "Reset CDs", tooltip = "Reset all spell cooldowns", row = 0, col = 0},
        {id = "fullHeal", text = "Full Heal", tooltip = "Restore health and mana to full", row = 0, col = 1},
        {id = "refresh", text = "Refresh", tooltip = "Refresh GM powers state", row = 0, col = 2},
        {id = "teleportTarget", text = "Teleport", tooltip = "Teleport to target location", row = 1, col = 0},
        {id = "appear", text = "Appear", tooltip = "Appear at target player", row = 1, col = 1},
        {id = "summon", text = "Summon", tooltip = "Summon target player", row = 1, col = 2}
    }
    
    -- Calculate centered layout
    local buttonWidth = 95
    local buttonHeight = 25
    local buttonsPerRow = 3
    local xSpacing = buttonWidth + 10
    local ySpacing = 30
    local totalButtonsWidth = (buttonsPerRow * buttonWidth) + ((buttonsPerRow - 1) * 10)
    local startX = (sectionWidth - totalButtonsWidth) / 2
    local startY = -35
    
    for _, action in ipairs(actions) do
        local btn = CreateStyledButton(section, action.text, buttonWidth, buttonHeight)
        btn:SetPoint("TOPLEFT", section, "TOPLEFT", 
            startX + (action.col * xSpacing), 
            startY - (action.row * ySpacing))
        
        -- Set tooltip
        btn:SetTooltip(action.text, action.tooltip)
        
        -- Click handler
        btn:SetScript("OnClick", function()
            GMPowers.ExecuteAction(action.id)
        end)
        
        -- Store reference
        GMPowers.frames["action_" .. action.id] = btn
        btn:Show()
    end
    
    -- Add status text at bottom center
    local statusText = section:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("BOTTOM", section, "BOTTOM", 0, 5)
    statusText:SetText("")
    statusText:SetTextColor(0.7, 0.7, 0.7)
    GMPowers.frames.statusText = statusText
    
    GMPowers.frames.actionSection = section
    print("[GMPowers] Action section created")
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
        else
            SendChatMessage(".gm visible on", "SAY")   -- on = visible
        end
        -- Show status message with fade
        GMPowers.ShowStatusMessage(GMPowers.state[powerId] and "Invisibility enabled" or "Invisibility disabled", "success")
    else
        -- For other powers, send to server as before
        AIO.Handle("GameMasterSystem", "toggleGMPower", powerId, GMPowers.state[powerId])
    end
end

-- Show status message with auto-fade
function GMPowers.ShowStatusMessage(message, messageType)
    if GMPowers.frames.statusText then
        GMPowers.frames.statusText:SetText(message)
        
        -- Set color based on type
        if messageType == "success" then
            GMPowers.frames.statusText:SetTextColor(0, 1, 0)
        elseif messageType == "error" then
            GMPowers.frames.statusText:SetTextColor(1, 0, 0)
        else
            GMPowers.frames.statusText:SetTextColor(0.7, 0.7, 0.7)
        end
        
        -- Auto-clear after 3 seconds using OnUpdate
        if GMPowers.statusFadeFrame then
            GMPowers.statusFadeFrame:SetScript("OnUpdate", nil)
        end
        
        GMPowers.statusFadeFrame = GMPowers.statusFadeFrame or CreateFrame("Frame")
        local elapsed = 0
        GMPowers.statusFadeFrame:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 3 then
                if GMPowers.frames.statusText then
                    GMPowers.frames.statusText:SetText("")
                end
                self:SetScript("OnUpdate", nil)
            end
        end)
    end
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

-- Execute quick action
function GMPowers.ExecuteAction(actionId)
    AIO.Handle("GameMasterSystem", "executeGMAction", actionId)
    
    -- Show status
    if GMPowers.frames.statusText then
        GMPowers.frames.statusText:SetText("Executed: " .. actionId)
        GMPowers.frames.statusText:SetTextColor(0, 1, 0)
        
        -- Fade out after 2 seconds using OnUpdate
        local elapsed = 0
        local fadeFrame = CreateFrame("Frame")
        fadeFrame:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 2 then
                if GMPowers.frames.statusText then
                    GMPowers.frames.statusText:SetText("")
                end
                self:SetScript("OnUpdate", nil)
            end
        end)
    end
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
    if GMPowers.frames.statusText then
        GMPowers.frames.statusText:SetText(message)
        
        -- Set color based on type
        if messageType == "success" then
            GMPowers.frames.statusText:SetTextColor(0, 1, 0)
        elseif messageType == "error" then
            GMPowers.frames.statusText:SetTextColor(1, 0, 0)
        else
            GMPowers.frames.statusText:SetTextColor(0.7, 0.7, 0.7)
        end
        
        -- Auto-clear after 3 seconds using OnUpdate
        local elapsed = 0
        local fadeFrame = CreateFrame("Frame")
        fadeFrame:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 3 then
                if GMPowers.frames.statusText then
                    GMPowers.frames.statusText:SetText("")
                end
                self:SetScript("OnUpdate", nil)
            end
        end)
    end
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

-- Export
_G.GMPowers = GMPowers
-- print("[GMPowers] Module loaded successfully")