local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- Get module references
local GMCards = _G.GMCards
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Create Spell Card
function GMCards.createSpellCard(card, entity, index)
    local name, rank, icon = GetSpellInfo(entity.spellID)
    local cardW = card:GetWidth()
    local textW = cardW - 10

    -- Set defaults for nil values
    name = name or "Unknown Spell"
    rank = rank or ""

    -- Create icon background for better visibility
    if not card.iconBackground then
        card.iconBackground = card:CreateTexture(nil, "BACKGROUND")
        card.iconBackground:SetSize(36, 36)
        card.iconBackground:SetPoint("TOP", card, "TOP", 0, -10)
        card.iconBackground:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
        card.iconBackground:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    end

    -- Create icon texture
    card.iconTexture = card:CreateTexture(nil, "ARTWORK")
    card.iconTexture:SetSize(32, 32)
    card.iconTexture:SetPoint("TOP", card, "TOP", 0, -10)
    card.iconTexture:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")

    -- Name: single line below icon
    card.nameText:ClearAllPoints()
    card.nameText:SetWidth(textW)
    card.nameText:SetJustifyH("CENTER")
    card.nameText:SetPoint("TOP", card.iconTexture, "BOTTOM", 0, -5)
    card.nameText:SetText(GMCards.truncateText(name, textW))

    -- Rank: single line below name
    card.additionalText:ClearAllPoints()
    card.additionalText:SetWidth(textW)
    card.additionalText:SetJustifyH("CENTER")
    card.additionalText:SetPoint("TOP", card.nameText, "BOTTOM", 0, -2)
    card.additionalText:SetText(rank ~= "" and GMCards.truncateText(rank, textW) or "")

    -- Spell ID: hidden (replaced by clickable ID line)
    card.entityText:ClearAllPoints()
    card.entityText:SetWidth(textW)
    card.entityText:SetJustifyH("CENTER")
    card.entityText:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 20)
    card.entityText:SetText("")

    -- Clickable spell ID line at bottom
    GMCards.createCopyableIdLine(card, "Spell", entity.spellID)

    card:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetSpellByID(entity.spellID)
        -- Manually set strata for spell tooltips
        local ownerStrata = self:GetFrameStrata()
        if ownerStrata == "TOOLTIP" or ownerStrata == "FULLSCREEN_DIALOG" then
            GameTooltip:SetFrameStrata("TOOLTIP")
            GameTooltip:SetFrameLevel(self:GetFrameLevel() + 10)
        end
        if GameTooltip:NumLines() == 0 then
            GameTooltip:SetText(
                "|cffffff00Description:|r "
                    .. (entity.spellDescription or "N/A")
                    .. "\n\n|cffffff00Tooltip:|r "
                    .. (entity.spellToolTip or "N/A"),
                nil,
                nil,
                nil,
                nil,
                true
            )
        end
        GameTooltip:Show()
    end)

    card:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("spell", card, entity)
        end
    end)

    -- Add magnifier icon for spell preview
    GMCards.addMagnifierIcon(card, entity, index, "Spell")

    -- Wire up card animations (icon-based)
    if GMCards.setupCardVisuals then
        GMCards.setupCardVisuals(card, "Spell")
    end
    if GMCards.setupIconGlow then
        GMCards.setupIconGlow(card, { 0.6, 0.4, 0.9 })
    end
    if GMCards.setupIconHoverEffects then
        GMCards.setupIconHoverEffects(card)
    end
    if GMCards.setupClickFlash then
        GMCards.setupClickFlash(card)
    end

    return card
end

-- Create SpellVisual Card
function GMCards.createSpellVisualCard(card, entity, i)
    local cardW = card:GetWidth()
    local cardH = card:GetHeight()
    local TEXT_AREA_HEIGHT = 48

    -- Create a background for better model visibility
    local modelBg = card:CreateTexture(nil, "BACKGROUND")
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(cardW - 10, cardH - TEXT_AREA_HEIGHT - 4)
    modelBg:SetPoint("TOPLEFT", card, "TOPLEFT", 5, -2)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)

    -- Set up the spell visual model with explicit parent
    local model = CreateFrame("DressUpModel", "modelSpellVisual" .. i, card)
    model:SetParent(card)
    model:SetSize(cardW - 20, cardH - TEXT_AREA_HEIGHT - 14)
    model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)
    model:SetFrameStrata("MEDIUM")  -- Same strata as card
    model:SetFrameLevel(card:GetFrameLevel() + 3)  -- Above background but reasonable
    model:ClearModel()
    
    -- Store the model path for restoration
    model.modelPath = entity.FilePath
    model.isSpellVisual = true
    card.preserveOnClear = true  -- Mark card to preserve on clear
    
    -- Function to restore the model
    local function RestoreModel()
        if model.modelPath then
            model:ClearModel()
            local success = pcall(function()
                model:SetModel(model.modelPath)
            end)
            if success then
                model:SetRotation(math.rad(30))
                model:SetPosition(0, 0, -1.0)
            end
        end
    end
    
    -- Apply the spell visual model immediately
    local success = pcall(function()
        model:SetModel(entity.FilePath)
    end)
    
    if success then
        model:SetRotation(math.rad(30))
        model:SetPosition(0, 0, -1.0)  -- Spell visuals often need more distance
        model:Show()  -- Ensure visibility
        
        -- Add OnShow handler to restore model when shown
        model:SetScript("OnShow", RestoreModel)
        
        -- Store reference
        card.modelFrame = model
    else
        -- Show error message if model fails
        local errorMsg = model:CreateFontString(nil, "OVERLAY")
        errorMsg:SetFontObject("GameFontNormalLarge")
        errorMsg:SetPoint("CENTER")
        errorMsg:SetText("NO MODEL")
        errorMsg:SetTextColor(1, 0, 0, 1)
    end

    -- Name: above filepath
    card.nameText:ClearAllPoints()
    card.nameText:SetWidth(cardW - 10)
    card.nameText:SetJustifyH("CENTER")
    card.nameText:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 16)
    card.nameText:SetText(GMCards.truncateText(entity.Name or "N/A", cardW - 10))

    -- Show truncated filepath as subtext
    card.entityText:ClearAllPoints()
    card.entityText:SetWidth(cardW - 10)
    card.entityText:SetJustifyH("CENTER")
    card.entityText:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 3)
    local filePath = entity.FilePath or ""
    local shortPath = filePath:match("[^\\]+$") or filePath
    card.entityText:SetText(GMCards.truncateText(shortPath, cardW - 10))
    card.entityText:SetTextColor(0.4, 0.4, 0.4, 1)

    card.additionalText:SetText("")

    card:SetScript("OnEnter", function(self)
        GMUtils.ShowTooltip(self, "ANCHOR_RIGHT", entity.tooltip or "No additional information.")
    end)

    card:SetScript("OnLeave", function()
        GMUtils.HideTooltip()
    end)

    -- Right-click context menu
    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("spellvisual", card, entity)
        end
    end)

    -- Add magnifier icon for spell visual preview
    GMCards.addMagnifierIcon(card, entity, i, "SpellVisual")

    -- Wire up card animations (model-based)
    if GMCards.setupCardVisuals then
        GMCards.setupCardVisuals(card, "SpellVisual")
    end
    if GMCards.setupHoverEffects then
        GMCards.setupHoverEffects(card)
    end
    if GMCards.setupBreathing then
        GMCards.setupBreathing(card, "GameObject")
    end
    if GMCards.setupClickFlash then
        GMCards.setupClickFlash(card)
    end

    return card
end

-- Card Spells module loaded