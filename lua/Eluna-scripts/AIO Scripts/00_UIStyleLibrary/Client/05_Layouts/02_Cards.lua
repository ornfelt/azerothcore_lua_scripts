local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY CARDS MODULE
-- ===================================
-- Card and item row components for grid displays

--[[
Creates a styled card for grid displays (items, spells, etc.)
@param parent - Parent frame
@param size - Card size (width and height)
@param data - Table with card data:
    - id: Unique identifier
    - texture: Icon texture path
    - count: Stack count (optional)
    - quality: Item quality for border color (optional)
    - name: Tooltip name (optional)
    - onClick: Click handler function(self, button)
    - onEnter: Additional OnEnter handler
    - onLeave: Additional OnLeave handler
    - onMouseWheel: Mouse wheel handler function(self, delta)
@return card button
]]
function CreateStyledCard(parent, size, data)
    local card = CreateFrame("Button", nil, parent)
    card:SetSize(size, size)

    -- Background
    card:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    card:SetBackdropColor(UISTYLE_COLORS.OptionBg[1], UISTYLE_COLORS.OptionBg[2], UISTYLE_COLORS.OptionBg[3], 0.8) -- Slightly transparent to debug

    -- Set border color based on quality
    if data.quality and UISTYLE_COLORS[data.quality] then
        local color = UISTYLE_COLORS[data.quality]
        card:SetBackdropBorderColor(color[1], color[2], color[3], 1)
    else
        card:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    end

    -- Use SetNormalTexture like the working test button
    if data.texture and data.texture ~= "" then
        card:SetNormalTexture(data.texture)
        local normalTexture = card:GetNormalTexture()
        if normalTexture then
            normalTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            normalTexture:SetPoint("TOPLEFT", 3, -3)
            normalTexture:SetPoint("BOTTOMRIGHT", -3, 3)
        end
        card.icon = normalTexture
    else
        -- Default empty texture
        card:SetNormalTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        local normalTexture = card:GetNormalTexture()
        if normalTexture then
            normalTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            normalTexture:SetPoint("TOPLEFT", 3, -3)
            normalTexture:SetPoint("BOTTOMRIGHT", -3, 3)
        end
        card.icon = normalTexture
    end

    -- Count text
    if data.count and data.count > 1 then
        local count = card:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
        count:SetPoint("BOTTOMRIGHT", -2, 2)
        count:SetText(data.count > 999 and "*" or tostring(data.count))
        count:SetTextColor(1, 1, 1, 1)
        card.count = count
    end

    -- Highlight
    local highlight = card:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
    highlight:SetVertexColor(1, 1, 1, 0.2)
    highlight:SetPoint("TOPLEFT", 1, -1)
    highlight:SetPoint("BOTTOMRIGHT", -1, 1)
    card:SetHighlightTexture(highlight)

    -- Cooldown frame (optional, for future use)
    local cooldown = CreateFrame("Cooldown", nil, card, "CooldownFrameTemplate")
    cooldown:SetAllPoints(card.icon)
    cooldown:Hide()
    card.cooldown = cooldown

    -- Store data
    card.data = data

    -- Click handlers
    card:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    card:SetScript("OnClick", function(self, button)
        if self.data.onClick then
            self.data.onClick(self, button)
        end
    end)

    -- Tooltip
    card:SetScript("OnEnter", function(self)
        if self.data.name or self.data.link then
            -- Check parent frame strata for proper tooltip elevation
            local parent = self:GetParent()
            while parent and parent ~= UIParent do
                local parentStrata = parent:GetFrameStrata()
                if parentStrata == "TOOLTIP" or parentStrata == "FULLSCREEN_DIALOG" then
                    GameTooltip:SetFrameStrata("TOOLTIP")
                    GameTooltip:SetFrameLevel(parent:GetFrameLevel() + 10)
                    break
                end
                parent = parent:GetParent()
            end

            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if self.data.link then
                GameTooltip:SetHyperlink(self.data.link)
            else
                GameTooltip:SetText(self.data.name, 1, 1, 1, 1)
            end
            GameTooltip:Show()
        end

        if self.data.onEnter then
            self.data.onEnter(self)
        end
    end)

    card:SetScript("OnLeave", function(self)
        GameTooltip:Hide()

        if self.data.onLeave then
            self.data.onLeave(self)
        end
    end)

    -- Mouse wheel support
    if data.onMouseWheel then
        card:EnableMouseWheel(true)
        card:SetScript("OnMouseWheel", function(self, delta)
            if self.data.onMouseWheel then
                self.data.onMouseWheel(self, delta)
            end
        end)
    end

    -- Update function
    card.Update = function(self, newData)
        self.data = newData

        -- Update icon using SetNormalTexture
        if newData.texture then
            self:SetNormalTexture(newData.texture)
            local normalTexture = self:GetNormalTexture()
            if normalTexture then
                normalTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
                normalTexture:SetPoint("TOPLEFT", 3, -3)
                normalTexture:SetPoint("BOTTOMRIGHT", -3, 3)
                self.icon = normalTexture
            end
        end

        -- Update count
        if self.count then
            if newData.count and newData.count > 1 then
                self.count:SetText(newData.count > 999 and "*" or tostring(newData.count))
                self.count:Show()
            else
                self.count:Hide()
            end
        elseif newData.count and newData.count > 1 then
            local count = self:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
            count:SetPoint("BOTTOMRIGHT", -2, 2)
            count:SetText(newData.count > 999 and "*" or tostring(newData.count))
            count:SetTextColor(1, 1, 1, 1)
            self.count = count
        end

        -- Update border color
        if newData.quality and UISTYLE_COLORS[newData.quality] then
            local color = UISTYLE_COLORS[newData.quality]
            self:SetBackdropBorderColor(color[1], color[2], color[3], 1)
        else
            self:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
        end

        -- Update mouse wheel handler if provided
        if newData.onMouseWheel then
            self:EnableMouseWheel(true)
            self:SetScript("OnMouseWheel", function(self, delta)
                newData.onMouseWheel(self, delta)
            end)
        end
    end

    return card
end

--[[
Creates a styled item row with icon + name + subtext
@param parent - Parent frame
@param width - Row width
@param options - Table with optional settings:
    - iconSize: Icon size (default 36)
@return Row frame with methods:
    .SetItem(entry, quality) - sets icon/name/type from GetItemInfo
    .Clear() - hides content
]]
function CreateStyledItemRow(parent, width, options)
    options = options or {}
    local iconSize = options.iconSize or 36

    local row = CreateFrame("Frame", nil, parent)
    row:SetSize(width, iconSize + 8)

    -- Icon with quality border
    local iconFrame = CreateFrame("Frame", nil, row)
    iconFrame:SetSize(iconSize, iconSize)
    iconFrame:SetPoint("LEFT", 0, 0)
    iconFrame:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    iconFrame:SetBackdropColor(0, 0, 0, 0.6)
    iconFrame:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    local icon = iconFrame:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT", 2, -2)
    icon:SetPoint("BOTTOMRIGHT", -2, 2)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    row.icon = icon
    row.iconFrame = iconFrame

    -- Name
    local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetPoint("TOPLEFT", iconFrame, "TOPRIGHT", 8, -2)
    name:SetPoint("RIGHT", row, "RIGHT", -4, 0)
    name:SetJustifyH("LEFT")
    row.name = name

    -- Subtext
    local subtext = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    subtext:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
    subtext:SetPoint("RIGHT", row, "RIGHT", -4, 0)
    subtext:SetJustifyH("LEFT")
    subtext:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    row.subtext = subtext

    function row:SetItem(entry, quality)
        local itemName, _, _, _, _, itemClass, itemSubClass, _, _, itemTexture = GetItemInfo(entry)
        self.icon:SetTexture(itemTexture or GetItemIcon(entry) or "Interface\\Icons\\INV_Misc_QuestionMark")
        self.name:SetText(itemName or ("Item #" .. entry))

        local qColor = quality and (SHOP_QUALITY_COLORS and SHOP_QUALITY_COLORS[quality]) or nil
        if qColor then
            self.name:SetTextColor(qColor[1], qColor[2], qColor[3], 1)
            self.iconFrame:SetBackdropBorderColor(qColor[1], qColor[2], qColor[3], 1)
        else
            self.name:SetTextColor(1, 1, 1, 1)
            self.iconFrame:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
        end

        local typeStr = itemClass or ""
        if itemSubClass and itemSubClass ~= "" then
            typeStr = typeStr .. " - " .. itemSubClass
        end
        self.subtext:SetText(typeStr)
        self:Show()
    end

    function row:Clear()
        self.icon:SetTexture(nil)
        self.name:SetText("")
        self.subtext:SetText("")
        self.iconFrame:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
        self:Hide()
    end

    return row
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Cards"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: Cards module loaded")
end
