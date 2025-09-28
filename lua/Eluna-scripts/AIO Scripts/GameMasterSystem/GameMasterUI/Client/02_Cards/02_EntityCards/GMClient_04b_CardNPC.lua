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

-- Create NPC Card
function GMCards.createNPCCard(card, entity, i)
    -- Create a background for better model visibility
    local modelBg = card:CreateTexture(nil, "BACKGROUND")
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(card:GetWidth() - 20, card:GetHeight() - 40)
    modelBg:SetPoint("CENTER", card, "CENTER", 0, 5)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    
    -- Create the model frame with explicit parent
    local model = CreateFrame("DressUpModel", "modelNpc" .. i, card)
    model:SetParent(card)  -- Explicitly set parent
    model:SetSize(card:GetWidth() - 30, card:GetHeight() - 50)
    model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)  -- Center on background
    model:SetFrameStrata("MEDIUM")  -- Same strata as card
    model:SetFrameLevel(card:GetFrameLevel() + 3)  -- Above background but reasonable
    model:ClearModel()
    
    -- Debug: Verify model parent
    if GMConfig.config.debug then
        -- Debug: NPC model parent
    end
    
    -- Apply the creature model immediately
    local success = pcall(function()
        model:SetCreature(entity.entry)
    end)
    
    if success then
        model:SetRotation(math.rad(30))
        model:SetPosition(0, 0, 0)  -- Start at center, adjust if needed
        model:Show()  -- Ensure model is visible
        
        -- Store reference
        card.modelFrame = model
        
        -- Debug: Confirm model is set
        if GMConfig.config.debug then
            -- Debug: NPC model created
        end
    else
        -- Fallback to show model ID as text if creature fails
        local errorMsg = model:CreateFontString(nil, "OVERLAY")
        errorMsg:SetFontObject("GameFontNormalLarge")
        errorMsg:SetPoint("CENTER")
        errorMsg:SetText("Model: " .. (entity.modelid[1] or entity.modelid))
        errorMsg:SetTextColor(1, 0.5, 0, 1)
        
        if GMConfig.config.debug then
            -- Debug: Failed to set creature
        end
    end

    -- Update text positioning - compact layout with model taking most space
    local name = entity.name .. (entity.subname and ("\n|cff888888" .. entity.subname .. "|r") or "")
    card.nameText:SetText(name)
    card.nameText:ClearAllPoints()
    card.nameText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    
    -- Hide other text elements to give more space to model
    card.entityText:SetText("")
    card.additionalText:SetText("")

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

    return card
end

-- Create GameObject Card
function GMCards.createGameObjectCard(card, entity, i)
    -- Create a background for better model visibility
    local modelBg = card:CreateTexture(nil, "BACKGROUND")
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(card:GetWidth() - 20, card:GetHeight() - 40)
    modelBg:SetPoint("CENTER", card, "CENTER", 0, 5)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    
    -- Create the model frame with explicit parent
    local model = CreateFrame("DressUpModel", "modelGob" .. i, card)
    model:SetParent(card)  -- Explicitly set parent
    model:SetSize(card:GetWidth() - 30, card:GetHeight() - 50)
    model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)  -- Center on background
    model:SetFrameStrata("MEDIUM")  -- Same strata as card
    model:SetFrameLevel(card:GetFrameLevel() + 3)  -- Above background but reasonable
    model:ClearModel()

    -- Apply the gameobject model immediately
    local modelPath = entity.modelName or "World\\Generic\\ActiveDoodads\\Chest02\\Chest02.mdx"
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
    
    -- Store reference
    card.modelFrame = model
    
    -- Update text positioning - compact layout with model taking most space
    card.nameText:SetText(entity.name)
    card.nameText:ClearAllPoints()
    card.nameText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    
    -- Hide other text elements to give more space to model
    card.entityText:SetText("")
    card.additionalText:SetText("")

    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("gameobject", card, entity)
        end
    end)

    GMCards.addMagnifierIcon(card, entity, i, "GameObject")

    return card
end

-- Card NPC module loaded