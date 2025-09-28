local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local PlayerInventory = _G.PlayerInventory
if not PlayerInventory then
    print("[ERROR] PlayerInventory namespace not found! Check load order.")
    return
end

local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig

-- ================================================================================
-- CORE CONTEXT MENU FUNCTIONS
-- This module provides core context menu functionality including:
-- - Input dialog creation
-- - Context menu positioning
-- - Menu lifecycle management
-- ================================================================================

-- Helper function to create input dialogs using UIStyleLibrary
function PlayerInventory.CreateInputDialog(options)
    local title = options.title or "Input"
    local message = options.message or "Enter value:"
    local placeholder = options.placeholder or ""
    local buttons = options.buttons or {}
    local numeric = options.numeric or false
    local maxLetters = options.maxLetters or 255
    
    -- Create modal overlay
    local overlay = CreateFrame("Frame", nil, UIParent)
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:SetFrameLevel(99)
    overlay:SetAllPoints(UIParent)
    overlay:EnableMouse(true)
    
    -- Semi-transparent background (WoW 3.3.5 compatible)
    overlay.bg = overlay:CreateTexture(nil, "BACKGROUND")
    overlay.bg:SetAllPoints()
    overlay.bg:SetTexture("Interface\\Buttons\\WHITE8X8")  -- Use white texture
    overlay.bg:SetVertexColor(0, 0, 0, 0.8)  -- Tint it black with alpha
    
    -- Create the dialog frame using UIStyleLibrary
    local dialog = CreateStyledFrame(overlay, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(options.width or 400, options.height or 180)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
    dialog:SetFrameLevel(100)
    
    -- Title
    local titleText = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOP", 0, -15)
    titleText:SetText(title)
    titleText:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    
    -- Message
    local messageText = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    messageText:SetPoint("TOP", titleText, "BOTTOM", 0, -10)
    messageText:SetText(message)
    messageText:SetTextColor(1, 1, 1)
    
    -- Create input box using UIStyleLibrary
    local inputBoxContainer = CreateStyledEditBox(dialog, 300, numeric, maxLetters)
    inputBoxContainer:SetPoint("TOP", messageText, "BOTTOM", 0, -15)
    
    -- Get the actual EditBox from the container
    local inputBox = inputBoxContainer.editBox
    inputBox:SetText(placeholder)
    inputBox:SetTextColor(0.7, 0.7, 0.7)
    
    inputBox:SetScript("OnEditFocusGained", function(self)
        if self:GetText() == placeholder then
            self:SetText("")
            self:SetTextColor(1, 1, 1)
        end
    end)
    
    inputBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            self:SetText(placeholder)
            self:SetTextColor(0.7, 0.7, 0.7)
        end
    end)
    
    -- Handle Enter key to submit
    inputBox:SetScript("OnEnterPressed", function(self)
        if buttons[1] and buttons[1].onClick then
            local inputText = self:GetText()
            if inputText == placeholder then
                inputText = ""
            end
            buttons[1].onClick(overlay, inputText)
        end
    end)
    
    -- Handle Escape key to cancel
    inputBox:SetScript("OnEscapePressed", function(self)
        overlay:Hide()
    end)
    
    -- Store input box references (both container and actual EditBox)
    dialog.inputBoxContainer = inputBoxContainer
    dialog.inputBox = inputBox
    
    -- Create buttons using UIStyleLibrary
    local buttonCount = #buttons
    local buttonWidth = 100
    local buttonSpacing = 10
    local totalWidth = (buttonWidth * buttonCount) + (buttonSpacing * (buttonCount - 1))
    local startX = -totalWidth / 2
    
    for i, buttonData in ipairs(buttons) do
        local btn = CreateStyledButton(dialog, buttonData.text, buttonWidth, 30)
        local xOffset = startX + ((i - 1) * (buttonWidth + buttonSpacing)) + (buttonWidth / 2)
        btn:SetPoint("CENTER", dialog, "BOTTOM", xOffset, 35)
        
        btn:SetScript("OnClick", function()
            local inputText = inputBox:GetText()
            if inputText == placeholder then
                inputText = ""
            end
            
            if buttonData.onClick then
                buttonData.onClick(overlay, inputText)
            else
                overlay:Hide()
            end
        end)
    end
    
    -- Click outside to close
    overlay:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            local focus = GetMouseFocus()
            if focus == self then
                self:Hide()
            end
        end
    end)
    
    -- Focus the input box when shown
    overlay:SetScript("OnShow", function(self)
        inputBox:SetFocus()
        inputBox:HighlightText()
    end)
    
    return overlay
end

-- Helper function to close any open context menu
function PlayerInventory.closeContextMenu()
    -- Close regular context menu
    if PlayerInventory.currentContextMenu and PlayerInventory.currentContextMenu:IsShown() then
        PlayerInventory.currentContextMenu:Hide()
        PlayerInventory.currentContextMenu = nil
    end
    -- Also close scrollable menu if open
    if PlayerInventory.currentScrollableMenu and PlayerInventory.currentScrollableMenu:IsShown() then
        PlayerInventory.currentScrollableMenu:Hide()
        PlayerInventory.currentScrollableMenu = nil
    end
end

-- Smart context menu positioning to avoid cutoff at modal edges
function PlayerInventory.showContextMenuWithSmartPositioning(menuItems, anchorFrame)
    -- Get screen dimensions
    local screenWidth = GetScreenWidth()
    local screenHeight = GetScreenHeight()
    
    -- Get modal boundaries if available
    local modal = PlayerInventory.currentModal
    local modalLeft, modalRight, modalTop, modalBottom
    if modal and modal.dialog then
        modalLeft = modal.dialog:GetLeft() or 0
        modalRight = modal.dialog:GetRight() or screenWidth
        modalTop = modal.dialog:GetTop() or screenHeight
        modalBottom = modal.dialog:GetBottom() or 0
    else
        -- Fallback to screen boundaries
        modalLeft = 0
        modalRight = screenWidth
        modalTop = screenHeight
        modalBottom = 0
    end
    
    -- Get anchor frame position and size
    local anchorLeft = anchorFrame:GetLeft() or 0
    local anchorRight = anchorFrame:GetRight() or 0
    local anchorTop = anchorFrame:GetTop() or 0
    local anchorBottom = anchorFrame:GetBottom() or 0
    
    -- Estimate menu size (approximate)
    local estimatedMenuWidth = 200  -- Standard menu width
    local estimatedMenuHeight = #menuItems * 20 + 20  -- Rough calculation
    
    -- Determine best position
    local xOffset = 0
    local yOffset = 0
    local anchorPoint = "TOPLEFT"
    local relativePoint = "TOPRIGHT"
    
    -- Check if menu would extend beyond modal's right edge
    if anchorRight + estimatedMenuWidth > modalRight then
        -- Position to the left of the anchor
        relativePoint = "TOPLEFT"
        anchorPoint = "TOPRIGHT"
        xOffset = -5  -- Small gap
    else
        -- Position to the right of the anchor (default)
        relativePoint = "TOPRIGHT"
        anchorPoint = "TOPLEFT"
        xOffset = 5   -- Small gap
    end
    
    -- Check if menu would extend beyond modal's bottom edge
    if anchorTop - estimatedMenuHeight < modalBottom then
        -- Position above the anchor
        anchorPoint = anchorPoint:gsub("TOP", "BOTTOM")
        relativePoint = relativePoint:gsub("TOP", "BOTTOM")
        yOffset = 5   -- Small gap upward
    else
        -- Position below the anchor (default)
        yOffset = -5  -- Small gap downward
    end
    
    -- Additional check: if positioning left would go beyond modal's left edge, force right
    if relativePoint == "TOPLEFT" and anchorLeft - estimatedMenuWidth < modalLeft then
        relativePoint = "TOPRIGHT"
        anchorPoint = "TOPLEFT"
        xOffset = 5
    end
    
    -- Debug output for troubleshooting
    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print(string.format("[PlayerInventory] Smart menu positioning: anchor=%s, relative=%s, offset=(%d,%d)", 
            anchorPoint, relativePoint, xOffset, yOffset))
        print(string.format("[PlayerInventory] Modal bounds: L=%d, R=%d, T=%d, B=%d", 
            modalLeft, modalRight, modalTop, modalBottom))
        print(string.format("[PlayerInventory] Anchor bounds: L=%d, R=%d, T=%d, B=%d", 
            anchorLeft, anchorRight, anchorTop, anchorBottom))
    end
    
    -- Fallback: if anchor frame has invalid position data, show at cursor
    if not anchorLeft or not anchorRight or not anchorTop or not anchorBottom or 
       anchorLeft == 0 and anchorRight == 0 and anchorTop == 0 and anchorBottom == 0 then
        if GMConfig and GMConfig.config and GMConfig.config.debug then
            print("[PlayerInventory] Invalid anchor position, falling back to cursor")
        end
        return ShowStyledEasyMenu(menuItems, "cursor")
    end
    
    -- Show menu with calculated position
    return ShowFullyStyledContextMenu(menuItems, anchorFrame, anchorPoint, relativePoint, xOffset, yOffset)
end

-- Export CreateInputDialog for backwards compatibility
_G.CreateInputDialog = PlayerInventory.CreateInputDialog

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[PlayerInventory] Context menu core module loaded")
end