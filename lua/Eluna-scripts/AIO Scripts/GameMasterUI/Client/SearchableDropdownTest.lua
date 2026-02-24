local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Test searchable dropdown functionality
local function TestSearchableDropdown()
    -- Create test frame
    local testFrame = CreateFrame("Frame", "SearchableDropdownTestFrame", UIParent)
    testFrame:SetSize(400, 300)
    testFrame:SetPoint("CENTER")
    testFrame:SetFrameStrata("DIALOG")
    testFrame:SetMovable(true)
    testFrame:EnableMouse(true)
    testFrame:RegisterForDrag("LeftButton")
    testFrame:SetScript("OnDragStart", testFrame.StartMoving)
    testFrame:SetScript("OnDragStop", testFrame.StopMovingOrSizing)
    
    -- Background
    testFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 1,
        insets = {left = 1, right = 1, top = 1, bottom = 1}
    })
    testFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    testFrame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    
    -- Title
    local title = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("Searchable Dropdown Test")
    title:SetTextColor(1, 1, 1)
    
    -- Create test items (many items to trigger search functionality)
    local testItems = {}
    for i = 1, 25 do
        table.insert(testItems, {
            text = "Test Item " .. i,
            value = i
        })
    end
    
    -- Add some special items for better testing
    table.insert(testItems, { text = "Special Option Alpha", value = "alpha" })
    table.insert(testItems, { text = "Special Option Beta", value = "beta" })
    table.insert(testItems, { text = "Different Category", value = "different" })
    table.insert(testItems, { text = "Another Choice", value = "another" })
    
    -- Test dropdown WITHOUT search
    local normalLabel = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    normalLabel:SetPoint("TOPLEFT", 20, -50)
    normalLabel:SetText("Normal Dropdown:")
    normalLabel:SetTextColor(1, 1, 1)
    
    local normalDropdown = CreateFullyStyledDropdown(
        testFrame,
        200,
        testItems,
        "Select an option...",
        function(value, item)
            print("Normal dropdown selected:", value, item.text)
        end
    )
    normalDropdown:SetPoint("TOPLEFT", normalLabel, "BOTTOMLEFT", 0, -10)
    
    -- Test dropdown WITH search
    local searchLabel = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    searchLabel:SetPoint("TOPLEFT", 20, -120)
    searchLabel:SetText("Searchable Dropdown:")
    searchLabel:SetTextColor(1, 1, 1)
    
    local searchableDropdown = CreateFullyStyledDropdown(
        testFrame,
        200,
        testItems,
        "Select an option...",
        function(value, item)
            print("Searchable dropdown selected:", value, item.text)
        end,
        true, -- Enable search
        "Type to filter options..."
    )
    searchableDropdown:SetPoint("TOPLEFT", searchLabel, "BOTTOMLEFT", 0, -10)
    
    -- Close button
    local closeBtn = CreateFrame("Button", nil, testFrame)
    closeBtn:SetSize(20, 20)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    closeBtn:SetScript("OnClick", function()
        testFrame:Hide()
    end)
    
    -- Instructions
    local instructions = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    instructions:SetPoint("BOTTOM", 0, 20)
    instructions:SetText("Compare the two dropdowns above. The bottom one has search functionality.")
    instructions:SetTextColor(0.8, 0.8, 0.8)
    
    testFrame:Show()
    print("Searchable Dropdown Test window created. Compare the two dropdowns!")
end

-- Create slash command for testing
SLASH_SEARCHDROPDOWNTEST1 = "/testdropdown"
SlashCmdList["SEARCHDROPDOWNTEST"] = TestSearchableDropdown

-- print("|cFF00FF00[SearchableDropdownTest] Loaded. Use /testdropdown to test!|r")