local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY DROP ZONE MODULE
-- ===================================
-- Drop zone component for drag and drop operations

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

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["DropZone"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: DropZone module loaded")
end
