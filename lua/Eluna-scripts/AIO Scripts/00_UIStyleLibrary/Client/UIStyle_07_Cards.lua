local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY CARDS MODULE
-- ===================================
-- Drop zones and card components for grid displays

--[[
Creates a styled drop zone for drag and drop operations
@param parent - Parent frame
@param width - Drop zone width
@param height - Drop zone height
@param options - Table with optional settings:
    - text: Display text (default "Drop items here")
    - icon: Icon texture path
    - instructions: Instruction text
    - onReceiveDrag: Callback function()
    - validationFunc: Function(cursorType, itemId, itemLink) returns isValid, reason
@return dropZone frame
]]
function CreateStyledDropZone(parent, width, height, options)
    options = options or {}
    
    local dropZone = CreateFrame("Frame", nil, parent)
    dropZone:SetSize(width, height)
    dropZone:EnableMouse(true)
    
    -- Background
    local bg = dropZone:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(UISTYLE_COLORS.OptionBg[1], UISTYLE_COLORS.OptionBg[2], UISTYLE_COLORS.OptionBg[3], 0.8)
    dropZone.bg = bg
    
    -- Create dashed border
    local borderFrame = CreateFrame("Frame", nil, dropZone)
    borderFrame:SetAllPoints()
    
    local borderPieces = {}
    local borderWidth = 2
    local dashSize = 10
    local gapSize = 6
    
    -- Function to create dashed border
    local function CreateDashedBorder(color)
        -- Clear existing pieces
        for _, piece in ipairs(borderPieces) do
            piece:Hide()
        end
        wipe(borderPieces)
        
        -- Top border
        local topDashes = math.floor(width / (dashSize + gapSize))
        for i = 0, topDashes do
            if i * (dashSize + gapSize) < width then
                local piece = borderFrame:CreateTexture(nil, "BORDER")
                piece:SetTexture("Interface\\Buttons\\WHITE8X8")
                piece:SetVertexColor(color[1], color[2], color[3], color[4] or 1)
                piece:SetWidth(math.min(dashSize, width - i * (dashSize + gapSize)))
                piece:SetHeight(borderWidth)
                piece:SetPoint("TOPLEFT", borderFrame, "TOPLEFT", i * (dashSize + gapSize), 0)
                table.insert(borderPieces, piece)
            end
        end
        
        -- Bottom border
        for i = 0, topDashes do
            if i * (dashSize + gapSize) < width then
                local piece = borderFrame:CreateTexture(nil, "BORDER")
                piece:SetTexture("Interface\\Buttons\\WHITE8X8")
                piece:SetVertexColor(color[1], color[2], color[3], color[4] or 1)
                piece:SetWidth(math.min(dashSize, width - i * (dashSize + gapSize)))
                piece:SetHeight(borderWidth)
                piece:SetPoint("BOTTOMLEFT", borderFrame, "BOTTOMLEFT", i * (dashSize + gapSize), 0)
                table.insert(borderPieces, piece)
            end
        end
        
        -- Left border
        local leftDashes = math.floor(height / (dashSize + gapSize))
        for i = 0, leftDashes do
            if i * (dashSize + gapSize) < height then
                local piece = borderFrame:CreateTexture(nil, "BORDER")
                piece:SetTexture("Interface\\Buttons\\WHITE8X8")
                piece:SetVertexColor(color[1], color[2], color[3], color[4] or 1)
                piece:SetWidth(borderWidth)
                piece:SetHeight(math.min(dashSize, height - i * (dashSize + gapSize)))
                piece:SetPoint("TOPLEFT", borderFrame, "TOPLEFT", 0, -i * (dashSize + gapSize))
                table.insert(borderPieces, piece)
            end
        end
        
        -- Right border
        for i = 0, leftDashes do
            if i * (dashSize + gapSize) < height then
                local piece = borderFrame:CreateTexture(nil, "BORDER")
                piece:SetTexture("Interface\\Buttons\\WHITE8X8")
                piece:SetVertexColor(color[1], color[2], color[3], color[4] or 1)
                piece:SetWidth(borderWidth)
                piece:SetHeight(math.min(dashSize, height - i * (dashSize + gapSize)))
                piece:SetPoint("TOPRIGHT", borderFrame, "TOPRIGHT", 0, -i * (dashSize + gapSize))
                table.insert(borderPieces, piece)
            end
        end
    end
    
    dropZone.borderPieces = borderPieces
    dropZone.CreateDashedBorder = CreateDashedBorder
    
    -- Create glow effect frame
    local glowFrame = CreateFrame("Frame", nil, dropZone)
    glowFrame:SetPoint("TOPLEFT", -5, 5)
    glowFrame:SetPoint("BOTTOMRIGHT", 5, -5)
    glowFrame:SetFrameLevel(dropZone:GetFrameLevel() - 1)
    glowFrame:Hide()
    
    -- Glow textures (using edge file to create a soft glow)
    local glowTextures = {}
    local glowSize = 5
    
    -- Top glow
    local topGlow = glowFrame:CreateTexture(nil, "BACKGROUND")
    topGlow:SetTexture("Interface\\Buttons\\WHITE8X8")
    topGlow:SetHeight(glowSize)
    topGlow:SetPoint("BOTTOMLEFT", glowFrame, "TOPLEFT", 0, -glowSize)
    topGlow:SetPoint("BOTTOMRIGHT", glowFrame, "TOPRIGHT", 0, -glowSize)
    topGlow:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 1, 1, 1, 0.3)
    table.insert(glowTextures, topGlow)
    
    -- Bottom glow
    local bottomGlow = glowFrame:CreateTexture(nil, "BACKGROUND")
    bottomGlow:SetTexture("Interface\\Buttons\\WHITE8X8")
    bottomGlow:SetHeight(glowSize)
    bottomGlow:SetPoint("TOPLEFT", glowFrame, "BOTTOMLEFT", 0, glowSize)
    bottomGlow:SetPoint("TOPRIGHT", glowFrame, "BOTTOMRIGHT", 0, glowSize)
    bottomGlow:SetGradientAlpha("VERTICAL", 1, 1, 1, 0.3, 0, 0, 0, 0)
    table.insert(glowTextures, bottomGlow)
    
    -- Left glow
    local leftGlow = glowFrame:CreateTexture(nil, "BACKGROUND")
    leftGlow:SetTexture("Interface\\Buttons\\WHITE8X8")
    leftGlow:SetWidth(glowSize)
    leftGlow:SetPoint("TOPRIGHT", glowFrame, "TOPLEFT", glowSize, 0)
    leftGlow:SetPoint("BOTTOMRIGHT", glowFrame, "BOTTOMLEFT", glowSize, 0)
    leftGlow:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 1, 1, 1, 0.3)
    table.insert(glowTextures, leftGlow)
    
    -- Right glow
    local rightGlow = glowFrame:CreateTexture(nil, "BACKGROUND")
    rightGlow:SetTexture("Interface\\Buttons\\WHITE8X8")
    rightGlow:SetWidth(glowSize)
    rightGlow:SetPoint("TOPLEFT", glowFrame, "TOPRIGHT", -glowSize, 0)
    rightGlow:SetPoint("BOTTOMLEFT", glowFrame, "BOTTOMRIGHT", -glowSize, 0)
    rightGlow:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 0.3, 0, 0, 0, 0)
    table.insert(glowTextures, rightGlow)
    
    dropZone.glowFrame = glowFrame
    dropZone.glowTextures = glowTextures
    
    -- Initial border
    CreateDashedBorder(UISTYLE_COLORS.BorderGrey)
    
    -- Icon
    if options.icon then
        local icon = dropZone:CreateTexture(nil, "ARTWORK")
        icon:SetSize(24, 24)
        icon:SetPoint("LEFT", 15, 0)
        icon:SetTexture(options.icon)
        icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        dropZone.icon = icon
    end
    
    -- Main text
    local text = dropZone:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    if options.icon then
        text:SetPoint("LEFT", dropZone.icon, "RIGHT", 8, 0)
    else
        text:SetPoint("CENTER", 0, 4)
    end
    text:SetText(options.text or "Drop items here")
    text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    dropZone.text = text
    
    -- Instructions
    if options.instructions then
        local instructions = dropZone:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        instructions:SetPoint("BOTTOM", 0, 4)
        instructions:SetText(options.instructions)
        instructions:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 0.7)
        dropZone.instructions = instructions
    end
    
    -- State colors
    local stateColors = {
        idle = { bg = {0.08, 0.08, 0.08, 0.8}, border = UISTYLE_COLORS.BorderGrey },
        hover = { bg = {0.1, 0.1, 0.12, 0.9}, border = {0.4, 0.4, 0.5, 1} },
        valid = { bg = {0.08, 0.12, 0.08, 0.9}, border = UISTYLE_COLORS.Green },
        invalid = { bg = {0.12, 0.08, 0.08, 0.9}, border = UISTYLE_COLORS.Red },
        validating = { bg = {0.08, 0.08, 0.10, 0.9}, border = UISTYLE_COLORS.Blue }
    }
    
    -- Animation frame for validating state
    local animFrame = CreateFrame("Frame")
    local animTime = 0
    local isValidating = false
    
    -- Update appearance function
    dropZone.SetState = function(self, state)
        local colors = stateColors[state] or stateColors.idle
        bg:SetVertexColor(colors.bg[1], colors.bg[2], colors.bg[3], colors.bg[4])
        CreateDashedBorder(colors.border)
        
        -- Show/hide glow based on state
        if state == "valid" then
            glowFrame:Show()
            -- Set glow color to match valid state
            for _, texture in ipairs(glowTextures) do
                texture:SetVertexColor(UISTYLE_COLORS.Green[1], UISTYLE_COLORS.Green[2], UISTYLE_COLORS.Green[3])
            end
        elseif state == "invalid" then
            glowFrame:Show()
            -- Set glow color to match invalid state
            for _, texture in ipairs(glowTextures) do
                texture:SetVertexColor(UISTYLE_COLORS.Red[1], UISTYLE_COLORS.Red[2], UISTYLE_COLORS.Red[3])
            end
        elseif state == "validating" then
            glowFrame:Show()
            -- Set glow color to match validating state
            for _, texture in ipairs(glowTextures) do
                texture:SetVertexColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
            end
        else
            glowFrame:Hide()
        end
        
        -- Start or stop animation for validating state
        if state == "validating" then
            isValidating = true
            animTime = 0
            animFrame:SetScript("OnUpdate", function(self, elapsed)
                animTime = animTime + elapsed
                -- Pulse the border opacity
                local alpha = 0.5 + 0.5 * math.sin(animTime * 4)
                for _, piece in ipairs(borderPieces) do
                    piece:SetAlpha(alpha)
                end
                -- Also pulse the glow
                local glowAlpha = 0.2 + 0.1 * math.sin(animTime * 4)
                for _, texture in ipairs(glowTextures) do
                    texture:SetAlpha(glowAlpha)
                end
            end)
        else
            isValidating = false
            animFrame:SetScript("OnUpdate", nil)
            -- Reset border opacity
            for _, piece in ipairs(borderPieces) do
                piece:SetAlpha(1)
            end
            -- Reset glow opacity
            for _, texture in ipairs(glowTextures) do
                texture:SetAlpha(0.3)
            end
        end
    end
    
    -- Scripts
    dropZone:SetScript("OnReceiveDrag", function(self)
        if options.onReceiveDrag then
            options.onReceiveDrag()
        end
        self:SetState("idle")
    end)
    
    -- Add OnMouseUp to support click-to-drop (when item is picked up and user clicks on dropzone)
    dropZone:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and CursorHasItem() then
            -- Same behavior as OnReceiveDrag
            if options.onReceiveDrag then
                options.onReceiveDrag()
            end
            self:SetState("idle")
        end
    end)
    
    dropZone:SetScript("OnEnter", function(self)
        if CursorHasItem() and options.validationFunc then
            local cursorType, itemId, itemLink = GetCursorInfo()
            local state, reason = options.validationFunc(cursorType, itemId, itemLink)
            
            -- Handle different return types
            if type(state) == "string" then
                -- State returned directly (e.g., "validating")
                self:SetState(state)
            elseif type(state) == "boolean" then
                -- Boolean returned (true/false)
                self:SetState(state and "valid" or "invalid")
            else
                -- Invalid return
                self:SetState("invalid")
            end
            
            if self.instructions and reason then
                self.instructions:SetText(reason)
            end
        else
            self:SetState("hover")
        end
    end)
    
    dropZone:SetScript("OnLeave", function(self)
        self:SetState("idle")
        if self.instructions and options.instructions then
            self.instructions:SetText(options.instructions)
        end
    end)
    
    return dropZone
end

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

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Cards"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Cards module loaded")
end