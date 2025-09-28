local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus or not GMMenus.SpellSelection then
    print("[ERROR] SpellSelection module not found! Check load order.")
    return
end

local SpellSelection = GMMenus.SpellSelection
local Duration = SpellSelection.Duration

-- Create duration controls for buffWithDuration mode
function Duration.createDurationControls(parent, state)
    -- Create duration control frame
    local durationControls = CreateFrame("Frame", nil, parent)
    durationControls:SetHeight(30)
    local modal = state.spellSelectionModal
    local searchBox = modal and modal.searchBox
    durationControls:SetPoint("TOP", searchBox or parent, "BOTTOM", 0, -30)
    durationControls:SetPoint("LEFT", parent, "LEFT", 10, 0)
    durationControls:SetPoint("RIGHT", parent, "RIGHT", -10, 0)
    
    -- Duration label
    local durationLabel = durationControls:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    durationLabel:SetPoint("LEFT", durationControls, "LEFT", 0, 0)
    durationLabel:SetText("Duration:")
    
    -- Quick duration buttons
    local quickDurations = {
        {text = "1m", duration = 60000},
        {text = "10m", duration = 600000},
        {text = "1h", duration = 3600000},
        {text = "24h", duration = 86400000},
        {text = "Permanent", duration = -1},
    }
    
    -- Store buttons for later reference
    durationControls.buttons = {}
    
    local lastButton = nil
    for i, dur in ipairs(quickDurations) do
        local btn = CreateStyledButton(durationControls, dur.text, dur.text == "Permanent" and 80 or 45, 24)
        if i == 1 then
            btn:SetPoint("LEFT", durationLabel, "RIGHT", 10, 0)
        else
            btn:SetPoint("LEFT", lastButton, "RIGHT", 5, 0)
        end
        
        -- Highlight default selection
        if dur.duration == state.selectedDuration then
            btn:LockHighlight()
        end
        
        btn:SetScript("OnClick", function()
            -- Unhighlight all buttons
            for _, b in ipairs(durationControls.buttons) do
                b:UnlockHighlight()
            end
            -- Highlight this button
            btn:LockHighlight()
            state.selectedDuration = dur.duration
            
            -- Update custom input if needed
            if durationControls.customInput then
                if dur.duration == -1 then
                    durationControls.customInput:SetText("")
                    -- Disable the editbox for permanent duration
                    if durationControls.customInput.editBox then
                        durationControls.customInput.editBox:EnableMouse(false)
                        durationControls.customInput.editBox:EnableKeyboard(false)
                        durationControls.customInput.editBox:SetTextColor(0.5, 0.5, 0.5, 1)
                    end
                else
                    durationControls.customInput:SetText(tostring(dur.duration / 1000))
                    -- Enable the editbox
                    if durationControls.customInput.editBox then
                        durationControls.customInput.editBox:EnableMouse(true)
                        durationControls.customInput.editBox:EnableKeyboard(true)
                        durationControls.customInput.editBox:SetTextColor(1, 1, 1, 1)
                    end
                end
            end
        end)
        
        -- Store button reference
        table.insert(durationControls.buttons, btn)
        lastButton = btn
    end
    
    -- Custom duration input
    local customLabel = durationControls:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customLabel:SetPoint("LEFT", lastButton, "RIGHT", 15, 0)
    customLabel:SetText("Custom (sec):")
    
    local customInput = CreateStyledEditBox(durationControls, 60, true, 10, false)
    customInput:SetPoint("LEFT", customLabel, "RIGHT", 5, 0)
    customInput:SetText("60")
    
    -- Set scripts on the actual EditBox, not the container
    if customInput.editBox then
        customInput.editBox:SetScript("OnTextChanged", function(self)
            local value = tonumber(self:GetText())
            if value and value > 0 then
                state.selectedDuration = value * 1000 -- Convert to milliseconds
                -- Unhighlight all quick buttons
                for _, b in ipairs(durationControls.buttons) do
                    b:UnlockHighlight()
                end
            end
        end)
        
        customInput.editBox:SetScript("OnEnterPressed", function(self)
            local value = tonumber(self:GetText())
            if value and value > 0 then
                state.selectedDuration = value * 1000
                -- Visual feedback
                CreateStyledToast(string.format("Duration set to %d seconds", value), 1, 0.5)
                self:ClearFocus()
            end
        end)
    end
    
    durationControls.customInput = customInput
    
    return durationControls
end