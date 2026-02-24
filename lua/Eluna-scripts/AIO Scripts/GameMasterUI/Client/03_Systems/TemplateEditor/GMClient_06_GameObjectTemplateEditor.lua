local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize GameObjectTemplateEditor namespace
_G.GameObjectTemplateEditor = _G.GameObjectTemplateEditor or {}
local GameObjectTemplateEditor = _G.GameObjectTemplateEditor

-- Get references to modules
local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local GameObjectFieldDefs = _G.GameObjectFieldDefs
local TemplateUI = _G.TemplateUI

-- Check dependencies
if not GameObjectFieldDefs then
    print("|cFFFF0000[GameObjectTemplateEditor] Error: GameObjectFieldDefs not loaded!|r")
    return
end

if not TemplateUI then
    print("|cFFFF0000[GameObjectTemplateEditor] Error: TemplateUI not loaded!|r")
    return
end

-- Current state
GameObjectTemplateEditor.isOpen = false
GameObjectTemplateEditor.currentTab = 1
GameObjectTemplateEditor.originalData = nil
GameObjectTemplateEditor.editedData = nil
GameObjectTemplateEditor.entryId = nil
GameObjectTemplateEditor.isDuplicate = false
GameObjectTemplateEditor.nextAvailableEntry = nil
GameObjectTemplateEditor.customEntryId = nil
GameObjectTemplateEditor.currentType = 0

-- Configuration (use from field defs module)
local CONFIG = GameObjectFieldDefs.CONFIG
local FIELDS = GameObjectFieldDefs.FIELDS

-- Select a tab
function GameObjectTemplateEditor.SelectTab(tabId)
    -- Force save any pending changes from current tab before switching
    GameObjectTemplateEditor.ForceFieldSave()
    
    GameObjectTemplateEditor.currentTab = tabId
    
    -- Update tab appearance - now handled by the styled tab group
    if GameObjectTemplateEditor.frame and GameObjectTemplateEditor.frame.tabContainer then
        GameObjectTemplateEditor.frame.tabContainer:SetActiveTab(tabId)
    end
    
    -- Populate fields
    GameObjectTemplateEditor.PopulateFields()
end

-- Populate fields for current tab
function GameObjectTemplateEditor.PopulateFields()
    local frame = GameObjectTemplateEditor.frame
    if not frame then return end
    
    local content = frame.content
    local tabName = CONFIG.TABS[GameObjectTemplateEditor.currentTab]
    local fields = FIELDS[tabName]
    
    if not content or not fields then return end
    
    -- Use the comprehensive cleanup function
    TemplateUI.CleanupContent(content)
    
    -- Initialize field tracking
    content.fields = {}
    content.fieldLabels = {}
    
    -- Create fields
    local yOffset = -10
    for _, field in ipairs(fields) do
        local success, fieldFrame = pcall(function()
            -- For Data fields in Data1/Data2 tabs, check if we need to update based on type
            if (tabName == "Data1" or tabName == "Data2") and field.key:match("^Data%d+$") then
                local dataIndex = tonumber(field.key:match("%d+"))
                if dataIndex and GameObjectTemplateEditor.currentType then
                    local typeField = GameObjectFieldDefs.GetDataField(GameObjectTemplateEditor.currentType, dataIndex)
                    if typeField then
                        -- Override field properties with type-specific ones
                        field = {
                            key = field.key,
                            label = typeField.name .. ":",
                            type = typeField.type,
                            min = typeField.min,
                            max = typeField.max,
                            options = typeField.options,
                            tooltip = typeField.tooltip,
                            defaultValue = typeField.defaultValue,
                            step = typeField.step
                        }
                    end
                end
            end
            
            local frame = TemplateUI.CreateField(content, field, CONFIG, GameObjectTemplateEditor.OnFieldChanged)
            frame:SetPoint("TOPLEFT", 0, yOffset)
            frame:SetPoint("TOPRIGHT", 0, yOffset)
            return frame
        end)
        
        if success and fieldFrame then
            table.insert(content.fields, fieldFrame)
            
            -- Adjust spacing based on field type
            local spacing = CONFIG.FIELD_HEIGHT + 5
            if field.type == "decimal" and (field.key == "size") then
                spacing = CONFIG.FIELD_HEIGHT + 20
            elseif field.type == "dropdown" then
                spacing = CONFIG.FIELD_HEIGHT + 8
            end
            yOffset = yOffset - spacing
            
            -- Set initial value
            if GameObjectTemplateEditor.editedData and GameObjectTemplateEditor.editedData[field.key] ~= nil then
                TemplateUI.SetFieldValue(fieldFrame, GameObjectTemplateEditor.editedData[field.key])
            end
        else
            print("|cFFFF0000Error creating field:|r", field.key)
        end
    end
    
    -- Update scroll height
    content:SetHeight(math.abs(yOffset) + 20)
    
    -- Update scrollbar
    if frame.updateScrollBar then
        frame.updateScrollBar()
    end
end

-- Handle field changes
function GameObjectTemplateEditor.OnFieldChanged(key, value)
    if not GameObjectTemplateEditor.editedData then
        GameObjectTemplateEditor.editedData = {}
    end
    
    GameObjectTemplateEditor.editedData[key] = value
    
    -- If type field changed, update Data fields and repopulate if on Data tabs
    if key == "type" then
        GameObjectTemplateEditor.currentType = tonumber(value) or 0
        -- Update field definitions
        GameObjectFieldDefs.UpdateDataFields(GameObjectTemplateEditor.currentType)
        -- If we're on a Data tab, repopulate to show updated field names
        local tabName = CONFIG.TABS[GameObjectTemplateEditor.currentTab]
        if tabName == "Data1" or tabName == "Data2" then
            GameObjectTemplateEditor.PopulateFields()
        end
    end
    
    -- Update save button color if changed
    if GameObjectTemplateEditor.frame and GameObjectTemplateEditor.frame.saveBtn then
        if GameObjectTemplateEditor.HasChanges() then
            GameObjectTemplateEditor.frame.saveBtn:SetText("|cFFFFFF00Save*|r")
        else
            GameObjectTemplateEditor.frame.saveBtn:SetText("Save")
        end
    end
end

-- Check if there are unsaved changes
function GameObjectTemplateEditor.HasChanges()
    if not GameObjectTemplateEditor.originalData or not GameObjectTemplateEditor.editedData then
        return false
    end
    
    for key, value in pairs(GameObjectTemplateEditor.editedData) do
        -- Skip entry field in comparison
        if key ~= "entry" and GameObjectTemplateEditor.originalData[key] ~= value then
            return true
        end
    end
    
    return false
end

-- Reset fields to original values
function GameObjectTemplateEditor.ResetFields()
    GameObjectTemplateEditor.editedData = {}
    for key, value in pairs(GameObjectTemplateEditor.originalData or {}) do
        -- Don't copy entry field to edited data
        if key ~= "entry" then
            GameObjectTemplateEditor.editedData[key] = value
        end
    end
    
    -- Update current type if resetting
    if GameObjectTemplateEditor.editedData.type then
        GameObjectTemplateEditor.currentType = tonumber(GameObjectTemplateEditor.editedData.type) or 0
        GameObjectFieldDefs.UpdateDataFields(GameObjectTemplateEditor.currentType)
    end
    
    GameObjectTemplateEditor.PopulateFields()
end

-- Preview changes
function GameObjectTemplateEditor.PreviewChanges()
    local changes = {}
    for key, value in pairs(GameObjectTemplateEditor.editedData or {}) do
        -- Skip entry field
        if key ~= "entry" and GameObjectTemplateEditor.originalData[key] ~= value then
            table.insert(changes, string.format("%s: %s -> %s", 
                key, 
                tostring(GameObjectTemplateEditor.originalData[key]),
                tostring(value)))
        end
    end
    
    if #changes > 0 then
        print("|cFFFFFF00Changes to apply:|r")
        for _, change in ipairs(changes) do
            print("  " .. change)
        end
    else
        print("|cFF00FF00No changes to apply|r")
    end
end

-- Save changes
function GameObjectTemplateEditor.Save()
    -- Force all edit boxes to lose focus to capture any pending changes
    GameObjectTemplateEditor.ForceFieldSave()
    
    if not GameObjectTemplateEditor.HasChanges() and not GameObjectTemplateEditor.isDuplicate and not GameObjectTemplateEditor.customEntryId then
        print("|cFFFF0000No changes to save|r")
        return
    end
    
    -- Prepare data for server
    local dataToSend = {
        entry = GameObjectTemplateEditor.entryId,
        isDuplicate = GameObjectTemplateEditor.isDuplicate,
        changes = {}
    }
    
    -- Add custom entry ID if user has specified one
    if GameObjectTemplateEditor.customEntryId then
        dataToSend.customEntry = GameObjectTemplateEditor.customEntryId
    end
    
    -- Collect changed fields (exclude entry field as it's not editable)
    for key, value in pairs(GameObjectTemplateEditor.editedData or {}) do
        -- Skip the entry field - it should never be part of changes
        if key ~= "entry" then
            if GameObjectTemplateEditor.isDuplicate or GameObjectTemplateEditor.originalData[key] ~= value then
                dataToSend.changes[key] = value
            end
        end
    end
    
    -- Send to server
    if GameObjectTemplateEditor.isDuplicate then
        AIO.Handle("GameMasterSystem", "duplicateGameObjectWithTemplate", dataToSend)
    else
        AIO.Handle("GameMasterSystem", "updateGameObjectTemplate", dataToSend)
    end
    
    GameObjectTemplateEditor.Close()
end

-- Force all fields to save their current values
function GameObjectTemplateEditor.ForceFieldSave()
    local frame = GameObjectTemplateEditor.frame
    if not frame then return end
    
    -- Check all tab content frames
    if frame.tabContentFrames then
        for _, tabFrame in ipairs(frame.tabContentFrames) do
            if tabFrame.content and tabFrame.content.fields then
                for _, fieldFrame in ipairs(tabFrame.content.fields) do
                    if fieldFrame.input then
                        local editBox = fieldFrame.input.editBox or fieldFrame.input
                        
                        -- Force the edit box to lose focus if it's currently focused
                        if editBox.HasFocus and editBox:HasFocus() then
                            editBox:ClearFocus()
                        end
                    end
                end
            end
        end
    end
    
    -- Also check the current active content
    if frame.content and frame.content.fields then
        for _, fieldFrame in ipairs(frame.content.fields) do
            if fieldFrame.input then
                local editBox = fieldFrame.input.editBox or fieldFrame.input
                
                -- Force the edit box to lose focus if it's currently focused
                if editBox.HasFocus and editBox:HasFocus() then
                    editBox:ClearFocus()
                end
            end
        end
    end
end

-- Open the editor
function GameObjectTemplateEditor.Open(entryId, isDuplicate)
    GameObjectTemplateEditor.entryId = entryId
    GameObjectTemplateEditor.isDuplicate = isDuplicate or false
    GameObjectTemplateEditor.nextAvailableEntry = nil
    GameObjectTemplateEditor.customEntryId = nil
    GameObjectTemplateEditor.currentType = 0
    
    -- Create dialog if needed
    if not GameObjectTemplateEditor.frame then
        GameObjectTemplateEditor.frame = TemplateUI.CreateDialog(
            CONFIG,
            GameObjectTemplateEditor.Close,        -- onClose
            GameObjectTemplateEditor.Save,         -- onSave  
            GameObjectTemplateEditor.ResetFields,  -- onReset
            GameObjectTemplateEditor.PreviewChanges, -- onPreview
            GameObjectTemplateEditor.SelectTab,    -- onTabChange
            GameObjectTemplateEditor              -- Pass editor reference for entry ID UI
        )
    end
    
    -- Update title
    if isDuplicate then
        GameObjectTemplateEditor.frame.title:SetText("Duplicate GameObject Template")
        -- Request next available entry ID from server
        AIO.Handle("GameMasterSystem", "getNextAvailableGameObjectEntry")
    else
        GameObjectTemplateEditor.frame.title:SetText("Edit GameObject Template")
    end
    
    -- Update entry ID display
    GameObjectTemplateEditor.UpdateEntryDisplay()
    
    -- Initialize with empty data first
    GameObjectTemplateEditor.originalData = {}
    GameObjectTemplateEditor.editedData = {}
    
    -- Request template data from server
    AIO.Handle("GameMasterSystem", "getGameObjectTemplateData", entryId)
    
    -- Show frame
    GameObjectTemplateEditor.frame:Show()
    GameObjectTemplateEditor.isOpen = true
    
    -- Select first tab
    GameObjectTemplateEditor.SelectTab(1)
end

-- Update entry ID display
function GameObjectTemplateEditor.UpdateEntryDisplay()
    if not GameObjectTemplateEditor.frame or not GameObjectTemplateEditor.frame.entryContainer then
        return
    end
    
    local container = GameObjectTemplateEditor.frame.entryContainer
    
    if GameObjectTemplateEditor.isDuplicate then
        -- Show next available entry and custom input for duplicate mode
        if GameObjectTemplateEditor.nextAvailableEntry then
            container.nextLabel:SetText("Next Available Entry: " .. GameObjectTemplateEditor.nextAvailableEntry)
        else
            container.nextLabel:SetText("Next Available Entry: Loading...")
        end
        container.nextLabel:Show()
        container.customLabel:Show()
        container.customInput:Show()
        container.currentLabel:Hide()
    else
        -- Show current entry and override option for edit mode
        container.currentLabel:SetText("Current Entry ID: " .. GameObjectTemplateEditor.entryId)
        container.currentLabel:Show()
        container.customLabel:Show()
        container.customInput:Show()
        container.nextLabel:Hide()
    end
end

-- Handle custom entry ID input
function GameObjectTemplateEditor.OnCustomEntryChanged(value)
    local entryId = tonumber(value)
    if entryId and entryId > 0 then
        GameObjectTemplateEditor.customEntryId = entryId
    else
        GameObjectTemplateEditor.customEntryId = nil
    end
end

-- Close the editor
function GameObjectTemplateEditor.Close()
    -- Notify state machine of modal closing
    local StateMachine = _G.GMStateMachine
    if StateMachine then
        StateMachine.closeModal()
    end

    if GameObjectTemplateEditor.frame then
        -- Clean up all tab contents before closing
        for i = 1, #CONFIG.TABS do
            local tabContentFrame = GameObjectTemplateEditor.frame.tabContentFrames and GameObjectTemplateEditor.frame.tabContentFrames[i]
            if tabContentFrame and tabContentFrame.content then
                TemplateUI.CleanupContent(tabContentFrame.content)
            end
        end

        -- Clean up current content reference
        if GameObjectTemplateEditor.frame.content then
            TemplateUI.CleanupContent(GameObjectTemplateEditor.frame.content)
        end

        GameObjectTemplateEditor.frame:Hide()
    end
    GameObjectTemplateEditor.isOpen = false
    GameObjectTemplateEditor.originalData = nil
    GameObjectTemplateEditor.editedData = nil
    GameObjectTemplateEditor.entryId = nil
    GameObjectTemplateEditor.isDuplicate = false
    GameObjectTemplateEditor.nextAvailableEntry = nil
    GameObjectTemplateEditor.customEntryId = nil
    GameObjectTemplateEditor.currentType = 0
end

-- Handle server response with template data
function GameObjectTemplateEditor.ReceiveTemplateData(data)
    GameObjectTemplateEditor.originalData = data
    GameObjectTemplateEditor.editedData = {}
    
    -- Copy original data to edited data (excluding entry for duplicates)
    for key, value in pairs(data) do
        -- Don't copy entry field to edited data to prevent it from being sent as a change
        if key ~= "entry" then
            GameObjectTemplateEditor.editedData[key] = value
        end
    end
    
    -- Update current type
    if data.type then
        GameObjectTemplateEditor.currentType = tonumber(data.type) or 0
        GameObjectFieldDefs.UpdateDataFields(GameObjectTemplateEditor.currentType)
    end
    
    -- If duplicating, modify the name
    if GameObjectTemplateEditor.isDuplicate then
        GameObjectTemplateEditor.editedData.name = (data.name or "GameObject") .. " (Copy)"
    end
    
    -- Populate fields
    GameObjectTemplateEditor.PopulateFields()
end

-- Register handlers
GameMasterSystem = GameMasterSystem or {}
GameMasterSystem.GameObjectTemplateEditor = GameObjectTemplateEditor

-- Register AIO handlers
local handlers = AIO.AddHandlers("GameObjectTemplateEditor", {})

-- Handler for receiving template data from server
function handlers.ReceiveTemplateData(player, data)
    GameObjectTemplateEditor.ReceiveTemplateData(data)
end

-- Handler for receiving next available entry ID
function handlers.ReceiveNextAvailableEntry(player, entryId)
    GameObjectTemplateEditor.nextAvailableEntry = entryId
    GameObjectTemplateEditor.UpdateEntryDisplay()
end

-- Test commands for debugging
SLASH_TESTGOBJECTTEMPLATE1 = "/testgotemplate"
SLASH_TESTGOBJECTTEMPLATE2 = "/gotemplate"
SlashCmdList["TESTGOBJECTTEMPLATE"] = function(msg)
    local entryId = tonumber(msg) or 184002  -- Default to a chest
    print("Opening GameObject Template Editor for entry: " .. entryId)
    GameObjectTemplateEditor.Open(entryId, false)
end

SLASH_TESTGOBJECTDUPLICATE1 = "/testgoduplicate"
SLASH_TESTGOBJECTDUPLICATE2 = "/goduplicate"
SlashCmdList["TESTGOBJECTDUPLICATE"] = function(msg)
    local entryId = tonumber(msg) or 184002
    print("Opening GameObject Template Editor in duplicate mode for entry: " .. entryId)
    GameObjectTemplateEditor.Open(entryId, true)
end

-- print("|cFF00FF00[GameObjectTemplateEditor] Main module loaded|r")