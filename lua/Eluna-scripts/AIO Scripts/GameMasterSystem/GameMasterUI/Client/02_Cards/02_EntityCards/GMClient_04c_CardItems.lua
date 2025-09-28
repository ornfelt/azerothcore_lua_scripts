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
local GMModels = _G.GMModels

-- Create Item Card
function GMCards.createItemCard(card, entity, index)
    if not entity or not entity.entry then
        -- Invalid entity data for item card
        return card
    end

    -- Pre-fetch item info
    local itemID = tonumber(entity.entry)
    local itemName, itemLink, itemQuality, itemLevel, _, _, _, _, itemEquipLoc, itemTexture = GetItemInfo(itemID)

    -- Determine item quality (with fallbacks)
    local quality = itemQuality
    if not quality then
        quality = tonumber(entity.quality)
        if not quality then
            quality = 1
        end
    end

    -- Ensure quality is in valid range (0-7)
    quality = math.max(0, math.min(quality, 7))

    -- Get quality colors with improved reliability
    local colors = GMCards.getQualityColor(quality)

    -- Apply card styling based on quality
    card:SetBackdropColor(colors.r * 0.2, colors.g * 0.2, colors.b * 0.2, 0.7)
    card:SetBackdropBorderColor(colors.r, colors.g, colors.b, 0.8)
    card.quality = quality

    -- Create icon background for better visibility with quality-colored border effect
    if not card.iconBg then
        card.iconBg = card:CreateTexture(nil, "BACKGROUND")
        card.iconBg:SetSize(44, 44)
        card.iconBg:SetPoint("TOP", card, "TOP", 0, -7)
        card.iconBg:SetTexture("Interface\\Buttons\\WHITE8X8")
        card.iconBg:SetVertexColor(colors.r * 0.3, colors.g * 0.3, colors.b * 0.3, 0.5)
    end
    
    -- Create darker inner background for icon
    if not card.iconInnerBg then
        card.iconInnerBg = card:CreateTexture(nil, "BORDER")
        card.iconInnerBg:SetSize(40, 40)
        card.iconInnerBg:SetPoint("CENTER", card.iconBg, "CENTER", 0, 0)
        card.iconInnerBg:SetTexture("Interface\\Buttons\\WHITE8X8")
        card.iconInnerBg:SetVertexColor(0.05, 0.05, 0.05, 0.95)
    end
    
    -- Create or update icon texture
    if not card.iconTexture then
        card.iconTexture = card:CreateTexture(nil, "ARTWORK")
        card.iconTexture:SetSize(40, 40)
        card.iconTexture:SetPoint("CENTER", card.iconBg, "CENTER", 0, 0)
    end

    -- Attempt to fetch the item icon
    local iconTexture = itemTexture or select(10, GetItemInfo(itemID)) or "Interface\\Icons\\INV_Misc_QuestionMark"
    card.iconTexture:SetTexture(iconTexture)
    card.iconTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92) -- Crop edges to prevent bleeding

    -- Update text fields with proper positioning
    card.nameText:ClearAllPoints()
    card.nameText:SetPoint("TOP", card.iconBg, "BOTTOM", 0, -5)
    card.nameText:SetText(itemName or ("Item #" .. itemID))
    card.nameText:SetTextColor(colors.r, colors.g, colors.b)

    card.entityText:ClearAllPoints()
    card.entityText:SetPoint("BOTTOM", card, "BOTTOM", 0, 5)
    card.entityText:SetText("ID: " .. itemID)

    card.additionalText:ClearAllPoints()
    card.additionalText:SetPoint("BOTTOM", card.entityText, "TOP", 0, 2)
    card.additionalText:SetText(string.format("iLvl: %d | Quality: %d", itemLevel or 0, quality))

    -- Handle equippable items with model preview (with safe comparison)
    local inventoryType = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(entity.inventoryType) or entity.inventoryType
    inventoryType = tonumber(inventoryType) or 0
    if inventoryType > 0 then
        -- Use small delay to prevent UI freeze
        if GMUtils.delayedExecution then
            GMUtils.delayedExecution(0.01 * math.min(index, 5), function()
                if not card:IsShown() or not entity or not entity.entry then
                    return
                end

                -- Check if item is equippable
                local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(entity.entry)
                if equipLoc and equipLoc ~= "" and equipLoc ~= "INVTYPE_BAG" then
                    -- Acquire model from pool (use GMModels if available)
                    local model = nil
                    if GMModels and GMModels.acquireModel then
                        model = GMModels.acquireModel()
                    else
                        model = GMCards.ModelManager.acquireModel()
                    end
                    
                    if model then
                        model:SetParent(card)  -- Explicitly set parent
                        model:SetSize(
                            card:GetWidth() - 30,
                            card:GetHeight() - 50
                        )
                        model:SetPoint("CENTER", card, "CENTER", 0, 5)
                        model:SetFrameStrata("MEDIUM")
                        model:SetFrameLevel(card:GetFrameLevel() + 3)
                        
                        -- Ensure model is naked before trying on the item
                        model:SetUnit("player")
                        model:Undress()
                        
                        -- Use full body camera view
                        model:SetCamera(1)
                        
                        -- Set rotation for better view
                        model:SetRotation(math.rad(-15))
                        
                        -- Configure camera target and distance based on slot type
                        local itemViewConfig = {
                            -- Head items - focus on head area
                            INVTYPE_HEAD = { targetZ = 1.7, distance = 1.5 },
                            INVTYPE_NECK = { targetZ = 1.5, distance = 1.5 },
                            
                            -- Upper body - focus on chest/shoulders
                            INVTYPE_SHOULDER = { targetZ = 1.4, distance = 2.0 },
                            INVTYPE_CHEST = { targetZ = 1.1, distance = 2.5 },
                            INVTYPE_ROBE = { targetZ = 0.9, distance = 3.5 },
                            INVTYPE_TABARD = { targetZ = 1.1, distance = 2.5 },
                            INVTYPE_SHIRT = { targetZ = 1.1, distance = 2.5 },
                            INVTYPE_CLOAK = { targetZ = 1.2, distance = 3.0 },
                            
                            -- Mid body - focus on waist/hands
                            INVTYPE_WAIST = { targetZ = 0.9, distance = 2.5 },
                            INVTYPE_WRIST = { targetZ = 0.8, distance = 2.0 },
                            INVTYPE_HAND = { targetZ = 0.8, distance = 2.0 },
                            
                            -- Lower body - focus on legs/feet
                            INVTYPE_LEGS = { targetZ = 0.5, distance = 3.5 },
                            INVTYPE_FEET = { targetZ = 0.1, distance = 3.5 },
                            
                            -- Weapons/held items - center view
                            INVTYPE_WEAPON = { targetZ = 1.0, distance = 3.0 },
                            INVTYPE_WEAPONMAINHAND = { targetZ = 1.0, distance = 3.0 },
                            INVTYPE_WEAPONOFFHAND = { targetZ = 1.0, distance = 3.0 },
                            INVTYPE_2HWEAPON = { targetZ = 1.0, distance = 3.5 },
                            INVTYPE_RANGED = { targetZ = 1.0, distance = 3.5 },
                            INVTYPE_RANGEDRIGHT = { targetZ = 1.0, distance = 3.5 },
                            INVTYPE_SHIELD = { targetZ = 1.0, distance = 2.5 },
                            INVTYPE_HOLDABLE = { targetZ = 0.9, distance = 2.0 },
                            
                            -- Small items - focus on hands/character
                            INVTYPE_FINGER = { targetZ = 0.8, distance = 1.5 },
                            INVTYPE_TRINKET = { targetZ = 1.0, distance = 2.5 },
                        }
                        
                        local config = itemViewConfig[equipLoc] or { targetZ = 1.0, distance = 2.5 }
                        
                        -- Try to use SetCameraTarget for precise focusing (may not work in all clients)
                        local cameraSuccess = pcall(function()
                            if model.SetCameraTarget then
                                model:SetCameraTarget(0, 0, config.targetZ)
                            end
                            if model.SetCameraDistance then
                                model:SetCameraDistance(config.distance)
                            end
                        end)
                        
                        -- Fallback to position adjustment if camera functions aren't available
                        if not cameraSuccess then
                            -- Calculate vertical offset to simulate camera targeting
                            local verticalOffset = (1.0 - config.targetZ) * 0.5
                            model:SetPosition(0, 0, verticalOffset)
                            -- Use scale as fallback for zoom
                            local scaleValue = 1.0 / (config.distance * 0.4)
                            model:SetModelScale(scaleValue)
                        end
                        
                        -- Try to apply item
                        local success = pcall(function()
                            model:TryOn(entity.entry)
                        end)
                        
                        if success then
                            card.modelFrame = model
                        else
                            if GMModels and GMModels.releaseModel then
                                GMModels.releaseModel(model)
                            else
                                GMCards.ModelManager.releaseModel(model)
                            end
                        end
                    end
                end
            end)
        end
    end

    -- Clean up handler
    card:SetScript("OnHide", function(self)
        if self.modelFrame then
            if GMModels and GMModels.releaseModel then
                GMModels.releaseModel(self.modelFrame)
            else
                GMCards.ModelManager.releaseModel(self.modelFrame)
            end
            self.modelFrame = nil
        end
    end)

    -- Tooltip handlers with quality-based highlighting
    card:SetScript("OnEnter", function(self)
        -- Show tooltip
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if itemLink then
            GameTooltip:SetHyperlink(itemLink)
        else
            GameTooltip:SetHyperlink("item:" .. itemID)
        end
        -- Manually set strata for item tooltips
        local ownerStrata = self:GetFrameStrata()
        if ownerStrata == "TOOLTIP" or ownerStrata == "FULLSCREEN_DIALOG" then
            GameTooltip:SetFrameStrata("TOOLTIP")
            GameTooltip:SetFrameLevel(self:GetFrameLevel() + 10)
        end
        GameTooltip:Show()
        
        -- Lighten card color on hover
        self:SetBackdropColor(colors.r * 0.3, colors.g * 0.3, colors.b * 0.3, 0.8)
    end)
    
    card:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        
        -- Return to normal color
        self:SetBackdropColor(colors.r * 0.2, colors.g * 0.2, colors.b * 0.2, 0.7)
    end)
    
    -- Add context menu
    card:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" and _G.GMMenus and _G.GMMenus.ShowContextMenu then
            _G.GMMenus.ShowContextMenu("item", self, entity)
        end
    end)

    -- Add magnifier icon
    GMCards.addMagnifierIcon(card, entity, index, "Item")

    return card
end

-- Card Items module loaded