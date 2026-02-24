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
SpellSelection.AuraOptions = SpellSelection.AuraOptions or {}
local AuraOptions = SpellSelection.AuraOptions

-- Constants
local DURATION_PRESETS = {
    {text = "1m", seconds = 60, ms = 60000},
    {text = "10m", seconds = 600, ms = 600000},
    {text = "30m", seconds = 1800, ms = 1800000},
    {text = "1h", seconds = 3600, ms = 3600000},
    {text = "6h", seconds = 21600, ms = 21600000},
    {text = "24h", seconds = 86400, ms = 86400000},
    {text = "Permanent", seconds = -1, ms = -1},
}

-- Show comprehensive aura options dialog
function AuraOptions.showAuraOptionsDialog(spellData)
    local state = SpellSelection.state
    local targetPlayerName = state.targetPlayerNameForSpell

    -- Create dialog
    local dialog = CreateStyledDialog({
        title = "Apply Aura - Advanced Options",
        width = 500,
        height = 520,
        closeOnEscape = true,
        buttons = {}, -- Disable default buttons
    })

    -- Make dialog movable by dragging anywhere on it
    dialog:SetMovable(true)
    dialog:EnableMouse(true)
    dialog:RegisterForDrag("LeftButton")
    dialog:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    dialog:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- Disable click-outside-to-close behavior
    local overlay = dialog:GetParent()
    if overlay then
        overlay:SetScript("OnMouseDown", nil)
    end

    -- Content frame
    local content = CreateFrame("Frame", nil, dialog)
    content:SetPoint("TOPLEFT", dialog, "TOPLEFT", 20, -50)
    content:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -20, 70)

    -- Store selected values
    local auraConfig = {
        duration = 60000, -- Default 1 minute in milliseconds
        stacks = 1,
        target = targetPlayerName,
    }

    -- === SPELL INFO SECTION ===
    local yOffset = -10

    local spellName = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    spellName:SetPoint("TOP", content, "TOP", 0, yOffset)
    spellName:SetText(spellData.name or "Unknown Spell")
    spellName:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    local spellId = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    spellId:SetPoint("TOP", content, "TOP", 0, yOffset)
    spellId:SetText("Spell ID: " .. (spellData.spellId or 0))
    spellId:SetTextColor(0.7, 0.7, 0.7)
    yOffset = yOffset - 30

    -- Separator
    local sep1 = content:CreateTexture(nil, "ARTWORK")
    sep1:SetPoint("TOP", content, "TOP", 0, yOffset)
    sep1:SetSize(460, 1)
    sep1:SetTexture(0.3, 0.3, 0.3, 0.8)
    yOffset = yOffset - 15

    -- === DURATION SECTION ===
    local durationLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    durationLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    durationLabel:SetText("Duration")
    durationLabel:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    -- Duration preset buttons (2 rows for better spacing)
    local presetContainer = CreateFrame("Frame", nil, content)
    presetContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    presetContainer:SetSize(460, 60)

    local durationButtons = {}
    local btnWidth = 68
    local btnSpacing = 6
    local rowSpacing = 6

    for i, preset in ipairs(DURATION_PRESETS) do
        local row = (i <= 4) and 0 or 1
        local col = (i <= 4) and (i - 1) or (i - 5)

        -- Make "Permanent" button wider
        local width = (preset.text == "Permanent") and 95 or btnWidth
        local btn = CreateStyledButton(presetContainer, preset.text, width, 26)
        btn:SetPoint("TOPLEFT", presetContainer, "TOPLEFT",
            col * (btnWidth + btnSpacing),
            -row * (26 + rowSpacing))

        -- Store original text for toggling
        btn.originalText = preset.text
        btn.isSelected = false

        -- Highlight first button by default
        if i == 1 then
            btn:LockHighlight()
            btn.isSelected = true
            if btn.text then
                btn.text:SetText("[X] " .. preset.text)
                btn.text:SetTextColor(0.5, 1, 0.5)
            end
        end

        btn:SetScript("OnClick", function()
            -- Update config
            auraConfig.duration = preset.ms

            -- Visual feedback - update all buttons
            for _, b in ipairs(durationButtons) do
                b:UnlockHighlight()
                b.isSelected = false
                if b.text then
                    b.text:SetText(b.originalText)
                    b.text:SetTextColor(1, 1, 1)
                end
            end

            -- Mark this button as selected
            btn:LockHighlight()
            btn.isSelected = true
            if btn.text then
                btn.text:SetText("[X] " .. preset.text)
                btn.text:SetTextColor(0.5, 1, 0.5)
            end

            -- Update custom input (if it exists)
            if customDurationInput and customDurationInput.editBox then
                if preset.seconds > 0 then
                    customDurationInput.editBox:SetText(tostring(preset.seconds))
                    customDurationInput.editBox:SetTextColor(1, 1, 1)
                else
                    customDurationInput.editBox:SetText("Permanent")
                    customDurationInput.editBox:SetTextColor(0.5, 1, 0.5)
                end
            end
        end)

        table.insert(durationButtons, btn)
    end

    yOffset = yOffset - 70

    -- Custom duration input
    local customLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    customLabel:SetText("Custom Duration (seconds):")
    customLabel:SetTextColor(1, 1, 1)

    local customDurationInput = CreateStyledEditBox(content, 100, true, 10, false)
    customDurationInput:SetPoint("LEFT", customLabel, "RIGHT", 10, 0)
    customDurationInput:SetText("60")

    customDurationInput.editBox:SetScript("OnTextChanged", function(self)
        local value = tonumber(self:GetText())
        if value and value > 0 then
            auraConfig.duration = value * 1000
            -- Unhighlight all presets when custom value entered
            for _, btn in ipairs(durationButtons) do
                btn:UnlockHighlight()
                btn.isSelected = false
                if btn.text then
                    btn.text:SetText(btn.originalText)
                    btn.text:SetTextColor(1, 1, 1)
                end
            end
        end
    end)

    yOffset = yOffset - 35

    -- Separator
    local sep2 = content:CreateTexture(nil, "ARTWORK")
    sep2:SetPoint("TOP", content, "TOP", 0, yOffset)
    sep2:SetSize(460, 1)
    sep2:SetTexture(0.3, 0.3, 0.3, 0.8)
    yOffset = yOffset - 15

    -- === STACK COUNT SECTION ===
    local stackLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    stackLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    stackLabel:SetText("Stack Count")
    stackLabel:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    local stackInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    stackInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    stackInfo:SetText("Set the number of stacks for this aura (1-255)")
    stackInfo:SetTextColor(0.7, 0.7, 0.7)
    yOffset = yOffset - 25

    -- Stack count slider (styled)
    local stackSlider = CreateStyledSlider(content, 340, 16, 1, 255, 1, 1)
    stackSlider:SetPoint("TOPLEFT", content, "TOPLEFT", 10, yOffset)
    stackSlider:SetLabel("Stacks")

    -- Stack count input (for precise control)
    local stackInput = CreateStyledEditBox(content, 60, true, 3, false)
    stackInput:SetPoint("LEFT", stackSlider, "RIGHT", 15, 5)
    stackInput:SetText("1")

    -- Link slider and input
    stackSlider:SetOnValueChanged(function(value)
        value = math.floor(value)
        auraConfig.stacks = value
        stackInput.editBox:SetText(tostring(value))
    end)

    stackInput.editBox:SetScript("OnTextChanged", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 1 and value <= 255 then
            auraConfig.stacks = math.floor(value)
            stackSlider:SetValue(value)
        end
    end)

    stackInput.editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)

    yOffset = yOffset - 55

    -- Quick stack presets
    local stackPresets = {
        {text = "1", value = 1},
        {text = "5", value = 5},
        {text = "10", value = 10},
        {text = "25", value = 25},
        {text = "50", value = 50},
        {text = "Max", value = 255},
    }

    local stackPresetLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    stackPresetLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    stackPresetLabel:SetText("Quick Select:")
    stackPresetLabel:SetTextColor(1, 1, 1)

    local lastStackBtn = nil
    for i, preset in ipairs(stackPresets) do
        local btn = CreateStyledButton(content, preset.text, 45, 24)
        if i == 1 then
            btn:SetPoint("LEFT", stackPresetLabel, "RIGHT", 10, 0)
        else
            btn:SetPoint("LEFT", lastStackBtn, "RIGHT", 6, 0)
        end

        btn:SetScript("OnClick", function()
            stackSlider:SetValue(preset.value)
        end)

        lastStackBtn = btn
    end

    yOffset = yOffset - 35

    -- Separator
    local sep3 = content:CreateTexture(nil, "ARTWORK")
    sep3:SetPoint("TOP", content, "TOP", 0, yOffset)
    sep3:SetSize(460, 1)
    sep3:SetTexture(0.3, 0.3, 0.3, 0.8)
    yOffset = yOffset - 15

    -- === TARGET SECTION ===
    local targetLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    targetLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    targetLabel:SetText("Target")
    targetLabel:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    local targetInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    targetInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    targetInfo:SetText("Applying to: " .. (targetPlayerName or "Unknown"))
    targetInfo:SetTextColor(0.5, 1, 0.5)

    -- === ACTION BUTTONS ===
    local applyBtn = CreateStyledButton(dialog, "Apply Aura", 120, 32)
    applyBtn:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -20, 20)
    applyBtn:SetScript("OnClick", function()
        -- Send to server with all options
        AIO.Handle("GameMasterSystem", "playerApplyAuraWithOptions",
            auraConfig.target,
            spellData.spellId,
            auraConfig.duration,
            auraConfig.stacks
        )

        -- Build feedback message
        local durationText = auraConfig.duration > 0 and
            string.format("%.0f sec", auraConfig.duration / 1000) or "permanent"
        local stackText = auraConfig.stacks > 1 and
            string.format(", %d stacks", auraConfig.stacks) or ""

        CreateStyledToast(
            string.format("Applied %s to %s (%s%s)",
                spellData.name,
                targetPlayerName,
                durationText,
                stackText
            ),
            2,
            0.5
        )

        dialog:Hide()
    end)

    local cancelBtn = CreateStyledButton(dialog, "Cancel", 100, 32)
    cancelBtn:SetPoint("RIGHT", applyBtn, "LEFT", -10, 0)
    cancelBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)

    dialog:Show()
end

-- Show aura options dialog for entity menu (self/target mode)
function AuraOptions.showEntityAuraOptionsDialog(spellId, spellName)
    -- Create dialog
    local dialog = CreateStyledDialog({
        title = "Apply Aura - Advanced Options",
        width = 500,
        height = 550,
        closeOnEscape = true,
        buttons = {}, -- Disable default buttons
    })

    -- Make dialog movable by dragging the title bar
    dialog:SetMovable(true)
    dialog:EnableMouse(true)
    dialog:RegisterForDrag("LeftButton")
    dialog:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    dialog:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- Disable click-outside-to-close behavior
    local overlay = dialog:GetParent()
    if overlay then
        overlay:SetScript("OnMouseDown", nil)
    end

    -- Content frame
    local content = CreateFrame("Frame", nil, dialog)
    content:SetPoint("TOPLEFT", dialog, "TOPLEFT", 20, -50)
    content:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -20, 70)

    -- Store selected values
    local auraConfig = {
        duration = 60000, -- Default 1 minute in milliseconds
        stacks = 1,
        targetMode = "self", -- "self" or "target"
    }

    -- === SPELL INFO SECTION ===
    local yOffset = -10

    local spellNameText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    spellNameText:SetPoint("TOP", content, "TOP", 0, yOffset)
    spellNameText:SetText(spellName or "Unknown Spell")
    spellNameText:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    local spellIdText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    spellIdText:SetPoint("TOP", content, "TOP", 0, yOffset)
    spellIdText:SetText("Spell ID: " .. (spellId or 0))
    spellIdText:SetTextColor(0.7, 0.7, 0.7)
    yOffset = yOffset - 30

    -- Separator
    local sep1 = content:CreateTexture(nil, "ARTWORK")
    sep1:SetPoint("TOP", content, "TOP", 0, yOffset)
    sep1:SetSize(460, 1)
    sep1:SetTexture(0.3, 0.3, 0.3, 0.8)
    yOffset = yOffset - 15

    -- === DURATION SECTION ===
    local durationLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    durationLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    durationLabel:SetText("Duration")
    durationLabel:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    -- Duration preset buttons (2 rows for better spacing)
    local presetContainer = CreateFrame("Frame", nil, content)
    presetContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    presetContainer:SetSize(460, 60)

    local durationButtons = {}
    local btnWidth = 68
    local btnSpacing = 6
    local rowSpacing = 6

    for i, preset in ipairs(DURATION_PRESETS) do
        local row = (i <= 4) and 0 or 1
        local col = (i <= 4) and (i - 1) or (i - 5)

        -- Make "Permanent" button wider
        local width = (preset.text == "Permanent") and 95 or btnWidth
        local btn = CreateStyledButton(presetContainer, preset.text, width, 26)
        btn:SetPoint("TOPLEFT", presetContainer, "TOPLEFT",
            col * (btnWidth + btnSpacing),
            -row * (26 + rowSpacing))

        -- Store original text for toggling
        btn.originalText = preset.text
        btn.isSelected = false

        -- Highlight first button by default
        if i == 1 then
            btn:LockHighlight()
            btn.isSelected = true
            if btn.text then
                btn.text:SetText("[X] " .. preset.text)
                btn.text:SetTextColor(0.5, 1, 0.5)
            end
        end

        btn:SetScript("OnClick", function()
            auraConfig.duration = preset.ms

            -- Visual feedback - update all buttons
            for _, b in ipairs(durationButtons) do
                b:UnlockHighlight()
                b.isSelected = false
                if b.text then
                    b.text:SetText(b.originalText)
                    b.text:SetTextColor(1, 1, 1)
                end
            end

            -- Mark this button as selected
            btn:LockHighlight()
            btn.isSelected = true
            if btn.text then
                btn.text:SetText("[X] " .. preset.text)
                btn.text:SetTextColor(0.5, 1, 0.5)
            end

            -- Update custom input (if it exists)
            if customDurationInput and customDurationInput.editBox then
                if preset.seconds > 0 then
                    customDurationInput.editBox:SetText(tostring(preset.seconds))
                    customDurationInput.editBox:SetTextColor(1, 1, 1)
                else
                    customDurationInput.editBox:SetText("Permanent")
                    customDurationInput.editBox:SetTextColor(0.5, 1, 0.5)
                end
            end
        end)

        table.insert(durationButtons, btn)
    end

    yOffset = yOffset - 70

    -- Custom duration input
    local customLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    customLabel:SetText("Custom Duration (seconds):")
    customLabel:SetTextColor(1, 1, 1)

    local customDurationInput = CreateStyledEditBox(content, 100, true, 10, false)
    customDurationInput:SetPoint("LEFT", customLabel, "RIGHT", 10, 0)
    customDurationInput:SetText("60")

    customDurationInput.editBox:SetScript("OnTextChanged", function(self)
        local value = tonumber(self:GetText())
        if value and value > 0 then
            auraConfig.duration = value * 1000
            -- Unhighlight all presets when custom value entered
            for _, btn in ipairs(durationButtons) do
                btn:UnlockHighlight()
                btn.isSelected = false
                if btn.text then
                    btn.text:SetText(btn.originalText)
                    btn.text:SetTextColor(1, 1, 1)
                end
            end
        end
    end)

    yOffset = yOffset - 35

    -- Separator
    local sep2 = content:CreateTexture(nil, "ARTWORK")
    sep2:SetPoint("TOP", content, "TOP", 0, yOffset)
    sep2:SetSize(460, 1)
    sep2:SetTexture(0.3, 0.3, 0.3, 0.8)
    yOffset = yOffset - 15

    -- === STACK COUNT SECTION ===
    local stackLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    stackLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    stackLabel:SetText("Stack Count")
    stackLabel:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    local stackInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    stackInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    stackInfo:SetText("Set the number of stacks for this aura (1-255)")
    stackInfo:SetTextColor(0.7, 0.7, 0.7)
    yOffset = yOffset - 25

    -- Stack count slider (styled)
    local stackSlider = CreateStyledSlider(content, 340, 16, 1, 255, 1, 1)
    stackSlider:SetPoint("TOPLEFT", content, "TOPLEFT", 10, yOffset)
    stackSlider:SetLabel("Stacks")

    -- Stack count input (for precise control)
    local stackInput = CreateStyledEditBox(content, 60, true, 3, false)
    stackInput:SetPoint("LEFT", stackSlider, "RIGHT", 15, 5)
    stackInput:SetText("1")

    -- Link slider and input
    stackSlider:SetOnValueChanged(function(value)
        value = math.floor(value)
        auraConfig.stacks = value
        stackInput.editBox:SetText(tostring(value))
    end)

    stackInput.editBox:SetScript("OnTextChanged", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 1 and value <= 255 then
            auraConfig.stacks = math.floor(value)
            stackSlider:SetValue(value)
        end
    end)

    stackInput.editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)

    yOffset = yOffset - 55

    -- Quick stack presets
    local stackPresets = {
        {text = "1", value = 1},
        {text = "5", value = 5},
        {text = "10", value = 10},
        {text = "25", value = 25},
        {text = "50", value = 50},
        {text = "Max", value = 255},
    }

    local stackPresetLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    stackPresetLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    stackPresetLabel:SetText("Quick Select:")
    stackPresetLabel:SetTextColor(1, 1, 1)

    local lastStackBtn = nil
    for i, preset in ipairs(stackPresets) do
        local btn = CreateStyledButton(content, preset.text, 45, 24)
        if i == 1 then
            btn:SetPoint("LEFT", stackPresetLabel, "RIGHT", 10, 0)
        else
            btn:SetPoint("LEFT", lastStackBtn, "RIGHT", 6, 0)
        end

        btn:SetScript("OnClick", function()
            stackSlider:SetValue(preset.value)
        end)

        lastStackBtn = btn
    end

    yOffset = yOffset - 35

    -- Separator
    local sep3 = content:CreateTexture(nil, "ARTWORK")
    sep3:SetPoint("TOP", content, "TOP", 0, yOffset)
    sep3:SetSize(460, 1)
    sep3:SetTexture(0.3, 0.3, 0.3, 0.8)
    yOffset = yOffset - 15

    -- === TARGET SECTION ===
    local targetLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    targetLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
    targetLabel:SetText("Target")
    targetLabel:SetTextColor(1, 1, 1)
    yOffset = yOffset - 25

    -- Target selection buttons
    local targetSelfBtn = CreateStyledButton(content, "[X] Self", 100, 28)
    targetSelfBtn:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)

    local targetTargetBtn = CreateStyledButton(content, "[  ] Target", 100, 28)
    targetTargetBtn:SetPoint("LEFT", targetSelfBtn, "RIGHT", 8, 0)

    local targetGroupBtn = CreateStyledButton(content, "[  ] Group", 100, 28)
    targetGroupBtn:SetPoint("LEFT", targetTargetBtn, "RIGHT", 8, 0)

    -- Set initial state
    auraConfig.targetMode = "self"
    targetSelfBtn:LockHighlight()

    targetSelfBtn:SetScript("OnClick", function()
        auraConfig.targetMode = "self"
        targetSelfBtn:LockHighlight()
        targetTargetBtn:UnlockHighlight()
        targetGroupBtn:UnlockHighlight()
        -- Update button text
        if targetSelfBtn.text then targetSelfBtn.text:SetText("[X] Self") end
        if targetTargetBtn.text then targetTargetBtn.text:SetText("[  ] Target") end
        if targetGroupBtn.text then targetGroupBtn.text:SetText("[  ] Group") end
    end)

    targetTargetBtn:SetScript("OnClick", function()
        auraConfig.targetMode = "target"
        targetTargetBtn:LockHighlight()
        targetSelfBtn:UnlockHighlight()
        targetGroupBtn:UnlockHighlight()
        -- Update button text
        if targetSelfBtn.text then targetSelfBtn.text:SetText("[  ] Self") end
        if targetTargetBtn.text then targetTargetBtn.text:SetText("[X] Target") end
        if targetGroupBtn.text then targetGroupBtn.text:SetText("[  ] Group") end
    end)

    targetGroupBtn:SetScript("OnClick", function()
        auraConfig.targetMode = "group"
        targetGroupBtn:LockHighlight()
        targetSelfBtn:UnlockHighlight()
        targetTargetBtn:UnlockHighlight()
        -- Update button text
        if targetSelfBtn.text then targetSelfBtn.text:SetText("[  ] Self") end
        if targetTargetBtn.text then targetTargetBtn.text:SetText("[  ] Target") end
        if targetGroupBtn.text then targetGroupBtn.text:SetText("[X] Group") end
    end)

    -- === ACTION BUTTONS ===
    local applyBtn = CreateStyledButton(dialog, "Apply Aura", 120, 32)
    applyBtn:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -20, 20)
    applyBtn:SetScript("OnClick", function()
        -- Send to server based on target mode
        if auraConfig.targetMode == "self" then
            AIO.Handle("GameMasterSystem", "applyAuraWithOptionsToSelf",
                spellId,
                auraConfig.duration,
                auraConfig.stacks
            )
        elseif auraConfig.targetMode == "group" then
            AIO.Handle("GameMasterSystem", "applyAuraWithOptionsToGroup",
                spellId,
                auraConfig.duration,
                auraConfig.stacks
            )
        else
            AIO.Handle("GameMasterSystem", "applyAuraWithOptionsToTarget",
                spellId,
                auraConfig.duration,
                auraConfig.stacks
            )
        end

        -- Build feedback message
        local durationText = auraConfig.duration > 0 and
            string.format("%.0f sec", auraConfig.duration / 1000) or "permanent"
        local stackText = auraConfig.stacks > 1 and
            string.format(", %d stacks", auraConfig.stacks) or ""
        local targetText = auraConfig.targetMode == "self" and "yourself" or
                          (auraConfig.targetMode == "group" and "group" or "target")

        CreateStyledToast(
            string.format("Applied %s to %s (%s%s)",
                spellName or "Spell",
                targetText,
                durationText,
                stackText
            ),
            2,
            0.5
        )

        dialog:Hide()
    end)

    local cancelBtn = CreateStyledButton(dialog, "Cancel", 100, 32)
    cancelBtn:SetPoint("RIGHT", applyBtn, "LEFT", -10, 0)
    cancelBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)

    dialog:Show()
end
