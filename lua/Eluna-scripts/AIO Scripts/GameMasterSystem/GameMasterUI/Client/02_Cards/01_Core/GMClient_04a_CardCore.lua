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
local GMData = _G.GMData
local GMModels = _G.GMModels

-- Constants for card creation
local CARD_CONFIG = {
    NUM_COLUMNS = 5,
    NUM_ROWS = 3,
    PADDING = 3,  -- Reduced from 5 to give more space to cards
    MODEL_CONFIG = {
        DELAY = 0.01,
        POOL_SIZE = 15,
        ROTATION = 0.4,
        ZOOM = {
            MIN = 0.5,
            MAX = 2.0,
            STEP = 0.1,
            DEFAULT = 0.8,  -- Slightly increased for better visibility
        },
        POSITION = { X = 0, Y = 0, Z = 0 },
        SIZE = {
            WIDTH_OFFSET = 15,  -- Adjusted for optimal spacing
            HEIGHT_FACTOR = 0.6,  -- Increased to use more vertical space
        },
    },
}

local VIEW_CONFIG = {
    ICONS = {
        MAGNIFIER = "Interface\\Icons\\INV_Misc_Spyglass_03",
        INFO = "Interface\\Icons\\INV_Misc_Book_09",
    },
    TEXTURES = {
        BACKDROP = "Interface\\DialogFrame\\UI-DialogBox-Background",
        BORDER = "Interface\\Tooltips\\UI-Tooltip-Border",
    },
    SIZES = {
        ICON = 16,
        FULL_VIEW = 400,
        TILE = 16,
        INSETS = 5,
    },
}

-- Model management - use GMModels module if available, otherwise create minimal fallback
local ModelManager = {}

-- Fallback functions that redirect to GMModels
ModelManager.releaseModel = function(model)
    if GMModels and GMModels.releaseModel then
        GMModels.releaseModel(model)
    else
        -- Minimal fallback
        if model then
            model:Hide()
            model:ClearAllPoints()
            model:SetParent(nil)
        end
    end
end

ModelManager.acquireModel = function()
    if GMModels and GMModels.acquireModel then
        return GMModels.acquireModel()
    else
        -- Minimal fallback
        local model = CreateFrame("DressUpModel")
        model:SetUnit("player")
        model:Undress()
        model:Show()
        return model
    end
end

-- Helper function to get quality colors
function GMCards.getQualityColor(quality)
    if not quality or type(quality) ~= "number" then
        quality = 1 -- Default to common quality
    end

    -- Ensure quality is in valid range (0-7)
    quality = math.max(0, math.min(quality, 7))

    -- GetItemQualityColor sometimes returns nil, so add fallbacks
    local r, g, b = GetItemQualityColor(quality)
    if not r or not g or not b then
        -- Fallback quality colors if GetItemQualityColor fails
        local fallbackColors = {
            [0] = { r = 0.5, g = 0.5, b = 0.5 }, -- Poor (gray)
            [1] = { r = 1.0, g = 1.0, b = 1.0 }, -- Common (white)
            [2] = { r = 0.3, g = 0.8, b = 0.3 }, -- Uncommon (green)
            [3] = { r = 0.0, g = 0.4, b = 0.8 }, -- Rare (blue)
            [4] = { r = 0.7, g = 0.3, b = 1.0 }, -- Epic (purple)
            [5] = { r = 1.0, g = 0.5, b = 0.0 }, -- Legendary (orange)
            [6] = { r = 1.0, g = 0.0, b = 0.0 }, -- Artifact (red)
            [7] = { r = 1.0, g = 0.8, b = 0.0 }, -- Heirloom (gold)
        }
        return fallbackColors[quality]
    end

    return { r = r, g = g, b = b }
end

-- Helper function to calculate card dimensions
function GMCards.calculateCardDimensions(parent)
    local parentWidth = parent:GetWidth()
    local parentHeight = parent:GetHeight()
    
    -- Debug logging
    if GMConfig.config.debug then
        -- Debug: Parent dimensions and grid config
    end
    
    -- Calculate card dimensions with safety margins
    local horizontalPadding = CARD_CONFIG.PADDING * (CARD_CONFIG.NUM_COLUMNS - 1)  -- Space between cards
    local horizontalMargin = 10  -- Small margin for edge spacing
    local verticalMargin = 30    -- Reduced vertical margin since we have more control now
    local safetyMargin = 10      -- Smaller safety margin since layout is fixed
    
    local cardWidth = (parentWidth - horizontalPadding - horizontalMargin * 2) / CARD_CONFIG.NUM_COLUMNS
    local cardHeight = (parentHeight - verticalMargin - safetyMargin) / CARD_CONFIG.NUM_ROWS
    
    -- Ensure minimum card size
    local MIN_CARD_WIDTH = 95   -- Increased for better visibility
    local MIN_CARD_HEIGHT = 115  -- Increased to better fill space
    
    if cardWidth < MIN_CARD_WIDTH then
        cardWidth = MIN_CARD_WIDTH
    end
    
    if cardHeight < MIN_CARD_HEIGHT then
        cardHeight = MIN_CARD_HEIGHT
    end
    
    if GMConfig.config.debug then
        -- Debug: Final card size
    end
    
    return cardWidth, cardHeight
end

-- Helper function to add magnifier icon
function GMCards.addMagnifierIcon(card, entity, index, type)
    local button = CreateStyledButton(card, "", VIEW_CONFIG.SIZES.ICON, VIEW_CONFIG.SIZES.ICON)
    button:SetPoint("TOPRIGHT", card, "TOPRIGHT", -5, -5)
    button:SetNormalTexture(VIEW_CONFIG.ICONS.MAGNIFIER)
    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
    button:GetHighlightTexture():SetBlendMode("ADD")

    button:SetScript("OnClick", function()
        -- Use GMModels module for full view functionality
        if GMModels and GMModels.createFullViewFrame then
            local fullViewFrame = GMModels.createFullViewFrame(index)
            
            -- Close button (positioned in title bar area)
            local closeButton = CreateStyledButton(fullViewFrame, "X", 24, 24)
            closeButton:SetPoint("TOPRIGHT", fullViewFrame, "TOPRIGHT", -3, -3)
            closeButton:SetFrameLevel(fullViewFrame:GetFrameLevel() + 10)
            closeButton:SetScript("OnClick", function()
                -- Clean up any icon frames created for items
                local model = _G["FullModel" .. index]
                if model and model.iconFrame then
                    model.iconFrame:Hide()
                    model.iconFrame:SetParent(nil)
                    model.iconFrame = nil
                end
                -- Stop any OnUpdate scripts
                if model then
                    model:SetScript("OnUpdate", nil)
                end
                fullViewFrame:Hide()
            end)
            
            -- Reset view button (positioned in title bar area)
            local resetButton = CreateStyledButton(fullViewFrame, "Reset", 50, 20)
            resetButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", -3, 0)
            resetButton:SetFrameLevel(fullViewFrame:GetFrameLevel() + 10)
            resetButton:SetScript("OnClick", function()
                -- Find the model frame and reset it
                local model = _G["FullModel" .. index]
                if model and model.viewState and GMModels and GMModels.resetModelState then
                    GMModels.resetModelState(model, model.viewState)
                end
            end)
            resetButton:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
                GameTooltip:AddLine("Reset View", 1, 1, 1)
                GameTooltip:AddLine("Reset model position, rotation, and zoom", 0.7, 0.7, 0.7)
                GameTooltip:Show()
            end)
            resetButton:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            -- Use GMMenus for info button if available
            if GMMenus and GMMenus.createInfoButton then
                GMMenus.createInfoButton(fullViewFrame, entity, type)
            end
            
            -- Use GMModels for model view
            if GMModels and GMModels.createModelView then
                local model = GMModels.createModelView(fullViewFrame, entity, type, index)
                -- Store reference for reset button
                if model then
                    _G["FullModel" .. index] = model
                end
            end
        end
    end)

    return button
end

-- Helper function to set up card base
function GMCards.setupCard(card, parent, i, cardWidth, cardHeight)
    card:SetSize(cardWidth, cardHeight)
    card:EnableMouse(true)
    card:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    
    -- Calculate dynamic vertical spacing to evenly distribute cards
    local parentHeight = parent:GetHeight()
    local totalCardHeight = CARD_CONFIG.NUM_ROWS * cardHeight
    local safetyMargin = 10  -- Reduced safety margin since layout is more controlled
    local availableVerticalSpace = parentHeight - totalCardHeight - safetyMargin
    local verticalSpacing = math.max(CARD_CONFIG.PADDING, availableVerticalSpace / (CARD_CONFIG.NUM_ROWS + 1))
    
    -- Ensure cards don't overflow by limiting vertical spacing
    local maxSpacing = 20  -- Increased max spacing for better distribution
    if verticalSpacing > maxSpacing then
        verticalSpacing = maxSpacing
    end
    
    -- Calculate position with dynamic vertical spacing
    local row = math.floor((i - 1) / CARD_CONFIG.NUM_COLUMNS)
    local col = (i - 1) % CARD_CONFIG.NUM_COLUMNS
    
    -- Calculate horizontal centering offset
    local parentWidth = parent:GetWidth()
    local totalGridWidth = CARD_CONFIG.NUM_COLUMNS * cardWidth + (CARD_CONFIG.NUM_COLUMNS - 1) * CARD_CONFIG.PADDING
    local horizontalOffset = (parentWidth - totalGridWidth) / 2
    
    -- Ensure minimum offset to prevent negative positioning
    if horizontalOffset < CARD_CONFIG.PADDING then
        horizontalOffset = CARD_CONFIG.PADDING
    end
    
    card:SetPoint(
        "TOPLEFT",
        parent,
        "TOPLEFT",
        horizontalOffset + col * (cardWidth + CARD_CONFIG.PADDING),
        -(verticalSpacing + row * (cardHeight + verticalSpacing))
    )
    
    -- Set frame strata and level to ensure proper layering
    card:SetFrameStrata("MEDIUM")
    card:SetFrameLevel(parent:GetFrameLevel() + 1)

    -- Add highlight texture
    local highlight = card:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    highlight:SetBlendMode("ADD")
    highlight:SetAllPoints()
    
    -- Ensure the card is visible
    card:Show()
    
    if GMConfig.config.debug then
        -- Debug: Card position and size
    end
end

-- Main function to generate cards
function GMCards.generateCards(parent, data, type)
    if GMConfig.config.debug then
        -- Debug: Generating cards
    end
    
    local cards = {}
    local cardWidth, cardHeight = GMCards.calculateCardDimensions(parent)
    local maxVisible = CARD_CONFIG.NUM_COLUMNS * CARD_CONFIG.NUM_ROWS

    for i = 1, math.min(#data, maxVisible) do
        local entity = data[i]

        -- Create styled card as a button for better mouse handling
        local card = CreateFrame("Button", nil, parent)
        -- Apply dark theme styling manually
        card:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            tile = false,
            edgeSize = 1,
            insets = { left = 1, right = 1, top = 1, bottom = 1 }
        })
        card:SetBackdropColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 1)  -- DarkGrey
        card:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)  -- BorderGrey
        GMCards.setupCard(card, parent, i, cardWidth, cardHeight)
        
        -- Debug: Track parent hierarchy
        if GMConfig.config.debug then
            -- Debug: Parent chain tracking
        end

        -- Create text elements
        card.nameText = card:CreateFontString(nil, "OVERLAY")
        card.nameText:SetFontObject("GameFontNormalSmall")  -- Changed to smaller font
        card.nameText:SetPoint("TOP", card, "TOP", 0, -8)  -- Adjusted position
        card.nameText:SetWidth(cardWidth - 10)
        card.nameText:SetWordWrap(true)
        card.nameText:SetTextColor(1, 1, 1, 1)

        card.entityText = card:CreateFontString(nil, "OVERLAY")
        card.entityText:SetFontObject("GameFontNormalSmall")  -- Changed to smaller font
        card.entityText:SetPoint("BOTTOM", card, "BOTTOM", 0, 8)  -- Adjusted position
        card.entityText:SetWidth(cardWidth - 10)
        card.entityText:SetWordWrap(true)
        card.entityText:SetTextColor(0.5, 0.5, 0.5, 1)

        card.additionalText = card:CreateFontString(nil, "OVERLAY")
        card.additionalText:SetFontObject("GameFontHighlightSmall")  -- Changed to smaller font
        card.additionalText:SetPoint("BOTTOM", card.entityText, "TOP", 0, 5)
        card.additionalText:SetWidth(cardWidth - 10)
        card.additionalText:SetFont("Fonts\\ARIALN.TTF", 10)
        card.additionalText:SetTextColor(0.5, 0.5, 0.5, 1)

        -- Create specific card type
        
        if type == "NPC" and GMCards.createNPCCard then
            GMCards.createNPCCard(card, entity, i)
        elseif type == "GameObject" and GMCards.createGameObjectCard then
            GMCards.createGameObjectCard(card, entity, i)
        elseif type == "Spell" and GMCards.createSpellCard then
            GMCards.createSpellCard(card, entity, i)
        elseif type == "SpellVisual" and GMCards.createSpellVisualCard then
            GMCards.createSpellVisualCard(card, entity, i)
        elseif type == "Item" and GMCards.createItemCard then
            GMCards.createItemCard(card, entity, i)
        elseif type == "Player" and GMCards.createPlayerCard then
            GMCards.createPlayerCard(card, entity, i)
        else
            -- Fallback: show basic info
            card.nameText:SetText(entity.name or "Unknown")
            card.entityText:SetText("Type: " .. type)
        end

        -- Make sure the card is shown after creation
        if card then
            card:Show()
            
            -- Debug: Confirm card creation
            if GMConfig.config.debug then
                -- Debug: Card creation confirmed
            end
        end

        cards[i] = card
    end

    -- Make sure parent frame is shown
    if parent then
        parent:Show()
        
        if GMConfig.config.debug then
            -- Debug: Cards generated
        end
    end

    -- Initialize model pool via GMModels if available
    if GMModels and GMModels.initializeModelPool then
        GMModels.initializeModelPool()
    end

    return cards
end

-- Export functions and constants to namespace
GMCards.ModelManager = ModelManager
GMCards.CARD_CONFIG = CARD_CONFIG
GMCards.VIEW_CONFIG = VIEW_CONFIG

-- Card Core module loaded