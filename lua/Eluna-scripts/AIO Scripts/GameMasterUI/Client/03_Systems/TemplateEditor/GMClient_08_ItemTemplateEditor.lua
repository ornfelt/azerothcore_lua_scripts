local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize ItemTemplateEditor namespace
_G.ItemTemplateEditor = _G.ItemTemplateEditor or {}
local ItemTemplateEditor = _G.ItemTemplateEditor

-- Get references to modules
local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local ItemTemplateFieldDefs = _G.ItemTemplateFieldDefs
local TemplateUI = _G.TemplateUI

-- Check dependencies
if not ItemTemplateFieldDefs then
    print("|cFFFF0000[ItemTemplateEditor] Error: ItemTemplateFieldDefs not loaded!|r")
    return
end

if not TemplateUI then
    print("|cFFFF0000[ItemTemplateEditor] Error: TemplateUI not loaded!|r")
    return
end

-- Current state
ItemTemplateEditor.isOpen = false
ItemTemplateEditor.currentTab = 1
ItemTemplateEditor.originalData = nil
ItemTemplateEditor.editedData = nil
ItemTemplateEditor.entryId = nil
ItemTemplateEditor.isDuplicate = false
ItemTemplateEditor.nextAvailableEntry = nil
ItemTemplateEditor.customEntryId = nil

-- Configuration (use from field defs module)
local CONFIG = ItemTemplateFieldDefs.CONFIG
local FIELDS = ItemTemplateFieldDefs.FIELDS
local SCALING_PRESETS = ItemTemplateFieldDefs.SCALING_PRESETS

-- Select a tab
function ItemTemplateEditor.SelectTab(tabId)
    -- Force save any pending changes from current tab before switching
    ItemTemplateEditor.ForceFieldSave()
    
    ItemTemplateEditor.currentTab = tabId
    
    -- The TemplateUI handles tab switching automatically, including content area updates
    -- We just need to populate the fields for the new tab
    ItemTemplateEditor.PopulateFields()
end

-- Populate fields for current tab
function ItemTemplateEditor.PopulateFields()
    local frame = ItemTemplateEditor.frame
    if not frame then return end
    
    local content = frame.content
    local tabName = CONFIG.TABS[ItemTemplateEditor.currentTab]
    local fields = FIELDS[tabName]
    
    if not content or not fields then return end
    
    -- Use the comprehensive cleanup function
    TemplateUI.CleanupContent(content)
    
    -- Initialize field tracking
    content.fields = {}
    content.fieldLabels = {}
    
    -- Check if this tab uses two-column layout
    local useTwoColumns = CONFIG.USE_TWO_COLUMNS and CONFIG.USE_TWO_COLUMNS[tabName]
    
    -- Initialize offset variables at function scope
    local currentYOffset = -10
    local yOffset = -10
    
    if useTwoColumns then
        -- Two-column paired layout
        local processedFields = {}
        
        -- Helper function to create and position a field
        local function CreateAndPositionField(field, xOffset, yOffset)
            local success, fieldFrame = pcall(function()
                -- Special handling for subclass field to use context-specific options
                local fieldToUse = field
                if field.key == "subclass" and ItemTemplateEditor.originalData and ItemTemplateEditor.originalData.class then
                    -- Create a modified field with context-specific subclass options
                    fieldToUse = {}
                    for k, v in pairs(field) do
                        fieldToUse[k] = v
                    end
                    fieldToUse.options = ItemTemplateFieldDefs.GetSubclassOptions(ItemTemplateEditor.originalData.class)
                end
                
                if field.key == "ScalingPreset" then
                    return TemplateUI.CreateField(content, fieldToUse, CONFIG, ItemTemplateEditor.OnScalingPresetChanged)
                else
                    return TemplateUI.CreateField(content, fieldToUse, CONFIG, ItemTemplateEditor.OnFieldChanged)
                end
            end)
            
            if success and fieldFrame then
                table.insert(content.fields, fieldFrame)
                
                -- Set position and width
                fieldFrame:SetPoint("TOPLEFT", content, "TOPLEFT", xOffset, yOffset)
                fieldFrame:SetWidth(CONFIG.COLUMN_WIDTH)
                
                -- Set initial value
                local valueToSet = nil
                if ItemTemplateEditor.editedData and ItemTemplateEditor.editedData[field.key] ~= nil then
                    valueToSet = ItemTemplateEditor.editedData[field.key]
                elseif ItemTemplateEditor.originalData and ItemTemplateEditor.originalData[field.key] ~= nil then
                    valueToSet = ItemTemplateEditor.originalData[field.key]
                end
                
                if valueToSet ~= nil and TemplateUI.SetFieldValue then
                    TemplateUI.SetFieldValue(fieldFrame, valueToSet)
                end
                
                return fieldFrame
            end
            return nil
        end
        
        -- Helper function to find field by key
        local function FindFieldByKey(key)
            if key == "_empty" then return nil end
            for _, field in ipairs(fields) do
                if field.key == key then
                    return field
                end
            end
            return nil
        end
        
        -- Process fields in pairs
        for _, field in ipairs(fields) do
            if not processedFields[field.key] then
                if field.pair then
                    -- This field has a pair - create both side by side
                    local leftField = field
                    local rightField = FindFieldByKey(field.pair)
                    
                    -- Create left field
                    CreateAndPositionField(leftField, 0, currentYOffset)
                    processedFields[leftField.key] = true
                    
                    -- Create right field (if it exists)
                    if rightField then
                        CreateAndPositionField(rightField, CONFIG.COLUMN_WIDTH + CONFIG.COLUMN_SPACING, currentYOffset)
                        processedFields[rightField.key] = true
                    end
                    
                    -- Calculate spacing
                    local spacing = CONFIG.FIELD_HEIGHT + 5
                    if leftField.type == "decimal" and leftField.key:match("Modifier") then
                        spacing = CONFIG.FIELD_HEIGHT + 20
                    elseif leftField.type == "dropdown" then
                        spacing = CONFIG.FIELD_HEIGHT + 8
                    end
                    currentYOffset = currentYOffset - spacing
                    
                    -- Add group separator if specified
                    if leftField.groupEnd then
                        currentYOffset = currentYOffset - 15  -- Extra spacing between groups
                    end
                    
                else
                    -- No pair - single field in left column
                    CreateAndPositionField(field, 0, currentYOffset)
                    processedFields[field.key] = true
                    
                    local spacing = CONFIG.FIELD_HEIGHT + 5
                    if field.type == "decimal" and field.key:match("Modifier") then
                        spacing = CONFIG.FIELD_HEIGHT + 20
                    elseif field.type == "dropdown" then
                        spacing = CONFIG.FIELD_HEIGHT + 8
                    end
                    currentYOffset = currentYOffset - spacing
                    
                    if field.groupEnd then
                        currentYOffset = currentYOffset - 15
                    end
                end
            end
        end
    else
        -- Single-column layout (original logic)
        for _, field in ipairs(fields) do
            local success, fieldFrame = pcall(function()
                -- Special handling for scaling preset dropdown
                if field.key == "ScalingPreset" then
                    local presetField = TemplateUI.CreateField(content, field, CONFIG, ItemTemplateEditor.OnScalingPresetChanged)
                    presetField:SetPoint("TOPLEFT", 0, yOffset)
                    presetField:SetPoint("TOPRIGHT", 0, yOffset)
                    return presetField
                else
                    -- Special handling for subclass field to use context-specific options
                    local fieldToUse = field
                    if field.key == "subclass" and ItemTemplateEditor.originalData and ItemTemplateEditor.originalData.class then
                        -- Create a modified field with context-specific subclass options
                        fieldToUse = {}
                        for k, v in pairs(field) do
                            fieldToUse[k] = v
                        end
                        fieldToUse.options = ItemTemplateFieldDefs.GetSubclassOptions(ItemTemplateEditor.originalData.class)
                    end
                    
                    local fieldFrame = TemplateUI.CreateField(content, fieldToUse, CONFIG, ItemTemplateEditor.OnFieldChanged)
                    fieldFrame:SetPoint("TOPLEFT", 0, yOffset)
                    fieldFrame:SetPoint("TOPRIGHT", 0, yOffset)
                    return fieldFrame
                end
            end)
            
            if success and fieldFrame then
                table.insert(content.fields, fieldFrame)
                
                -- Adjust spacing based on field type
                local spacing = CONFIG.FIELD_HEIGHT + 5
                if field.type == "decimal" and field.key:match("Modifier") then
                    spacing = CONFIG.FIELD_HEIGHT + 20
                elseif field.type == "dropdown" then
                    spacing = CONFIG.FIELD_HEIGHT + 8
                end
                yOffset = yOffset - spacing
                
                -- Set initial value
                local valueToSet = nil
                if ItemTemplateEditor.editedData and ItemTemplateEditor.editedData[field.key] ~= nil then
                    valueToSet = ItemTemplateEditor.editedData[field.key]
                elseif ItemTemplateEditor.originalData and ItemTemplateEditor.originalData[field.key] ~= nil then
                    valueToSet = ItemTemplateEditor.originalData[field.key]
                end
                
                if valueToSet ~= nil and TemplateUI.SetFieldValue then
                    TemplateUI.SetFieldValue(fieldFrame, valueToSet)
                end
            end
        end
    end
    
    -- Update scroll height based on layout type
    local finalHeight = 100  -- Default minimum height
    if useTwoColumns then
        finalHeight = math.abs(currentYOffset) + 50
    else
        finalHeight = math.abs(yOffset) + 50
    end
    content:SetHeight(finalHeight)
    
    -- Update scrollbar
    if frame.updateScrollBar then
        frame.updateScrollBar()
    end
end

-- Handle field changes
function ItemTemplateEditor.OnFieldChanged(key, value)
    if not ItemTemplateEditor.editedData then
        ItemTemplateEditor.editedData = {}
    end
    
    ItemTemplateEditor.editedData[key] = value
    
    -- Handle context-dependent field updates
    if key == "class" then
        ItemTemplateEditor.UpdateSubclassOptions(value)
    end
    
    -- Update save button color if changed
    if ItemTemplateEditor.frame and ItemTemplateEditor.frame.saveBtn then
        if ItemTemplateEditor.HasChanges() then
            ItemTemplateEditor.frame.saveBtn:SetText("|cFFFFFF00Save*|r")
        else
            ItemTemplateEditor.frame.saveBtn:SetText("Save")
        end
    end
end

-- Update subclass dropdown options based on selected item class
function ItemTemplateEditor.UpdateSubclassOptions(itemClass, preserveValue)
    if not ItemTemplateEditor.frame or not ItemTemplateEditor.frame.tabPanels then
        return
    end
    
    -- Find the subclass field in the Basic tab (tab 1)
    local basicTabContent = ItemTemplateEditor.frame.tabPanels[1]
    if not basicTabContent or not basicTabContent.fields then
        return
    end
    
    -- Find subclass field frame
    local subclassField = nil
    for _, fieldFrame in pairs(basicTabContent.fields) do
        if fieldFrame.field and fieldFrame.field.key == "subclass" then
            subclassField = fieldFrame
            break
        end
    end
    
    if not subclassField or not subclassField.input then
        return
    end
    
    -- Get new subclass options from predefined values
    local newOptions = ItemTemplateFieldDefs.GetSubclassOptions(itemClass)
    if not newOptions then
        return
    end
    
    -- Update dropdown options
    local dropdown = subclassField.input
    if dropdown.UpdateOptions then
        -- Create items in the format expected by the dropdown
        local items = {}
        local valueMap = {}
        for _, option in ipairs(newOptions) do
            table.insert(items, {
                text = option.text,
                value = option.value
            })
            valueMap[option.value] = option.text
        end
        dropdown:UpdateOptions(items)
        dropdown.valueMap = valueMap
        
        -- Set the appropriate subclass value
        if preserveValue ~= nil then
            -- Try to find and set the specific subclass value
            local foundOption = nil
            for _, option in ipairs(newOptions) do
                if option.value == preserveValue then
                    foundOption = option
                    break
                end
            end
            
            if foundOption then
                dropdown:SetValue(foundOption.value, foundOption.text)
                -- Don't trigger OnFieldChanged when preserving value during data load
            else
                -- Fallback to first option if the value isn't valid for this class
                if #newOptions > 0 then
                    dropdown:SetValue(newOptions[1].value, newOptions[1].text)
                end
            end
        else
            -- Reset to first option (when user changes class)
            if #newOptions > 0 then
                dropdown:SetValue(newOptions[1].value, newOptions[1].text)
                ItemTemplateEditor.OnFieldChanged("subclass", newOptions[1].value)
            end
        end
    end
end

-- Handle scaling preset changes
function ItemTemplateEditor.OnScalingPresetChanged(key, value)
    ItemTemplateEditor.OnFieldChanged(key, value)
    
    -- Apply preset if selected
    if value and value ~= "" and SCALING_PRESETS[value] then
        local preset = SCALING_PRESETS[value]
        
        -- Apply preset values to scaling fields
        for presetKey, presetValue in pairs(preset) do
            ItemTemplateEditor.OnFieldChanged(presetKey, presetValue)
        end
        
        -- Refresh current tab if it's the scaling tab
        if ItemTemplateEditor.currentTab == 7 then -- Scaling tab index
            ItemTemplateEditor.PopulateFields()
        end
    end
end

-- Check if there are unsaved changes
function ItemTemplateEditor.HasChanges()
    if not ItemTemplateEditor.originalData or not ItemTemplateEditor.editedData then
        return false
    end
    
    for key, value in pairs(ItemTemplateEditor.editedData) do
        -- Skip entry field in comparison
        if key ~= "entry" and ItemTemplateEditor.originalData[key] ~= value then
            return true
        end
    end
    
    return false
end

-- Force save current field values (called before tab switches and save)
function ItemTemplateEditor.ForceFieldSave()
    local frame = ItemTemplateEditor.frame
    if not frame then return end
    
    -- Iterate through ALL tabs' scrollable content to force save all fields
    if frame.scrollableContents then
        for _, scrollContent in ipairs(frame.scrollableContents) do
            if scrollContent and scrollContent.fields then
                for _, fieldFrame in ipairs(scrollContent.fields) do
                    if fieldFrame and fieldFrame.input then
                        local editBox = fieldFrame.input.editBox or fieldFrame.input
                        
                        -- Force the edit box to lose focus if it's currently focused
                        if editBox and editBox.HasFocus and editBox:HasFocus() then
                            editBox:ClearFocus()
                        end
                    end
                end
            end
        end
    end
    
    -- Also check the current active content (fallback)
    if frame.content and frame.content.fields then
        for _, fieldFrame in ipairs(frame.content.fields) do
            if fieldFrame and fieldFrame.input then
                local editBox = fieldFrame.input.editBox or fieldFrame.input
                
                -- Force the edit box to lose focus if it's currently focused
                if editBox and editBox.HasFocus and editBox:HasFocus() then
                    editBox:ClearFocus()
                end
            end
        end
    end
    
    -- Clear any tracked active edit box
    if frame.content and frame.content.activeEditBox then
        frame.content.activeEditBox:ClearFocus()
        frame.content.activeEditBox = nil
    end
end

-- Save template data
function ItemTemplateEditor.SaveTemplate()
    if not ItemTemplateEditor.editedData then
        print("|cFFFF0000[ItemTemplateEditor] No data to save|r")
        return
    end
    
    ItemTemplateEditor.ForceFieldSave()
    
    -- Validate required fields - only for new items/duplicates
    if ItemTemplateEditor.isDuplicate then
        -- For new items, check if we have a valid name (from editedData or originalData)
        local itemName = ItemTemplateEditor.editedData.name or 
                        (ItemTemplateEditor.originalData and ItemTemplateEditor.originalData.name)
        if not itemName or itemName == "" then
            print("|cFFFF0000[ItemTemplateEditor] Item name is required for new items|r")
            return
        end
    end
    -- For updates, name validation is not needed - item already exists with a name
    
    -- Use custom entry if specified and duplicating
    local targetEntry = ItemTemplateEditor.entryId
    if ItemTemplateEditor.isDuplicate and ItemTemplateEditor.customEntryId and ItemTemplateEditor.customEntryId > 0 then
        targetEntry = ItemTemplateEditor.customEntryId
    elseif ItemTemplateEditor.isDuplicate and ItemTemplateEditor.nextAvailableEntry then
        targetEntry = ItemTemplateEditor.nextAvailableEntry
    end
    
    -- Apply scaling modifiers if they exist
    ItemTemplateEditor.ApplyScalingModifiers()
    
    local dataToSend
    
    if ItemTemplateEditor.isDuplicate then
        -- For duplicates/new items, we need ALL field values (edited + original)
        dataToSend = {}
        
        -- Start with all original values
        if ItemTemplateEditor.originalData then
            for key, value in pairs(ItemTemplateEditor.originalData) do
                if key ~= "entry" then  -- Skip entry field
                    dataToSend[key] = value
                end
            end
        end
        
        -- Override with any edited values
        if ItemTemplateEditor.editedData then
            for key, value in pairs(ItemTemplateEditor.editedData) do
                if key ~= "entry" then  -- Skip entry field
                    dataToSend[key] = value
                end
            end
        end
        
        print("|cFF00FF00[ItemTemplateEditor] Creating new item template " .. (targetEntry or "?") .. "...|r")
    else
        -- For updates, editedData now only contains actually changed fields
        local changeCount = 0
        for _ in pairs(ItemTemplateEditor.editedData or {}) do
            changeCount = changeCount + 1
        end
        
        if changeCount == 0 then
            print("|cFFFFFF00[ItemTemplateEditor] No changes to save|r")
            return
        end
        
        dataToSend = ItemTemplateEditor.editedData
        print("|cFF00FF00[ItemTemplateEditor] Saving " .. changeCount .. " changes to item template " .. targetEntry .. "...|r")
    end
    
    -- Prepare data structure like creature template editor
    local requestData = {
        entry = ItemTemplateEditor.entryId,
        isDuplicate = ItemTemplateEditor.isDuplicate,
        changes = dataToSend
    }
    
    -- Add custom entry ID if user has specified one
    if ItemTemplateEditor.customEntryId then
        requestData.customEntry = ItemTemplateEditor.customEntryId
    end
    
    -- Send save request to server
    if ItemTemplateEditor.isDuplicate then
        AIO.Handle("GameMasterSystem", "duplicateItemWithTemplate", requestData)
    else
        AIO.Handle("GameMasterSystem", "saveItemTemplate", requestData)
    end
end

-- Apply scaling modifiers to item stats (DISABLED - scaling fields don't exist in database)
function ItemTemplateEditor.ApplyScalingModifiers()
    -- This function is disabled because StatModifier, DamageModifier, ArmorModifier,
    -- and RequiredLevelModifier are not actual database fields in item_template.
    -- They were UI-only fields that caused database save errors.
    
    --[[ ORIGINAL SCALING CODE - COMMENTED OUT
    if not ItemTemplateEditor.editedData then return end
    
    local statMod = ItemTemplateEditor.editedData.StatModifier or 1.0
    local armorMod = ItemTemplateEditor.editedData.ArmorModifier or 1.0
    local levelMod = ItemTemplateEditor.editedData.RequiredLevelModifier or 0
    
    -- Apply stat modifiers
    if statMod ~= 1.0 then
        for i = 1, 10 do
            local statKey = "stat_value" .. i
            if ItemTemplateEditor.editedData[statKey] then
                ItemTemplateEditor.editedData[statKey] = math.floor(ItemTemplateEditor.editedData[statKey] * statMod + 0.5)
            end
        end
    end
    
    -- Apply armor modifier
    if armorMod ~= 1.0 and ItemTemplateEditor.editedData.armor then
        ItemTemplateEditor.editedData.armor = math.floor(ItemTemplateEditor.editedData.armor * armorMod + 0.5)
    end
    
    -- Apply level modifier
    if levelMod ~= 0 and ItemTemplateEditor.editedData.RequiredLevel then
        ItemTemplateEditor.editedData.RequiredLevel = math.max(1, ItemTemplateEditor.editedData.RequiredLevel + levelMod)
    end
    --]]
end

-- Save as new template
function ItemTemplateEditor.SaveAsNew()
    ItemTemplateEditor.isDuplicate = true
    ItemTemplateEditor.SaveTemplate()
end

-- Reset to original values
function ItemTemplateEditor.Reset()
    if not ItemTemplateEditor.originalData then return end
    
    ItemTemplateEditor.editedData = {}
    for key, value in pairs(ItemTemplateEditor.originalData) do
        ItemTemplateEditor.editedData[key] = value
    end
    
    ItemTemplateEditor.PopulateFields()
    
    if ItemTemplateEditor.frame and ItemTemplateEditor.frame.saveBtn then
        ItemTemplateEditor.frame.saveBtn:SetText("Save")
    end
    
    print("|cFF00FF00[ItemTemplateEditor] Reset to original values|r")
end

-- Confirm delete template
function ItemTemplateEditor.ConfirmDelete()
    if not ItemTemplateEditor.entryId then
        print("|cFFFF0000[ItemTemplateEditor] No item template to delete|r")
        return
    end
    
    -- Don't allow deleting during duplicate mode
    if ItemTemplateEditor.isDuplicate then
        print("|cFFFF0000[ItemTemplateEditor] Cannot delete while in duplicate mode|r")
        return
    end
    
    local itemName = ItemTemplateEditor.originalData and ItemTemplateEditor.originalData.name or "Unknown Item"
    
    -- Create confirmation popup
    StaticPopup_Show("ITEMTEMPLATEEDITOR_CONFIRM_DELETE", itemName, ItemTemplateEditor.entryId)
end

-- Delete template
function ItemTemplateEditor.DeleteTemplate()
    if not ItemTemplateEditor.entryId then
        print("|cFFFF0000[ItemTemplateEditor] No item template to delete|r")
        return
    end
    
    -- Send delete request to server
    AIO.Handle("GameMasterSystem", "deleteItemTemplate", ItemTemplateEditor.entryId)
    print("|cFFFFFF00[ItemTemplateEditor] Deleting item template " .. ItemTemplateEditor.entryId .. "...|r")
end

-- Update entry ID display
function ItemTemplateEditor.UpdateEntryDisplay()
    if not ItemTemplateEditor.frame or not ItemTemplateEditor.frame.entryContainer then
        return
    end
    
    local container = ItemTemplateEditor.frame.entryContainer
    
    if ItemTemplateEditor.isDuplicate then
        -- Show next available entry and custom input for duplicate mode
        if ItemTemplateEditor.nextAvailableEntry then
            container.nextLabel:SetText("Next Available Entry: " .. ItemTemplateEditor.nextAvailableEntry)
        else
            container.nextLabel:SetText("Next Available Entry: Loading...")
        end
        container.nextLabel:Show()
        container.customLabel:Show()
        container.customInput:Show()
        container.currentLabel:Hide()
    else
        -- Show current entry and override option for edit mode
        container.currentLabel:SetText("Current Entry ID: " .. ItemTemplateEditor.entryId)
        container.currentLabel:Show()
        container.customLabel:Show()
        container.customInput:Show()
        container.nextLabel:Hide()
    end
end

-- Handle custom entry ID input
function ItemTemplateEditor.OnCustomEntryChanged(value)
    local entryId = tonumber(value)
    if entryId and entryId > 0 then
        ItemTemplateEditor.customEntryId = entryId
    else
        ItemTemplateEditor.customEntryId = nil
    end
end

-- Create the main UI frame
function ItemTemplateEditor.CreateFrame()
    if ItemTemplateEditor.frame then
        return ItemTemplateEditor.frame
    end
    
    -- Use TemplateUI to create the dialog with entry container functionality
    local frame = TemplateUI.CreateDialog(
        CONFIG,
        function() ItemTemplateEditor.Close() end,       -- onClose
        function() ItemTemplateEditor.SaveTemplate() end, -- onSave
        function() ItemTemplateEditor.Reset() end,       -- onReset
        nil,                                             -- onPreview (not needed)
        function(tabIndex) ItemTemplateEditor.SelectTab(tabIndex) end, -- onTabChange
        ItemTemplateEditor                               -- editor reference
    )
    
    -- Update title for item editor
    frame.title:SetText("Item Template Editor")
    
    -- Add custom buttons that aren't in the standard TemplateUI
    local buttonContainer = frame:GetChildren()
    -- Find the button container (it's the last child frame)
    for i = frame:GetNumChildren(), 1, -1 do
        local child = select(i, frame:GetChildren())
        if child:GetObjectType() == "Frame" and child:GetHeight() == 40 then
            buttonContainer = child
            break
        end
    end
    
    -- Add Save As New button
    local saveAsNewBtn = CreateStyledButton(buttonContainer, "Save As New", 100, 25)
    saveAsNewBtn:SetPoint("TOPLEFT", buttonContainer, "TOPLEFT", 120, -2)
    saveAsNewBtn:SetScript("OnClick", function()
        ItemTemplateEditor.SaveAsNew()
    end)
    frame.saveAsNewBtn = saveAsNewBtn
    
    -- Add Delete button
    local deleteBtn = CreateStyledButton(buttonContainer, "Delete", 80, 25)
    deleteBtn:SetPoint("TOPLEFT", buttonContainer, "TOPLEFT", 230, -2)
    deleteBtn:SetScript("OnClick", function()
        ItemTemplateEditor.ConfirmDelete()
    end)
    frame.deleteBtn = deleteBtn
    
    -- Add to UI special frames for ESC key support
    local frameName = "ItemTemplateEditorFrame"
    _G[frameName] = frame
    tinsert(UISpecialFrames, frameName)
    
    ItemTemplateEditor.frame = frame
    return frame
end

-- Create new blank template
function ItemTemplateEditor.CreateNew()
    ItemTemplateEditor.entryId = nil
    ItemTemplateEditor.isDuplicate = true  -- Treat as duplicate so it creates new entry
    ItemTemplateEditor.currentTab = 1
    ItemTemplateEditor.originalData = nil
    ItemTemplateEditor.editedData = nil
    ItemTemplateEditor.nextAvailableEntry = nil
    ItemTemplateEditor.customEntryId = nil
    
    -- Create frame if it doesn't exist
    if not ItemTemplateEditor.frame then
        ItemTemplateEditor.CreateFrame()
    end
    
    local frame = ItemTemplateEditor.frame
    
    -- Update title for new item creation
    frame.title:SetText("Create New Item Template")
    
    -- Update entry display
    ItemTemplateEditor.UpdateEntryDisplay()
    
    -- Hide delete button when creating new (if it exists)
    if frame.deleteBtn then
        frame.deleteBtn:Hide()
    end
    
    -- Request blank template from server
    AIO.Handle("GameMasterSystem", "createBlankItemTemplate")
    
    -- Show frame and set as open
    frame:Show()
    ItemTemplateEditor.isOpen = true
    
    print("|cFF00FF00[ItemTemplateEditor] Creating new item template...|r")
end

-- Open the editor
function ItemTemplateEditor.Open(entryId, isDuplicate)
    entryId = tonumber(entryId)
    if not entryId or entryId <= 0 then
        print("|cFFFF0000[ItemTemplateEditor] Invalid item entry ID|r")
        return
    end
    
    ItemTemplateEditor.entryId = entryId
    ItemTemplateEditor.isDuplicate = isDuplicate or false
    ItemTemplateEditor.currentTab = 1
    ItemTemplateEditor.originalData = nil
    ItemTemplateEditor.editedData = nil
    ItemTemplateEditor.nextAvailableEntry = nil
    ItemTemplateEditor.customEntryId = nil
    
    -- Create frame if it doesn't exist
    if not ItemTemplateEditor.frame then
        ItemTemplateEditor.CreateFrame()
    end
    
    local frame = ItemTemplateEditor.frame
    
    -- Update title
    if isDuplicate then
        frame.title:SetText("Duplicate Item Template")
        -- Request next available entry ID from server
        AIO.Handle("GameMasterSystem", "getNextAvailableItemEntry")
    else
        frame.title:SetText("Item Template Editor")
    end
    
    -- Update entry ID display
    ItemTemplateEditor.UpdateEntryDisplay()
    
    -- Initialize with empty data first
    ItemTemplateEditor.originalData = {}
    ItemTemplateEditor.editedData = {}
    
    -- Request item data from server
    AIO.Handle("GameMasterSystem", "getItemTemplateData", entryId)
    
    -- Show frame and set as open
    frame:Show()
    ItemTemplateEditor.isOpen = true
    
    print("|cFF00FF00[ItemTemplateEditor] Loading item " .. entryId .. "...|r")
end

-- Close the editor
function ItemTemplateEditor.Close()
    -- Notify state machine of modal closing
    local StateMachine = _G.GMStateMachine
    if StateMachine then
        StateMachine.closeModal()
    end

    if ItemTemplateEditor.frame then
        ItemTemplateEditor.frame:Hide()
    end

    ItemTemplateEditor.isOpen = false
    ItemTemplateEditor.entryId = nil
    ItemTemplateEditor.originalData = nil
    ItemTemplateEditor.editedData = nil
    ItemTemplateEditor.isDuplicate = false
    ItemTemplateEditor.nextAvailableEntry = nil
    ItemTemplateEditor.customEntryId = nil
end

-- Handle server responses
function ItemTemplateEditor.HandleItemTemplateData(data)
    if not ItemTemplateEditor.isOpen or not data then
        return
    end
    
    ItemTemplateEditor.originalData = data
    ItemTemplateEditor.editedData = {}  -- Keep empty! Only populate when fields are actually edited
    
    -- For duplicates, pre-populate with modified name since it's an intended change
    if ItemTemplateEditor.isDuplicate then
        ItemTemplateEditor.editedData.name = (data.name or "Item") .. " (Copy)"
    end
    
    -- Populate fields
    ItemTemplateEditor.PopulateFields()
    
    -- Update subclass options based on the item's class and preserve the correct subclass value
    -- (This ensures consistency when switching tabs or for edge cases)
    if data.class then
        ItemTemplateEditor.UpdateSubclassOptions(data.class, data.subclass)
    end
end

function ItemTemplateEditor.HandleNextAvailableItemEntry(entryId)
    if not ItemTemplateEditor.isOpen then
        return
    end
    
    ItemTemplateEditor.nextAvailableEntry = entryId
    ItemTemplateEditor.UpdateEntryDisplay()
end

function ItemTemplateEditor.HandleItemTemplateSaved(success, message, entryId)
    if success then
        print("|cFF00FF00[ItemTemplateEditor] " .. (message or "Item template saved successfully!") .. "|r")
        
        if ItemTemplateEditor.isDuplicate and entryId then
            ItemTemplateEditor.entryId = entryId
            ItemTemplateEditor.isDuplicate = false
            
            if ItemTemplateEditor.frame then
                -- Update title and entry display
                ItemTemplateEditor.frame.title:SetText("Item Template Editor - Edit Item " .. entryId)
                ItemTemplateEditor.UpdateEntryDisplay()
            end
        end
        
        -- Update save button
        if ItemTemplateEditor.frame and ItemTemplateEditor.frame.saveBtn then
            ItemTemplateEditor.frame.saveBtn:SetText("Save")
        end
    else
        print("|cFFFF0000[ItemTemplateEditor] " .. (message or "Failed to save item template!") .. "|r")
    end
end

function ItemTemplateEditor.HandleItemTemplateDeleted(success, message)
    if success then
        print("|cFF00FF00[ItemTemplateEditor] " .. (message or "Item template deleted successfully!") .. "|r")
        -- Close the editor after successful deletion
        ItemTemplateEditor.Close()
    else
        print("|cFFFF0000[ItemTemplateEditor] " .. (message or "Failed to delete item template!") .. "|r")
    end
end

-- Register handlers for server communication
if AIO.AddHandlers then
    AIO.AddHandlers("ItemTemplateEditor", {
        HandleItemTemplateData = function(player, data)
            ItemTemplateEditor.HandleItemTemplateData(data)
        end,
        HandleNextAvailableItemEntry = function(player, entryId)
            ItemTemplateEditor.HandleNextAvailableItemEntry(entryId)
        end,
        HandleItemTemplateSaved = function(player, success, message, entryId)
            ItemTemplateEditor.HandleItemTemplateSaved(success, message, entryId)
        end,
        HandleItemTemplateDeleted = function(player, success, message)
            ItemTemplateEditor.HandleItemTemplateDeleted(success, message)
        end
    })
end

-- Item Template Editor module loaded