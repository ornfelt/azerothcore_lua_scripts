local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Test validation for predefined values
local function TestPredefinedValues()
    local PredefinedValues = _G.ItemTemplatePredefinedValues
    
    if not PredefinedValues then
        print("|cFFFF0000[TestPredefinedValues] Error: ItemTemplatePredefinedValues not found!|r")
        return false
    end
    
    local testResults = {}
    local function addResult(test, success, details)
        table.insert(testResults, {test = test, success = success, details = details or ""})
    end
    
    -- Test basic enumerations exist
    addResult("ITEM_CLASSES", PredefinedValues.ITEM_CLASSES ~= nil, "Count: " .. (#(PredefinedValues.ITEM_CLASSES or {})))
    addResult("ITEM_QUALITIES", PredefinedValues.ITEM_QUALITIES ~= nil, "Count: " .. (#(PredefinedValues.ITEM_QUALITIES or {})))
    addResult("INVENTORY_TYPES", PredefinedValues.INVENTORY_TYPES ~= nil, "Count: " .. (#(PredefinedValues.INVENTORY_TYPES or {})))
    addResult("BONDING_TYPES", PredefinedValues.BONDING_TYPES ~= nil, "Count: " .. (#(PredefinedValues.BONDING_TYPES or {})))
    addResult("STAT_TYPES", PredefinedValues.STAT_TYPES ~= nil, "Count: " .. (#(PredefinedValues.STAT_TYPES or {})))
    addResult("SPELL_TRIGGERS", PredefinedValues.SPELL_TRIGGERS ~= nil, "Count: " .. (#(PredefinedValues.SPELL_TRIGGERS or {})))
    addResult("MATERIAL_TYPES", PredefinedValues.MATERIAL_TYPES ~= nil, "Count: " .. (#(PredefinedValues.MATERIAL_TYPES or {})))
    addResult("SHEATH_TYPES", PredefinedValues.SHEATH_TYPES ~= nil, "Count: " .. (#(PredefinedValues.SHEATH_TYPES or {})))
    addResult("BAG_FAMILY", PredefinedValues.BAG_FAMILY ~= nil, "Count: " .. (#(PredefinedValues.BAG_FAMILY or {})))
    addResult("SOCKET_COLORS", PredefinedValues.SOCKET_COLORS ~= nil, "Count: " .. (#(PredefinedValues.SOCKET_COLORS or {})))
    addResult("TOTEM_CATEGORIES", PredefinedValues.TOTEM_CATEGORIES ~= nil, "Count: " .. (#(PredefinedValues.TOTEM_CATEGORIES or {})))
    addResult("FOOD_TYPES", PredefinedValues.FOOD_TYPES ~= nil, "Count: " .. (#(PredefinedValues.FOOD_TYPES or {})))
    addResult("PAGE_MATERIALS", PredefinedValues.PAGE_MATERIALS ~= nil, "Count: " .. (#(PredefinedValues.PAGE_MATERIALS or {})))
    addResult("LANGUAGE_IDS", PredefinedValues.LANGUAGE_IDS ~= nil, "Count: " .. (#(PredefinedValues.LANGUAGE_IDS or {})))
    addResult("ITEM_SUBCLASSES", PredefinedValues.ITEM_SUBCLASSES ~= nil, "Tables: " .. (PredefinedValues.ITEM_SUBCLASSES and #(PredefinedValues.ITEM_SUBCLASSES) or 0))
    
    -- Test specific values
    if PredefinedValues.STAT_TYPES then
        local hasStamina = false
        local hasSpellPower = false
        for _, stat in ipairs(PredefinedValues.STAT_TYPES) do
            if stat.value == 7 and stat.text == "Stamina" then hasStamina = true end
            if stat.value == 45 and stat.text == "Spell Power" then hasSpellPower = true end
        end
        addResult("Stamina stat (value 7)", hasStamina)
        addResult("Spell Power stat (value 45)", hasSpellPower)
    end
    
    if PredefinedValues.SPELL_TRIGGERS then
        local hasOnUse = false
        local hasOnEquip = false
        for _, trigger in ipairs(PredefinedValues.SPELL_TRIGGERS) do
            if trigger.value == 0 and trigger.text == "On Use" then hasOnUse = true end
            if trigger.value == 1 and trigger.text == "On Equip" then hasOnEquip = true end
        end
        addResult("On Use trigger (value 0)", hasOnUse)
        addResult("On Equip trigger (value 1)", hasOnEquip)
    end
    
    if PredefinedValues.MATERIAL_TYPES then
        local hasConsumables = false
        local hasMetal = false
        for _, material in ipairs(PredefinedValues.MATERIAL_TYPES) do
            if material.value == -1 and material.text == "Consumables" then hasConsumables = true end
            if material.value == 1 and material.text == "Metal" then hasMetal = true end
        end
        addResult("Consumables material (value -1)", hasConsumables)
        addResult("Metal material (value 1)", hasMetal)
    end
    
    -- Test subclass structure
    if PredefinedValues.ITEM_SUBCLASSES then
        local hasWeaponSubclasses = PredefinedValues.ITEM_SUBCLASSES[2] ~= nil
        local hasArmorSubclasses = PredefinedValues.ITEM_SUBCLASSES[4] ~= nil
        addResult("Weapon subclasses (class 2)", hasWeaponSubclasses)
        addResult("Armor subclasses (class 4)", hasArmorSubclasses)
    end
    
    -- Print results
    -- print("|cFF00FF00[TestPredefinedValues] Running validation tests...|r")
    -- print("=" .. string.rep("=", 60))
    
    local passed = 0
    local total = #testResults
    
    for _, result in ipairs(testResults) do
        local color = result.success and "|cFF00FF00" or "|cFFFF0000"
        local status = result.success and "PASS" or "FAIL"
        -- print(string.format("%s[%s]|r %-30s %s", color, status, result.test, result.details))
        if result.success then passed = passed + 1 end
    end
    
    -- print("=" .. string.rep("=", 60))
    -- print(string.format("|cFFFFFF00Results: %d/%d tests passed (%.1f%%)|r", passed, total, (passed/total)*100))
    
    if passed == total then
        -- print("|cFF00FF00All predefined values tests passed! Ready for use.|r")
    else
        -- print("|cFFFF0000Some tests failed. Check the predefined values file.|r")
    end
    
    return passed == total
end

-- Test ItemTemplateFieldDefs integration
local function TestFieldDefinitions()
    local ItemTemplateFieldDefs = _G.ItemTemplateFieldDefs
    
    if not ItemTemplateFieldDefs then
        print("|cFFFF0000[TestPredefinedValues] Error: ItemTemplateFieldDefs not found!|r")
        return false
    end
    
    -- print("|cFF00FF00[TestPredefinedValues] Testing field definitions integration...|r")
    
    local fields = ItemTemplateFieldDefs.FIELDS
    if not fields then
        print("|cFFFF0000Error: No FIELDS found in ItemTemplateFieldDefs|r")
        return false
    end
    
    local dropdownCount = 0
    local editableCount = 0
    
    -- Count dropdowns and editable fields
    for tabName, tabFields in pairs(fields) do
        for _, field in ipairs(tabFields) do
            if field.type == "dropdown" then
                dropdownCount = dropdownCount + 1
                if field.allowEdit then
                    editableCount = editableCount + 1
                end
            end
        end
    end
    
    -- print(string.format("Found %d dropdown fields, %d with edit buttons", dropdownCount, editableCount))
    
    -- Test GetSubclassOptions function
    if ItemTemplateFieldDefs.GetSubclassOptions then
        local weaponSubclasses = ItemTemplateFieldDefs.GetSubclassOptions(2) -- Weapons
        local armorSubclasses = ItemTemplateFieldDefs.GetSubclassOptions(4)  -- Armor
        
        -- print(string.format("Weapon subclasses: %d options", #(weaponSubclasses or {})))
        -- print(string.format("Armor subclasses: %d options", #(armorSubclasses or {})))
        
        if weaponSubclasses and #weaponSubclasses > 0 then
            -- print("|cFF00FF00Subclass system working correctly|r")
            return true
        else
            -- print("|cFFFF0000Subclass system not working|r")
            return false
        end
    else
        -- print("|cFFFF0000GetSubclassOptions function not found|r")
        return false
    end
end

-- Auto-run tests when file loads
local function RunAllTests()
    -- print("|cFFFFFF00" .. string.rep("=", 80) .. "|r")
    -- print("|cFFFFFF00     ITEM TEMPLATE PREDEFINED VALUES VALIDATION TESTS|r")
    -- print("|cFFFFFF00" .. string.rep("=", 80) .. "|r")
    
    local test1 = TestPredefinedValues()
    local test2 = TestFieldDefinitions()
    
    -- print("|cFFFFFF00" .. string.rep("=", 80) .. "|r")
    
    -- if test1 and test2 then
    --     print("|cFF00FF00     ALL TESTS PASSED - SYSTEM READY FOR USE!|r")
    -- else
    --     print("|cFFFF0000     SOME TESTS FAILED - CHECK CONFIGURATION|r")
    -- end
    
    -- print("|cFFFFFF00" .. string.rep("=", 80) .. "|r")
end

-- Export test function for manual use
_G.TestItemTemplatePredefinedValues = RunAllTests

-- Auto-run tests after a delay to ensure all files are loaded
if C_Timer and C_Timer.After then
    C_Timer.After(2, RunAllTests)
else
    -- Fallback for C_Timer not being available (shouldn't happen with UIStyleLibrary)
    local delayFrame = CreateFrame("Frame")
    local timeElapsed = 0
    delayFrame:SetScript("OnUpdate", function(self, elapsed)
        timeElapsed = timeElapsed + elapsed
        if timeElapsed >= 2 then
            self:SetScript("OnUpdate", nil)
            RunAllTests()
        end
    end)
    -- print("|cFFFF0000[TestPredefinedValues] WARNING: C_Timer not available, using fallback timer|r")
end

-- print("|cFF00FF00[TestPredefinedValues] Test file loaded. Tests will run automatically in 2 seconds.|r")
-- print("|cFFFFFF00You can also run tests manually with: /run TestItemTemplatePredefinedValues()|r")