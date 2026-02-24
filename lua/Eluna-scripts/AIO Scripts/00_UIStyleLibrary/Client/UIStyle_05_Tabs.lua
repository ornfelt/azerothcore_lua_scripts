local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY TABS MODULE
-- ===================================
-- Tab buttons and tab group functionality

--[[
Creates a styled tab button matching the dark theme
@param parent - Parent frame
@param text - Tab text
@param width - Optional width (defaults to auto-size)
@param height - Optional height (defaults to 26)
@param icon - Optional icon texture path
@return Styled tab button
]]
function CreateStyledTabButton(parent, text, width, height, icon)
    local button = CreateFrame("Button", nil, parent)
    button:SetHeight(height or 26)
    
    -- Button backdrop
    button:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    
    -- Set initial state (inactive)
    button.isActive = false
    button:SetBackdropColor(0.05, 0.05, 0.05, 1) -- Darker for inactive
    button:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    
    -- Icon (optional)
    local iconTexture
    if icon then
        iconTexture = button:CreateTexture(nil, "ARTWORK")
        iconTexture:SetSize(16, 16)
        iconTexture:SetPoint("LEFT", 6, 0)
        iconTexture:SetTexture(icon)
        button.icon = iconTexture
    end
    
    -- Button text
    local label = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    if icon then
        label:SetPoint("LEFT", iconTexture, "RIGHT", 4, 0)
        label:SetPoint("RIGHT", -10, 0)
    else
        label:SetPoint("CENTER")
    end
    label:SetText(text or "Tab")
    label:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    button.text = label
    
    -- Auto-size if no width specified
    if not width then
        local textWidth = label:GetStringWidth()
        local totalWidth = textWidth + 20 -- padding
        if icon then
            totalWidth = totalWidth + 20 -- icon width + spacing
        end
        button:SetWidth(totalWidth)
    else
        button:SetWidth(width)
    end
    
    -- State management
    button.SetActive = function(self, active)
        self.isActive = active
        if active then
            self:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
            self.text:SetTextColor(1, 1, 1, 1)
            self:LockHighlight()
        else
            self:SetBackdropColor(0.05, 0.05, 0.05, 1)
            self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
            self:UnlockHighlight()
        end
    end
    
    button.GetActive = function(self)
        return self.isActive
    end
    
    -- Hover effects (only when not active)
    button:SetScript("OnEnter", function(self)
        if not self.isActive then
            self:SetBackdropColor(0.08, 0.08, 0.08, 1)
            self.text:SetTextColor(0.9, 0.9, 0.9, 1)
        end
    end)
    
    button:SetScript("OnLeave", function(self)
        if not self.isActive then
            self:SetBackdropColor(0.05, 0.05, 0.05, 1)
            self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
        end
    end)
    
    -- Click effect
    button:SetScript("OnMouseDown", function(self)
        if not self.isActive then
            self:SetBackdropColor(0.03, 0.03, 0.03, 1)
        end
    end)
    
    button:SetScript("OnMouseUp", function(self)
        if not self.isActive then
            if self:IsMouseOver() then
                self:SetBackdropColor(0.08, 0.08, 0.08, 1)
            else
                self:SetBackdropColor(0.05, 0.05, 0.05, 1)
            end
        end
    end)
    
    -- Add highlight texture
    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
    highlight:SetVertexColor(1, 1, 1, 0.05)
    highlight:SetPoint("TOPLEFT", 1, -1)
    highlight:SetPoint("BOTTOMRIGHT", -1, 1)
    
    -- Add SetTooltip method
    button.SetTooltip = function(self, text, subtext)
        SetupTooltip(self, text, subtext)
    end
    
    return button
end

--[[
Creates a styled tab group with automatic tab switching
@param parent - Parent frame
@param tabs - Table of tab configurations: {{text="Tab1", icon=nil, tooltip="Description"}, ...}
@param width - Total width of the tab group
@param height - Total height including content area
@param orientation - "HORIZONTAL" (default) or "VERTICAL"
@param onTabChange - Optional callback function(tabIndex, tabData)
@return tabContainer, contentFrames table, tabButtons table
]]
function CreateStyledTabGroup(parent, tabs, width, height, orientation, onTabChange)
    orientation = orientation or "HORIZONTAL"
    
    -- Main container
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width, height)
    
    -- Calculate dimensions based on orientation
    local tabAreaWidth, tabAreaHeight, contentWidth, contentHeight
    local tabWidth, tabHeight, tabSpacing = nil, nil, 2
    
    if orientation == "HORIZONTAL" then
        tabAreaHeight = 28
        tabAreaWidth = width
        contentWidth = width
        contentHeight = height - tabAreaHeight - 2
        tabHeight = 26
    else -- VERTICAL
        tabAreaWidth = 150
        tabAreaHeight = height
        contentWidth = width - tabAreaWidth - 2
        contentHeight = height
        tabWidth = 148
        tabHeight = 26
    end
    
    -- Tab area
    local tabArea = CreateFrame("Frame", nil, container)
    tabArea:SetSize(tabAreaWidth, tabAreaHeight)
    
    if orientation == "HORIZONTAL" then
        tabArea:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
        tabArea:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
    else
        tabArea:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
        tabArea:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", 0, 0)
    end
    
    -- Content area
    local contentArea = CreateStyledFrame(container, UISTYLE_COLORS.OptionBg)
    contentArea:SetSize(contentWidth, contentHeight)
    
    if orientation == "HORIZONTAL" then
        contentArea:SetPoint("TOPLEFT", tabArea, "BOTTOMLEFT", 0, -2)
        contentArea:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
    else
        contentArea:SetPoint("TOPLEFT", tabArea, "TOPRIGHT", 2, 0)
        contentArea:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
    end
    
    -- Create tab buttons and content frames
    local tabButtons = {}
    local contentFrames = {}
    local activeTab = 1
    
    -- Scrollable tab area for vertical orientation with many tabs
    local tabScrollFrame, tabContentFrame, updateScrollBar
    if orientation == "VERTICAL" and #tabs > math.floor(tabAreaHeight / (tabHeight + tabSpacing)) then
        -- Create scrollable area
        local scrollContainer, scrollContent, scrollBar
        scrollContainer, scrollContent, scrollBar, updateScrollBar = CreateScrollableFrame(tabArea, tabAreaWidth - 2, tabAreaHeight)
        scrollContainer:SetPoint("TOPLEFT", 0, 0)
        scrollContainer:SetPoint("BOTTOMRIGHT", 0, 0)
        tabContentFrame = scrollContent
        tabScrollFrame = scrollContainer
    else
        tabContentFrame = tabArea
    end
    
    -- Create tabs
    for i, tabData in ipairs(tabs) do
        -- Create tab button
        local tabButton = CreateStyledTabButton(tabContentFrame, tabData.text, tabWidth, tabHeight, tabData.icon)
        
        -- Position tab
        if orientation == "HORIZONTAL" then
            if i == 1 then
                tabButton:SetPoint("LEFT", tabContentFrame, "LEFT", 0, 0)
            else
                tabButton:SetPoint("LEFT", tabButtons[i-1], "RIGHT", tabSpacing, 0)
            end
        else -- VERTICAL
            if i == 1 then
                tabButton:SetPoint("TOP", tabContentFrame, "TOP", 0, 0)
            else
                tabButton:SetPoint("TOP", tabButtons[i-1], "BOTTOM", 0, -tabSpacing)
            end
        end
        
        -- Set tooltip if provided
        if tabData.tooltip then
            tabButton:SetTooltip(tabData.tooltip, tabData.subtip)
        end
        
        -- Create content frame for this tab
        local contentFrame = CreateFrame("Frame", nil, contentArea)
        contentFrame:SetAllPoints(contentArea)
        contentFrame:Hide()
        
        -- Store references
        tabButton.index = i
        tabButton.contentFrame = contentFrame
        tabButtons[i] = tabButton
        contentFrames[i] = contentFrame
        
        -- Tab click handler
        tabButton:SetScript("OnClick", function(self)
            -- Switch to this tab
            for j, btn in ipairs(tabButtons) do
                btn:SetActive(j == i)
                contentFrames[j]:Hide()
            end
            
            self:SetActive(true)
            contentFrame:Show()
            activeTab = i
            
            -- Call callback if provided
            if onTabChange then
                onTabChange(i, tabData)
            end
        end)
    end
    
    -- Update scroll content height if using scroll frame
    if tabScrollFrame and tabContentFrame ~= tabArea then
        local totalHeight = #tabs * (tabHeight + tabSpacing) - tabSpacing + 4
        tabContentFrame:SetHeight(totalHeight)
        if updateScrollBar then
            updateScrollBar()
        end
    end
    
    -- Activate first tab by default
    if #tabButtons > 0 then
        tabButtons[1]:SetActive(true)
        contentFrames[1]:Show()
    end
    
    -- Helper functions
    container.SetActiveTab = function(self, index)
        if index > 0 and index <= #tabButtons then
            tabButtons[index]:Click()
        end
    end
    
    container.GetActiveTab = function(self)
        return activeTab
    end
    
    container.GetTabButton = function(self, index)
        return tabButtons[index]
    end
    
    container.GetContentFrame = function(self, index)
        return contentFrames[index]
    end
    
    return container, contentFrames, tabButtons
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Tabs"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Tabs module loaded")
end