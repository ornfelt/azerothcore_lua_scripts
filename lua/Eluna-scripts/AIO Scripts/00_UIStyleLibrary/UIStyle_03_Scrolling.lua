local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY SCROLLING MODULE
-- ===================================
-- Scrollbars and scrollable frames for WoW 3.3.5

--[[
Creates a styled scrollbar matching Dejunk dark theme
@param parent - Parent frame
@param width - Scrollbar width (defaults to 12)
@param height - Scrollbar height
@param orientation - "VERTICAL" or "HORIZONTAL" (defaults to "VERTICAL")
@return Styled scrollbar slider
]]
function CreateStyledScrollBar(parent, width, height, orientation)
    local scrollBar = CreateFrame("Slider", nil, parent)
    scrollBar:SetWidth(width or 12)
    scrollBar:SetHeight(height)
    scrollBar:SetOrientation(orientation or "VERTICAL")

    -- Track (background)
    local track = scrollBar:CreateTexture(nil, "BACKGROUND")
    track:SetTexture("Interface\\Buttons\\WHITE8X8")
    track:SetVertexColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 1)
    track:SetAllPoints()

    -- Border
    scrollBar:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    scrollBar:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    -- Thumb (the draggable part)
    local thumb = scrollBar:CreateTexture(nil, "OVERLAY")
    thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
    thumb:SetVertexColor(0.3, 0.3, 0.3, 1) -- Slightly lighter than track

    if orientation == "HORIZONTAL" then
        thumb:SetSize(30, height - 4)
    else
        thumb:SetSize(width - 4, 30)
    end

    scrollBar:SetThumbTexture(thumb)

    -- Interactive states
    scrollBar.isHovered = false
    scrollBar.isDragging = false

    -- Hover effect
    scrollBar:EnableMouse(true)
    scrollBar:SetScript("OnEnter", function(self)
        self.isHovered = true
        thumb:SetVertexColor(0.4, 0.4, 0.4, 1) -- Lighter on hover
    end)

    scrollBar:SetScript("OnLeave", function(self)
        self.isHovered = false
        if not self.isDragging then
            thumb:SetVertexColor(0.3, 0.3, 0.3, 1)
        end
    end)

    -- Dragging state
    scrollBar:SetScript("OnMouseDown", function(self)
        self.isDragging = true
        thumb:SetVertexColor(0.5, 0.5, 0.5, 1) -- Even lighter when dragging
    end)

    scrollBar:SetScript("OnMouseUp", function(self)
        self.isDragging = false
        if self.isHovered then
            thumb:SetVertexColor(0.4, 0.4, 0.4, 1)
        else
            thumb:SetVertexColor(0.3, 0.3, 0.3, 1)
        end
    end)

    return scrollBar
end

--[[
Creates a scrollable frame with styled scrollbar compatible with WoW 3.3.5

IMPORTANT WoW 3.3.5 NOTES:
1. The content frame MUST NOT be parented to the ScrollFrame
2. SetClipsChildren does not exist in 3.3.5
3. Always call SetScrollChild AFTER creating the content frame
4. Set content height explicitly after adding all elements

Usage Example:
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(parent, 400, 300)
    -- Add your elements to 'content'
    -- Set content:SetHeight(totalHeight) based on your content
    -- Call updateScrollBar() to refresh the scrollbar

@param parent - Parent frame
@param width - Container width
@param height - Container height
@return container, content, scrollBar, updateScrollBar function
]]
function CreateScrollableFrame(parent, width, height)
    -- Container frame
    local container = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    container:SetSize(width, height)

    -- Scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, container)
    scrollFrame:SetPoint("TOPLEFT", 2, -2)
    scrollFrame:SetPoint("BOTTOMRIGHT", -14, 2) -- Leave room for scrollbar

    -- Content frame (what gets scrolled)
    -- CRITICAL: In WoW 3.3.5, the content frame MUST NOT be parented to scrollFrame!
    -- The ScrollFrame will manage the content's position when SetScrollChild is called
    local content = CreateFrame("Frame", nil, container)
    content:SetWidth(width - 16) -- Account for scrollbar and borders
    content:SetHeight(1) -- Initial height, will be adjusted by user

    -- Set the scroll child - this makes the ScrollFrame manage the content
    scrollFrame:SetScrollChild(content)

    -- Ensure the scroll frame shows content properly
    scrollFrame:Show()
    content:Show()

    -- Styled scrollbar
    local scrollBar = CreateStyledScrollBar(container, 12, height - 4)
    scrollBar:SetPoint("TOPRIGHT", -2, -2)
    scrollBar:SetPoint("BOTTOMRIGHT", -2, 2)
    scrollBar:SetMinMaxValues(0, 100)
    scrollBar:SetValue(0)

    -- Connect scrollbar to scroll frame
    scrollBar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)

    -- Mouse wheel support
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = scrollBar:GetValue()
        local min, max = scrollBar:GetMinMaxValues()
        local step = 20 -- Scroll speed

        if delta > 0 then
            scrollBar:SetValue(math.max(min, current - step))
        else
            scrollBar:SetValue(math.min(max, current + step))
        end
    end)

    -- Update scrollbar when content changes
    local function UpdateScrollBar()
        local contentHeight = content:GetHeight()
        local frameHeight = scrollFrame:GetHeight()

        if contentHeight > frameHeight then
            local maxScroll = contentHeight - frameHeight
            scrollBar:SetMinMaxValues(0, maxScroll)
            scrollBar:Show()
            scrollFrame:SetPoint("BOTTOMRIGHT", -14, 2)
        else
            scrollBar:SetMinMaxValues(0, 0)
            scrollBar:Hide()
            scrollFrame:SetPoint("BOTTOMRIGHT", -2, 2)
        end
    end

    return container, content, scrollBar, UpdateScrollBar
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Scrolling"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Scrolling module loaded")
end