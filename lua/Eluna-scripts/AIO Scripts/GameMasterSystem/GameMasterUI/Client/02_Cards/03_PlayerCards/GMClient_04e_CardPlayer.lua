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

-- Create Player Card
function GMCards.createPlayerCard(card, entity, i)
    -- Debug logging
    if GMConfig.config.debug then
        -- Debug: Creating player card
    end
    
    -- Create a background for better character visibility
    local modelBg = card:CreateTexture(nil, "BACKGROUND")
    modelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    modelBg:SetSize(card:GetWidth() - 20, card:GetHeight() - 40)
    modelBg:SetPoint("CENTER", card, "CENTER", 0, 5)
    modelBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    
    -- Try to create model, but don't fail if it doesn't work
    local modelSuccess = false
    local model = CreateFrame("PlayerModel", "modelPlayer" .. i, card)
    
    if model and entity.displayId then
        model:SetParent(card)
        model:SetSize(card:GetWidth() - 30, card:GetHeight() - 50)
        model:SetPoint("CENTER", modelBg, "CENTER", 0, 0)
        model:SetFrameStrata("MEDIUM")
        model:SetFrameLevel(card:GetFrameLevel() + 3)
        model:ClearModel()
        
        -- Try to set the display ID directly
        local success = pcall(function()
            model:SetDisplayInfo(entity.displayId)
        end)
        
        if success then
            model:SetRotation(math.rad(-15))
            model:SetPosition(0, 0, -0.1)
            model:Show()
            card.modelFrame = model
            modelSuccess = true
            
            if GMConfig.config.debug then
                -- Debug: Player model set successfully
            end
        else
            -- Hide model if it failed
            model:Hide()
            if GMConfig.config.debug then
                -- Debug: Failed to set player model
            end
        end
    end
    
    -- If model failed, show a class icon instead
    if not modelSuccess then
        local classIcon = card:CreateTexture(nil, "ARTWORK")
        classIcon:SetSize(48, 48)
        classIcon:SetPoint("CENTER", modelBg, "CENTER", 0, 10)
        
        -- Class icons mapping
        local classIcons = {
            ["Warrior"] = "Interface\\Icons\\INV_Sword_27",
            ["Paladin"] = "Interface\\Icons\\Spell_Holy_DevotionAura",
            ["Hunter"] = "Interface\\Icons\\INV_Weapon_Bow_07",
            ["Rogue"] = "Interface\\Icons\\INV_ThrowingKnife_04",
            ["Priest"] = "Interface\\Icons\\INV_Staff_30",
            ["Death Knight"] = "Interface\\Icons\\Spell_Deathknight_ClassIcon",
            ["Shaman"] = "Interface\\Icons\\Spell_Nature_BloodLust",
            ["Mage"] = "Interface\\Icons\\INV_Staff_13",
            ["Warlock"] = "Interface\\Icons\\Spell_Nature_FaerieFire",
            ["Druid"] = "Interface\\Icons\\Ability_Druid_Maul"
        }
        
        local iconPath = classIcons[entity.class] or "Interface\\Icons\\INV_Misc_QuestionMark"
        classIcon:SetTexture(iconPath)
    end
    
    -- Player info display
    local playerInfo = string.format("|cff%s%s|r", entity.classColor or "FFFFFF", entity.name)
    card.nameText:SetText(playerInfo)
    card.nameText:ClearAllPoints()
    card.nameText:SetPoint("TOP", card, "TOP", 0, -5)
    
    -- Level and class info
    local levelClassText = string.format("Level %d %s %s", entity.level or 1, entity.race or "", entity.class or "")
    card.entityText:SetText(levelClassText)
    card.entityText:ClearAllPoints()
    card.entityText:SetPoint("TOP", card.nameText, "BOTTOM", 0, -2)
    
    -- Location info
    local locationText = entity.zone or "Unknown Zone"
    card.additionalText:SetText(locationText)
    card.additionalText:ClearAllPoints()
    card.additionalText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    
    -- Tooltip
    card:SetScript("OnEnter", function(self)
        local lines = {
            entity.name,
            "Level " .. (entity.level or 1) .. " " .. (entity.race or "") .. " " .. (entity.class or ""),
            "Guild: " .. (entity.guildName or "No Guild"),
            "Zone: " .. (entity.zone or "Unknown"),
            "Gold: " .. (entity.gold or 0) .. "g",
            " ",
            "Right-click for management options"
        }
        GMUtils.ShowTooltip(self, "ANCHOR_RIGHT", unpack(lines))
    end)
    
    card:SetScript("OnLeave", function()
        GMUtils.HideTooltip()
    end)
    
    -- Right-click menu
    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("player", card, entity)
        end
    end)
    
    -- Add online status indicator
    local statusIndicator = card:CreateTexture(nil, "OVERLAY")
    statusIndicator:SetSize(10, 10)
    statusIndicator:SetPoint("TOPRIGHT", card, "TOPRIGHT", -5, -5)
    if entity.online then
        statusIndicator:SetTexture("Interface\\FriendsFrame\\StatusIcon-Online")
    else
        statusIndicator:SetTexture("Interface\\FriendsFrame\\StatusIcon-Offline")
        
        -- Add offline overlay to dim the card
        local offlineOverlay = card:CreateTexture(nil, "OVERLAY")
        offlineOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")
        offlineOverlay:SetVertexColor(0, 0, 0, 0.4)
        offlineOverlay:SetAllPoints(card)
        
        -- Add "Last Seen" text for offline players
        if entity.lastSeen then
            local lastSeenText = card:CreateFontString(nil, "OVERLAY")
            lastSeenText:SetFontObject("GameFontNormalSmall")
            lastSeenText:SetPoint("BOTTOM", card.additionalText, "TOP", 0, 2)
            lastSeenText:SetText(entity.lastSeen)
            lastSeenText:SetTextColor(0.6, 0.6, 0.6, 1)
        end
    end
    
    return card
end

-- Card Player module loaded