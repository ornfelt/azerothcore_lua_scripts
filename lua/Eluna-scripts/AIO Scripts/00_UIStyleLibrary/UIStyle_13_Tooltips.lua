local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY TOOLTIPS MODULE
-- ===================================
-- Tooltip frames and helper functions

--[[
Sets up a tooltip for a frame
@param frame - The frame to attach tooltip to
@param text - Main tooltip text
@param subtext - Optional secondary text (appears in different color)
]]
function SetupTooltip(frame, text, subtext)
    if not text then
        return
    end

    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, 1, 1, 1, 1, true)
        if subtext then
            GameTooltip:AddLine(subtext, 0.7, 0.7, 0.7, true)
        end
        GameTooltip:Show()

        -- Call original OnEnter if it exists
        if self.originalOnEnter then
            self:originalOnEnter()
        end
    end)

    -- Store original OnLeave handler
    local originalOnLeave = frame:GetScript("OnLeave")
    frame.originalOnLeave = originalOnLeave

    frame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        
        -- Call original OnLeave if it exists
        if self.originalOnLeave then
            self:originalOnLeave()
        end
    end)
end

--[[
Creates a styled tooltip frame with rich content support
@param parent - Parent frame to attach tooltip to
@param anchor - Anchor point ("TOPLEFT", "RIGHT", etc)
@param xOffset - X offset from anchor
@param yOffset - Y offset from anchor
@return Tooltip frame with methods:
  - .SetContent(lines) - Set tooltip content: {{text="Title", color={1,1,1}, size="large"}, ...}
  - .AddLine(text, r, g, b, size) - Add a line of text
  - .Show() - Show tooltip
  - .Hide() - Hide tooltip
  - .Clear() - Clear all content
]]
function CreateStyledTooltipFrame(parent, anchor, xOffset, yOffset)
    local tooltip = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    tooltip:SetFrameStrata("TOOLTIP")
    tooltip:SetFrameLevel(100)
    tooltip:Hide()
    
    -- Content area
    local content = CreateFrame("Frame", nil, tooltip)
    content:SetPoint("TOPLEFT", UISTYLE_SMALL_PADDING, -UISTYLE_SMALL_PADDING)
    content:SetPoint("TOPRIGHT", -UISTYLE_SMALL_PADDING, -UISTYLE_SMALL_PADDING)
    
    -- Line storage
    local lines = {}
    local linePool = {}
    local currentY = 0
    
    -- Get or create line
    local function GetLine()
        local line = table.remove(linePool)
        if not line then
            line = content:CreateFontString(nil, "OVERLAY")
            line:SetJustifyH("LEFT")
            line:SetJustifyV("TOP")
        end
        return line
    end
    
    -- Return line to pool
    local function ReleaseLine(line)
        line:Hide()
        line:SetText("")
        table.insert(linePool, line)
    end
    
    -- Clear all lines
    local function Clear()
        for _, line in ipairs(lines) do
            ReleaseLine(line)
        end
        wipe(lines)
        currentY = 0
    end
    
    -- Add line
    local function AddLine(text, r, g, b, size)
        local line = GetLine()
        
        -- Set font size
        if size == "large" then
            line:SetFontObject("GameFontNormalLarge")
        elseif size == "small" then
            line:SetFontObject("GameFontNormalSmall")
        else
            line:SetFontObject("GameFontHighlight")
        end
        
        line:SetText(text)
        line:SetTextColor(r or 1, g or 1, b or 1)
        line:SetPoint("TOPLEFT", 0, -currentY)
        line:SetPoint("TOPRIGHT", 0, -currentY)
        line:Show()
        
        table.insert(lines, line)
        currentY = currentY + line:GetStringHeight() + 2
        
        return line
    end
    
    -- Update size
    local function UpdateSize()
        local maxWidth = 0
        for _, line in ipairs(lines) do
            maxWidth = math.max(maxWidth, line:GetStringWidth())
        end
        
        tooltip:SetWidth(math.max(150, maxWidth + UISTYLE_SMALL_PADDING * 2))
        tooltip:SetHeight(currentY + UISTYLE_SMALL_PADDING * 2)
        content:SetHeight(currentY)
    end
    
    -- Position tooltip
    local function UpdatePosition()
        tooltip:ClearAllPoints()
        if parent then
            tooltip:SetPoint(anchor or "BOTTOMRIGHT", parent, anchor or "TOPRIGHT", xOffset or 0, yOffset or 5)
        else
            tooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 100, 100)
        end
    end
    
    -- Methods
    tooltip.SetContent = function(self, contentLines)
        Clear()
        
        for _, lineData in ipairs(contentLines) do
            local color = lineData.color or {1, 1, 1}
            AddLine(lineData.text, color[1], color[2], color[3], lineData.size)
        end
        
        UpdateSize()
        UpdatePosition()
    end
    
    tooltip.AddLine = function(self, text, r, g, b, size)
        AddLine(text, r, g, b, size)
        UpdateSize()
    end
    
    tooltip.Clear = Clear
    
    tooltip.SetAnchor = function(self, newParent, newAnchor, newXOffset, newYOffset)
        parent = newParent
        anchor = newAnchor
        xOffset = newXOffset
        yOffset = newYOffset
        UpdatePosition()
    end
    
    -- Auto-hide on parent hide
    if parent then
        parent:HookScript("OnHide", function()
            tooltip:Hide()
        end)
    end
    
    return tooltip
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Tooltips"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Tooltips module loaded")
end