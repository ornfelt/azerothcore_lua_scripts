local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Verify namespace exists
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get module references
local GMCards = _G.GMCards
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Create Spell Card
function GMCards.createSpellCard(card, entity, index)
    local name, rank, icon = GetSpellInfo(entity.spellID)

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
    
    -- Update text positioning to account for icon
    card.nameText:ClearAllPoints()
    card.nameText:SetPoint("TOP", card.iconTexture, "BOTTOM", 0, -5)
    card.nameText:SetText(name .. (rank ~= "" and ("\n" .. rank) or ""))
    
    card.entityText:ClearAllPoints()
    card.entityText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    card.entityText:SetText("Spell ID: " .. entity.spellID)
    
    card.additionalText:ClearAllPoints()
    card.additionalText:SetPoint("BOTTOM", card.entityText, "TOP", 0, 2)
    card.additionalText:SetText("Icon: " .. (icon and "Yes" or "N/A"))

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

    return card
end

-- Create SpellVisual Card
function GMCards.createSpellVisualCard(card, entity, i)
    -- Create a background for better model visibility
    local modelBg = card:CreateTexture(nil, "BACKGROUND")
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(card:GetWidth() - 20, card:GetHeight() - 40)
    modelBg:SetPoint("CENTER", card, "CENTER", 0, 5)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    
    -- Set up the spell visual model with explicit parent
    local model = CreateFrame("DressUpModel", "modelSpellVisual" .. i, card)
    model:SetParent(card)  -- Explicitly set parent
    model:SetSize(card:GetWidth() - 30, card:GetHeight() - 50)
    model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)  -- Center on background
    model:SetFrameStrata("MEDIUM")  -- Same strata as card
    model:SetFrameLevel(card:GetFrameLevel() + 3)  -- Above background but reasonable
    model:ClearModel()
    
    -- Apply the spell visual model immediately
    local success = pcall(function()
        model:SetModel(entity.FilePath)
    end)
    
    if success then
        model:SetRotation(math.rad(30))
        model:SetPosition(0, 0, -1.0)  -- Spell visuals often need more distance
        model:Show()  -- Ensure visibility
        
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

    -- Update text positioning - compact layout with model taking most space
    card.nameText:SetText(entity.Name or "N/A")
    card.nameText:ClearAllPoints()
    card.nameText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    
    -- Hide other text elements to give more space to model
    card.entityText:SetText("")
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

    return card
end

-- Card Spells module loaded