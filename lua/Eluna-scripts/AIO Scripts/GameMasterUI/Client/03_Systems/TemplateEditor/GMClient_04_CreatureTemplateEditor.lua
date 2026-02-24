local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize CreatureTemplateEditor namespace
_G.CreatureTemplateEditor = _G.CreatureTemplateEditor or {}
local CreatureTemplateEditor = _G.CreatureTemplateEditor

-- Get references to modules
local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local TemplateFieldDefs = _G.TemplateFieldDefs
local TemplateUI = _G.TemplateUI

-- Check dependencies
if not TemplateFieldDefs then
    print("|cFFFF0000[CreatureTemplateEditor] Error: TemplateFieldDefs not loaded!|r")
    return
end

if not TemplateUI then
    print("|cFFFF0000[CreatureTemplateEditor] Error: TemplateUI not loaded!|r")
    return
end

-- Current state
CreatureTemplateEditor.isOpen = false
CreatureTemplateEditor.currentTab = 1
CreatureTemplateEditor.originalData = nil
CreatureTemplateEditor.editedData = nil
CreatureTemplateEditor.entryId = nil
CreatureTemplateEditor.isDuplicate = false
CreatureTemplateEditor.nextAvailableEntry = nil
CreatureTemplateEditor.customEntryId = nil

-- Configuration (use from field defs module)
local CONFIG = TemplateFieldDefs.CONFIG
local FIELDS = TemplateFieldDefs.FIELDS

-- Select a tab
function CreatureTemplateEditor.SelectTab(tabId)
    -- Force save any pending changes from current tab before switching
    CreatureTemplateEditor.ForceFieldSave()
    
    CreatureTemplateEditor.currentTab = tabId
    
    -- Update tab appearance - now handled by the styled tab group
    if CreatureTemplateEditor.frame and CreatureTemplateEditor.frame.tabContainer then
        CreatureTemplateEditor.frame.tabContainer:SetActiveTab(tabId)
    end
    
    -- Populate fields
    CreatureTemplateEditor.PopulateFields()
end

-- Populate fields for current tab
function CreatureTemplateEditor.PopulateFields()
    local frame = CreatureTemplateEditor.frame
    if not frame then return end
    
    local content = frame.content
    local tabName = CONFIG.TABS[CreatureTemplateEditor.currentTab]
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
            local frame = TemplateUI.CreateField(content, field, CONFIG, CreatureTemplateEditor.OnFieldChanged)
            frame:SetPoint("TOPLEFT", 0, yOffset)
            frame:SetPoint("TOPRIGHT", 0, yOffset)
            return frame
        end)
        
        if success and fieldFrame then
            table.insert(content.fields, fieldFrame)
            
            -- Adjust spacing based on field type
            local spacing = CONFIG.FIELD_HEIGHT + 5
            if field.type == "decimal" and (field.key:match("Modifier") or field.key == "scale") then
                spacing = CONFIG.FIELD_HEIGHT + 20
            elseif field.type == "dropdown" then
                spacing = CONFIG.FIELD_HEIGHT + 8
            end
            yOffset = yOffset - spacing
            
            -- Set initial value
            if CreatureTemplateEditor.editedData and CreatureTemplateEditor.editedData[field.key] ~= nil then
                TemplateUI.SetFieldValue(fieldFrame, CreatureTemplateEditor.editedData[field.key])
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
function CreatureTemplateEditor.OnFieldChanged(key, value)
    if not CreatureTemplateEditor.editedData then
        CreatureTemplateEditor.editedData = {}
    end
    
    CreatureTemplateEditor.editedData[key] = value
    
    -- Update save button color if changed
    if CreatureTemplateEditor.frame and CreatureTemplateEditor.frame.saveBtn then
        if CreatureTemplateEditor.HasChanges() then
            CreatureTemplateEditor.frame.saveBtn:SetText("|cFFFFFF00Save*|r")
        else
            CreatureTemplateEditor.frame.saveBtn:SetText("Save")
        end
    end
end

-- Check if there are unsaved changes
function CreatureTemplateEditor.HasChanges()
    if not CreatureTemplateEditor.originalData or not CreatureTemplateEditor.editedData then
        return false
    end
    
    for key, value in pairs(CreatureTemplateEditor.editedData) do
        -- Skip entry field in comparison
        if key ~= "entry" and CreatureTemplateEditor.originalData[key] ~= value then
            return true
        end
    end
    
    return false
end

-- Reset fields to original values
function CreatureTemplateEditor.ResetFields()
    CreatureTemplateEditor.editedData = {}
    for key, value in pairs(CreatureTemplateEditor.originalData or {}) do
        -- Don't copy entry field to edited data
        if key ~= "entry" then
            CreatureTemplateEditor.editedData[key] = value
        end
    end
    CreatureTemplateEditor.PopulateFields()
end

-- Preview changes
function CreatureTemplateEditor.PreviewChanges()
    local changes = {}
    for key, value in pairs(CreatureTemplateEditor.editedData or {}) do
        -- Skip entry field
        if key ~= "entry" and CreatureTemplateEditor.originalData[key] ~= value then
            table.insert(changes, string.format("%s: %s -> %s", 
                key, 
                tostring(CreatureTemplateEditor.originalData[key]),
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
function CreatureTemplateEditor.Save()
    -- Force all edit boxes to lose focus to capture any pending changes
    CreatureTemplateEditor.ForceFieldSave()
    
    if not CreatureTemplateEditor.HasChanges() and not CreatureTemplateEditor.isDuplicate and not CreatureTemplateEditor.customEntryId then
        print("|cFFFF0000No changes to save|r")
        return
    end
    
    -- Prepare data for server
    local dataToSend = {
        entry = CreatureTemplateEditor.entryId,
        isDuplicate = CreatureTemplateEditor.isDuplicate,
        changes = {}
    }
    
    -- Add custom entry ID if user has specified one
    if CreatureTemplateEditor.customEntryId then
        dataToSend.customEntry = CreatureTemplateEditor.customEntryId
    end
    
    -- Collect changed fields (exclude entry field as it's not editable)
    for key, value in pairs(CreatureTemplateEditor.editedData or {}) do
        -- Skip the entry field - it should never be part of changes
        if key ~= "entry" then
            if CreatureTemplateEditor.isDuplicate or CreatureTemplateEditor.originalData[key] ~= value then
                dataToSend.changes[key] = value
            end
        end
    end
    
    -- Send to server
    if CreatureTemplateEditor.isDuplicate then
        AIO.Handle("GameMasterSystem", "duplicateCreatureWithTemplate", dataToSend)
    else
        AIO.Handle("GameMasterSystem", "updateCreatureTemplate", dataToSend)
    end
    
    CreatureTemplateEditor.Close()
end

-- Force all fields to save their current values
function CreatureTemplateEditor.ForceFieldSave()
    local frame = CreatureTemplateEditor.frame
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
function CreatureTemplateEditor.Open(entryId, isDuplicate)
    CreatureTemplateEditor.entryId = entryId
    CreatureTemplateEditor.isDuplicate = isDuplicate or false
    CreatureTemplateEditor.nextAvailableEntry = nil
    CreatureTemplateEditor.customEntryId = nil
    
    -- Create dialog if needed
    if not CreatureTemplateEditor.frame then
        CreatureTemplateEditor.frame = TemplateUI.CreateDialog(
            CONFIG,
            CreatureTemplateEditor.Close,        -- onClose
            CreatureTemplateEditor.Save,         -- onSave  
            CreatureTemplateEditor.ResetFields,  -- onReset
            CreatureTemplateEditor.PreviewChanges, -- onPreview
            CreatureTemplateEditor.SelectTab,    -- onTabChange
            CreatureTemplateEditor              -- Pass editor reference for entry ID UI
        )
        
        -- The styled tab group handles click events automatically
        -- We just need to make sure our SelectTab function is called
        -- This is handled through the onTabChange callback in TemplateUI.CreateDialog
    end
    
    -- Update title
    if isDuplicate then
        CreatureTemplateEditor.frame.title:SetText("Duplicate Creature Template")
        -- Request next available entry ID from server
        AIO.Handle("GameMasterSystem", "getNextAvailableEntry")
    else
        CreatureTemplateEditor.frame.title:SetText("Edit Creature Template")
    end
    
    -- Update entry ID display
    CreatureTemplateEditor.UpdateEntryDisplay()
    
    -- Initialize with empty data first
    CreatureTemplateEditor.originalData = {}
    CreatureTemplateEditor.editedData = {}
    
    -- Request template data from server
    AIO.Handle("GameMasterSystem", "getCreatureTemplateData", entryId)
    
    -- Show frame
    CreatureTemplateEditor.frame:Show()
    CreatureTemplateEditor.isOpen = true
    
    -- Select first tab
    CreatureTemplateEditor.SelectTab(1)
end

-- Update entry ID display
function CreatureTemplateEditor.UpdateEntryDisplay()
    if not CreatureTemplateEditor.frame or not CreatureTemplateEditor.frame.entryContainer then
        return
    end
    
    local container = CreatureTemplateEditor.frame.entryContainer
    
    if CreatureTemplateEditor.isDuplicate then
        -- Show next available entry and custom input for duplicate mode
        if CreatureTemplateEditor.nextAvailableEntry then
            container.nextLabel:SetText("Next Available Entry: " .. CreatureTemplateEditor.nextAvailableEntry)
        else
            container.nextLabel:SetText("Next Available Entry: Loading...")
        end
        container.nextLabel:Show()
        container.customLabel:Show()
        container.customInput:Show()
        container.currentLabel:Hide()
    else
        -- Show current entry and override option for edit mode
        container.currentLabel:SetText("Current Entry ID: " .. CreatureTemplateEditor.entryId)
        container.currentLabel:Show()
        container.customLabel:Show()
        container.customInput:Show()
        container.nextLabel:Hide()
    end
end

-- Handle custom entry ID input
function CreatureTemplateEditor.OnCustomEntryChanged(value)
    local entryId = tonumber(value)
    if entryId and entryId > 0 then
        CreatureTemplateEditor.customEntryId = entryId
    else
        CreatureTemplateEditor.customEntryId = nil
    end
end

-- Close the editor
function CreatureTemplateEditor.Close()
    -- Notify state machine of modal closing
    local StateMachine = _G.GMStateMachine
    if StateMachine then
        StateMachine.closeModal()
    end

    if CreatureTemplateEditor.frame then
        -- Clean up all tab contents before closing
        for i = 1, #CONFIG.TABS do
            local tabContentFrame = CreatureTemplateEditor.frame.tabContentFrames and CreatureTemplateEditor.frame.tabContentFrames[i]
            if tabContentFrame and tabContentFrame.content then
                TemplateUI.CleanupContent(tabContentFrame.content)
            end
        end

        -- Clean up current content reference
        if CreatureTemplateEditor.frame.content then
            TemplateUI.CleanupContent(CreatureTemplateEditor.frame.content)
        end

        CreatureTemplateEditor.frame:Hide()
    end
    CreatureTemplateEditor.isOpen = false
    CreatureTemplateEditor.originalData = nil
    CreatureTemplateEditor.editedData = nil
    CreatureTemplateEditor.entryId = nil
    CreatureTemplateEditor.isDuplicate = false
    CreatureTemplateEditor.nextAvailableEntry = nil
    CreatureTemplateEditor.customEntryId = nil
end

-- Handle server response with template data
function CreatureTemplateEditor.ReceiveTemplateData(data)
    CreatureTemplateEditor.originalData = data
    CreatureTemplateEditor.editedData = {}
    
    -- Copy original data to edited data (excluding entry for duplicates)
    for key, value in pairs(data) do
        -- Don't copy entry field to edited data to prevent it from being sent as a change
        if key ~= "entry" then
            CreatureTemplateEditor.editedData[key] = value
        end
    end
    
    -- If duplicating, modify the name
    if CreatureTemplateEditor.isDuplicate then
        CreatureTemplateEditor.editedData.name = (data.name or "Creature") .. " (Copy)"
    end
    
    -- Populate fields
    CreatureTemplateEditor.PopulateFields()
end

-- Register handlers
GameMasterSystem = GameMasterSystem or {}
GameMasterSystem.CreatureTemplateEditor = CreatureTemplateEditor

-- Register AIO handlers
local handlers = AIO.AddHandlers("CreatureTemplateEditor", {})

-- Handler for receiving template data from server
function handlers.ReceiveTemplateData(player, data)
    CreatureTemplateEditor.ReceiveTemplateData(data)
end

-- Handler for receiving next available entry ID
function handlers.ReceiveNextAvailableEntry(player, entryId)
    CreatureTemplateEditor.nextAvailableEntry = entryId
    CreatureTemplateEditor.UpdateEntryDisplay()
end

-- Test commands for debugging
SLASH_TESTTEMPLATEEDITOR1 = "/testtemplate"
SlashCmdList["TESTTEMPLATEEDITOR"] = function(msg)
    local entryId = tonumber(msg) or 1234
    print("Opening Template Editor for creature entry: " .. entryId)
    -- Check if FlagEditor is loaded
    if _G.FlagEditor then
        print("|cFF00FF00FlagEditor is loaded and available|r")
    else
        print("|cFFFF0000FlagEditor is NOT loaded!|r")
    end
    CreatureTemplateEditor.Open(entryId, true)
end

SLASH_TESTFLAGEDITOR1 = "/testflags"
SlashCmdList["TESTFLAGEDITOR"] = function(msg)
    local parts = {}
    for part in msg:gmatch("%S+") do
        table.insert(parts, part)
    end
    
    local flagType = parts[1] or "npcflag"
    local value = tonumber(parts[2]) or 0
    
    print("Opening Flag Editor for type: " .. flagType .. " with value: " .. value)
    local FlagEditor = _G.FlagEditor
    if FlagEditor and FlagEditor.Open then
        FlagEditor.Open(flagType, value, function(newValue)
            print("New flag value:", newValue, string.format("(0x%X)", newValue))
        end)
    else
        print("|cFFFF0000FlagEditor not loaded!|r")
    end
end

-- print("|cFF00FF00[CreatureTemplateEditor] Main module loaded|r")