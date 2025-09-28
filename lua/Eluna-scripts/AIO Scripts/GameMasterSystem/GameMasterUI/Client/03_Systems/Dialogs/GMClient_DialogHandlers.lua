local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in DialogHandlers! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI
local GMConfig = _G.GMConfig

-- ============================================================================
-- Gold Dialog
-- ============================================================================

-- Create styled gold dialog function
function GameMasterSystem.ShowGiveGoldDialog(playerName)
    -- Local reference for the dialog
    local goldDialog = nil
    local customAmountEdit = nil
    
    -- Helper function to format gold display
    local function FormatGoldAmount(copper)
        local gold = math.floor(copper / 10000)
        local silver = math.floor((copper % 10000) / 100)
        local remaining_copper = copper % 100
        
        if gold > 0 then
            return string.format("|cffffd700%dg|r |cffc7c7cf%ds|r |cffeda55f%dc|r", gold, silver, remaining_copper)
        elseif silver > 0 then
            return string.format("|cffc7c7cf%ds|r |cffeda55f%dc|r", silver, remaining_copper)
        else
            return string.format("|cffeda55f%dc|r", remaining_copper)
        end
    end
    
    -- Helper function to send gold
    local function SendGold(amount)
        if amount and amount > 0 then
            AIO.Handle("GameMasterSystem", "givePlayerGold", playerName, amount)
            CreateStyledToast(string.format("Gave %d gold to %s", amount, playerName), 3, 0.5)
            if goldDialog then
                goldDialog:Hide()
            end
        else
            CreateStyledToast("Invalid gold amount!", 3, 0.5)
        end
    end
    
    -- Create modal dialog
    local options = {
        title = "Give Gold to " .. playerName,
        width = 450,
        height = 420,  -- Increased height to accommodate buttons
        closeOnEscape = true,
        buttons = {
            {
                text = "Cancel",
                callback = function()
                    if goldDialog then
                        goldDialog:Hide()
                    end
                end
            },
            {
                text = "Give Custom Amount",
                callback = function()
                    if customAmountEdit then
                        local amount = tonumber(customAmountEdit:GetText())
                        SendGold(amount)
                    end
                end
            }
        }
    }
    
    goldDialog = CreateStyledDialog(options)
    
    -- Create custom content area with more space at bottom for buttons
    local content = CreateFrame("Frame", nil, goldDialog)
    content:SetPoint("TOPLEFT", goldDialog, "TOPLEFT", 20, -50)
    content:SetPoint("BOTTOMRIGHT", goldDialog, "BOTTOMRIGHT", -20, 80)  -- Increased from 60 to 80
    
    
    -- Gold icon and header
    local goldIcon = content:CreateTexture(nil, "ARTWORK")
    goldIcon:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
    goldIcon:SetSize(32, 32)
    goldIcon:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
    
    local headerText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    headerText:SetPoint("LEFT", goldIcon, "RIGHT", 10, 0)
    headerText:SetText("|cffffd700Select Amount|r")
    
    -- Instruction text
    local instructionText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    instructionText:SetPoint("TOPLEFT", goldIcon, "BOTTOMLEFT", 0, -10)
    instructionText:SetText("Choose a preset amount or enter a custom value:")
    instructionText:SetTextColor(0.8, 0.8, 0.8)
    
    -- Create section for preset amounts
    local presetSection = CreateStyledFrame(content, UISTYLE_COLORS.SectionBg)
    presetSection:SetHeight(140)
    presetSection:SetPoint("TOPLEFT", instructionText, "BOTTOMLEFT", 0, -15)
    presetSection:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -85)  -- Adjusted positioning
    
    local presetLabel = presetSection:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    presetLabel:SetPoint("TOPLEFT", presetSection, "TOPLEFT", 10, -10)
    presetLabel:SetText("Quick Amounts:")
    presetLabel:SetTextColor(1, 0.82, 0)
    
    -- Predefined gold amounts
    local presetAmounts = {
        { amount = 10, label = "10 Gold" },
        { amount = 100, label = "100 Gold" },
        { amount = 1000, label = "1,000 Gold" },
        { amount = 10000, label = "10,000 Gold" },
        { amount = 50000, label = "50,000 Gold" },
        { amount = 100000, label = "100,000 Gold" }
    }
    
    -- Create preset buttons in a 2x3 grid
    local buttonWidth = 125
    local buttonHeight = 28
    local spacing = 10
    local startX = 15
    local startY = -35
    
    for i, preset in ipairs(presetAmounts) do
        local row = math.floor((i - 1) / 2)
        local col = (i - 1) % 2
        
        local button = CreateStyledButton(presetSection, preset.label, buttonWidth, buttonHeight)
        button:SetPoint("TOPLEFT", presetSection, "TOPLEFT", 
            startX + (col * (buttonWidth + spacing)), 
            startY - (row * (buttonHeight + spacing)))
        
        -- Add tooltip with formatted amount
        button:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(preset.label, 1, 1, 1)
            GameTooltip:AddLine(FormatGoldAmount(preset.amount * 10000), 1, 0.82, 0)
            GameTooltip:AddLine("Click to give this amount", 0.7, 0.7, 0.7)
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function() GameTooltip:Hide() end)
        
        button:SetScript("OnClick", function()
            SendGold(preset.amount)
        end)
    end
    
    -- Create custom amount section
    local customSection = CreateStyledFrame(content, UISTYLE_COLORS.SectionBg)
    customSection:SetHeight(80)
    customSection:SetPoint("TOPLEFT", presetSection, "BOTTOMLEFT", 0, -10)
    customSection:SetPoint("TOPRIGHT", presetSection, "BOTTOMRIGHT", 0, -10)
    
    local customLabel = customSection:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customLabel:SetPoint("TOPLEFT", customSection, "TOPLEFT", 10, -10)
    customLabel:SetText("Custom Amount:")
    customLabel:SetTextColor(1, 0.82, 0)
    
    -- Custom amount input
    local customContainer = CreateStyledEditBox(customSection, 150, true, 10, false)
    customContainer:SetPoint("TOPLEFT", customLabel, "BOTTOMLEFT", 0, -5)
    customAmountEdit = customContainer.editBox
    customAmountEdit:SetText("1")
    customAmountEdit:SetScript("OnEnterPressed", function(self)
        local amount = tonumber(self:GetText())
        SendGold(amount)
    end)
    
    -- Gold label next to input
    local goldLabel = customSection:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    goldLabel:SetPoint("LEFT", customContainer, "RIGHT", 5, 0)
    goldLabel:SetText("|cffffd700gold|r")
    
    -- Help text
    local helpText = customSection:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    helpText:SetPoint("TOPLEFT", customContainer, "BOTTOMLEFT", 0, -2)
    helpText:SetText("Enter amount in gold (max: 214,748)")
    helpText:SetTextColor(0.6, 0.6, 0.6)
    
    -- Quick fill buttons for custom amount
    local quickFills = { 500, 5000, 25000 }
    local fillX = 0
    for _, amount in ipairs(quickFills) do
        local fillBtn = CreateStyledButton(customSection, tostring(amount), 50, 22)
        fillBtn:SetPoint("LEFT", goldLabel, "RIGHT", 20 + fillX, 0)
        fillX = fillX + 55
        
        fillBtn:SetScript("OnClick", function()
            customAmountEdit:SetText(tostring(amount))
            customAmountEdit:SetFocus()
            customAmountEdit:HighlightText()
        end)
        
        fillBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:AddLine("Quick Fill: " .. amount .. " gold", 1, 1, 1)
            GameTooltip:Show()
        end)
        fillBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    
    -- Focus the custom input by default
    customAmountEdit:SetFocus()
    customAmountEdit:HighlightText()
    
    goldDialog:Show()
end

-- ============================================================================
-- Ban Dialog
-- ============================================================================

-- Custom Ban Dialog
function GameMasterSystem.ShowBanDialog(playerName, banType)
    -- Prevent multiple dialogs
    if GameMasterSystem.banDialog and GameMasterSystem.banDialog:IsShown() then
        GameMasterSystem.banDialog:Hide()
    end
    
    -- Default to character ban if not specified
    banType = banType or 1
    
    -- Ban type labels
    local banTypeLabels = {
        [0] = "Account",
        [1] = "Character",
        [2] = "IP"
    }
    
    -- Ban type descriptions
    local banTypeDescriptions = {
        [0] = "Bans all characters on this player's account",
        [1] = "Bans only this specific character",
        [2] = "Bans this player's IP address"
    }
    
    -- Ban type colors
    local banTypeColors = {
        [0] = UISTYLE_COLORS.Orange,    -- Orange for account ban
        [1] = UISTYLE_COLORS.Yellow,    -- Yellow for character ban
        [2] = UISTYLE_COLORS.Red        -- Red for IP ban
    }
    
    -- Create main dialog frame
    local dialog = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(450, 420)  -- Increased height for ban type info
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("DIALOG")
    dialog:SetFrameLevel(100)
    dialog:EnableMouse(true)
    dialog:SetMovable(true)
    dialog:RegisterForDrag("LeftButton")
    dialog:SetScript("OnDragStart", dialog.StartMoving)
    dialog:SetScript("OnDragStop", dialog.StopMovingOrSizing)
    
    -- Store reference
    GameMasterSystem.banDialog = dialog
    
    -- Create title bar
    local titleBar = CreateStyledFrame(dialog, UISTYLE_COLORS.SectionBg)
    titleBar:SetHeight(30)
    titleBar:SetPoint("TOPLEFT", dialog, "TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", dialog, "TOPRIGHT", -1, -1)
    
    -- Title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBar, "LEFT", 10, 0)
    title:SetText(string.format("Ban %s", playerName))
    title:SetTextColor(1, 1, 1)
    
    -- Close button
    local closeBtn = CreateStyledButton(titleBar, "X", 24, 24)
    closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -5, 0)
    closeBtn:SetScript("OnClick", function() dialog:Hide() end)
    
    -- Content area
    local content = CreateStyledFrame(dialog, UISTYLE_COLORS.OptionBg)
    content:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 10, -10)
    content:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -10, 10)
    
    -- Ban type info section
    local banTypeSection = CreateStyledFrame(content, UISTYLE_COLORS.SectionBg)
    banTypeSection:SetHeight(60)
    banTypeSection:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
    banTypeSection:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, 0)
    
    -- Ban type icon
    local banTypeIcon = banTypeSection:CreateTexture(nil, "ARTWORK")
    banTypeIcon:SetSize(32, 32)
    banTypeIcon:SetPoint("LEFT", banTypeSection, "LEFT", 10, 0)
    if banType == 0 then
        banTypeIcon:SetTexture("Interface\\Icons\\INV_Misc_GroupLooking")  -- Account icon
    elseif banType == 1 then
        banTypeIcon:SetTexture("Interface\\Icons\\Achievement_Character_Human_Male")  -- Character icon
    else
        banTypeIcon:SetTexture("Interface\\Icons\\Spell_Fire_SelfDestruct")  -- IP ban icon
    end
    
    -- Ban type label with color
    local banTypeLabel = banTypeSection:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    banTypeLabel:SetPoint("LEFT", banTypeIcon, "RIGHT", 10, 8)
    banTypeLabel:SetText(banTypeLabels[banType] .. " Ban")
    local r, g, b = unpack(banTypeColors[banType])
    banTypeLabel:SetTextColor(r, g, b)
    
    -- Ban type description
    local banTypeDesc = banTypeSection:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    banTypeDesc:SetPoint("TOPLEFT", banTypeLabel, "BOTTOMLEFT", 0, -2)
    banTypeDesc:SetText(banTypeDescriptions[banType])
    banTypeDesc:SetTextColor(0.7, 0.7, 0.7)
    
    -- Duration label
    local durationLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    durationLabel:SetPoint("TOPLEFT", banTypeSection, "BOTTOMLEFT", 10, -15)
    durationLabel:SetText("Ban Duration (minutes):")
    durationLabel:SetTextColor(1, 1, 1)
    
    -- Duration edit box
    local durationContainer = CreateStyledEditBox(content, 400, true, 10, false)
    durationContainer:SetPoint("TOPLEFT", durationLabel, "BOTTOMLEFT", 0, -5)
    local durationEdit = durationContainer.editBox  -- Get the actual EditBox
    durationEdit:SetText("0")
    durationEdit:HighlightText()
    durationEdit:SetFocus()
    
    -- Duration help text
    local durationHelp = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    durationHelp:SetPoint("TOPLEFT", durationContainer, "BOTTOMLEFT", 0, -2)
    durationHelp:SetText("Enter 0 for permanent ban")
    durationHelp:SetTextColor(0.7, 0.7, 0.7)
    
    -- Reason label
    local reasonLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    reasonLabel:SetPoint("TOPLEFT", durationHelp, "BOTTOMLEFT", 0, -15)
    reasonLabel:SetText("Ban Reason:")
    reasonLabel:SetTextColor(1, 1, 1)
    
    -- Reason edit box (multi-line) - Create manually to avoid UIStyleLibrary bug
    local reasonContainer = CreateStyledFrame(content, UISTYLE_COLORS.OptionBg)
    reasonContainer:SetPoint("TOPLEFT", reasonLabel, "BOTTOMLEFT", 0, -5)
    reasonContainer:SetHeight(100)
    reasonContainer:SetWidth(400)
    
    -- Create simple multi-line EditBox without scroll frame
    local reasonEdit = CreateFrame("EditBox", nil, reasonContainer)
    reasonEdit:SetPoint("TOPLEFT", 4, -4)
    reasonEdit:SetPoint("BOTTOMRIGHT", -4, 4)
    reasonEdit:SetMultiLine(true)
    reasonEdit:SetMaxLetters(200)
    reasonEdit:SetFontObject("GameFontHighlight")
    reasonEdit:SetTextColor(1, 1, 1)
    reasonEdit:SetText("Banned by GM")
    reasonEdit:SetAutoFocus(false)
    
    -- Button container
    local buttonContainer = CreateStyledFrame(content, UISTYLE_COLORS.OptionBg)
    buttonContainer:SetHeight(40)
    buttonContainer:SetPoint("BOTTOMLEFT", content, "BOTTOMLEFT", 0, 0)
    buttonContainer:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
    
    -- Cancel button
    local cancelBtn = CreateStyledButton(buttonContainer, "Cancel", 100, 26)
    cancelBtn:SetPoint("LEFT", buttonContainer, "LEFT", 10, 0)
    cancelBtn:SetScript("OnClick", function() dialog:Hide() end)
    
    -- Ban button
    local banBtn = CreateStyledButton(buttonContainer, "Ban", 100, 26)
    banBtn:SetPoint("RIGHT", buttonContainer, "RIGHT", -10, 0)
    banBtn:SetScript("OnClick", function()
        local duration = tonumber(durationEdit:GetText()) or 0
        local reason = reasonEdit:GetText()
        
        -- Validate input
        if reason == "" then
            reason = "Banned by GM"
        end
        
        -- Show confirmation dialog
        local confirmMsg = string.format(
            "Are you sure you want to %s %s?\n\nBan Type: %s\nDuration: %s\nReason: %s",
            duration == 0 and "permanently ban" or "ban",
            playerName,
            banTypeLabels[banType] .. " Ban",
            duration == 0 and "Permanent" or duration .. " minutes",
            reason
        )
        
        -- Create custom confirmation dialog
        StaticPopupDialogs["GM_CONFIRM_BAN"] = {
            text = confirmMsg,
            button1 = "Confirm Ban",
            button2 = "Cancel",
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
            OnAccept = function()
                -- Send ban command with ban type
                AIO.Handle("GameMasterSystem", "banPlayer", playerName, duration, reason, banType)
                
                -- Close ban dialog
                dialog:Hide()
                
                -- Show feedback
                CreateStyledToast("Ban command sent", 2, 0.5)
            end,
            OnCancel = function()
                -- Do nothing, keep ban dialog open
            end,
        }
        
        StaticPopup_Show("GM_CONFIRM_BAN")
    end)
    
    -- Handle escape key
    durationEdit:SetScript("OnEscapePressed", function() dialog:Hide() end)
    reasonEdit:SetScript("OnEscapePressed", function() dialog:Hide() end)
    
    -- Handle enter key on duration to move to reason
    durationEdit:SetScript("OnEnterPressed", function()
        reasonEdit:SetFocus()
    end)
    
    -- Add to UISpecialFrames for ESC key closing
    local dialogName = "GameMasterBanDialog"
    _G[dialogName] = dialog  -- Store in global namespace
    tinsert(UISpecialFrames, dialogName)
    
    -- Show the dialog
    dialog:Show()
    
    return dialog
end

-- ============================================================================
-- Mail Dialog (truncated for size - will continue in part 2)
-- ============================================================================

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Dialog handlers module loaded (part 1)")
end