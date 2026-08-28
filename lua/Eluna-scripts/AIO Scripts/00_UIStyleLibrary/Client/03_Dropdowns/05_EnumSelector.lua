--[[
    EnumSelector - Searchable enum/ID selector component

    A reusable dropdown-style selector for large enum lists (spell effects, aura types, etc.)
    Features:
    - Search by ID or name
    - Category grouping
    - ID + Name + Description display
    - Result count and pagination
    - Keyboard navigation

    Usage:
        local selector = CreateEnumSelector(parent, {
            width = 300,
            label = "Effect Type",
            items = {
                { id = 6, name = "APPLY_AURA", desc = "Apply aura effect", category = "AURA" },
                { id = 27, name = "PERSISTENT_AREA_AURA", desc = "Persistent area aura", category = "AURA" },
                ...
            },
            onSelect = function(item) print("Selected:", item.id, item.name) end,
            currentValue = 6, -- optional initial value
        })
]]

local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

-- Use global UISTYLE_COLORS (defined in UIStyle_00_Core.lua)
-- Map to local COLORS for convenience
local COLORS = {
    DarkGrey = UISTYLE_COLORS.DarkGrey or {0.06, 0.06, 0.06},
    ButtonBg = UISTYLE_COLORS.ButtonBg or {0.09, 0.09, 0.10},
    SectionBg = UISTYLE_COLORS.SectionBg or {0.12, 0.12, 0.12},
    ButtonBorder = UISTYLE_COLORS.ButtonBorder or {0.25, 0.25, 0.26},
    White = UISTYLE_COLORS.White or {1, 1, 1},
    TextGrey = UISTYLE_COLORS.TextGrey or {0.7, 0.7, 0.7},
    Blue = UISTYLE_COLORS.Blue or {0.31, 0.69, 0.89},
    BorderGrey = UISTYLE_COLORS.BorderGrey or {0.08, 0.08, 0.08},
}

-- Constants
local ITEM_HEIGHT = 44
local VISIBLE_ITEMS = 8
local PAGE_SIZE = 50

-- Helper: Set solid color on texture (3.3.5 compatible)
local function SetSolidColor(texture, r, g, b, a)
    texture:SetTexture("Interface\\Buttons\\WHITE8X8")
    texture:SetVertexColor(r, g, b, a or 1)
end

-- Create the main EnumSelector function
function CreateEnumSelector(parent, config)
    config = config or {}
    local width = config.width or 300
    local label = config.label or "Select"
    local items = config.items or {}
    local onSelect = config.onSelect
    local currentValue = config.currentValue

    -- State
    local isOpen = false
    local filteredItems = {}
    local selectedItem = nil
    local scrollOffset = 0
    local currentPage = 1

    -- Find initial selected item
    if currentValue then
        for _, item in ipairs(items) do
            if item.id == currentValue then
                selectedItem = item
                break
            end
        end
    end

    -- Main container
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width, 32)

    -- Label
    local labelText = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", 0, 0)
    labelText:SetText(label)
    labelText:SetTextColor(COLORS.White[1], COLORS.White[2], COLORS.White[3])

    -- Selected value button (the collapsed view)
    local selectBtn = CreateFrame("Button", nil, container)
    selectBtn:SetPoint("TOPLEFT", 0, -18)
    selectBtn:SetSize(width, 32)

    -- Button background
    local btnBg = selectBtn:CreateTexture(nil, "BACKGROUND")
    btnBg:SetAllPoints()
    SetSolidColor(btnBg, COLORS.ButtonBg[1], COLORS.ButtonBg[2], COLORS.ButtonBg[3], 1)

    -- Button border
    local btnBorder = CreateFrame("Frame", nil, selectBtn)
    btnBorder:SetAllPoints()
    btnBorder:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    btnBorder:SetBackdropBorderColor(COLORS.ButtonBorder[1], COLORS.ButtonBorder[2], COLORS.ButtonBorder[3], 1)

    -- ID text (left side)
    local idText = selectBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    idText:SetPoint("LEFT", 8, 0)
    idText:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])
    idText:SetText(selectedItem and tostring(selectedItem.id) or "")

    -- Name text
    local nameText = selectBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", idText, "RIGHT", 8, 0)
    nameText:SetTextColor(COLORS.White[1], COLORS.White[2], COLORS.White[3])
    nameText:SetText(selectedItem and selectedItem.name or "Select...")

    -- Dropdown arrow and X button container
    local arrowText = selectBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    arrowText:SetPoint("RIGHT", -8, 0)
    arrowText:SetText("v")
    arrowText:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])

    -- Clear button (X)
    local clearBtn = CreateFrame("Button", nil, selectBtn)
    clearBtn:SetSize(16, 16)
    clearBtn:SetPoint("RIGHT", arrowText, "LEFT", -4, 0)
    clearBtn:SetNormalFontObject("GameFontNormal")
    clearBtn:SetText("x")
    clearBtn:GetFontString():SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])
    clearBtn:SetScript("OnEnter", function(self)
        self:GetFontString():SetTextColor(1, 0.3, 0.3)
    end)
    clearBtn:SetScript("OnLeave", function(self)
        self:GetFontString():SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])
    end)
    clearBtn:Hide()

    -- Dropdown panel
    local dropdown = CreateFrame("Frame", nil, selectBtn)
    dropdown:SetPoint("TOPLEFT", selectBtn, "BOTTOMLEFT", 0, -2)
    dropdown:SetSize(width, 300)
    dropdown:SetFrameStrata("FULLSCREEN_DIALOG")
    dropdown:SetFrameLevel(100)
    dropdown:Hide()

    -- Dropdown background
    local dropBg = dropdown:CreateTexture(nil, "BACKGROUND")
    dropBg:SetAllPoints()
    SetSolidColor(dropBg, COLORS.DarkGrey[1], COLORS.DarkGrey[2], COLORS.DarkGrey[3], 0.98)

    -- Dropdown border
    local dropBorder = CreateFrame("Frame", nil, dropdown)
    dropBorder:SetAllPoints()
    dropBorder:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    dropBorder:SetBackdropBorderColor(COLORS.ButtonBorder[1], COLORS.ButtonBorder[2], COLORS.ButtonBorder[3], 1)

    -- Search box
    local searchBox = CreateFrame("EditBox", nil, dropdown)
    searchBox:SetSize(width - 16, 24)
    searchBox:SetPoint("TOPLEFT", 8, -8)
    searchBox:SetFontObject("GameFontNormal")
    searchBox:SetTextColor(COLORS.White[1], COLORS.White[2], COLORS.White[3])
    searchBox:SetAutoFocus(false)
    searchBox:SetTextInsets(24, 8, 0, 0)  -- Left inset accounts for search icon

    -- Search box background
    local searchBg = searchBox:CreateTexture(nil, "BACKGROUND")
    searchBg:SetAllPoints()
    SetSolidColor(searchBg, COLORS.ButtonBg[1], COLORS.ButtonBg[2], COLORS.ButtonBg[3], 1)

    -- Search box border
    local searchBorder = CreateFrame("Frame", nil, searchBox)
    searchBorder:SetPoint("TOPLEFT", -1, 1)
    searchBorder:SetPoint("BOTTOMRIGHT", 1, -1)
    searchBorder:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    searchBorder:SetBackdropBorderColor(COLORS.ButtonBorder[1], COLORS.ButtonBorder[2], COLORS.ButtonBorder[3], 1)

    -- Search icon
    local searchIcon = searchBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    searchIcon:SetPoint("LEFT", 4, 0)
    searchIcon:SetText("Q")
    searchIcon:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])

    -- Placeholder text
    local placeholder = searchBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    placeholder:SetPoint("LEFT", 24, 0)
    placeholder:SetText("Search by ID or name...")
    placeholder:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])

    -- Scroll frame for items
    local scrollFrame = CreateFrame("ScrollFrame", nil, dropdown)
    scrollFrame:SetPoint("TOPLEFT", 8, -40)
    scrollFrame:SetPoint("BOTTOMRIGHT", -18, 36)  -- Leave room for scrollbar

    local scrollContent = CreateFrame("Frame", nil, scrollFrame)
    scrollContent:SetSize(width - 26, 1)  -- Adjusted for scrollbar
    scrollFrame:SetScrollChild(scrollContent)

    -- Scrollbar
    local scrollBar = CreateFrame("Slider", nil, dropdown)
    scrollBar:SetWidth(8)
    scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 2, 0)
    scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 2, 0)
    scrollBar:SetOrientation("VERTICAL")

    -- Scrollbar track background
    local scrollTrack = scrollBar:CreateTexture(nil, "BACKGROUND")
    scrollTrack:SetAllPoints()
    SetSolidColor(scrollTrack, COLORS.ButtonBg[1], COLORS.ButtonBg[2], COLORS.ButtonBg[3], 1)

    -- Scrollbar thumb
    local scrollThumb = scrollBar:CreateTexture(nil, "OVERLAY")
    scrollThumb:SetTexture("Interface\\Buttons\\WHITE8X8")
    scrollThumb:SetVertexColor(COLORS.ButtonBorder[1], COLORS.ButtonBorder[2], COLORS.ButtonBorder[3], 1)
    scrollThumb:SetSize(6, 30)
    scrollBar:SetThumbTexture(scrollThumb)

    scrollBar:SetMinMaxValues(0, 1)
    scrollBar:SetValue(0)
    scrollBar:Hide()  -- Hidden by default until content exceeds visible area

    -- Connect scrollbar to scroll frame
    scrollBar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
        scrollOffset = value
    end)

    -- Scrollbar hover effect
    scrollBar:SetScript("OnEnter", function(self)
        scrollThumb:SetVertexColor(COLORS.ButtonBorder[1] + 0.1, COLORS.ButtonBorder[2] + 0.1, COLORS.ButtonBorder[3] + 0.1, 1)
    end)
    scrollBar:SetScript("OnLeave", function(self)
        scrollThumb:SetVertexColor(COLORS.ButtonBorder[1], COLORS.ButtonBorder[2], COLORS.ButtonBorder[3], 1)
    end)

    -- Separate pools for headers and item buttons to prevent orphaned frames
    local headerPool = {}
    local itemButtonPool = {}

    -- Results count text (centered at bottom)
    local resultsText = dropdown:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resultsText:SetPoint("BOTTOM", 0, 8)
    resultsText:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])
    resultsText:SetText("0 results")

    -- Create item button
    local function CreateItemButton(index)
        local btn = CreateFrame("Button", nil, scrollContent)
        btn:SetSize(width - 34, ITEM_HEIGHT)  -- Adjusted for scrollbar

        -- Background
        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        SetSolidColor(bg, 0, 0, 0, 0)
        btn.bg = bg

        -- Name text (top-left, white - FIRST)
        local name = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        name:SetPoint("TOPLEFT", 8, -8)
        name:SetJustifyH("LEFT")
        name:SetTextColor(COLORS.White[1], COLORS.White[2], COLORS.White[3])
        btn.nameText = name

        -- ID/Bitmask text (after name, grey)
        local id = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        id:SetPoint("LEFT", name, "RIGHT", 8, 0)
        id:SetJustifyH("LEFT")
        id:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])
        btn.idText = id

        -- Description text (below name)
        local desc = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        desc:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
        desc:SetPoint("RIGHT", btn, "RIGHT", -8, 0)
        desc:SetJustifyH("LEFT")
        desc:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3], 0.8)
        btn.descText = desc

        -- Hover effects
        btn:SetScript("OnEnter", function(self)
            SetSolidColor(self.bg, COLORS.SectionBg[1], COLORS.SectionBg[2], COLORS.SectionBg[3], 1)
        end)
        btn:SetScript("OnLeave", function(self)
            if self.isSelected then
                SetSolidColor(self.bg, COLORS.Blue[1], COLORS.Blue[2], COLORS.Blue[3], 0.5)
            else
                SetSolidColor(self.bg, 0, 0, 0, 0)
            end
        end)

        return btn
    end

    -- Create category header
    local function CreateCategoryHeader(index)
        local header = CreateFrame("Frame", nil, scrollContent)
        header:SetSize(width - 34, 20)  -- Adjusted for scrollbar

        local text = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("LEFT", 8, 0)
        text:SetTextColor(COLORS.TextGrey[1], COLORS.TextGrey[2], COLORS.TextGrey[3])
        header.text = text

        return header
    end

    -- Filter items based on search
    local function FilterItems(searchText)
        filteredItems = {}
        searchText = searchText and searchText:lower() or ""

        for _, item in ipairs(items) do
            local matchesSearch = searchText == "" or
                tostring(item.id):find(searchText, 1, true) or
                (item.name and item.name:lower():find(searchText, 1, true)) or
                (item.desc and item.desc:lower():find(searchText, 1, true))

            if matchesSearch then
                table.insert(filteredItems, item)
            end
        end

        -- Sort by ID
        table.sort(filteredItems, function(a, b) return a.id < b.id end)

        currentPage = 1
        scrollOffset = 0
    end

    -- Update displayed items
    local function UpdateDisplay()
        -- Hide all existing headers
        for _, header in ipairs(headerPool) do
            header:Hide()
        end
        -- Hide all existing item buttons
        for _, btn in ipairs(itemButtonPool) do
            btn:Hide()
        end

        local totalItems = #filteredItems
        local totalPages = math.ceil(totalItems / PAGE_SIZE)
        if totalPages < 1 then totalPages = 1 end
        local startIdx = (currentPage - 1) * PAGE_SIZE + 1
        local endIdx = math.min(startIdx + PAGE_SIZE - 1, totalItems)

        -- Update results text
        resultsText:SetText(totalItems .. " results")

        -- Group items by category
        local categories = {}
        local categoryOrder = {}

        for i = startIdx, endIdx do
            local item = filteredItems[i]
            if item then
                local cat = item.category or "OTHER"
                if not categories[cat] then
                    categories[cat] = {}
                    table.insert(categoryOrder, cat)
                end
                table.insert(categories[cat], item)
            end
        end

        -- Display items with category headers
        local yOffset = 0
        local headerIndex = 0
        local itemIndex = 0

        for _, category in ipairs(categoryOrder) do
            -- Category header
            headerIndex = headerIndex + 1
            local header = headerPool[headerIndex]
            if not header then
                header = CreateCategoryHeader(headerIndex)
                headerPool[headerIndex] = header
            end
            header.text:SetText(category)
            header:SetPoint("TOPLEFT", 0, -yOffset)
            header:Show()
            yOffset = yOffset + 20

            -- Items in category
            for _, item in ipairs(categories[category]) do
                itemIndex = itemIndex + 1
                local btn = itemButtonPool[itemIndex]
                if not btn then
                    btn = CreateItemButton(itemIndex)
                    itemButtonPool[itemIndex] = btn
                end

                btn.idText:SetText(tostring(item.id))
                btn.nameText:SetText(item.name or "Unknown")
                btn.descText:SetText(item.desc or "")
                btn.item = item
                btn.isSelected = selectedItem and selectedItem.id == item.id

                if btn.isSelected then
                    SetSolidColor(btn.bg, COLORS.Blue[1], COLORS.Blue[2], COLORS.Blue[3], 0.5)
                else
                    SetSolidColor(btn.bg, 0, 0, 0, 0)
                end

                btn:SetScript("OnClick", function(self)
                    selectedItem = self.item
                    idText:SetText(tostring(selectedItem.id))
                    nameText:SetText(selectedItem.name)
                    clearBtn:Show()

                    if onSelect then
                        onSelect(selectedItem)
                    end

                    dropdown:Hide()
                    isOpen = false
                    arrowText:SetText("v")
                end)

                btn:SetPoint("TOPLEFT", 0, -yOffset)
                btn:Show()
                yOffset = yOffset + ITEM_HEIGHT
            end
        end

        scrollContent:SetHeight(math.max(yOffset, 1))

        -- Update scrollbar visibility and range
        local contentHeight = scrollContent:GetHeight()
        local frameHeight = scrollFrame:GetHeight()
        if contentHeight > frameHeight then
            local maxScroll = contentHeight - frameHeight
            scrollBar:SetMinMaxValues(0, maxScroll)
            scrollBar:SetValueStep(ITEM_HEIGHT)
            scrollBar:Show()
        else
            scrollBar:SetMinMaxValues(0, 0)
            scrollBar:SetValue(0)
            scrollBar:Hide()
        end
    end

    -- Search box events
    searchBox:SetScript("OnTextChanged", function(self, userInput)
        local text = self:GetText() or ""
        if text == "" then
            placeholder:Show()
        else
            placeholder:Hide()
        end
        -- Always filter and update, regardless of userInput flag
        FilterItems(text)
        UpdateDisplay()
        -- Reset scroll position on new search
        scrollOffset = 0
        scrollFrame:SetVerticalScroll(0)
        scrollBar:SetValue(0)
    end)

    searchBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)

    searchBox:SetScript("OnEditFocusGained", function(self)
        placeholder:Hide()
    end)

    searchBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            placeholder:Show()
        end
    end)

    -- Toggle dropdown
    selectBtn:SetScript("OnClick", function()
        isOpen = not isOpen
        if isOpen then
            FilterItems(searchBox:GetText())
            UpdateDisplay()
            dropdown:Show()
            arrowText:SetText("^")
            searchBox:SetFocus()
        else
            dropdown:Hide()
            arrowText:SetText("v")
        end
    end)

    -- Clear button
    clearBtn:SetScript("OnClick", function()
        selectedItem = nil
        idText:SetText("")
        nameText:SetText("Select...")
        clearBtn:Hide()
        if onSelect then
            onSelect(nil)
        end
    end)

    -- Mouse wheel scrolling
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local maxScroll = scrollContent:GetHeight() - scrollFrame:GetHeight()
        if maxScroll > 0 then
            scrollOffset = math.max(0, math.min(maxScroll, scrollOffset - delta * 30))
            scrollFrame:SetVerticalScroll(scrollOffset)
            scrollBar:SetValue(scrollOffset)  -- Sync scrollbar position
        end
    end)

    -- Reset scroll on show
    dropdown:SetScript("OnShow", function()
        scrollOffset = 0
        scrollFrame:SetVerticalScroll(0)
        scrollBar:SetValue(0)
    end)

    -- Show clear button if value is set
    if selectedItem then
        clearBtn:Show()
    end

    -- Public API
    container.SetValue = function(self, value)
        selectedItem = nil
        for _, item in ipairs(items) do
            if item.id == value then
                selectedItem = item
                break
            end
        end
        if selectedItem then
            idText:SetText(tostring(selectedItem.id))
            nameText:SetText(selectedItem.name)
            clearBtn:Show()
        else
            idText:SetText("")
            nameText:SetText("Select...")
            clearBtn:Hide()
        end
    end

    container.GetValue = function(self)
        return selectedItem and selectedItem.id or nil
    end

    container.GetSelectedItem = function(self)
        return selectedItem
    end

    container.SetItems = function(self, newItems)
        items = newItems or {}
        FilterItems(searchBox:GetText())
        UpdateDisplay()
    end

    container.Close = function(self)
        dropdown:Hide()
        isOpen = false
        arrowText:SetText("v")
    end

    -- Adjust container height to include label
    container:SetHeight(50)

    return container
end

-- Export to global
_G.CreateEnumSelector = CreateEnumSelector

-- Print load message (debug)
-- print("|cFF00FF00[UIStyleLibrary] EnumSelector loaded|r")
