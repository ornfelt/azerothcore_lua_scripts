local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY LISTS MODULE
-- ===================================
-- List view components with scrolling and selection

--[[
Creates a styled list view with selectable rows
@param parent - Parent frame
@param width - List width
@param height - List height
@param rowHeight - Height of each row (defaults to 20)
@param columns - Optional column definitions: {{key="id", text="ID", width=50}, ...}
@return List view with methods:
  - .SetData(data) - Set list data (table of items)
  - .GetSelected() - Get selected item data
  - .SetSelected(index) - Set selected row by index
  - .SetOnSelectionChanged(callback) - Set selection callback function(data, index)
  - .Refresh() - Refresh the list display
]]
function CreateStyledListView(parent, width, height, rowHeight, columns)
    rowHeight = rowHeight or 20
    
    -- Main container
    local container = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    container:SetSize(width, height)
    
    -- Header (if columns defined)
    local headerHeight = 0
    local header
    if columns then
        headerHeight = 24
        header = CreateFrame("Frame", nil, container)
        header:SetHeight(headerHeight)
        header:SetPoint("TOPLEFT", 2, -2)
        header:SetPoint("TOPRIGHT", -2, -2)
        
        header:SetBackdrop(UISTYLE_BACKDROPS.Solid)
        header:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
        
        -- Create column headers
        local xOffset = 0
        for i, col in ipairs(columns) do
            local colHeader = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            colHeader:SetPoint("LEFT", header, "LEFT", xOffset + 5, 0)
            colHeader:SetText(col.text or col.key)
            colHeader:SetTextColor(1, 1, 1, 1)
            colHeader:SetWidth(col.width or 100)
            colHeader:SetJustifyH(col.align or "LEFT")
            
            xOffset = xOffset + (col.width or 100)
        end
    end
    
    -- Scrollable content area
    local scrollFrame = CreateFrame("ScrollFrame", nil, container)
    scrollFrame:SetPoint("TOPLEFT", 2, -(2 + headerHeight))
    scrollFrame:SetPoint("BOTTOMRIGHT", -14, 2)
    
    -- Content frame
    local content = CreateFrame("Frame", nil, container)
    content:SetWidth(width - 16)
    content:SetHeight(1)
    scrollFrame:SetScrollChild(content)
    
    -- Scrollbar
    local scrollBar = CreateStyledScrollBar(container, 12, height - 4 - headerHeight)
    scrollBar:SetPoint("TOPRIGHT", -2, -(2 + headerHeight))
    scrollBar:SetPoint("BOTTOMRIGHT", -2, 2)
    
    scrollBar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    
    -- Mouse wheel support
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = scrollBar:GetValue()
        local min, max = scrollBar:GetMinMaxValues()
        local step = rowHeight * 3
        
        if delta > 0 then
            scrollBar:SetValue(math.max(min, current - step))
        else
            scrollBar:SetValue(math.min(max, current + step))
        end
    end)
    
    -- Data storage
    local data = {}
    local rows = {}
    local selectedIndex = nil
    
    -- Update scrollbar
    local function UpdateScrollBar()
        local contentHeight = #data * rowHeight
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
        
        content:SetHeight(math.max(1, contentHeight))
    end
    
    -- Create row
    local function CreateRow(index)
        local row = CreateFrame("Button", nil, content)
        row:SetHeight(rowHeight)
        row:SetPoint("TOPLEFT", 0, -(index - 1) * rowHeight)
        row:SetPoint("TOPRIGHT", 0, -(index - 1) * rowHeight)
        
        -- Row background
        row:SetBackdrop(UISTYLE_BACKDROPS.Solid)
        row:SetBackdropColor(0, 0, 0, 0)
        
        -- Highlight texture
        local highlight = row:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
        highlight:SetVertexColor(1, 1, 1, 0.1)
        highlight:SetAllPoints()
        
        -- Selection texture
        local selection = row:CreateTexture(nil, "BACKGROUND")
        selection:SetTexture("Interface\\Buttons\\WHITE8X8")
        selection:SetVertexColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 0.3)
        selection:SetAllPoints()
        selection:Hide()
        row.selection = selection
        
        -- Text elements
        if columns then
            row.texts = {}
            local xOffset = 0
            for i, col in ipairs(columns) do
                local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                text:SetPoint("LEFT", row, "LEFT", xOffset + 5, 0)
                text:SetWidth(col.width or 100)
                text:SetJustifyH(col.align or "LEFT")
                text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
                row.texts[col.key] = text
                
                xOffset = xOffset + (col.width or 100)
            end
        else
            -- Single text for simple list
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            row.text:SetPoint("LEFT", 5, 0)
            row.text:SetPoint("RIGHT", -5, 0)
            row.text:SetJustifyH("LEFT")
            row.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
        end
        
        -- Click handler
        row:SetScript("OnClick", function(self)
            if selectedIndex ~= index then
                -- Clear previous selection
                if selectedIndex and rows[selectedIndex] then
                    rows[selectedIndex].selection:Hide()
                end
                
                -- Set new selection
                selectedIndex = index
                self.selection:Show()
                
                -- Callback
                if container.onSelectionChanged then
                    container.onSelectionChanged(data[index], index)
                end
            end
        end)
        
        return row
    end
    
    -- Refresh list
    local function Refresh()
        -- Clear existing rows
        for i, row in ipairs(rows) do
            row:Hide()
        end
        
        -- Create/update rows
        for i, item in ipairs(data) do
            local row = rows[i]
            if not row then
                row = CreateRow(i)
                rows[i] = row
            end
            
            -- Update row content
            if columns then
                for _, col in ipairs(columns) do
                    if row.texts[col.key] then
                        local value = item[col.key] or ""
                        row.texts[col.key]:SetText(tostring(value))
                    end
                end
            else
                -- Simple list - expect string or use tostring
                local text = type(item) == "table" and (item.text or item.name or tostring(item)) or tostring(item)
                row.text:SetText(text)
            end
            
            -- Update selection state
            if i == selectedIndex then
                row.selection:Show()
            else
                row.selection:Hide()
            end
            
            row:Show()
        end
        
        UpdateScrollBar()
    end
    
    -- Container methods
    container.SetData = function(self, newData)
        data = newData or {}
        selectedIndex = nil
        Refresh()
    end
    
    container.GetSelected = function(self)
        return selectedIndex and data[selectedIndex] or nil
    end
    
    container.SetSelected = function(self, index)
        if index and index > 0 and index <= #data then
            selectedIndex = index
            Refresh()
            
            if self.onSelectionChanged then
                self.onSelectionChanged(data[index], index)
            end
        end
    end
    
    container.SetOnSelectionChanged = function(self, callback)
        self.onSelectionChanged = callback
    end
    
    container.Refresh = Refresh
    
    container.scrollFrame = scrollFrame
    container.content = content
    container.scrollBar = scrollBar
    container.data = data
    container.rows = rows
    
    return container
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Lists"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Lists module loaded")
end