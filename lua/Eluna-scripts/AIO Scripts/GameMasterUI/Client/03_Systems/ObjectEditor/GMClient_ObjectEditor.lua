local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize ObjectEditor namespace
_G.ObjectEditor = _G.ObjectEditor or {}
local ObjectEditor = _G.ObjectEditor

-- Get references
local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Configuration
ObjectEditor.CONFIG = {
    MODAL_WIDTH = 380,  -- Reduced from 450 for more compact UI
    MODAL_HEIGHT = 630, -- Increased to accommodate new controls and delete button in third row
    SLIDER_WIDTH = 120, -- Reduced to fit within available space
    BUTTON_SIZE = 28,   -- Reduced from 32
    UPDATE_THROTTLE = 0.05, -- Throttle updates to 20 per second (50ms delay)
    MAX_RANGE = 100, -- Maximum range to edit objects
    MIN_SCALE = 0.1,
    MAX_SCALE = 10.0,
    POSITION_STEP = 0.5, -- Base step for position nudge buttons
    POSITION_SLIDER_RANGE = 10, -- Reduced from 100 for finer control
    POSITION_SLIDER_STEP = 0.001, -- Very fine step to allow modifier precision (0.001 allows Alt/Shift to work)
    ROTATION_STEP = 15, -- Base degrees for rotation buttons
    ROTATION_SLIDER_STEP = 1, -- Fine step for rotation slider
    SCALE_STEP = 0.1, -- Base step for scale
    SCALE_SLIDER_STEP = 0.001, -- Very fine step to allow modifier precision (0.001 allows Alt/Shift to work)

    -- World coordinate bounds for WoW 3.3.5 (covers all continents)
    -- Eastern Kingdoms, Kalimdor, Outland, and Northrend typically range from -17066 to +17066
    -- Using -20000 to +20000 for safety margin
    WORLD_BOUNDS = {
        x = { min = -20000, max = 20000 },
        y = { min = -20000, max = 20000 },
        z = { min = -5000, max = 5000 },  -- From deep underground to sky limit
    },
    
    -- Grid layout configuration
    GRID_PADDING = 8,  -- Reduced padding for more content space
    GRID_SPACING = 5,   -- Reduced spacing between grid items
    CONTROL_ROW_HEIGHT = 45,  -- Slightly reduced row height
    SECTION_SPACING = 12,  -- Reduced spacing between sections
    
    -- Column widths for consistent alignment (total must fit in ~360px)
    LABEL_WIDTH = 70,  -- Reduced from 80
    BUTTON_WIDTH = 20,  -- Reduced from 24
    VALUE_WIDTH = 50,  -- Reduced from 60
    SLIDER_COLUMN_WIDTH = 130,  -- Reduced from 160
}

-- Current editing state
ObjectEditor.currentObject = nil
ObjectEditor.originalState = nil
ObjectEditor.lastUpdate = 0
ObjectEditor.pendingUpdates = {}
ObjectEditor.positionMode = "relative" -- "relative" or "absolute"

-- ===================================
-- HELPER FUNCTIONS
-- ===================================

-- Get dynamic step based on modifier keys
function ObjectEditor.GetDynamicStep(baseStep)
    if IsAltKeyDown() then
        return baseStep * 0.01  -- Ultra fine
    elseif IsShiftKeyDown() then
        return baseStep * 0.1   -- Fine
    elseif IsControlKeyDown() then
        return baseStep * 10     -- Coarse
    else
        return baseStep          -- Normal
    end
end

-- ===================================
-- GRID LAYOUT HELPER FUNCTIONS
-- ===================================

-- Create a container frame with grid properties
function ObjectEditor.CreateGridContainer(parent, width, height, x, y)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width or parent:GetWidth(), height or 100)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", x or 0, y or 0)
    
    -- Add visual debugging border (can be removed later)
    if GMConfig and GMConfig.config and GMConfig.config.debug then
        local border = container:CreateTexture(nil, "BACKGROUND")
        border:SetAllPoints()
        border:SetTexture("Interface\\Buttons\\WHITE8X8")
        border:SetVertexColor(1, 1, 1, 0.05)
    end
    
    container.rows = {}
    container.currentRow = 0
    
    return container
end

-- Create a row within a grid container
function ObjectEditor.CreateGridRow(container, height)
    local CONFIG = ObjectEditor.CONFIG
    height = height or CONFIG.CONTROL_ROW_HEIGHT
    
    local row = CreateFrame("Frame", nil, container)
    row:SetHeight(height)
    row:SetPoint("TOPLEFT", container, "TOPLEFT", 0, -(container.currentRow * (height + CONFIG.GRID_SPACING)))
    row:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, -(container.currentRow * (height + CONFIG.GRID_SPACING)))
    
    container.currentRow = container.currentRow + 1
    table.insert(container.rows, row)
    
    row.elements = {}
    row.currentX = 0
    
    return row
end

-- Position an element in a grid row with column alignment
function ObjectEditor.PositionInRow(row, element, width, alignment)
    local CONFIG = ObjectEditor.CONFIG
    alignment = alignment or "LEFT"
    
    if alignment == "LEFT" then
        element:SetPoint("LEFT", row, "LEFT", row.currentX, 0)
    elseif alignment == "CENTER" then
        element:SetPoint("CENTER", row, "LEFT", row.currentX + (width / 2), 0)
    elseif alignment == "RIGHT" then
        element:SetPoint("RIGHT", row, "LEFT", row.currentX + width, 0)
    end
    
    row.currentX = row.currentX + width + CONFIG.GRID_SPACING
    table.insert(row.elements, element)
    
    return element
end

-- Create a standard control row (label, minus button, slider, plus button, value)
function ObjectEditor.CreateStandardControlRow(parent, label, sliderConfig, handlers)
    local CONFIG = ObjectEditor.CONFIG
    local row = ObjectEditor.CreateGridRow(parent, CONFIG.CONTROL_ROW_HEIGHT)
    
    -- Create background for the row
    local rowBg = row:CreateTexture(nil, "BACKGROUND")
    rowBg:SetAllPoints()
    rowBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    rowBg:SetVertexColor(0.15, 0.15, 0.15, 0.3)
    
    -- Label
    local labelText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelText:SetText(label)
    labelText:SetTextColor(0.7, 0.7, 0.7)  -- Gray color for axis/property labels
    labelText:SetJustifyH("LEFT")
    labelText:SetSize(CONFIG.LABEL_WIDTH - 10, 20) -- Slightly smaller to fit input
    ObjectEditor.PositionInRow(row, labelText, CONFIG.LABEL_WIDTH - 10, "LEFT")
    
    -- Minus button
    local minusBtn = CreateStyledButton(row, "-", CONFIG.BUTTON_WIDTH, CONFIG.BUTTON_WIDTH)
    ObjectEditor.PositionInRow(row, minusBtn, CONFIG.BUTTON_WIDTH, "CENTER")
    if handlers.onMinus then
        minusBtn:SetScript("OnClick", handlers.onMinus)
    end
    
    -- Slider container (for slider + labels)
    local sliderContainer = CreateFrame("Frame", nil, row)
    sliderContainer:SetSize(CONFIG.SLIDER_COLUMN_WIDTH - 20, CONFIG.CONTROL_ROW_HEIGHT) -- Smaller to fit input
    ObjectEditor.PositionInRow(row, sliderContainer, CONFIG.SLIDER_COLUMN_WIDTH - 20, "LEFT")
    
    -- Create slider
    local slider = CreateFrame("Slider", nil, sliderContainer)
    slider:SetSize(CONFIG.SLIDER_WIDTH - 20, 20) -- Slightly smaller
    slider:SetPoint("CENTER", sliderContainer, "CENTER", 0, 0)
    slider:SetOrientation("HORIZONTAL")
    slider:SetMinMaxValues(sliderConfig.min, sliderConfig.max)
    slider:SetValue(sliderConfig.default)
    slider:SetValueStep(sliderConfig.step)
    
    -- Slider background track
    local bg = slider:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0.2, 0.2, 0.2, 1)
    bg:SetHeight(4)
    bg:SetPoint("LEFT", slider, "LEFT", 0, 0)
    bg:SetPoint("RIGHT", slider, "RIGHT", 0, 0)
    
    -- Slider thumb
    local thumb = slider:CreateTexture(nil, "OVERLAY")
    thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
    thumb:SetVertexColor(0.8, 0.8, 0.8, 1)
    thumb:SetSize(12, 20)
    slider:SetThumbTexture(thumb)
    
    -- Min/Max labels
    local minLabel = sliderContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    minLabel:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 0, -2)
    minLabel:SetText(sliderConfig.minLabel or tostring(sliderConfig.min))
    minLabel:SetTextColor(0.5, 0.5, 0.5)
    
    local maxLabel = sliderContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    maxLabel:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 0, -2)
    maxLabel:SetText(sliderConfig.maxLabel or tostring(sliderConfig.max))
    maxLabel:SetTextColor(0.5, 0.5, 0.5)
    
    -- Current value display
    local valueText = sliderContainer:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    valueText:SetPoint("TOP", slider, "TOP", 0, 15)
    valueText:SetText(sliderConfig.defaultLabel or tostring(sliderConfig.default))
    
    -- Plus button
    local plusBtn = CreateStyledButton(row, "+", CONFIG.BUTTON_WIDTH, CONFIG.BUTTON_WIDTH)
    ObjectEditor.PositionInRow(row, plusBtn, CONFIG.BUTTON_WIDTH, "CENTER")
    if handlers.onPlus then
        plusBtn:SetScript("OnClick", handlers.onPlus)
    end
    
    -- Input field for direct value entry (always create for numeric controls)
    local inputBox = CreateFrame("EditBox", nil, row)
    inputBox:SetSize(60, 22)
    ObjectEditor.PositionInRow(row, inputBox, 65, "LEFT")
    inputBox:SetAutoFocus(false)
    inputBox:SetFontObject("GameFontHighlightSmall")
    inputBox:SetMaxLetters(10)
    inputBox:SetNumeric(false) -- Allow decimals and negative
    
    -- Create background
    local inputBg = inputBox:CreateTexture(nil, "BACKGROUND")
    inputBg:SetAllPoints()
    inputBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    inputBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    
    -- Create border
    local inputBorder = CreateFrame("Frame", nil, inputBox)
    inputBorder:SetPoint("TOPLEFT", -2, 2)
    inputBorder:SetPoint("BOTTOMRIGHT", 2, -2)
    inputBorder:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1
    })
    inputBorder:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
    
    -- Set initial text based on default value
    inputBox:SetText(tostring(sliderConfig.default or "0"))
    
    -- Real-time update as user types
    local lastValidValue = sliderConfig.default or 0
    local updateTimer = nil
    
    inputBox:SetScript("OnTextChanged", function(self, userInput)
        if userInput then  -- Only process if user typed (not programmatic change)
            local text = self:GetText()
            local value = tonumber(text)
            
            if value then
                -- Clamp value to min/max
                value = math.max(sliderConfig.min, math.min(sliderConfig.max, value))
                lastValidValue = value
                
                -- Cancel any pending update
                if updateTimer then
                    updateTimer:SetScript("OnUpdate", nil)
                end
                
                -- Create a small delay timer (50ms) to avoid too many updates while typing
                updateTimer = CreateFrame("Frame")
                local elapsed = 0
                updateTimer:SetScript("OnUpdate", function(timer, delta)
                    elapsed = elapsed + delta
                    if elapsed >= 0.05 then  -- 50ms delay
                        timer:SetScript("OnUpdate", nil)
                        updateTimer = nil
                        
                        -- Apply the value
                        if handlers.onDirectInput then
                            handlers.onDirectInput(value)
                        elseif handlers.onChange then
                            slider:SetValue(value)
                        end
                    end
                end)
            end
        end
    end)
    
    -- Handle Enter key to confirm and defocus
    inputBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    
    -- Handle Escape to revert to last valid value
    inputBox:SetScript("OnEscapePressed", function(self)
        self:SetText(tostring(lastValidValue))
        self:ClearFocus()
    end)
    
    -- Highlight text on focus
    inputBox:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)
    
    inputBox:SetScript("OnEditFocusLost", function(self)
        self:HighlightText(0, 0)
    end)
    
    -- Add tooltip
    inputBox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Direct Input", 1, 1, 1)
        GameTooltip:AddLine("Updates in real-time as you type", 0.7, 0.7, 0.7)
        GameTooltip:AddLine(string.format("Range: %s to %s", tostring(sliderConfig.min), tostring(sliderConfig.max)), 0.6, 0.6, 0.6)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Enter: Confirm", 0.5, 1, 0.5)
        GameTooltip:AddLine("Escape: Revert", 1, 0.5, 0.5)
        GameTooltip:Show()
    end)
    inputBox:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- World value display (for position controls) - place it under the slider
    local worldValueText = nil
    if sliderConfig.showWorldValue then
        worldValueText = sliderContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        worldValueText:SetText("(0.00)")
        worldValueText:SetTextColor(0.6, 0.6, 0.6)
        -- Position below the slider, centered
        worldValueText:SetPoint("TOP", slider, "BOTTOM", 0, -12)
    end
    
    -- Set up slider change handler
    if handlers.onChange then
        slider:SetScript("OnValueChanged", function(self, value)
            -- Don't update input box here - it will be handled by the specific control handlers
            -- This prevents the input box from showing slider offset values in relative mode
            handlers.onChange(self, value, valueText, worldValueText)
        end)
    end
    
    -- Add slider tooltip
    slider:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:AddLine("Drag to adjust", 1, 1, 1)
        GameTooltip:AddLine("Mouse wheel to step", 0.8, 0.8, 0.8)
        GameTooltip:AddLine(" ", 1, 1, 1)
        GameTooltip:AddLine("With Mouse Wheel:", 0.9, 0.9, 0.9)
        GameTooltip:AddLine("Alt+Scroll: Ultra-fine", 0.5, 0.8, 1.0)
        GameTooltip:AddLine("Shift+Scroll: Fine", 0.7, 0.9, 0.7)
        GameTooltip:AddLine("Ctrl+Scroll: Coarse", 1.0, 0.9, 0.5)
        GameTooltip:Show()
    end)
    slider:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Enable mouse wheel with modifier support
    slider:EnableMouseWheel(true)
    slider:SetScript("OnMouseWheel", function(self, delta)
        local current = self:GetValue()
        local baseStep = sliderConfig.wheelStep or sliderConfig.step
        -- Apply modifier keys to wheel step
        local step = ObjectEditor.GetDynamicStep(baseStep)
        -- Get actual min/max from slider (not closure variables, which don't update when mode changes)
        local minVal, maxVal = self:GetMinMaxValues()
        if delta > 0 then
            self:SetValue(math.min(current + step, maxVal))
        else
            self:SetValue(math.max(current - step, minVal))
        end
    end)
    
    -- Set tooltips with modifier key info
    if sliderConfig.tooltip then
        minusBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(sliderConfig.tooltip.minus.title, 1, 1, 1)
            GameTooltip:AddLine(sliderConfig.tooltip.minus.text, 0.7, 0.7, 0.7)
            GameTooltip:AddLine(" ", 1, 1, 1)
            GameTooltip:AddLine("Modifier Keys (Click/Scroll):", 0.8, 0.8, 0.8)
            GameTooltip:AddLine("Alt: Ultra-fine (0.01x)", 0.5, 0.8, 1.0)
            GameTooltip:AddLine("Shift: Fine (0.1x)", 0.7, 0.9, 0.7)
            GameTooltip:AddLine("Ctrl: Coarse (10x)", 1.0, 0.9, 0.5)
            GameTooltip:Show()
        end)
        minusBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        
        plusBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(sliderConfig.tooltip.plus.title, 1, 1, 1)
            GameTooltip:AddLine(sliderConfig.tooltip.plus.text, 0.7, 0.7, 0.7)
            GameTooltip:AddLine(" ", 1, 1, 1)
            GameTooltip:AddLine("Modifier Keys (Click/Scroll):", 0.8, 0.8, 0.8)
            GameTooltip:AddLine("Alt: Ultra-fine (0.01x)", 0.5, 0.8, 1.0)
            GameTooltip:AddLine("Shift: Fine (0.1x)", 0.7, 0.9, 0.7)
            GameTooltip:AddLine("Ctrl: Coarse (10x)", 1.0, 0.9, 0.5)
            GameTooltip:Show()
        end)
        plusBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    
    return {
        row = row,
        label = labelText,
        minusBtn = minusBtn,
        slider = slider,
        plusBtn = plusBtn,
        valueText = valueText,
        worldValueText = worldValueText,
        container = sliderContainer,
        inputBox = inputBox
    }
end

-- Create the main editor modal
function ObjectEditor.CreateEditorModal()
    local CONFIG = ObjectEditor.CONFIG
    
    -- Create main dialog frame directly on UIParent (no modal overlay)
    local dialog = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(CONFIG.MODAL_WIDTH, CONFIG.MODAL_HEIGHT)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("HIGH") -- Changed from FULLSCREEN_DIALOG to HIGH
    dialog:SetFrameLevel(10)
    dialog:SetMovable(true)
    dialog:EnableMouse(true)
    dialog:SetClampedToScreen(true) -- Keep within screen bounds
    dialog:Hide() -- Start hidden
    ObjectEditor.dialog = dialog
    ObjectEditor.modal = dialog -- Keep reference for compatibility
    
    -- Create global name for ESC support
    local modalName = "GMObjectEditorModal_" .. math.floor(GetTime() * 1000)
    _G[modalName] = dialog
    tinsert(UISpecialFrames, modalName)
    
    -- Add keyboard shortcuts
    dialog:EnableKeyboard(true)
    dialog:SetScript("OnKeyDown", function(self, key)
        if IsAltKeyDown() then
            if key == "LEFT" then
                dialog:ClearAllPoints()
                dialog:SetPoint("LEFT", UIParent, "LEFT", 50, 0)
            elseif key == "RIGHT" then
                dialog:ClearAllPoints()
                dialog:SetPoint("RIGHT", UIParent, "RIGHT", -50, 0)
            elseif key == "UP" or key == "DOWN" then
                dialog:ClearAllPoints()
                dialog:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            elseif key == "H" and IsAltKeyDown() then
                -- Toggle opacity using the button's logic (Alt+H)
                if dialog.opacityToggle then
                    dialog.opacityToggle:Click()
                else
                    -- Fallback if button doesn't exist
                    if dialog:GetAlpha() > 0.5 then
                        dialog:SetAlpha(0.3)
                    else
                        dialog:SetAlpha(1.0)
                    end
                end
            end
        elseif key == "ESCAPE" then
            ObjectEditor.CloseEditor()
        end
    end)
    
    -- Title bar
    local titleBar = CreateStyledFrame(dialog, UISTYLE_COLORS.SectionBg)
    titleBar:SetHeight(35)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    titleBar:EnableMouse(true) -- Enable mouse for dragging
    
    -- Make title bar draggable
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function()
        dialog:StartMoving()
    end)
    titleBar:SetScript("OnDragStop", function()
        dialog:StopMovingOrSizing()
    end)
    
    -- Title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("CENTER", titleBar, "CENTER", 0, 0)
    title:SetText("Object Editor")
    title:SetTextColor(1, 1, 1)  -- Ensure white text
    ObjectEditor.titleText = title
    
    -- Add drag hint text
    local dragHint = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dragHint:SetPoint("BOTTOM", titleBar, "BOTTOM", 0, 2)
    dragHint:SetText("(Drag to move)")
    dragHint:SetTextColor(0.5, 0.5, 0.5)
    dragHint:SetAlpha(0.7)
    
    -- Opacity toggle button
    local opacityToggle = CreateStyledButton(titleBar, "O", 20, 20)  -- Using simple O character
    opacityToggle:SetPoint("LEFT", titleBar, "LEFT", 10, 0)
    opacityToggle.isTransparent = false
    dialog.opacityToggle = opacityToggle  -- Store reference for keyboard shortcut
    
    -- Set up toggle functionality
    opacityToggle:SetScript("OnClick", function(self)
        if self.isTransparent then
            dialog:SetAlpha(1.0)  -- Full opacity
            self:SetText("O")  -- O for opaque/full
            self.isTransparent = false
        else
            dialog:SetAlpha(0.3)  -- Low opacity
            self:SetText("-")  -- Dash for transparent
            self.isTransparent = true
        end
    end)
    
    -- Add tooltip
    opacityToggle:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Toggle Opacity", 1, 1, 1)
        GameTooltip:AddLine("Click to toggle between full and low opacity", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("Hotkey: Alt+H", 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    opacityToggle:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Position buttons container
    local positionBtns = CreateFrame("Frame", nil, titleBar)
    positionBtns:SetSize(80, 24)
    positionBtns:SetPoint("RIGHT", titleBar, "RIGHT", -35, 0)
    
    -- Left side button
    local leftBtn = CreateStyledButton(positionBtns, "<", 20, 20)
    leftBtn:SetPoint("LEFT", positionBtns, "LEFT", 0, 0)
    leftBtn:SetScript("OnClick", function()
        dialog:ClearAllPoints()
        dialog:SetPoint("LEFT", UIParent, "LEFT", 50, 0)
    end)
    leftBtn:SetTooltip("Move to Left", "Position editor on left side of screen")
    
    -- Center button
    local centerBtn = CreateStyledButton(positionBtns, "O", 20, 20)
    centerBtn:SetPoint("CENTER", positionBtns, "CENTER", 0, 0)
    centerBtn:SetScript("OnClick", function()
        dialog:ClearAllPoints()
        dialog:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end)
    centerBtn:SetTooltip("Center", "Center editor on screen")
    
    -- Right side button
    local rightBtn = CreateStyledButton(positionBtns, ">", 20, 20)
    rightBtn:SetPoint("RIGHT", positionBtns, "RIGHT", 0, 0)
    rightBtn:SetScript("OnClick", function()
        dialog:ClearAllPoints()
        dialog:SetPoint("RIGHT", UIParent, "RIGHT", -50, 0)
    end)
    rightBtn:SetTooltip("Move to Right", "Position editor on right side of screen")
    
    -- Close button
    local closeBtn = CreateStyledButton(titleBar, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", titleBar, "TOPRIGHT", -5, -3)
    closeBtn:SetScript("OnClick", function()
        ObjectEditor.CloseEditor()
    end)
    
    -- Content area (now just a container, sections have their own backgrounds)
    local content = CreateFrame("Frame", nil, dialog)
    content:SetPoint("TOPLEFT", dialog, "TOPLEFT", 10, -45)
    content:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -10, 50)
    ObjectEditor.content = content
    
    -- Create control sections with grid layout
    local positionSection = ObjectEditor.CreatePositionControls(content)
    local rotationSection = ObjectEditor.CreateRotationControls(content)
    local scaleSection = ObjectEditor.CreateScaleControls(content)
    local actionsSection = ObjectEditor.CreateQuickActions(content)
    
    -- Store section references for potential future use
    ObjectEditor.sections = {
        position = positionSection,
        rotation = rotationSection,
        scale = scaleSection,
        actions = actionsSection
    }
    
    ObjectEditor.CreateBottomButtons(dialog)
    
    -- Dialog starts hidden, no need to hide again
    
    return dialog
end

-- Position controls section
function ObjectEditor.CreatePositionControls(parent)
    local CONFIG = ObjectEditor.CONFIG
    
    -- Section container with background (increased height for mode toggle)
    local sectionContainer = CreateStyledFrame(parent, UISTYLE_COLORS.SectionBg)
    sectionContainer:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -10)
    sectionContainer:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -10)
    sectionContainer:SetHeight((CONFIG.CONTROL_ROW_HEIGHT * 3) + (CONFIG.GRID_SPACING * 2) + 60) -- Increased for mode toggle
    
    -- Section header
    local posHeader = sectionContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    posHeader:SetPoint("TOPLEFT", sectionContainer, "TOPLEFT", CONFIG.GRID_PADDING, -CONFIG.GRID_PADDING)
    posHeader:SetText("Position")
    posHeader:SetTextColor(1, 1, 1)  -- White for section headers
    
    -- Mode toggle button
    local modeToggle = CreateStyledButton(sectionContainer, "Mode: Relative", 100, 20)
    modeToggle:SetPoint("TOPRIGHT", sectionContainer, "TOPRIGHT", -CONFIG.GRID_PADDING, -CONFIG.GRID_PADDING + 2)
    modeToggle:SetScript("OnClick", function(self)
        -- Toggle the mode
        if ObjectEditor.positionMode == "relative" then
            ObjectEditor.positionMode = "absolute"
            -- Update button text immediately
            if self.text then
                self.text:SetText("Mode: Absolute")
            end
        else
            ObjectEditor.positionMode = "relative"
            -- Update button text immediately
            if self.text then
                self.text:SetText("Mode: Relative")
            end
        end
        -- Update sliders based on new mode
        ObjectEditor.UpdatePositionSlidersForMode()
    end)
    modeToggle:SetTooltip("Position Mode", "Toggle between relative offset and absolute world coordinates")
    ObjectEditor.positionModeButton = modeToggle
    
    -- Create grid container for controls (adjusted position for mode toggle)
    local gridContainer = ObjectEditor.CreateGridContainer(
        sectionContainer,
        sectionContainer:GetWidth() - (CONFIG.GRID_PADDING * 2),
        (CONFIG.CONTROL_ROW_HEIGHT * 3) + (CONFIG.GRID_SPACING * 2),
        CONFIG.GRID_PADDING,
        -55  -- Increased from -30 to accommodate mode toggle
    )
    
    -- Store slider references
    ObjectEditor.positionSliders = {}
    
    -- Create X, Y, Z controls using the grid system
    local axes = {"X", "Y", "Z"}
    for i, axis in ipairs(axes) do
        local axisLower = axis:lower()
        
        -- Create a custom label with world coordinate display
        local labelText = axis .. ":"
        if ObjectEditor.currentObject then
            labelText = string.format("%s: %.1f", axis, ObjectEditor.currentObject[axisLower] or 0)
        end
        
        -- Determine slider config based on mode (will be updated dynamically)
        local sliderConfig = {
            min = -CONFIG.POSITION_SLIDER_RANGE,
            max = CONFIG.POSITION_SLIDER_RANGE,
            default = 0,
            step = CONFIG.POSITION_SLIDER_STEP,
            wheelStep = CONFIG.POSITION_STEP * 0.5,
            minLabel = "-" .. CONFIG.POSITION_SLIDER_RANGE,
            maxLabel = "+" .. CONFIG.POSITION_SLIDER_RANGE,
            defaultLabel = "+0.0",
            showWorldValue = true,  -- Enable input box
            tooltip = {
                minus = {
                    title = "Decrease " .. axis,
                    text = "Step: -" .. CONFIG.POSITION_STEP
                },
                plus = {
                    title = "Increase " .. axis,
                    text = "Step: +" .. CONFIG.POSITION_STEP
                }
            }
        }
        
        -- Create control row
        local controls = ObjectEditor.CreateStandardControlRow(
            gridContainer,
            labelText,  -- Use the formatted label with world coordinate
            sliderConfig,
            {
                onMinus = function()
                    local step = ObjectEditor.GetDynamicStep(CONFIG.POSITION_STEP)
                    if ObjectEditor.positionMode == "relative" then
                        ObjectEditor.NudgePosition(axisLower, -step)
                    else
                        -- In absolute mode, nudge the actual world position
                        local slider = ObjectEditor.positionSliders[axisLower].slider
                        if slider then
                            local currentValue = slider:GetValue()
                            -- Get actual min/max from slider (not stored properties, which don't update when mode changes)
                            local minVal, maxVal = slider:GetMinMaxValues()
                            slider:SetValue(math.max(minVal, currentValue - step))
                        end
                    end
                end,
                onPlus = function()
                    local step = ObjectEditor.GetDynamicStep(CONFIG.POSITION_STEP)
                    if ObjectEditor.positionMode == "relative" then
                        ObjectEditor.NudgePosition(axisLower, step)
                    else
                        -- In absolute mode, nudge the actual world position
                        local slider = ObjectEditor.positionSliders[axisLower].slider
                        if slider then
                            local currentValue = slider:GetValue()
                            -- Get actual min/max from slider (not stored properties, which don't update when mode changes)
                            local minVal, maxVal = slider:GetMinMaxValues()
                            slider:SetValue(math.min(maxVal, currentValue + step))
                        end
                    end
                end,
                onChange = function(slider, value, valueText, worldValueText)
                    if ObjectEditor.currentObject then
                        local worldPos
                        if ObjectEditor.positionMode == "relative" then
                            -- Relative mode: slider value is offset from current position
                            worldPos = ObjectEditor.currentObject[axisLower] + value
                            valueText:SetText(string.format("%+.1f", value))
                            
                            -- Update input box to show world position (not offset)
                            local inputBox = ObjectEditor.positionSliders[axisLower].inputBox
                            if inputBox and not inputBox:HasFocus() then
                                inputBox:SetText(string.format("%.2f", worldPos))
                            end
                        else
                            -- Absolute mode: slider value IS the world position
                            worldPos = value
                            valueText:SetText(string.format("%.1f", value))
                            
                            -- Update input box to match slider
                            local inputBox = ObjectEditor.positionSliders[axisLower].inputBox
                            if inputBox and not inputBox:HasFocus() then
                                inputBox:SetText(string.format("%.2f", worldPos))
                            end
                        end
                        
                        -- Update the label to show world coordinate
                        local labelControl = ObjectEditor.positionSliders[axisLower]
                        if labelControl and labelControl.label then
                            labelControl.label:SetText(string.format("%s: %.1f", axis:upper(), worldPos))
                        end
                        
                        if not ObjectEditor.isUpdating then
                            ObjectEditor.QueueUpdate("position", {
                                axis = axisLower,
                                value = worldPos
                            })
                        end
                    end
                end,
                onDirectInput = function(value)
                    if ObjectEditor.currentObject then
                        local worldPos = value  -- Input is always treated as world coordinate
                        
                        -- Update the object's actual position
                        ObjectEditor.currentObject[axisLower] = worldPos
                        
                        -- Update the label to show world coordinate
                        local labelControl = ObjectEditor.positionSliders[axisLower]
                        if labelControl and labelControl.label then
                            labelControl.label:SetText(string.format("%s: %.1f", axis:upper(), worldPos))
                        end
                        
                        -- Update slider based on mode
                        local slider = ObjectEditor.positionSliders[axisLower].slider
                        if slider then
                            ObjectEditor.isUpdating = true
                            if ObjectEditor.positionMode == "relative" then
                                -- In relative mode, slider shows 0 for current position
                                slider:SetValue(0)
                            else
                                -- In absolute mode, slider shows world position
                                slider:SetValue(worldPos)
                            end
                            ObjectEditor.isUpdating = false
                        end
                        
                        -- Queue update to server
                        if not ObjectEditor.isUpdating then
                            ObjectEditor.QueueUpdate("position", {
                                axis = axisLower,
                                value = worldPos
                            })
                        end
                    end
                end
            }
        )
        
        -- Store axis property for the slider
        controls.slider.axis = axisLower
        controls.slider.min = sliderConfig.min  -- Store min for access
        controls.slider.max = sliderConfig.max  -- Store max for access
        
        -- Store references
        ObjectEditor.positionSliders[axisLower] = {
            slider = controls.slider,
            label = controls.label,  -- Store the label for updating
            valueText = controls.worldValueText,
            offsetText = controls.valueText,
            minusBtn = controls.minusBtn,
            plusBtn = controls.plusBtn,
            container = controls.row,
            inputBox = controls.inputBox,
            axis = axis  -- Store the axis name for label updates
        }
    end
    
    return sectionContainer
end

-- Update position sliders when switching between relative and absolute mode
function ObjectEditor.UpdatePositionSlidersForMode()
    -- Early return if no object loaded
    if not ObjectEditor.currentObject then return end

    local CONFIG = ObjectEditor.CONFIG
    ObjectEditor.isUpdating = true

    for axis, controls in pairs(ObjectEditor.positionSliders) do
        local slider = controls.slider
        local worldPos = ObjectEditor.currentObject[axis] or 0

        -- Update the axis label with world coordinate
        if controls.label then
            controls.label:SetText(string.format("%s: %.1f", controls.axis or axis:upper(), worldPos))
        end

        if ObjectEditor.positionMode == "relative" then
            -- Relative mode: show offset from current position
            slider:SetMinMaxValues(-CONFIG.POSITION_SLIDER_RANGE, CONFIG.POSITION_SLIDER_RANGE)
            slider:SetValue(0) -- Reset to 0 offset
            slider:SetValueStep(CONFIG.POSITION_SLIDER_STEP)

            -- Update display values
            controls.offsetText:SetText("+0.0")

            -- Update input box to show WORLD position (not offset)
            if controls.inputBox then
                controls.inputBox:SetText(string.format("%.2f", worldPos))
            end
        else
            -- Absolute mode: show actual world coordinates
            local bounds = CONFIG.WORLD_BOUNDS[axis]
            slider:SetMinMaxValues(bounds.min, bounds.max)
            slider:SetValue(worldPos)
            slider:SetValueStep(0.001) -- Fine step to allow modifier precision

            -- Update display values
            controls.offsetText:SetText(string.format("%.1f", worldPos))

            -- Update input box
            if controls.inputBox then
                controls.inputBox:SetText(string.format("%.2f", worldPos))
            end
        end
    end

    ObjectEditor.isUpdating = false
end

-- Rotation controls section
function ObjectEditor.CreateRotationControls(parent)
    local CONFIG = ObjectEditor.CONFIG
    
    -- Section container with background
    local sectionContainer = CreateStyledFrame(parent, UISTYLE_COLORS.SectionBg)
    sectionContainer:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -((CONFIG.CONTROL_ROW_HEIGHT * 3) + (CONFIG.GRID_SPACING * 2) + 35 + CONFIG.SECTION_SPACING + 10))
    sectionContainer:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -((CONFIG.CONTROL_ROW_HEIGHT * 3) + (CONFIG.GRID_SPACING * 2) + 35 + CONFIG.SECTION_SPACING + 10))
    sectionContainer:SetHeight(CONFIG.CONTROL_ROW_HEIGHT + 35)
    
    -- Section header
    local rotHeader = sectionContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    rotHeader:SetPoint("TOPLEFT", sectionContainer, "TOPLEFT", CONFIG.GRID_PADDING, -CONFIG.GRID_PADDING)
    rotHeader:SetText("Rotation")
    rotHeader:SetTextColor(1, 1, 1)  -- White for section headers
    
    -- Create grid container for controls
    local gridContainer = ObjectEditor.CreateGridContainer(
        sectionContainer,
        sectionContainer:GetWidth() - (CONFIG.GRID_PADDING * 2),
        CONFIG.CONTROL_ROW_HEIGHT,
        CONFIG.GRID_PADDING,
        -30
    )
    
    -- Create rotation control row
    local controls = ObjectEditor.CreateStandardControlRow(
        gridContainer,
        "Angle:",
        {
            min = 0,
            max = 359,
            default = 0,
            step = CONFIG.ROTATION_SLIDER_STEP,
            wheelStep = 5,
            minLabel = "0°",
            maxLabel = "359°",
            defaultLabel = "0°",
            showWorldValue = false,
            tooltip = {
                minus = {
                    title = "Rotate Left",
                    text = "Step: -" .. CONFIG.ROTATION_STEP .. "°"
                },
                plus = {
                    title = "Rotate Right",
                    text = "Step: +" .. CONFIG.ROTATION_STEP .. "°"
                }
            }
        },
        {
            onMinus = function()
                local step = ObjectEditor.GetDynamicStep(CONFIG.ROTATION_STEP)
                ObjectEditor.RotateObject(-step)
            end,
            onPlus = function()
                local step = ObjectEditor.GetDynamicStep(CONFIG.ROTATION_STEP)
                ObjectEditor.RotateObject(step)
            end,
            onChange = function(slider, value, valueText)
                valueText:SetText(string.format("%d°", value))
                
                -- Update input box
                local controls = ObjectEditor.rotationControls
                if controls and controls.inputBox and not controls.inputBox:HasFocus() then
                    controls.inputBox:SetText(string.format("%d", value))
                end
                
                if not ObjectEditor.isUpdating then
                    -- Convert degrees to radians for server
                    local radians = math.rad(value)
                    ObjectEditor.QueueUpdate("rotation", radians)
                end
            end,
            onDirectInput = function(value)
                -- Ensure value wraps around 0-359
                value = value % 360
                if value < 0 then value = value + 360 end
                
                if ObjectEditor.rotationSlider then
                    ObjectEditor.rotationSlider:SetValue(value)
                end
            end
        }
    )
    
    -- Update button text for rotation controls
    controls.minusBtn:SetText("<<")
    controls.plusBtn:SetText(">>")
    
    -- Custom mouse wheel handler for wrapping with modifier support
    controls.slider:SetScript("OnMouseWheel", function(self, delta)
        local current = self:GetValue()
        local baseStep = 5  -- Base 5 degrees per wheel tick
        -- Apply modifier keys to wheel step
        local step = ObjectEditor.GetDynamicStep(baseStep)
        if delta > 0 then
            self:SetValue((current + step) % 360)
        else
            local newVal = current - step
            if newVal < 0 then newVal = newVal + 360 end
            self:SetValue(newVal)
        end
    end)
    
    -- Store references
    ObjectEditor.rotationSlider = controls.slider
    ObjectEditor.rotationValueText = controls.valueText
    ObjectEditor.rotationControls = controls  -- Store all controls including inputBox
    
    return sectionContainer
end

-- Scale controls section
function ObjectEditor.CreateScaleControls(parent)
    local CONFIG = ObjectEditor.CONFIG
    
    -- Calculate position based on previous sections
    local previousHeight = (CONFIG.CONTROL_ROW_HEIGHT * 3) + (CONFIG.GRID_SPACING * 2) + 35  -- Position section
    local rotationHeight = CONFIG.CONTROL_ROW_HEIGHT + 35  -- Rotation section
    local totalOffset = previousHeight + CONFIG.SECTION_SPACING + rotationHeight + CONFIG.SECTION_SPACING + 10
    
    -- Section container with background
    local sectionContainer = CreateStyledFrame(parent, UISTYLE_COLORS.SectionBg)
    sectionContainer:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -totalOffset)
    sectionContainer:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -totalOffset)
    sectionContainer:SetHeight(CONFIG.CONTROL_ROW_HEIGHT + 35)
    
    -- Section header
    local scaleHeader = sectionContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleHeader:SetPoint("TOPLEFT", sectionContainer, "TOPLEFT", CONFIG.GRID_PADDING, -CONFIG.GRID_PADDING)
    scaleHeader:SetText("Scale")
    scaleHeader:SetTextColor(1, 1, 1)  -- White for section headers
    
    -- Create grid container for controls
    local gridContainer = ObjectEditor.CreateGridContainer(
        sectionContainer,
        sectionContainer:GetWidth() - (CONFIG.GRID_PADDING * 2),
        CONFIG.CONTROL_ROW_HEIGHT,
        CONFIG.GRID_PADDING,
        -30
    )
    
    -- Create scale control row
    local controls = ObjectEditor.CreateStandardControlRow(
        gridContainer,
        "Size:",
        {
            min = CONFIG.MIN_SCALE,
            max = CONFIG.MAX_SCALE,
            default = 1.0,
            step = CONFIG.SCALE_SLIDER_STEP,
            wheelStep = 0.05,
            minLabel = string.format("%.1fx", CONFIG.MIN_SCALE),
            maxLabel = string.format("%.1fx", CONFIG.MAX_SCALE),
            defaultLabel = "1.00x",
            showWorldValue = false,
            tooltip = {
                minus = {
                    title = "Decrease Scale",
                    text = "Step: -" .. CONFIG.SCALE_STEP
                },
                plus = {
                    title = "Increase Scale",
                    text = "Step: +" .. CONFIG.SCALE_STEP
                }
            }
        },
        {
            onMinus = function()
                if ObjectEditor.scaleSlider then
                    local step = ObjectEditor.GetDynamicStep(CONFIG.SCALE_STEP)
                    local currentValue = ObjectEditor.scaleSlider:GetValue()
                    -- Get actual min/max from slider for consistency and safety
                    local minVal, maxVal = ObjectEditor.scaleSlider:GetMinMaxValues()
                    local newValue = math.max(minVal, currentValue - step)
                    ObjectEditor.scaleSlider:SetValue(newValue)
                end
            end,
            onPlus = function()
                if ObjectEditor.scaleSlider then
                    local step = ObjectEditor.GetDynamicStep(CONFIG.SCALE_STEP)
                    local currentValue = ObjectEditor.scaleSlider:GetValue()
                    -- Get actual min/max from slider for consistency and safety
                    local minVal, maxVal = ObjectEditor.scaleSlider:GetMinMaxValues()
                    local newValue = math.min(maxVal, currentValue + step)
                    ObjectEditor.scaleSlider:SetValue(newValue)
                end
            end,
            onChange = function(slider, value, valueText)
                valueText:SetText(string.format("%.2fx", value))
                
                -- Update input box
                local controls = ObjectEditor.scaleControls
                if controls and controls.inputBox and not controls.inputBox:HasFocus() then
                    controls.inputBox:SetText(string.format("%.2f", value))
                end
                
                if not ObjectEditor.isUpdating then
                    ObjectEditor.QueueUpdate("scale", value)
                end
            end,
            onDirectInput = function(value)
                -- Clamp scale value
                value = math.max(CONFIG.MIN_SCALE, math.min(CONFIG.MAX_SCALE, value))
                
                if ObjectEditor.scaleSlider then
                    ObjectEditor.scaleSlider:SetValue(value)
                end
            end
        }
    )
    
    -- Store references
    ObjectEditor.scaleSlider = controls.slider
    ObjectEditor.scaleValueText = controls.valueText
    ObjectEditor.scaleControls = controls  -- Store all controls including inputBox
    
    return sectionContainer
end

-- Quick action buttons
function ObjectEditor.CreateQuickActions(parent)
    local CONFIG = ObjectEditor.CONFIG
    
    -- Calculate position based on previous sections
    local previousHeight = (CONFIG.CONTROL_ROW_HEIGHT * 3) + (CONFIG.GRID_SPACING * 2) + 35  -- Position section
    local rotationHeight = CONFIG.CONTROL_ROW_HEIGHT + 35  -- Rotation section
    local scaleHeight = CONFIG.CONTROL_ROW_HEIGHT + 35  -- Scale section
    local totalOffset = previousHeight + (CONFIG.SECTION_SPACING * 3) + rotationHeight + scaleHeight + 10
    
    -- Section container with background (increased height for 2x3 grid - 2 columns, 3 rows)
    local sectionContainer = CreateStyledFrame(parent, UISTYLE_COLORS.SectionBg)
    sectionContainer:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -totalOffset)
    sectionContainer:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -totalOffset)
    sectionContainer:SetHeight(140)  -- Increased to accommodate 3 rows
    
    -- Section header
    local actionHeader = sectionContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    actionHeader:SetPoint("TOPLEFT", sectionContainer, "TOPLEFT", CONFIG.GRID_PADDING, -CONFIG.GRID_PADDING)
    actionHeader:SetText("Quick Actions")
    actionHeader:SetTextColor(1, 1, 1)  -- White for section headers
    
    -- Create grid container for 2x3 button layout (2 columns, 3 rows)
    local gridContainer = CreateFrame("Frame", nil, sectionContainer)
    gridContainer:SetPoint("TOPLEFT", sectionContainer, "TOPLEFT", CONFIG.GRID_PADDING, -35)
    gridContainer:SetPoint("TOPRIGHT", sectionContainer, "TOPRIGHT", -CONFIG.GRID_PADDING, -35)
    gridContainer:SetHeight(105)  -- Increased to fit three rows with spacing
    
    -- Calculate button dimensions for 2x3 grid (2 columns, 3 rows)
    -- Account for actual available width after padding
    local availableWidth = CONFIG.MODAL_WIDTH - (CONFIG.GRID_PADDING * 4) - 20  -- Extra safety margin
    local buttonWidth = math.floor((availableWidth - CONFIG.GRID_SPACING) / 2)  -- 2 columns
    local buttonHeight = 24
    
    -- Create buttons in 2x3 grid layout (2 columns, 3 rows)
    local buttons = {
        {
            text = "Copy My Pos",
            tooltip = { title = "Copy My Position", text = "Move object to your current position" },
            onClick = function() ObjectEditor.CopyPlayerPosition() end,
            row = 0, col = 0
        },
        {
            text = "Face Me",
            tooltip = { title = "Face Me", text = "Rotate object to face your position" },
            onClick = function() ObjectEditor.FacePlayer() end,
            row = 0, col = 1
        },
        {
            text = "Reset",
            tooltip = { title = "Reset", text = "Reset to original position and scale" },
            onClick = function() ObjectEditor.ResetToOriginal() end,
            row = 1, col = 0
        },
        {
            text = "Duplicate",
            tooltip = { title = "Duplicate", text = "Save current & create copy at this position" },
            onClick = function() ObjectEditor.DuplicateObject() end,
            row = 1, col = 1
        },
        {
            text = "Delete",
            tooltip = { title = "Delete Object", text = "Permanently remove this object from the world" },
            onClick = function() ObjectEditor.DeleteObject() end,
            row = 2, col = 0,
            color = {0.8, 0.2, 0.2}  -- Red tint for delete button
        },
        {
            text = "Teleport Away",
            tooltip = { title = "Teleport Away", text = "Teleport yourself away from the entity\nUseful if stuck inside it" },
            onClick = function() ObjectEditor.TeleportAway() end,
            row = 2, col = 1,
            color = {0.2, 0.6, 0.8}  -- Blue tint for teleport button
        }
    }
    
    -- Create and position buttons
    for _, btnData in ipairs(buttons) do
        local btn = CreateStyledButton(gridContainer, btnData.text, buttonWidth, buttonHeight)
        
        -- Apply custom color if specified (for delete button)
        if btnData.color then
            local r, g, b = unpack(btnData.color)
            -- Override the backdrop color for the delete button
            btn:SetBackdropColor(r, g, b, 1)
            
            -- Update hover effects with red tint
            btn:SetScript("OnEnter", function(self)
                self:SetBackdropColor(r * 1.2, g * 1.2, b * 1.2, 1)
            end)
            
            btn:SetScript("OnLeave", function(self)
                self:SetBackdropColor(r, g, b, 1)
            end)
        end
        
        -- Calculate position based on row and column with proper spacing
        local xPos = btnData.col * (buttonWidth + CONFIG.GRID_SPACING)
        local yPos = -btnData.row * (buttonHeight + CONFIG.GRID_SPACING)
        
        btn:SetPoint("TOPLEFT", gridContainer, "TOPLEFT", xPos, yPos)
        btn:SetScript("OnClick", btnData.onClick)
        btn:SetTooltip(btnData.tooltip.title, btnData.tooltip.text)
    end
    
    return sectionContainer
end

-- Bottom action buttons
function ObjectEditor.CreateBottomButtons(dialog)
    -- Button container
    local buttonContainer = CreateFrame("Frame", nil, dialog)
    buttonContainer:SetHeight(40)
    buttonContainer:SetPoint("BOTTOMLEFT", dialog, "BOTTOMLEFT", 10, 5)
    buttonContainer:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -10, 5)
    
    -- Save button
    local saveBtn = CreateStyledButton(buttonContainer, "Save Changes", 110, 30)
    saveBtn:SetPoint("LEFT", buttonContainer, "LEFT", 40, 0)
    saveBtn:SetScript("OnClick", function()
        ObjectEditor.SaveChanges()
    end)
    
    -- Cancel button
    local cancelBtn = CreateStyledButton(buttonContainer, "Cancel", 90, 30)
    cancelBtn:SetPoint("RIGHT", buttonContainer, "RIGHT", -40, 0)
    cancelBtn:SetScript("OnClick", function()
        ObjectEditor.CloseEditor(true) -- true = restore original
    end)
end

-- Update queueing system for throttling
function ObjectEditor.QueueUpdate(updateType, data)
    ObjectEditor.pendingUpdates[updateType] = data
    ObjectEditor.ProcessPendingUpdates()
end

-- Process pending updates with throttling
function ObjectEditor.ProcessPendingUpdates()
    local now = GetTime()
    if now - ObjectEditor.lastUpdate < ObjectEditor.CONFIG.UPDATE_THROTTLE then
        -- Schedule update if not already scheduled
        if not ObjectEditor.updateTimer then
            ObjectEditor.updateTimer = CreateFrame("Frame")
            ObjectEditor.updateTimer:SetScript("OnUpdate", function(self, elapsed)
                if GetTime() - ObjectEditor.lastUpdate >= ObjectEditor.CONFIG.UPDATE_THROTTLE then
                    self:SetScript("OnUpdate", nil)
                    ObjectEditor.updateTimer = nil
                    ObjectEditor.SendUpdates()
                end
            end)
        end
    else
        ObjectEditor.SendUpdates()
    end
end

-- Send all pending updates to server
function ObjectEditor.SendUpdates()
    if not ObjectEditor.currentObject or not next(ObjectEditor.pendingUpdates) then
        return
    end
    
    local updates = {}
    for updateType, data in pairs(ObjectEditor.pendingUpdates) do
        updates[updateType] = data
    end
    
    -- Sending updates
    
    -- Clear pending updates
    ObjectEditor.pendingUpdates = {}
    ObjectEditor.lastUpdate = GetTime()
    
    -- Send to server based on entity type
    if ObjectEditor.currentObject.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "updateCreature", ObjectEditor.currentObject.guid, updates)
    else
        -- Default to GameObject for backward compatibility
        AIO.Handle("GameMasterSystem", "updateGameObject", ObjectEditor.currentObject.guid, updates)
    end
end

-- Helper functions
function ObjectEditor.NudgePosition(axis, amount)
    if not ObjectEditor.currentObject then return end
    
    local slider = ObjectEditor.positionSliders[axis].slider
    if slider then
        local currentValue = slider:GetValue()
        slider:SetValue(currentValue + amount)
    end
end

function ObjectEditor.RotateObject(degrees)
    if not ObjectEditor.rotationSlider then return end
    
    local currentDegrees = ObjectEditor.rotationSlider:GetValue()
    local newDegrees = (currentDegrees + degrees) % 360
    if newDegrees < 0 then newDegrees = newDegrees + 360 end
    ObjectEditor.rotationSlider:SetValue(newDegrees)
end

function ObjectEditor.CopyPlayerPosition()
    if not ObjectEditor.currentObject then return end
    
    -- Check entity type and call appropriate handler
    if ObjectEditor.currentObject.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "copyPlayerPositionToCreature", ObjectEditor.currentObject.guid)
    else
        AIO.Handle("GameMasterSystem", "copyPlayerPositionToObject", ObjectEditor.currentObject.guid)
    end
end

function ObjectEditor.FacePlayer()
    if not ObjectEditor.currentObject then return end
    
    -- Check entity type and call appropriate handler
    if ObjectEditor.currentObject.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "faceCreatureToPlayer", ObjectEditor.currentObject.guid)
    else
        AIO.Handle("GameMasterSystem", "faceObjectToPlayer", ObjectEditor.currentObject.guid)
    end
end

function ObjectEditor.ResetToOriginal()
    if not ObjectEditor.originalState or not ObjectEditor.currentObject then return end
    
    -- Reset UI values
    ObjectEditor.LoadObjectData(ObjectEditor.originalState)
    
    -- Send reset to server based on entity type
    if ObjectEditor.currentObject.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "resetCreature", ObjectEditor.currentObject.guid, ObjectEditor.originalState)
    else
        AIO.Handle("GameMasterSystem", "resetGameObject", ObjectEditor.currentObject.guid, ObjectEditor.originalState)
    end
end

function ObjectEditor.DuplicateObject()
    if not ObjectEditor.currentObject then return end
    
    -- Send any pending updates first
    if next(ObjectEditor.pendingUpdates) then
        ObjectEditor.SendUpdates()
    end
    
    -- Check entity type and save/duplicate appropriately
    if ObjectEditor.currentObject.entityType == "Creature" then
        -- Use combined save and duplicate function for creatures
        -- This ensures proper sequencing and avoids timing issues
        AIO.Handle("GameMasterSystem", "duplicateAndSaveCreature", ObjectEditor.currentObject.guid)
    else
        -- Save current object to database
        AIO.Handle("GameMasterSystem", "saveGameObjectToDB", ObjectEditor.currentObject.guid)
        
        -- Duplicate at current edited position with current scale
        AIO.Handle("GameMasterSystem", "duplicateGameObjectAtPosition", 
            ObjectEditor.currentObject.entry,
            ObjectEditor.currentObject.x,
            ObjectEditor.currentObject.y,
            ObjectEditor.currentObject.z,
            ObjectEditor.currentObject.o,
            ObjectEditor.currentObject.scale or 1.0
        )
    end
end

function ObjectEditor.DeleteObject()
    if not ObjectEditor.currentObject then return end

    -- Check entity type and call appropriate delete handler
    if ObjectEditor.currentObject.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "deleteCreatureFromWorld", ObjectEditor.currentObject.guid)
    else
        -- Default to GameObject for backward compatibility
        AIO.Handle("GameMasterSystem", "deleteGameObjectFromWorld", ObjectEditor.currentObject.guid)
    end

    -- Show feedback
    if CreateStyledToast then
        local entityType = ObjectEditor.currentObject.entityType or "GameObject"
        CreateStyledToast(entityType .. " deleted from world!", 2, 0.5)
    end

    -- Close the editor
    ObjectEditor.CloseEditor()
end

function ObjectEditor.TeleportAway()
    if not ObjectEditor.currentObject then return end

    -- Send teleport request to server with entity position and scale
    AIO.Handle("GameMasterSystem", "teleportAwayFromEntity",
        ObjectEditor.currentObject.x,
        ObjectEditor.currentObject.y,
        ObjectEditor.currentObject.z,
        ObjectEditor.currentObject.scale or 1.0
    )

    -- Show feedback
    if CreateStyledToast then
        CreateStyledToast("Teleporting away from entity...", 2, 0.5)
    end
end

function ObjectEditor.SaveChanges()
    if not ObjectEditor.currentObject then return end
    
    -- Send any pending updates
    if next(ObjectEditor.pendingUpdates) then
        ObjectEditor.SendUpdates()
    end
    
    -- Save to database based on entity type
    if ObjectEditor.currentObject.entityType == "Creature" then
        AIO.Handle("GameMasterSystem", "saveCreatureToDB", ObjectEditor.currentObject.guid)
        
        -- Show feedback
        if CreateStyledToast then
            CreateStyledToast("Creature saved to database!", 2, 0.5)
        end
    else
        AIO.Handle("GameMasterSystem", "saveGameObjectToDB", ObjectEditor.currentObject.guid)
        
        -- Show feedback
        if CreateStyledToast then
            CreateStyledToast("GameObject saved to database!", 2, 0.5)
        end
    end
    
    ObjectEditor.CloseEditor()
end

-- Open the editor with object data
function ObjectEditor.OpenEditor(objectData)
    if not ObjectEditor.dialog then
        ObjectEditor.CreateEditorModal()
    end
    
    -- Close the GM menu if it's open
    if _G.GMData and _G.GMData.frames and _G.GMData.frames.mainFrame then
        if _G.GMData.frames.mainFrame:IsShown() then
            _G.GMData.frames.mainFrame:Hide()
            ObjectEditor.gmMenuWasOpen = true -- Remember it was open
        end
    end
    
    -- Close any open dropdown menus
    CloseDropDownMenus()
    
    -- Store current object data
    ObjectEditor.currentObject = objectData
    ObjectEditor.originalState = {
        x = objectData.x,
        y = objectData.y,
        z = objectData.z,
        o = objectData.o,
        scale = objectData.scale,
        guid = objectData.guid,
        entry = objectData.entry
    }
    
    -- Update title
    if ObjectEditor.titleText then
        local entityType = objectData.entityType or "GameObject"
        local displayText = entityType .. " Editor - ID: " .. (objectData.entry or "Unknown")
        -- Limit name display to avoid overflowing the title bar
        if objectData.name and string.len(objectData.name) <= 20 then
            displayText = entityType .. " - " .. objectData.name
        elseif objectData.name then
            displayText = entityType .. " - " .. string.sub(objectData.name, 1, 17) .. "..."
        end
        ObjectEditor.titleText:SetText(displayText)
    end
    
    -- Load values into UI
    ObjectEditor.LoadObjectData(objectData)

    -- Sync mode button text with current mode state
    if ObjectEditor.positionModeButton and ObjectEditor.positionModeButton.text then
        if ObjectEditor.positionMode == "relative" then
            ObjectEditor.positionModeButton.text:SetText("Mode: Relative")
        else
            ObjectEditor.positionModeButton.text:SetText("Mode: Absolute")
        end
    end

    -- Position dialog to the right side initially (so it doesn't block the object)
    if not ObjectEditor.hasBeenPositioned then
        ObjectEditor.dialog:ClearAllPoints()
        ObjectEditor.dialog:SetPoint("RIGHT", UIParent, "RIGHT", -50, 0)
        ObjectEditor.hasBeenPositioned = true
    end

    -- Show dialog
    ObjectEditor.dialog:Show()
end

-- Load object data into UI controls
function ObjectEditor.LoadObjectData(objectData)
    ObjectEditor.isUpdating = true
    
    -- Update all axis labels with world coordinates
    for axis, controls in pairs(ObjectEditor.positionSliders) do
        local worldPos = objectData[axis] or 0
        if controls.label then
            controls.label:SetText(string.format("%s: %.1f", controls.axis or axis:upper(), worldPos))
        end
    end
    
    -- Load position based on current mode
    if ObjectEditor.positionMode == "relative" then
        -- Reset position sliders to 0 (they show relative offset)
        for axis, controls in pairs(ObjectEditor.positionSliders) do
            local worldPos = objectData[axis] or 0
            controls.slider:SetValue(0)
            controls.offsetText:SetText("+0.0")
            -- Input box shows world position, not offset
            if controls.inputBox then
                controls.inputBox:SetText(string.format("%.2f", worldPos))
            end
        end
    else
        -- Absolute mode: set sliders to actual world coordinates
        for axis, controls in pairs(ObjectEditor.positionSliders) do
            local worldPos = objectData[axis] or 0
            controls.slider:SetValue(worldPos)
            controls.offsetText:SetText(string.format("%.1f", worldPos))
            if controls.inputBox then
                controls.inputBox:SetText(string.format("%.2f", worldPos))
            end
        end
    end
    
    -- Set rotation (convert from radians to degrees)
    if ObjectEditor.rotationSlider then
        local degrees = math.deg(objectData.o or 0)
        ObjectEditor.rotationSlider:SetValue(degrees)
    end
    
    -- Set scale
    if ObjectEditor.scaleSlider then
        ObjectEditor.scaleSlider:SetValue(objectData.scale or 1.0)
    end
    
    ObjectEditor.isUpdating = false
end

-- Close the editor
function ObjectEditor.CloseEditor(restore)
    -- Notify state machine of modal closing
    local StateMachine = _G.GMStateMachine
    if StateMachine then
        StateMachine.closeModal()
    end

    if restore and ObjectEditor.originalState then
        -- Restore original state on server
        AIO.Handle("GameMasterSystem", "resetGameObject", ObjectEditor.currentObject.guid, ObjectEditor.originalState)
    end

    -- Clear state
    ObjectEditor.currentObject = nil
    ObjectEditor.originalState = nil
    ObjectEditor.pendingUpdates = {}
    ObjectEditor.lastUpdate = 0

    -- Hide dialog
    if ObjectEditor.dialog then
        ObjectEditor.dialog:Hide()
    end

    -- Optionally reopen GM menu if it was open before
    if ObjectEditor.gmMenuWasOpen and _G.GMData and _G.GMData.frames and _G.GMData.frames.mainFrame then
        _G.GMData.frames.mainFrame:Show()
        ObjectEditor.gmMenuWasOpen = false
    end
end

-- Initialize on load
if not ObjectEditor.initialized then
    ObjectEditor.initialized = true
    -- Module loaded with step power control via modifier keys
    -- Alt+Click: 0.01x, Shift+Click: 0.1x, Ctrl+Click: 10x
end