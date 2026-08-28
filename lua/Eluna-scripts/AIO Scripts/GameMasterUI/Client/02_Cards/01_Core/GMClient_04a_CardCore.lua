local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- Get module references
local GMCards = _G.GMCards
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local GMData = _G.GMData
local GMModels = _G.GMModels

local cardFramePool = {}
local activeCards = {}

-- Constants for card creation
local CARD_CONFIG = {
    NUM_COLUMNS = 2,
    NUM_ROWS = 3,
    PADDING = 3,
    TEXT_AREA = {
        HEIGHT = 32,       -- Reserved height at bottom for name + subname
        BOTTOM_PAD = 3,    -- Padding from card bottom to first text line
        LINE_SPACING = 1,  -- Space between name and subname lines
    },
    MODEL_CONFIG = {
        DELAY = 0.01,
        POOL_SIZE = 15,
        ROTATION = 0.4,
        ZOOM = {
            MIN = 0.5,
            MAX = 2.0,
            STEP = 0.1,
            DEFAULT = 0.8,
        },
        POSITION = { X = 0, Y = 0, Z = 0 },
        SIZE = {
            WIDTH_OFFSET = 15,
            HEIGHT_FACTOR = 0.6,
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

-- truncateText, getQualityColor, addMagnifierIcon moved to GMClient_04a2_CardHelpers.lua

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

-- Helper function to calculate card dimensions
function GMCards.calculateCardDimensions(parent)
    local parentWidth = parent:GetWidth()
    local parentHeight = parent:GetHeight()

    -- Guard against zero-size parent (frame not yet laid out)
    if parentWidth < 1 or parentHeight < 1 then
        return 95, 115
    end

    -- Use responsive columns from config when available
    local numColumns = CARD_CONFIG.NUM_COLUMNS
    if GMConfig and GMConfig.config and GMConfig.config.getResponsiveColumns then
        numColumns = GMConfig.config.getResponsiveColumns(parentWidth)
    end

    -- Calculate card dimensions with safety margins
    local horizontalPadding = CARD_CONFIG.PADDING * (numColumns - 1)  -- Space between cards
    local horizontalMargin = 10  -- Small margin for edge spacing
    local verticalMargin = 8     -- Minimal top/bottom margin
    local safetyMargin = 4       -- Small safety buffer

    local cardWidth = (parentWidth - horizontalPadding - horizontalMargin * 2) / numColumns
    local cardHeight = (parentHeight - verticalMargin - safetyMargin) / CARD_CONFIG.NUM_ROWS

    -- Ensure minimum card size
    local MIN_CARD_WIDTH = 95   -- Increased for better visibility
    local MIN_CARD_HEIGHT = 145  -- Taller cards for 3-row grid with ID line
    
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

-- Helper function to set up card base
function GMCards.setupCard(card, parent, i, cardWidth, cardHeight)
    card:SetSize(cardWidth, cardHeight)
    card:EnableMouse(true)
    card:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    
    -- Use responsive columns for layout
    local numColumns = CARD_CONFIG.NUM_COLUMNS
    if GMConfig and GMConfig.config and GMConfig.config.getResponsiveColumns then
        numColumns = GMConfig.config.getResponsiveColumns(parent:GetWidth())
    end

    -- Calculate dynamic vertical spacing to evenly distribute cards
    local parentHeight = parent:GetHeight()
    local totalCardHeight = CARD_CONFIG.NUM_ROWS * cardHeight
    local availableVerticalSpace = parentHeight - totalCardHeight
    local verticalSpacing = math.max(CARD_CONFIG.PADDING, availableVerticalSpace / (CARD_CONFIG.NUM_ROWS + 1))

    -- Clamp spacing so rows never overflow the parent boundary
    local maxSafeSpacing = (parentHeight - totalCardHeight) / (CARD_CONFIG.NUM_ROWS + 1)
    if maxSafeSpacing < CARD_CONFIG.PADDING then
        maxSafeSpacing = CARD_CONFIG.PADDING
    end
    if verticalSpacing > maxSafeSpacing then
        verticalSpacing = maxSafeSpacing
    end

    -- Calculate position with dynamic vertical spacing
    local row = math.floor((i - 1) / numColumns)
    local col = (i - 1) % numColumns

    -- Calculate horizontal centering offset
    local parentWidth = parent:GetWidth()
    local totalGridWidth = numColumns * cardWidth + (numColumns - 1) * CARD_CONFIG.PADDING
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

    -- Reuse or create highlight texture (subtle hover tint)
    if not card.highlightTexture then
        card.highlightTexture = card:CreateTexture(nil, "HIGHLIGHT")
        card.highlightTexture:SetTexture("Interface\\Buttons\\WHITE8X8")
        card.highlightTexture:SetBlendMode("ADD")
        card.highlightTexture:SetAllPoints()
        card.highlightTexture:SetAlpha(0.08)
        card.highlightTexture:SetVertexColor(0.4, 0.6, 1.0)
    end
    
    -- Ensure the card is visible
    card:Show()
    
    if GMConfig.config.debug then
        -- Debug: Card position and size
    end
end

function GMCards.acquireCard(parent)
    local card = table.remove(cardFramePool)
    if card then
        card:SetParent(parent)
        card:Show()
    else
        card = CreateFrame("Button", nil, parent)
        card:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            tile = false,
            edgeSize = 1,
            insets = { left = 1, right = 1, top = 1, bottom = 1 }
        })

        card.nameText = card:CreateFontString(nil, "OVERLAY")
        card.nameText:SetFontObject("GameFontNormalSmall")
        card.nameText:SetPoint("TOP", card, "TOP", 0, -8)
        card.nameText:SetWordWrap(false)
        card.nameText:SetTextColor(1, 1, 1, 1)

        card.entityText = card:CreateFontString(nil, "OVERLAY")
        card.entityText:SetFontObject("GameFontNormalSmall")
        card.entityText:SetPoint("BOTTOM", card, "BOTTOM", 0, 8)
        card.entityText:SetWordWrap(false)
        card.entityText:SetTextColor(0.5, 0.5, 0.5, 1)

        card.additionalText = card:CreateFontString(nil, "OVERLAY")
        card.additionalText:SetFontObject("GameFontHighlightSmall")
        card.additionalText:SetPoint("BOTTOM", card.entityText, "TOP", 0, 5)
        card.additionalText:SetFont("Fonts\\ARIALN.TTF", 10)
        card.additionalText:SetWordWrap(false)
        card.additionalText:SetTextColor(0.5, 0.5, 0.5, 1)
    end

    card:SetBackdropColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 1)
    card:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    activeCards[card] = true
    return card
end

function GMCards.releaseCard(card)
    if not card then return end

    -- Clean up animations before hiding
    if GMCards.cleanupCardAnimations then
        GMCards.cleanupCardAnimations(card)
    end

    card:Hide()
    card:ClearAllPoints()
    card:SetScript("OnClick", nil)
    card:SetScript("OnEnter", nil)
    card:SetScript("OnLeave", nil)

    if card.nameText then
        card.nameText:SetText("")
        card.nameText:SetTextColor(1, 1, 1, 1)
    end
    if card.entityText then
        card.entityText:SetText("")
        card.entityText:SetTextColor(0.5, 0.5, 0.5, 1)
    end
    if card.additionalText then
        card.additionalText:SetText("")
        card.additionalText:SetTextColor(0.5, 0.5, 0.5, 1)
    end

    if card.model then
        ModelManager.releaseModel(card.model)
        card.model = nil
    end

    -- Clean up model frame used by NPC/GameObject cards
    if card.modelFrame then
        card.modelFrame:Hide()
        card.modelFrame:ClearModel()
        pcall(function() card.modelFrame:SetCreature(0) end)
        card.modelFrame:SetScript("OnShow", nil)
    end

    -- Hide model background texture (can't destroy textures, reuse on acquire)
    if card.modelBg then
        card.modelBg:Hide()
    end

    -- Hide magnifier button (reused on next acquire)
    if card.magnifierBtn then
        card.magnifierBtn:Hide()
    end

    -- Hide copyable ID fields (reused on next acquire)
    if card.idLabelL then card.idLabelL:Hide() end
    if card.idLabelR then card.idLabelR:Hide() end
    if card.idBoxL then
        card.idBoxL:ClearFocus()
        card.idBoxL:SetText("")
        card.idBoxL:Hide()
    end
    if card.idBoxR then
        card.idBoxR:ClearFocus()
        card.idBoxR:SetText("")
        card.idBoxR:Hide()
    end

    -- Hide icon textures from spell/item cards (reused on next acquire)
    if card.iconTexture then
        card.iconTexture:Hide()
    end
    if card.iconBackground then
        card.iconBackground:Hide()
    end
    if card.iconBg then
        card.iconBg:Hide()
    end
    if card.iconInnerBg then
        card.iconInnerBg:Hide()
    end

    -- Clear flags that persist through pooling
    card.preserveOnClear = nil

    -- Clear additional scripts
    card:SetScript("OnMouseUp", nil)

    activeCards[card] = nil
    table.insert(cardFramePool, card)
end

function GMCards.releaseAllCards()
    for card in pairs(activeCards) do
        GMCards.releaseCard(card)
    end
end

-- Main function to generate cards
function GMCards.generateCards(parent, data, type)
    if GMConfig.config.debug then
        -- Debug: Generating cards
    end
    
    GMCards.releaseAllCards()

    local cards = {}
    local cardWidth, cardHeight = GMCards.calculateCardDimensions(parent)
    -- Use responsive columns for maxVisible calculation
    local numColumns = CARD_CONFIG.NUM_COLUMNS
    if GMConfig and GMConfig.config and GMConfig.config.getResponsiveColumns then
        numColumns = GMConfig.config.getResponsiveColumns(parent:GetWidth())
    end
    local maxVisible = numColumns * CARD_CONFIG.NUM_ROWS

    for i = 1, math.min(#data, maxVisible) do
        local entity = data[i]

        local card = GMCards.acquireCard(parent)
        GMCards.setupCard(card, parent, i, cardWidth, cardHeight)

        card.nameText:SetWidth(cardWidth - 10)
        card.entityText:SetWidth(cardWidth - 10)
        card.additionalText:SetWidth(cardWidth - 10)

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

            -- Staggered entrance animation
            if GMCards.animateCardEntrance then
                GMCards.animateCardEntrance(card, i)
            end

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

    -- Apply selected animation to new cards
    if GMCards.AnimationData and GMCards.AnimationData.getSelectedAnimation() then
        GMCards.AnimationData.applyAnimationToAllCards()
    end

    return cards
end

-- Export functions and constants to namespace
GMCards.ModelManager = ModelManager
GMCards.CARD_CONFIG = CARD_CONFIG
GMCards.VIEW_CONFIG = VIEW_CONFIG
GMCards.getActiveCards = function() return activeCards end

-- Card Core module loaded