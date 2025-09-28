local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY STATUS BARS MODULE
-- ===================================
-- Loading bars and status bars

--[[
Creates a styled loading bar with percentage display
@param parent - Parent frame
@param width - Bar width (defaults to 250)
@param height - Bar height (defaults to 24)
@return Loading bar frame with methods:
  - .SetProgress(progress) - Set progress (0-1)
  - .Reset() - Reset to 0%
  - .SetBarColor(r, g, b, a) - Set bar color
  - .ShowPercentage(show) - Show/hide percentage text
]]
function CreateStyledLoadingBar(parent, width, height)
    local loadingBarFrame = CreateStyledFrame(parent, UISTYLE_COLORS.DarkGrey)
    loadingBarFrame:SetSize(width or 250, height or 24)

    -- Progress bar background
    local progressBg = loadingBarFrame:CreateTexture(nil, "BACKGROUND")
    progressBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    progressBg:SetVertexColor(0.05, 0.05, 0.05, 1)
    progressBg:SetPoint("TOPLEFT", 2, -2)
    progressBg:SetPoint("BOTTOMRIGHT", -2, 2)

    -- Progress bar texture
    local loadingBarTexture = loadingBarFrame:CreateTexture(nil, "OVERLAY")
    loadingBarTexture:SetTexture("Interface\\Buttons\\WHITE8X8")
    loadingBarTexture:SetVertexColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
    loadingBarTexture:SetPoint("LEFT", loadingBarFrame, "LEFT", 2, 0)
    loadingBarTexture:SetHeight((height or 24) - 4)
    loadingBarTexture:SetWidth(0)

    -- Percentage text
    local loadingBarPercentage = loadingBarFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    loadingBarPercentage:SetPoint("CENTER", loadingBarFrame, "CENTER", 0, 0)
    loadingBarPercentage:SetText("0%")

    -- Spark effect
    local loadingBarSpark = loadingBarFrame:CreateTexture(nil, "OVERLAY")
    loadingBarSpark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    loadingBarSpark:SetBlendMode("ADD")
    loadingBarSpark:SetWidth(20)
    loadingBarSpark:SetHeight(loadingBarFrame:GetHeight() * 1.5)
    loadingBarSpark:SetPoint("LEFT", loadingBarTexture, "RIGHT", -10, 0)
    loadingBarSpark:Hide()

    -- Progress update function
    function loadingBarFrame:SetProgress(progress)
        progress = math.max(0, math.min(1, progress)) -- Clamp between 0 and 1
        local width = (loadingBarFrame:GetWidth() - 4) * progress
        loadingBarTexture:SetWidth(width)
        loadingBarPercentage:SetText(math.floor(progress * 100) .. "%")

        if progress > 0 and progress < 1 then
            loadingBarSpark:SetPoint("LEFT", loadingBarTexture, "RIGHT", -10, 0)
            loadingBarSpark:Show()
        else
            loadingBarSpark:Hide()
        end
    end

    -- Reset function
    function loadingBarFrame:Reset()
        loadingBarTexture:SetWidth(0)
        loadingBarPercentage:SetText("0%")
        loadingBarSpark:Hide()
    end

    -- Set custom color
    function loadingBarFrame:SetBarColor(r, g, b, a)
        loadingBarTexture:SetVertexColor(r, g, b, a or 1)
    end

    -- Show/hide percentage text
    function loadingBarFrame:ShowPercentage(show)
        if show then
            loadingBarPercentage:Show()
        else
            loadingBarPercentage:Hide()
        end
    end

    -- Expose elements for advanced customization
    loadingBarFrame.texture = loadingBarTexture
    loadingBarFrame.percentage = loadingBarPercentage
    loadingBarFrame.spark = loadingBarSpark

    -- Initialize at 0%
    loadingBarFrame:Reset()

    return loadingBarFrame
end

--[[
Creates a styled status bar (health/mana/etc)
@param parent - Parent frame
@param width - Bar width
@param height - Bar height (defaults to 20)
@param color - Bar color {r, g, b} or color name ("health", "mana", "energy", "rage", "focus")
@param showText - Whether to show value text (defaults to true)
@return Status bar with methods:
  - .SetMinMaxValues(min, max) - Set value range
  - .SetValue(value) - Set current value
  - .GetValue() - Get current value
  - .SetColor(r, g, b) - Set bar color
  - .SetText(text) - Set custom text (overrides auto text)
  - .SetTextFormat(format) - Set text format (e.g., "%d / %d")
]]
function CreateStyledStatusBar(parent, width, height, color, showText)
    height = height or 20
    showText = showText ~= false
    
    -- Container frame
    local container = CreateStyledFrame(parent, UISTYLE_COLORS.DarkGrey)
    container:SetSize(width, height)
    
    -- Background
    local bg = container:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0.05, 0.05, 0.05, 1)
    bg:SetPoint("TOPLEFT", 1, -1)
    bg:SetPoint("BOTTOMRIGHT", -1, 1)
    
    -- Status bar
    local statusBar = CreateFrame("StatusBar", nil, container)
    statusBar:SetPoint("TOPLEFT", 1, -1)
    statusBar:SetPoint("BOTTOMRIGHT", -1, 1)
    statusBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
    statusBar:SetMinMaxValues(0, 100)
    statusBar:SetValue(100)
    
    -- Predefined colors
    local colorPresets = {
        health = {0.12, 0.75, 0.12},
        mana = {0.31, 0.69, 0.89},
        energy = {1, 1, 0},
        rage = {0.89, 0.31, 0.31},
        focus = {1, 0.5, 0.25},
        runic = {0, 0.82, 1}
    }
    
    -- Set color
    if type(color) == "string" and colorPresets[color] then
        local c = colorPresets[color]
        statusBar:SetStatusBarColor(c[1], c[2], c[3])
    elseif type(color) == "table" then
        statusBar:SetStatusBarColor(color[1], color[2], color[3])
    else
        statusBar:SetStatusBarColor(0.12, 0.75, 0.12) -- Default to health green
    end
    
    -- Text overlay
    local text
    if showText then
        text = statusBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("CENTER")
        text:SetTextColor(1, 1, 1, 1)
    end
    
    -- Text format
    local textFormat = "%d / %d"
    local customText = nil
    
    -- Update text
    local function UpdateText()
        if text and not customText then
            local value = statusBar:GetValue()
            local min, max = statusBar:GetMinMaxValues()
            text:SetText(string.format(textFormat, value, max))
        end
    end
    
    -- Spark effect
    local spark = statusBar:CreateTexture(nil, "OVERLAY")
    spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    spark:SetBlendMode("ADD")
    spark:SetWidth(10)
    spark:SetHeight(height * 1.5)
    
    -- Update spark position
    local function UpdateSpark()
        local value = statusBar:GetValue()
        local min, max = statusBar:GetMinMaxValues()
        local width = statusBar:GetWidth()
        
        if value > min and value < max then
            local percent = (value - min) / (max - min)
            spark:SetPoint("CENTER", statusBar, "LEFT", width * percent, 0)
            spark:Show()
        else
            spark:Hide()
        end
    end
    
    -- Methods
    container.SetMinMaxValues = function(self, min, max)
        statusBar:SetMinMaxValues(min, max)
        UpdateText()
        UpdateSpark()
    end
    
    container.SetValue = function(self, value)
        statusBar:SetValue(value)
        UpdateText()
        UpdateSpark()
    end
    
    container.GetValue = function(self)
        return statusBar:GetValue()
    end
    
    container.SetColor = function(self, r, g, b)
        statusBar:SetStatusBarColor(r, g, b)
    end
    
    container.SetText = function(self, newText)
        if text then
            customText = newText
            text:SetText(newText)
        end
    end
    
    container.SetTextFormat = function(self, format)
        textFormat = format
        customText = nil
        UpdateText()
    end
    
    container.ShowText = function(self, show)
        if text then
            if show then
                text:Show()
            else
                text:Hide()
            end
        end
    end
    
    container.statusBar = statusBar
    container.text = text
    container.spark = spark
    
    -- Initial update
    UpdateText()
    UpdateSpark()
    
    return container
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["StatusBars"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: StatusBars module loaded")
end