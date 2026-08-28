local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- Get module references
local GMCards = _G.GMCards
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Text area height reserved at card bottom for name + subname + ID row
local TEXT_AREA_HEIGHT = 48

-- Create NPC Card
function GMCards.createNPCCard(card, entity, i)
    local cardW = card:GetWidth()
    local cardH = card:GetHeight()
    local textW = cardW - 10

    -- Reuse or create model background
    if not card.modelBg then
        card.modelBg = card:CreateTexture(nil, "BACKGROUND")
    end
    local modelBg = card.modelBg
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(cardW - 10, cardH - TEXT_AREA_HEIGHT - 4)
    modelBg:ClearAllPoints()
    modelBg:SetPoint("TOPLEFT", card, "TOPLEFT", 5, -2)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    modelBg:Show()

    -- Reuse or create model frame
    local model
    if card.modelFrame then
        model = card.modelFrame
        model:ClearModel()
        model:ClearAllPoints()
        model:SetParent(card)
    else
        model = CreateFrame("DressUpModel", nil, card)
        card.modelFrame = model
    end
    model:SetSize(cardW - 20, cardH - TEXT_AREA_HEIGHT - 14)
    model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)
    model:SetFrameStrata("MEDIUM")
    model:SetFrameLevel(card:GetFrameLevel() + 3)
    model:SetScript("OnShow", nil)

    -- Apply the creature model immediately
    local success = pcall(function()
        model:SetCreature(entity.entry)
    end)

    if success then
        model:SetRotation(math.rad(30))
        model:SetPosition(0, 0, 0)
        model:Show()
    else
        -- Fallback to show model ID as text if creature fails
        local errorMsg = model:CreateFontString(nil, "OVERLAY")
        errorMsg:SetFontObject("GameFontNormalLarge")
        errorMsg:SetPoint("CENTER")
        errorMsg:SetText("Model: " .. (entity.modelid[1] or entity.modelid))
        errorMsg:SetTextColor(1, 0.5, 0, 1)
    end

    -- Name text (top of text area)
    card.nameText:ClearAllPoints()
    card.nameText:SetWidth(textW)
    card.nameText:SetJustifyH("CENTER")
    card.nameText:SetText(GMCards.truncateText(entity.name, textW))
    card.nameText:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 32)

    -- Subname in entityText (middle line)
    card.entityText:ClearAllPoints()
    card.entityText:SetWidth(textW)
    card.entityText:SetJustifyH("CENTER")
    card.entityText:SetText(entity.subname and GMCards.truncateText(entity.subname, textW) or "")
    card.entityText:SetTextColor(0.5, 0.5, 0.5, 1)
    card.entityText:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 20)

    card.additionalText:SetText("")

    -- Copyable ID fields at bottom
    local modelId = entity.modelid[1] or entity.modelid
    GMCards.createCopyableIdLine(card, "Entry", entity.entry, "Model", modelId)

    card:SetScript("OnEnter", function(self)
        local lines = {
            entity.name,
            "Creature ID: " .. entity.entry,
            "Model ID: " .. (entity.modelid[1] or entity.modelid),
            "Name: " .. entity.name,
            "Subname: " .. (entity.subname or "")
        }
        GMUtils.ShowTooltip(self, "ANCHOR_RIGHT", unpack(lines))
    end)

    card:SetScript("OnLeave", function()
        GMUtils.HideTooltip()
    end)

    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("npc", card, entity)
        end
    end)

    GMCards.addMagnifierIcon(card, entity, i, "NPC")

    -- Wire up card animations
    if GMCards.setupCardVisuals then
        GMCards.setupCardVisuals(card, "NPC")
    end
    if GMCards.setupHoverEffects then
        GMCards.setupHoverEffects(card)
    end
    if GMCards.setupBreathing then
        GMCards.setupBreathing(card, "NPC")
    end
    if GMCards.setupClickFlash then
        GMCards.setupClickFlash(card)
    end

    return card
end

-- Create GameObject Card
function GMCards.createGameObjectCard(card, entity, i)
    local cardW = card:GetWidth()
    local cardH = card:GetHeight()
    local textW = cardW - 10

    -- Reuse or create model background
    if not card.modelBg then
        card.modelBg = card:CreateTexture(nil, "BACKGROUND")
    end
    local modelBg = card.modelBg
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(cardW - 10, cardH - TEXT_AREA_HEIGHT - 4)
    modelBg:ClearAllPoints()
    modelBg:SetPoint("TOPLEFT", card, "TOPLEFT", 5, -2)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    modelBg:Show()

    -- Reuse or create model frame
    local model
    if card.modelFrame then
        model = card.modelFrame
        model:Hide()
        pcall(function() model:SetCreature(0) end)
        model:ClearModel()
        model:ClearAllPoints()
        model:SetParent(card)
    else
        model = CreateFrame("DressUpModel", nil, card)
        card.modelFrame = model
    end
    model:SetSize(cardW - 20, cardH - TEXT_AREA_HEIGHT - 14)
    model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)
    model:SetFrameStrata("MEDIUM")
    model:SetFrameLevel(card:GetFrameLevel() + 3)
    model:ClearModel()

    -- Store the model path for restoration
    local modelPath = entity.modelName or "World\\Generic\\ActiveDoodads\\Chest02\\Chest02.mdx"
    model.modelPath = modelPath
    model.isGameObject = true
    
    -- Function to restore the model
    local function RestoreModel()
        if model.modelPath then
            model:ClearModel()
            local success = pcall(function()
                model:SetModel(model.modelPath)
            end)
            if success then
                model:SetRotation(math.rad(30))
                model:SetPosition(0, 0, -0.5)
            else
                -- Fallback model if original fails
                model:SetModel("World\\Generic\\ActiveDoodads\\Chest02\\Chest02.mdx")
            end
        end
    end

    -- Apply the gameobject model immediately
    local success, err = pcall(function()
        model:SetModel(modelPath)
    end)
    if not success then
        model:SetModel("World\\Generic\\ActiveDoodads\\Chest02\\Chest02.mdx")
        local errorMsg = model:CreateFontString(nil, "OVERLAY")
        errorMsg:SetFontObject("GameFontNormalLarge")
        errorMsg:SetPoint("CENTER")
        errorMsg:SetText("Model Error")
        errorMsg:SetTextColor(1, 0, 0, 1)
    end

    model:SetRotation(math.rad(30))
    model:SetPosition(0, 0, -0.5)  -- GameObjects often need slight offset
    model:Show()  -- Ensure visibility
    
    -- Add OnShow handler to restore model when shown
    model:SetScript("OnShow", RestoreModel)
    
    -- Name text (above ID line)
    card.nameText:ClearAllPoints()
    card.nameText:SetWidth(textW)
    card.nameText:SetJustifyH("CENTER")
    card.nameText:SetText(GMCards.truncateText(entity.name, textW))
    card.nameText:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 20)

    card.entityText:SetText("")
    card.additionalText:SetText("")

    -- Copyable ID fields at bottom
    local dispId = entity.displayid or "?"
    GMCards.createCopyableIdLine(card, "Entry", entity.entry, "Disp", dispId)

    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("gameobject", card, entity)
        end
    end)

    GMCards.addMagnifierIcon(card, entity, i, "GameObject")

    -- Wire up card animations
    if GMCards.setupCardVisuals then
        GMCards.setupCardVisuals(card, "GameObject")
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

-- Card NPC module loaded