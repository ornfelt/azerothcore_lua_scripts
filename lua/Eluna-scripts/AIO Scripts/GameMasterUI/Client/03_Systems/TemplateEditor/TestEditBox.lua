-- Test UIStyleLibrary EditBox functionality for Template Editor fix
local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Test UIStyleLibrary EditBox
local function TestUIStyleEditBox()
    if not _G.CreateStyledEditBox then
        print("|cFFFF0000UIStyleLibrary not loaded - cannot test|r")
        return false
    end
    
    print("|cFF00FF00Testing UIStyleLibrary EditBox...|r")
    
    -- Create test frame
    local testFrame = CreateFrame("Frame", nil, UIParent)
    testFrame:SetSize(1, 1)
    testFrame:SetPoint("CENTER")
    
    -- Test regular text editbox
    local textBox = _G.CreateStyledEditBox(testFrame, 200, false)
    if not textBox then
        print("|cFFFF0000FAIL: CreateStyledEditBox returned nil|r")
        return false
    end
    
    -- Check structure
    if not textBox.editBox then
        print("|cFFFF0000FAIL: No editBox property in container|r")
        return false
    end
    
    -- Test setting scripts on actual EditBox
    local success = pcall(function()
        textBox.editBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        textBox.editBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
        textBox.editBox:SetScript("OnEditFocusLost", function(self) end)
    end)
    
    if not success then
        print("|cFFFF0000FAIL: Could not set scripts on editBox|r")
        return false
    end
    
    -- Test numeric editbox
    local numBox = _G.CreateStyledEditBox(testFrame, 200, true)
    if not numBox or not numBox.editBox then
        print("|cFFFF0000FAIL: Numeric editbox creation failed|r")
        return false
    end
    
    print("|cFF00FF00SUCCESS: All UIStyleLibrary EditBox tests passed!|r")
    
    -- Clean up
    testFrame:Hide()
    testFrame:SetParent(nil)
    
    return true
end

-- Test the actual CreatureTemplateEditor field creation
local function TestTemplateEditorFields()
    if not _G.CreatureTemplateEditor then
        print("|cFFFF0000CreatureTemplateEditor not loaded - skipping|r")
        return false
    end
    
    print("|cFF00FF00Testing CreatureTemplateEditor field creation...|r")
    
    -- Create a mock parent
    local parent = CreateFrame("Frame", nil, UIParent)
    parent:SetSize(600, 400)
    parent:Hide()
    
    -- Test different field types
    local testFields = {
        { key = "name", label = "Name:", type = "text" },
        { key = "level", label = "Level:", type = "number", min = 1, max = 80 },
        { key = "scale", label = "Scale:", type = "decimal", min = 0.1, max = 10 },
        { key = "npcflag", label = "NPC Flags:", type = "flags" }
    }
    
    local allPassed = true
    for _, field in ipairs(testFields) do
        local success = pcall(function()
            local fieldFrame = _G.CreatureTemplateEditor.CreateField(parent, field, -20)
            if not fieldFrame then
                error("Field creation returned nil")
            end
        end)
        
        if success then
            print("|cFF00FF00  " .. field.type .. " field: PASS|r")
        else
            print("|cFFFF0000  " .. field.type .. " field: FAIL|r")
            allPassed = false
        end
    end
    
    -- Clean up
    parent:Hide()
    parent:SetParent(nil)
    
    return allPassed
end

-- Test the cleanup functionality
local function TestCleanupFunctionality()
    if not _G.TemplateUI or not _G.TemplateUI.CleanupContent then
        print("|cFFFF0000FAIL: TemplateUI.CleanupContent not available|r")
        return false
    end
    
    print("|cFF00FF00Testing cleanup functionality...|r")
    
    -- Create test frame
    local testFrame = CreateFrame("Frame", nil, UIParent)
    testFrame:SetSize(400, 300)
    testFrame:Hide()
    
    -- Initialize tracking tables
    testFrame.fieldLabels = {}
    testFrame.fields = {}
    
    -- Create some test FontStrings
    local testLabel1 = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    testLabel1:SetText("Test Label 1")
    table.insert(testFrame.fieldLabels, testLabel1)
    
    local testLabel2 = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    testLabel2:SetText("Test Label 2") 
    table.insert(testFrame.fieldLabels, testLabel2)
    
    testFrame.headerText = testFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    testFrame.headerText:SetText("Test Header")
    
    -- Test cleanup
    local success = pcall(function()
        _G.TemplateUI.CleanupContent(testFrame)
    end)
    
    if not success then
        print("|cFFFF0000FAIL: CleanupContent threw an error|r")
        return false
    end
    
    -- Verify cleanup worked
    if #testFrame.fieldLabels > 0 then
        print("|cFFFF0000FAIL: fieldLabels not cleared|r")
        return false
    end
    
    if testFrame.headerText ~= nil then
        print("|cFFFF0000FAIL: headerText not cleared|r")
        return false
    end
    
    -- Clean up test frame
    testFrame:SetParent(nil)
    
    print("|cFF00FF00SUCCESS: Cleanup functionality works!|r")
    return true
end

-- Run all tests
SLASH_TESTTEMPLATEFIX1 = "/testtemplatefix"
SlashCmdList["TESTTEMPLATEFIX"] = function()
    print("|cFFFFFF00=== Running Template Editor Fix Tests ===|r")
    
    local uiStyleOK = TestUIStyleEditBox()
    local fieldsOK = TestTemplateEditorFields()
    local cleanupOK = TestCleanupFunctionality()
    
    if uiStyleOK and fieldsOK and cleanupOK then
        print("|cFF00FF00=== ALL TESTS PASSED ===|r")
        print("|cFF00FF00The overlapping text issues should be fixed!|r")
        print("|cFF00FF00Try opening the template editor with /testtemplate|r")
    else
        print("|cFFFF0000=== SOME TESTS FAILED ===|r")
        if not uiStyleOK then
            print("|cFFFF0000Check UIStyleLibrary installation|r")
        end
        if not cleanupOK then
            print("|cFFFF0000Cleanup functionality failed|r")
        end
    end
end

-- print("|cFF00FF00[TemplateEditor Fix Test] Use /testtemplatefix to verify the fixes|r")