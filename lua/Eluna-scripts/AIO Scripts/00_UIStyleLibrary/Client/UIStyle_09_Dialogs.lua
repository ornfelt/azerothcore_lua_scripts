local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY DIALOGS MODULE
-- ===================================
-- Modal dialogs and overlay components

-- Global dialog manager to prevent multiple dialogs
local activeDialog = nil

--[[
Creates a modal overlay that blocks input
@param parent - Parent frame (defaults to UIParent)
@param alpha - Overlay transparency (optional, deprecated)
@return Overlay frame
]]
function CreateModalOverlay(parent, alpha) --dont use this somewhat broken
    parent = parent or UIParent
    -- alpha = alpha or 0.8  -- Commented out, no longer using alpha
    
    -- Create borderless frame
    local overlay = CreateFrame("Frame", nil, parent)
    overlay:SetAllPoints()
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:EnableMouse(true)
    
    -- Block keyboard events from propagating through the modal
    overlay:EnableKeyboard(true)
    overlay:SetScript("OnKeyDown", function(self, key)
        -- The modal overlay blocks all keyboard input
        -- Child frames (dialog) will handle specific keys
        return true
    end)
    
    -- Dark background removed - no more overlay darkening
    -- local bg = overlay:CreateTexture(nil, "BACKGROUND")
    -- bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    -- bg:SetVertexColor(0, 0, 0, alpha)
    -- bg:SetAllPoints()
    
    return overlay
end

--[[
Creates a styled modal dialog with customizable buttons
@param options - Dialog configuration:
  - title: Dialog title text
  - message: Main message text
  - buttons: Table of button configs {text="OK", callback=function() end}
  - width: Optional width (defaults to 400)
  - height: Optional height (auto-sizes based on content)
  - parent: Optional parent (defaults to UIParent)
  - closeOnEscape: Optional boolean (defaults to true)
@return Dialog frame with methods:
  - .Show() - Show the dialog
  - .Hide() - Hide the dialog
  - .SetMessage(text) - Update message text
]]
function CreateStyledDialog(options)
    options = options or {}
    local parent = options.parent or UIParent
    
    -- Create fullscreen background overlay
    local overlay = CreateFrame("Frame", nil, parent)
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:SetAllPoints(parent)
    overlay:EnableMouse(true)  -- Enable mouse to block clicks
    overlay:Hide()
    
    -- Dark background removed - no more overlay darkening
    -- local overlayBg = overlay:CreateTexture(nil, "BACKGROUND")
    -- overlayBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    -- overlayBg:SetVertexColor(0, 0, 0, 0.8)
    -- overlayBg:SetAllPoints()
    
    -- Dialog frame
    local dialog = CreateStyledFrame(overlay, UISTYLE_COLORS.DarkGrey)
    dialog:SetFrameStrata("TOOLTIP")  -- Use TOOLTIP strata to ensure it's on top
    dialog:SetWidth(options.width or 400)
    dialog:SetPoint("CENTER")
    
    -- Title bar
    local titleBar = CreateFrame("Frame", nil, dialog)
    titleBar:SetHeight(30)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    titleBar:SetFrameLevel(dialog:GetFrameLevel() + 1)
    
    titleBar:SetBackdrop(UISTYLE_BACKDROPS.Solid)
    titleBar:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
    
    -- Title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER")
    title:SetText(options.title or "Dialog")
    title:SetTextColor(1, 1, 1, 1)
    
    -- Close button
    local closeButton = CreateStyledButton(titleBar, "X", 20, 20)
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Message area
    local messageFrame = CreateFrame("Frame", nil, dialog)
    messageFrame:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", UISTYLE_PADDING, -UISTYLE_PADDING)
    messageFrame:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", -UISTYLE_PADDING, -UISTYLE_PADDING)
    
    local message = messageFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    message:SetPoint("TOPLEFT")
    message:SetPoint("TOPRIGHT")
    message:SetJustifyH("LEFT")
    message:SetJustifyV("TOP")
    message:SetText(options.message or "")
    message:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    
    -- Button area
    local buttonArea = CreateFrame("Frame", nil, dialog)
    buttonArea:SetHeight(40)
    buttonArea:SetPoint("BOTTOMLEFT", UISTYLE_PADDING, UISTYLE_PADDING)
    buttonArea:SetPoint("BOTTOMRIGHT", -UISTYLE_PADDING, UISTYLE_PADDING)
    
    -- Create buttons
    local buttons = {}
    local buttonConfigs = options.buttons or {{text = "OK", callback = function() dialog:Hide() end}}
    local buttonWidth = 100
    local buttonSpacing = 10
    local totalButtonWidth = (#buttonConfigs * buttonWidth) + ((#buttonConfigs - 1) * buttonSpacing)
    
    -- Create a container frame for centering buttons
    local buttonContainer = CreateFrame("Frame", nil, buttonArea)
    buttonContainer:SetSize(totalButtonWidth, 30)
    buttonContainer:SetPoint("CENTER", buttonArea, "CENTER", 0, 0)
    
    for i, config in ipairs(buttonConfigs) do
        local button = CreateStyledButton(buttonContainer, config.text, buttonWidth, 30)
        
        if i == 1 then
            button:SetPoint("LEFT", buttonContainer, "LEFT", 0, 0)
        else
            button:SetPoint("LEFT", buttons[i-1], "RIGHT", buttonSpacing, 0)
        end
        
        button:SetScript("OnClick", function()
            if config.callback then
                config.callback()
            end
            if config.closeOnClick ~= false then
                dialog:Hide()
            end
        end)
        
        table.insert(buttons, button)
    end
    
    -- Auto-size height based on content
    local messageHeight = message:GetStringHeight()
    local totalHeight = 30 + UISTYLE_PADDING * 2 + messageHeight + UISTYLE_PADDING + 40 + UISTYLE_PADDING * 2
    dialog:SetHeight(options.height or math.max(150, totalHeight))
    
    -- Message frame height
    messageFrame:SetHeight(messageHeight + UISTYLE_PADDING)
    
    -- Escape key handling
    if options.closeOnEscape ~= false then
        dialog:SetScript("OnKeyDown", function(self, key)
            if key == "ESCAPE" then
                dialog:Hide()
            end
        end)
        dialog:EnableKeyboard(true)
    end
    
    -- Click outside to close (but not on the dialog itself)
    overlay:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            -- Get mouse position
            local scale = UIParent:GetEffectiveScale()
            local cursorX, cursorY = GetCursorPosition()
            cursorX = cursorX / scale
            cursorY = cursorY / scale
            
            -- Get dialog bounds
            local dialogLeft = dialog:GetLeft()
            local dialogRight = dialog:GetRight()
            local dialogTop = dialog:GetTop()
            local dialogBottom = dialog:GetBottom()
            
            -- Check if click was outside the dialog
            if dialogLeft and dialogRight and dialogTop and dialogBottom then
                if cursorX < dialogLeft or cursorX > dialogRight or 
                   cursorY < dialogBottom or cursorY > dialogTop then
                    dialog:Hide()
                end
            end
        end
    end)
    
    -- Prevent click-through to dialog
    dialog:SetScript("OnMouseDown", function(self, button)
        -- Do nothing, stops propagation
    end)
    
    -- Methods
    dialog.Show = function(self)
        -- Close any existing dialog
        if activeDialog and activeDialog ~= dialog then
            activeDialog:Hide()
        end
        activeDialog = dialog
        overlay:Show()
    end
    
    dialog.Hide = function(self)
        overlay:Hide()
        if activeDialog == dialog then
            activeDialog = nil
        end
    end
    
    dialog.SetMessage = function(self, text)
        message:SetText(text)
        local messageHeight = message:GetStringHeight()
        messageFrame:SetHeight(messageHeight + UISTYLE_PADDING)
        local totalHeight = 30 + UISTYLE_PADDING * 2 + messageHeight + UISTYLE_PADDING + 40 + UISTYLE_PADDING * 2
        dialog:SetHeight(math.max(150, totalHeight))
    end
    
    dialog.overlay = overlay
    dialog.buttons = buttons
    
    return dialog
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Dialogs"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Dialogs module loaded")
end