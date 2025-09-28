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
local ContextMenu = SpellSelection.ContextMenu

-- Show context menu for spell with advanced options
function ContextMenu.showSpellContextMenu(spellData)
    local state = SpellSelection.state
    local targetPlayerName = state.targetPlayerNameForSpell
    
    local menu = {
        {
            text = "Spell: " .. (spellData.name or "Unknown"),
            isTitle = true,
            notCheckable = true,
        },
        {
            text = "Apply as Aura",
            hasArrow = true,
            menuList = {
                {
                    text = "Apply to Player",
                    func = function()
                        AIO.Handle("GameMasterSystem", "playerSpellApplyAura", targetPlayerName, spellData.spellId)
                        CreateStyledToast(string.format("Applied %s as aura to %s", spellData.name, targetPlayerName), 2, 0.5)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Apply Aura",
                    tooltipText = "Apply this spell as a persistent aura/buff on the player",
                },
                { isSeparator = true },
                {
                    text = "Apply with Duration",
                    hasArrow = true,
                    menuList = {
                        {
                            text = "1 Minute",
                            func = function()
                                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", targetPlayerName, spellData.spellId, 60000)
                                CreateStyledToast(string.format("Applied %s (1 minute) to %s", spellData.name, targetPlayerName), 2, 0.5)
                            end,
                            notCheckable = true,
                        },
                        {
                            text = "10 Minutes",
                            func = function()
                                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", targetPlayerName, spellData.spellId, 600000)
                                CreateStyledToast(string.format("Applied %s (10 minutes) to %s", spellData.name, targetPlayerName), 2, 0.5)
                            end,
                            notCheckable = true,
                        },
                        {
                            text = "1 Hour",
                            func = function()
                                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", targetPlayerName, spellData.spellId, 3600000)
                                CreateStyledToast(string.format("Applied %s (1 hour) to %s", spellData.name, targetPlayerName), 2, 0.5)
                            end,
                            notCheckable = true,
                        },
                        {
                            text = "24 Hours",
                            func = function()
                                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", targetPlayerName, spellData.spellId, 86400000)
                                CreateStyledToast(string.format("Applied %s (24 hours) to %s", spellData.name, targetPlayerName), 2, 0.5)
                            end,
                            notCheckable = true,
                        },
                        {
                            text = "Permanent",
                            func = function()
                                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", targetPlayerName, spellData.spellId, -1)
                                CreateStyledToast(string.format("Applied %s (permanent) to %s", spellData.name, targetPlayerName), 2, 0.5)
                            end,
                            notCheckable = true,
                            tooltipTitle = "Permanent",
                            tooltipText = "Apply until death or manual removal",
                        },
                        { isSeparator = true },
                        {
                            text = "Custom Duration...",
                            func = function()
                                ContextMenu.showCustomDurationDialog(spellData)
                            end,
                            notCheckable = true,
                            tooltipTitle = "Custom Duration",
                            tooltipText = "Enter a custom duration in seconds",
                        },
                    },
                    notCheckable = true,
                },
                { isSeparator = true },
                {
                    text = "Remove This Aura",
                    func = function()
                        AIO.Handle("GameMasterSystem", "playerSpellRemoveAura", targetPlayerName, spellData.spellId)
                        CreateStyledToast(string.format("Removed %s aura from %s", spellData.name, targetPlayerName), 2, 0.5)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Remove Aura",
                    tooltipText = "Remove only this specific aura from the player",
                },
            },
            notCheckable = true,
        },
        {
            text = "Cast Spell",
            hasArrow = true,
            menuList = {
                {
                    text = "Cast on Player",
                    func = function()
                        AIO.Handle("GameMasterSystem", "playerSpellCastOnSelf", targetPlayerName, spellData.spellId)
                        CreateStyledToast(string.format("Making %s cast %s on self", targetPlayerName, spellData.name), 2, 0.5)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Cast on Player",
                    tooltipText = "Make the player cast this spell on themselves",
                },
                {
                    text = "Cast on Target",
                    func = function()
                        AIO.Handle("GameMasterSystem", "playerSpellCastOnTarget", targetPlayerName, spellData.spellId)
                        CreateStyledToast(string.format("Making %s cast %s on target", targetPlayerName, spellData.name), 2, 0.5)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Cast on Target",
                    tooltipText = "Make the player cast this spell on their current target",
                },
                {
                    text = "Cast from Player",
                    func = function()
                        AIO.Handle("GameMasterSystem", "playerSpellCastFromPlayer", targetPlayerName, spellData.spellId)
                        CreateStyledToast(string.format("Making %s cast %s on you", targetPlayerName, spellData.name), 2, 0.5)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Cast from Player",
                    tooltipText = "Make the player cast this spell on you",
                },
            },
            notCheckable = true,
        },
        { isSeparator = true },
        {
            text = "Learn Spell",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellLearn", targetPlayerName, spellData.spellId)
                CreateStyledToast(string.format("Teaching %s to %s", spellData.name, targetPlayerName), 2, 0.5)
            end,
            notCheckable = true,
            tooltipTitle = "Learn Spell",
            tooltipText = "Make the player permanently learn this spell",
        },
        { isSeparator = true },
        {
            text = "Cancel",
            func = function() end,
            notCheckable = true,
        },
    }
    
    ShowStyledEasyMenu(menu, "cursor")
end

-- Show custom duration dialog for aura application
function ContextMenu.showCustomDurationDialog(spellData)
    local state = SpellSelection.state
    local targetPlayerName = state.targetPlayerNameForSpell
    
    -- Create custom duration dialog
    local dialog = CreateStyledDialog({
        title = "Apply Aura with Custom Duration",
        width = 400,
        height = 250,
        closeOnEscape = true,
    })
    
    -- Content frame
    local content = CreateFrame("Frame", nil, dialog)
    content:SetPoint("TOPLEFT", dialog, "TOPLEFT", 15, -40)
    content:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -15, 60)
    
    -- Spell info
    local spellInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    spellInfo:SetPoint("TOP", content, "TOP", 0, -10)
    spellInfo:SetText(spellData.name or "Unknown Spell")
    
    local spellId = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    spellId:SetPoint("TOP", spellInfo, "BOTTOM", 0, -5)
    spellId:SetText("Spell ID: " .. (spellData.spellId or 0))
    spellId:SetTextColor(0.7, 0.7, 0.7)
    
    -- Duration input
    local inputLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    inputLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -60)
    inputLabel:SetText("Duration (seconds):")
    
    local inputBox = CreateStyledEditBox(content, 150, true, 10, false)
    inputBox:SetPoint("LEFT", inputLabel, "RIGHT", 10, 0)
    inputBox:SetText("60")
    inputBox:SetFocus()
    inputBox:HighlightText()
    
    -- Quick duration buttons
    local quickLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quickLabel:SetPoint("TOPLEFT", inputLabel, "BOTTOMLEFT", 0, -20)
    quickLabel:SetText("Quick Select:")
    
    local quickButtons = {
        {text = "1m", duration = 60},
        {text = "10m", duration = 600},
        {text = "30m", duration = 1800},
        {text = "1h", duration = 3600},
        {text = "6h", duration = 21600},
        {text = "24h", duration = 86400},
    }
    
    local lastButton = nil
    for i, btn in ipairs(quickButtons) do
        local quickBtn = CreateStyledButton(content, btn.text, 45, 22)
        if i == 1 then
            quickBtn:SetPoint("TOPLEFT", quickLabel, "BOTTOMLEFT", 0, -5)
        else
            quickBtn:SetPoint("LEFT", lastButton, "RIGHT", 5, 0)
        end
        quickBtn:SetScript("OnClick", function()
            inputBox:SetText(tostring(btn.duration))
            inputBox:HighlightText()
        end)
        lastButton = quickBtn
    end
    
    -- Action buttons
    local applyBtn = CreateStyledButton(content, "Apply", 100, 24)
    applyBtn:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
    applyBtn:SetScript("OnClick", function()
        local duration = tonumber(inputBox:GetText())
        if duration and duration > 0 then
            -- Convert seconds to milliseconds
            local durationMs = duration * 1000
            AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", targetPlayerName, spellData.spellId, durationMs)
            dialog:Hide()
            CreateStyledToast(string.format("Applied %s (%d seconds) to %s", spellData.name, duration, targetPlayerName), 2, 0.5)
        else
            CreateStyledToast("Invalid duration! Please enter a positive number.", 3, 0.5)
        end
    end)
    
    local cancelBtn = CreateStyledButton(content, "Cancel", 100, 24)
    cancelBtn:SetPoint("RIGHT", applyBtn, "LEFT", -10, 0)
    cancelBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Handle Enter key
    inputBox:SetScript("OnEnterPressed", function()
        applyBtn:Click()
    end)
    
    dialog:Show()
end