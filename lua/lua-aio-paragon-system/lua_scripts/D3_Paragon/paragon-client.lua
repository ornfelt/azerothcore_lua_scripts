-- ------------------------------------------------------------------------------------------------
-- -- PARAGON CLIENT CONFIGURATION
-- ------------------------------------------------------------------------------------------------

local AIO = AIO or require("AIO");
if AIO.AddAddon() then return end

local paragon = {}
local paragon_addon = AIO.AddHandlers("AIO_Paragon", {})

paragon.mainWindow = CreateFrame("Frame", "ParagonMainWindow", UIParent)
-- paragon.mainWindow = CreateFrame("Frame", paragon.mainWindow, UIParent)
    paragon.mainWindow:SetSize(300, 570)
    paragon.mainWindow:SetMovable(false)
    paragon.mainWindow:EnableMouse(true)
    paragon.mainWindow:RegisterForDrag("Right_Button")
    paragon.mainWindow:SetPoint("CENTER", 0, 150)
    paragon.mainWindow:Hide()
    -- Add the frame to UISpecialFrames to close it with the Escape key
    tinsert(UISpecialFrames, paragon.mainWindow:GetName())

paragon.mainWindowTexture = paragon.mainWindow:CreateTexture()
    paragon.mainWindowTexture:SetAllPoints(paragon.mainWindow)
    paragon.mainWindowTexture:SetTexture("interface/D3_Paragon/paragon/paragon_frame")
    paragon.mainWindowTexture:SetTexCoord(0.58154296875, 0.96435546875, 0.04052734375, 0.81201171875)

paragon.mainTitle = CreateFrame("Frame", paragon.mainTitle, paragon.mainWindow)
    paragon.mainTitle:SetSize(150, 45)
    paragon.mainTitle:SetPoint("TOP", 0, 20)
    paragon.mainTitle:SetFrameLevel(paragon.mainWindow:GetFrameLevel() + 1)

paragon.mainTitleTexture = paragon.mainWindow:CreateTexture()
    paragon.mainTitleTexture:SetAllPoints(paragon.mainTitle)
    paragon.mainTitleTexture:SetTexture("interface/D3_Paragon/paragon/paragon_frame")
    paragon.mainTitleTexture:SetParent(paragon.mainTitle)
    paragon.mainTitleTexture:SetTexCoord(0.23486328125, 0.48779296875, 0.33251953125, 0.40966796875)

paragon.mainTitleText = paragon.mainTitle:CreateFontString(paragon.mainTitleText)
    paragon.mainTitleText:SetFont("Fonts\\FRIZQT__.TTF", 14)
    paragon.mainTitleText:SetSize(190, 5)
    paragon.mainTitleText:SetPoint("CENTER", 0, 3)
    paragon.mainTitleText:SetText("|CFF000000Paragon|r")

paragon.mainWindowArt = CreateFrame("Button", paragon.mainWindowArt, paragon.mainWindow)
    paragon.mainWindowArt:SetSize(140, 100)
    paragon.mainWindowArt:SetPoint("TOP", -70, -80)
    paragon.mainWindowArt:SetFrameLevel(1)
    paragon.mainWindowArt:SetAlpha(0.4)
    paragon.mainWindowArt:SetFrameLevel(2)

paragon.mainWindowArtTexture = paragon.mainWindowArt:CreateTexture()
    paragon.mainWindowArtTexture:SetAllPoints(paragon.mainWindowArt)
    paragon.mainWindowArtTexture:SetTexture("interface/D3_Paragon/paragon/paragon_frame")
    paragon.mainWindowArtTexture:SetTexCoord(0.00048828125, 0.35009765625, 0.00048828125, 0.21435546875)

paragon.levelWindow = CreateFrame("Frame", paragon.levelWindow, paragon.mainWindow)
    paragon.levelWindow:SetSize(95, 90)
    paragon.levelWindow:SetPoint("TOP", 0, -30)
    paragon.levelWindow:SetFrameLevel(2)

paragon.levelWindowTexture = paragon.levelWindow:CreateTexture()
    paragon.levelWindowTexture:SetAllPoints(paragon.levelWindow)
    paragon.levelWindowTexture:SetTexture("interface/D3_Paragon/paragon/paragon_frame")
    paragon.levelWindowTexture:SetTexCoord(0.05419921875, 0.17431640625, 0.31201171875, 0.42724609375)

paragon.levelText = paragon.levelWindow:CreateFontString(paragon.levelText)
    paragon.levelText:SetFont("Fonts\\FRIZQT__.TTF", 18)
    paragon.levelText:SetSize(190, 3)
    paragon.levelText:SetPoint("CENTER", -2, 1)
    paragon.levelText:SetShadowColor(0.156, 0.2, 0.2)
    paragon.levelText:SetShadowOffset(0.5, 0)

paragon.closeButton = CreateFrame("Button", paragon.closeButton, paragon.mainWindow, "UIPanelCloseButton")
    paragon.closeButton:SetPoint("TOPRIGHT", 1.5, 3)
    paragon.closeButton:EnableMouse(true)
    paragon.closeButton:SetSize(28, 28)
    paragon.closeButton:SetFrameLevel(2)

paragon.expIcon = CreateFrame("Frame", paragon.expIcon, paragon.mainWindow)
    paragon.expIcon:SetSize(39, 39)
    paragon.expIcon:SetBackdrop({
        bgFile = "Interface/D3_Paragon/Icons/garr_currencyicon-xp",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }})
    paragon.expIcon:SetPoint("TOP", 0, -115)
    paragon.expIcon:SetFrameLevel(6)

paragon.expText = paragon.mainWindow:CreateFontString(paragon.expText)
    paragon.expText:SetFont("Fonts\\FRIZQT__.TTF", 13)
    paragon.expText:SetSize(190, 3)
    paragon.expText:SetPoint("TOP", 0, -155)
    paragon.expText:SetShadowColor(0.156, 0.2, 0.2)
    paragon.expText:SetShadowOffset(0.5, 0)

paragon.buttonsCoords = {
  global = {
    pos_y = 85
  }
}

paragon.leftButtons = {}
paragon.leftButtonsTexture = {}
paragon.leftButtonsArt = {}

paragon.centerButtons = {}
paragon.centerText = {}

paragon.rightButtons = {}
paragon.rightButtonsTexture = {}
paragon.rightText = {}

paragon.spellsList = {
    --[[ -Aldori note 
      If you want to use different icons, place the .blp file in the Interface/D3_Paragon/Icons folder
      in your Client patch.  Then just use the icon name below.
    --]]
    [7464] = {name = 'Strength', icon = '_D3mantraofconviction'},
    [7468] = {name = 'Intellect', icon = '_D3mantraofhealing'},
    [7471] = {name = 'Agility', icon = '_D3mantraofevasion'},
    [7474] = {name = 'Spirit', icon = '_D3mantraofevasion'},
    [7477] = {name = 'Stamina', icon = '_D3mantraofretribution'},
    [7511] = {name = 'Defense Rating', icon = '_D3mantraofretribution'},
}

for id, subtable in pairs(paragon.spellsList) do
    paragon.leftButtons[id] = CreateFrame("Frame", paragon.leftButtons[id], paragon.mainWindow)
        paragon.leftButtons[id]:SetSize(50, 50)
        paragon.leftButtons[id]:SetPoint("LEFT", 20, paragon.buttonsCoords.global.pos_y)
        paragon.leftButtons[id]:SetFrameLevel(1000)
        paragon.leftButtons[id]:SetFrameLevel(3)

    paragon.leftButtonsTexture[id] = paragon.leftButtons[id]:CreateTexture()
        paragon.leftButtonsTexture[id]:SetAllPoints(paragon.leftButtons[id])
        paragon.leftButtonsTexture[id]:SetTexture("Interface/D3_Paragon/paragon/ButtonBorder")

    paragon.leftButtonsArt[id] = CreateFrame("Frame", paragon.leftButtonsArt[id], paragon.leftButtons[id], nil)
        paragon.leftButtonsArt[id]:SetSize(35, 35)
        paragon.leftButtonsArt[id]:SetBackdrop(
          {
            bgFile = "Interface/D3_Paragon/Icons/"..subtable.icon,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
          }
        )
        paragon.leftButtonsArt[id]:SetPoint("CENTER", 0, 0)
        paragon.leftButtonsArt[id]:SetFrameLevel(2)

    paragon.centerButtons[id] = CreateFrame("Button", paragon.centerButtons[id], paragon.mainWindow, nil)
        paragon.centerButtons[id]:SetSize(170, 55)
        paragon.centerButtons[id]:SetPoint("CENTER", 0, paragon.buttonsCoords.global.pos_y)
        paragon.centerButtons[id]:SetNormalTexture("Interface/D3_Paragon/paragon/LargeButtonBorder")
        paragon.centerButtons[id]:SetHighlightTexture("Interface/D3_Paragon/paragon/LargeButtonBorder_Hover")
        paragon.centerButtons[id]:SetPushedTexture("Interface/D3_Paragon/paragon/LargeButtonBorder_Push")
        paragon.centerButtons[id]:EnableMouseWheel(1)
        paragon.centerButtons[id]:SetFrameLevel(3)

    paragon.centerButtons[id]:SetScript("OnMouseUp", function(self, button, down)
        if (button == "LeftButton") then
            AIO.Handle("AIO_Paragon", "setStatsInformation", id, 1, true)
        elseif (button == "RightButton") then
            AIO.Handle("AIO_Paragon", "setStatsInformation", id, 1, false)
        elseif (button == "MiddleButton") then
            AIO.Handle("AIO_Paragon", "setStatsInformation", id, 10, true)
        end
    end)

    paragon.centerButtons[id]:SetScript("OnMouseWheel", function(self, value)
        if (value > 0) then
            AIO.Handle("AIO_Paragon", "setStatsInformation", id, 1, true)
        else
            AIO.Handle("AIO_Paragon", "setStatsInformation", id, 1, false)
        end
    end)

    paragon.centerText[id] = paragon.centerButtons[id]:CreateFontString(paragon.centerText[id])
        paragon.centerText[id]:SetFont("Interface/D3_Paragon/Fonts/MARCELLUS.TTF", 14)
        paragon.centerText[id]:SetSize(190, 3)
        paragon.centerText[id]:SetPoint("CENTER", -1, 1)
        paragon.centerText[id]:SetText("|CFFFFFFFF"..subtable.name.."|r")
        paragon.centerText[id]:SetShadowColor(0, 0, 0)
        paragon.centerText[id]:SetShadowOffset(0.5, 0.5)

    paragon.rightButtons[id] = CreateFrame("Frame", paragon.rightButtons[id], paragon.mainWindow)
        paragon.rightButtons[id]:SetSize(50, 50)
        paragon.rightButtons[id]:SetPoint("Right", -20, paragon.buttonsCoords.global.pos_y)
        paragon.rightButtons[id]:SetFrameLevel(1000)
        paragon.rightButtons[id]:SetFrameLevel(3)

    paragon.rightText[id] = paragon.rightButtons[id]:CreateFontString(paragon.rightText[id])
        paragon.rightText[id]:SetFont("Fonts/FRIZQT__.TTF", 14)
        paragon.rightText[id]:SetSize(190, 3)
        paragon.rightText[id]:SetPoint("CENTER", 0.5, 0)
        paragon.rightText[id]:SetShadowColor(0, 0, 0)
        paragon.rightText[id]:SetShadowOffset(0.5, 0)

    paragon.rightButtonsTexture[id] = paragon.rightButtons[id]:CreateTexture()
        paragon.rightButtonsTexture[id]:SetAllPoints(paragon.rightButtons[id])
        paragon.rightButtonsTexture[id]:SetTexture("Interface/D3_Paragon/paragon/ButtonBorder")

    paragon.buttonsCoords.global.pos_y = paragon.buttonsCoords.global.pos_y - 50
end

paragon.pointsLeft = paragon.mainWindow:CreateFontString(paragon.pointsLeft)
    paragon.pointsLeft:SetFont("Fonts/FRIZQT__.TTF", 12)
    paragon.pointsLeft:SetSize(999, 3)
    paragon.pointsLeft:SetPoint("BOTTOM", 0, 75)
    paragon.pointsLeft:SetShadowColor(0, 0, 0)
    paragon.pointsLeft:SetShadowOffset(1, 1)

paragon.saveButton = CreateFrame("Button", paragon.saveButton, paragon.mainWindow)
    paragon.saveButton:SetSize(125, 40)
    paragon.saveButton:SetNormalTexture("Interface/D3_Paragon/buttons/ui-dialogbox-button-gold-up")
    paragon.saveButton:SetHighlightTexture("Interface/D3_Paragon/buttons/ui-dialogbox-button-highlight")
    paragon.saveButton:SetPushedTexture("Interface/D3_Paragon/buttons/ui-dialogbox-button-gold-down")
    paragon.saveButton:SetPoint("BOTTOM", 0, 20)
    paragon.saveButton:SetFrameLevel(2)

paragon.saveButton:SetScript("OnMouseUp", function(self, button, down)
    if (button == "LeftButton") then
        paragon.mainWindow:Hide()
        AIO.Handle("AIO_Paragon", "setStats")
    end
end)

paragon.saveButtonText = paragon.saveButton:CreateFontString(paragon.saveButtonText)
    paragon.saveButtonText:SetFont("Fonts/FRIZQT__.TTF", 12)
    paragon.saveButtonText:SetSize(180, 3)
    paragon.saveButtonText:SetPoint("CENTER", 0, 6)
    paragon.saveButtonText:SetText("|CFFFFFFFFAccept Changes|r")
    paragon.saveButtonText:SetShadowColor(0, 0, 0)
    paragon.saveButtonText:SetShadowOffset(0.5, 0.5)

paragon.paragonCharacterButton = CreateFrame("Button", paragon.paragonCharacterButton, CharacterFrame)
    paragon.paragonCharacterButton:SetSize(86, 40)
    paragon.paragonCharacterButton:SetPoint("TOP", 0, 18)
    paragon.paragonCharacterButton:SetNormalTexture("Interface/D3_Paragon/buttons/ui-dialogbox-button-gold-up")
    paragon.paragonCharacterButton:SetHighlightTexture("Interface/D3_Paragon/buttons/ui-dialogbox-button-highlight")
    paragon.paragonCharacterButton:SetPushedTexture("Interface/D3_Paragon/buttons/ui-dialogbox-button-gold-down")
    paragon.paragonCharacterButton:SetFrameStrata("DIALOG")
    paragon.paragonCharacterButton:SetFrameLevel(100)

paragon.paragonCharacterButton:SetScript("OnEnter", function(self, button, down)
    GameTooltip:SetOwner(paragon.paragonCharacterButton, "ANCHOR_RIGHT", 12, 0)
    GameTooltip:AddLine("Paragon Info", 1, 1, 1)
    GameTooltip:AddLine("Toggles the Paragon points allocation window.\n"..paragon.pointsLeft:GetText().."\n")

    for spellid, subtable in pairs(paragon.spellsList) do
        GameTooltip:AddLine("|CFFFFFFFF+ "..paragon.rightText[spellid]:GetText().."|CFFFFFFFF "..subtable.name.."|r");
    end
    GameTooltip:AddLine("\n|CFFFFFFFF"..paragon.expText:GetText().."|r ");

    GameTooltip:Show()
end)

paragon.paragonCharacterButton:SetScript("OnLeave", function (self, button, down)
    GameTooltip:Hide()
end)

paragon.paragonCharacterButton:SetScript("OnMouseUp", function (self, button, down)
    if(paragon.mainWindow:IsShown())then
        paragon.mainWindow:Hide()
    else
        paragon.mainWindow:Show()
    end
end)

paragon.paragonCharacterButtonText = paragon.paragonCharacterButton:CreateFontString(paragon.paragonCharacterButtonText)
    --paragon.paragonCharacterButtonText:SetFont("Interface/D3_Paragon/Fonts/MARCELLUS.TTF", 12)
    paragon.paragonCharacterButtonText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    paragon.paragonCharacterButtonText:SetSize(180, 3)
    paragon.paragonCharacterButtonText:SetPoint("CENTER", 0, 6)
    paragon.paragonCharacterButtonText:SetText("|CFFFFD900Paragon|r")
    paragon.paragonCharacterButtonText:SetShadowColor(0, 0, 0)
    paragon.paragonCharacterButtonText:SetShadowOffset(0.5, 0.5)




-- paragon.characterFrameContainer = CreateFrame("Frame", paragon.characterFrameContainer, CharacterFrame);
--     paragon.characterFrameContainer:SetSize(45, 45)
--     paragon.characterFrameContainer:RegisterForDrag("LeftButton")
--     paragon.characterFrameContainer:SetPoint("BOTTOMLEFT", 300, -37)
--     paragon.characterFrameContainer:SetBackdrop({
--         bgFile = "Interface/bankframe/bank-background",
--         edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
--         edgeSize = 20,
--         insets = { left = 5, right = 5, top = 5, bottom = 5 }
--     })
--     paragon.characterFrameContainer:SetFrameLevel(5)
--     paragon.characterFrameContainer:SetMovable(false)
--     paragon.characterFrameContainer:EnableMouse(true)
--     paragon.characterFrameContainer:SetClampedToScreen(true)
--     paragon.characterFrameContainer:SetScript("OnDragStart", paragon.characterFrameContainer.StartMoving)
--     paragon.characterFrameContainer:SetScript("OnHide", paragon.characterFrameContainer.StopMovingOrSizing)
--     paragon.characterFrameContainer:SetScript("OnDragStop", paragon.characterFrameContainer.StopMovingOrSizing)

-- paragon.characterFrameBorder = CreateFrame("Button", paragon.characterFrameBorder, paragon.characterFrameContainer)
--     paragon.characterFrameBorder:SetSize(40, 40)
--     paragon.characterFrameBorder:SetNormalTexture("Interface/D3_Paragon/paragon/ButtonBorder")
--     paragon.characterFrameBorder:SetHighlightTexture("Interface/D3_Paragon/paragon/ButtonBorder_Hover")
--     paragon.characterFrameBorder:SetPushedTexture("Interface/D3_Paragon/paragon/ButtonBorder_Push")
--     paragon.characterFrameBorder:SetPoint("CENTER", 0, 0)
--     paragon.characterFrameBorder:EnableMouseWheel(1)
--     paragon.characterFrameBorder:SetFrameLevel(1000)
--     paragon.characterFrameBorder:SetFrameLevel(7)

--     paragon.characterFrameBorder:SetScript("OnEnter", function(self, button, down)
--         GameTooltip:SetOwner(paragon.characterFrameBackground, "ANCHOR_RIGHT", 12, 0)

--         GameTooltip:AddLine("Paragon Info", 1, 1, 1)
--         GameTooltip:AddLine("Toggles the Paragon points allocation window.\n"..paragon.pointsLeft:GetText().."\n")

--         for spellid, subtable in pairs(paragon.spellsList) do
--             GameTooltip:AddLine("|CFFFFFFFF+ "..paragon.rightText[spellid]:GetText().."|CFFFFFFFF "..subtable.name.."|r");
--         end
--         GameTooltip:AddLine("\n|CFFFFFFFF"..paragon.expText:GetText().."|r ");

--         GameTooltip:Show()
--     end)

--     paragon.characterFrameBorder:SetScript("OnLeave", function (self, button, down)
--         GameTooltip:Hide()
--     end)

--     paragon.characterFrameBorder:SetScript("OnMouseUp", function (self, button, down)
--         if(paragon.mainWindow:IsShown())then
--             paragon.mainWindow:Hide()
--         else
--             paragon.mainWindow:Show()
--         end
--     end)

-- paragon.characterFrameBackground = CreateFrame("Frame", paragon.characterFrameBackground, paragon.characterFrameBorder)
--     paragon.characterFrameBackground:SetSize(29, 29)
--     paragon.characterFrameBackground:SetBackdrop({
--         bgFile = "Interface/D3_Paragon/Icons/_LDAKnowledge",
--         insets = { left = 0, right = 0, top = 0, bottom = 0 }
--     })
--     paragon.characterFrameBackground:SetPoint("CENTER", 0, 0)
--     paragon.characterFrameBackground:SetFrameLevel(6)


function paragon_addon.setInfo(player, stats, level, points, exps, playerLevel, minPlayerLevel)
    for statid, value in pairs(stats) do
        paragon.rightText[statid]:SetText("|CFF00CE00" .. value)
    end

    paragon.levelText:SetText("|CFFFFFFFF" .. level)
    
    if (points > 1) then
        paragon.pointsLeft:SetText("You still have |CFF00CE00" .. points .. "|r points left to spend.")
    elseif (points == 1) then
        paragon.pointsLeft:SetText("You still have |CFF00CE00" .. points .. "|r point left to spend.")
    else
        paragon.pointsLeft:SetText("You have |CFFCE0000" .. points .. "|r points left to spend.")
    end

    paragon.expText:SetText("|CFFC758FE(".. exps.exp .. " / " .. exps.exp_max .. ")")

    -- Hide the Paragon button if the player has not unlocked the Paragon system
    if playerLevel < minPlayerLevel then
        paragon.paragonCharacterButton:Hide()
    else
        paragon.paragonCharacterButton:Show()
    end
end