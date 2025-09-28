local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY BASIC DROPDOWNS MODULE
-- ===================================
-- Basic dropdown functionality using UIDropDownMenuTemplate

--[[
Creates a styled dropdown menu with dark theme
@param parent - Parent frame
@param width - Width of the dropdown (excluding arrow)
@param items - Table of string options
@param defaultValue - Optional default selected value
@param onSelect - Callback function when selection changes
@return dropdown frame, background frame
]]
function CreateStyledDropdown(parent, width, items, defaultValue, onSelect)
    -- Generate unique global name (required for UIDropDownMenuTemplate in 3.3.5)
    local dropdownName = "UIStyleDropdown" .. math.random(100000, 999999)

    -- Create background frame with enhanced styling
    local dropdownBg = CreateStyledFrame(parent, UISTYLE_COLORS.SectionBg)
    dropdownBg:SetSize(width + 30, 32)

    -- Add inner shadow effect
    local innerShadow = dropdownBg:CreateTexture(nil, "OVERLAY")
    innerShadow:SetTexture("Interface\\Buttons\\WHITE8X8")
    innerShadow:SetVertexColor(0, 0, 0, 0.3)
    innerShadow:SetPoint("TOPLEFT", 1, -1)
    innerShadow:SetPoint("BOTTOMRIGHT", -1, 1)
    innerShadow:SetBlendMode("BLEND")

    -- Create dropdown with global name
    local dropdown = CreateFrame("Frame", dropdownName, dropdownBg, "UIDropDownMenuTemplate")
    dropdown:SetPoint("CENTER", dropdownBg, "CENTER", -16, 0)

    -- Style the dropdown text
    local dropdownText = _G[dropdownName .. "Text"]
    if dropdownText then
        dropdownText:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
        dropdownText:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
    end

    -- Create a custom highlight overlay for better visual feedback
    local highlightOverlay = dropdownBg:CreateTexture(nil, "HIGHLIGHT")
    highlightOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")
    highlightOverlay:SetVertexColor(1, 1, 1, 0.05)
    highlightOverlay:SetPoint("TOPLEFT", 1, -1)
    highlightOverlay:SetPoint("BOTTOMRIGHT", -1, 1)

    -- Hide the default dropdown button borders (they don't match our theme)
    local leftTexture = _G[dropdownName .. "Left"]
    local middleTexture = _G[dropdownName .. "Middle"]
    local rightTexture = _G[dropdownName .. "Right"]
    if leftTexture then
        leftTexture:SetAlpha(0)
    end
    if middleTexture then
        middleTexture:SetAlpha(0)
    end
    if rightTexture then
        rightTexture:SetAlpha(0)
    end

    -- Helper function to process menu items recursively
    local function processMenuItem(item, level, parentList)
        local info = UIDropDownMenu_CreateInfo()
        
        -- Handle simple string items
        if type(item) == "string" then
            info.text = item
            info.value = item
            info.func = function()
                UIDropDownMenu_SetSelectedName(dropdown, item)
                if onSelect then
                    onSelect(item)
                end
            end
            info.checked = (UIDropDownMenu_GetSelectedName(dropdown) == item)
        -- Handle complex table items
        elseif type(item) == "table" then
            -- Required properties
            info.text = item.text or "Unnamed"
            info.value = item.value or item.text
            
            -- Optional properties
            info.hasArrow = item.hasArrow
            info.menuList = item.menuList
            info.disabled = item.disabled
            info.isTitle = item.isTitle
            info.notCheckable = item.notCheckable or item.isTitle
            
            -- Icon support
            if item.icon then
                info.icon = item.icon
                info.tCoordLeft = item.tCoordLeft or 0.1
                info.tCoordRight = item.tCoordRight or 0.9
                info.tCoordTop = item.tCoordTop or 0.1
                info.tCoordBottom = item.tCoordBottom or 0.9
            end
            
            -- Separator support
            if item.isSeparator then
                info = UIDropDownMenu_CreateInfo()
                info.text = ""
                info.disabled = true
                info.notClickable = true
                info.notCheckable = true
            else
                -- Function handling
                if item.func then
                    info.func = item.func
                elseif not item.hasArrow and not item.isTitle and not item.disabled then
                    -- Default selection behavior for non-submenu items
                    info.func = function()
                        UIDropDownMenu_SetSelectedName(dropdown, info.value)
                        if onSelect then
                            onSelect(info.value, item)
                        end
                    end
                end
                
                -- Checked state
                if item.checked ~= nil then
                    info.checked = item.checked
                elseif not item.notCheckable and not item.hasArrow then
                    info.checked = (UIDropDownMenu_GetSelectedName(dropdown) == info.value)
                end
            end
        end
        
        return info
    end
    
    -- Initialize dropdown with nested menu support
    UIDropDownMenu_SetWidth(dropdown, width)
    UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
        level = level or 1
        local itemList = menuList or items
        
        if type(itemList) == "table" then
            for _, item in ipairs(itemList) do
                local info = processMenuItem(item, level, itemList)
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end)

    -- Set default value if provided
    if defaultValue then
        UIDropDownMenu_SetSelectedName(dropdown, defaultValue)
    end

    -- Store references
    dropdown.bg = dropdownBg

    -- Add method to update items
    dropdown.UpdateItems = function(self, newItems, newDefault)
        items = newItems
        UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
            level = level or 1
            local itemList = menuList or items
            
            if type(itemList) == "table" then
                for _, item in ipairs(itemList) do
                    local info = processMenuItem(item, level, itemList)
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        end)
        if newDefault then
            UIDropDownMenu_SetSelectedName(dropdown, newDefault)
        end
    end

    -- Add method to get selected value
    dropdown.GetValue = function(self)
        return UIDropDownMenu_GetSelectedName(dropdown)
    end

    -- Add method to set value
    dropdown.SetValue = function(self, value)
        UIDropDownMenu_SetSelectedName(dropdown, value)
    end

    return dropdown, dropdownBg
end

--[[
Creates a styled nested dropdown menu with support for submenus, icons, and complex items
@param parent - Parent frame
@param width - Width of the dropdown (excluding arrow)
@param items - Table of menu items (can be strings or tables with properties)
@param defaultValue - Optional default selected value
@param onSelect - Callback function when selection changes
@param options - Optional table with additional configuration:
    - multiSelect: boolean - Allow multiple selections
    - closeOnSelect: boolean - Close menu on selection (default true)
    - showValue: boolean - Show value instead of text when selected
@return dropdown frame, background frame

Example usage:
local items = {
    "Simple Option",
    { text = "Disabled Option", disabled = true },
    { isSeparator = true },
    { text = "Title", isTitle = true },
    {
        text = "Submenu",
        hasArrow = true,
        menuList = {
            { text = "Sub Option 1", value = "sub1", icon = "Interface\\Icons\\Spell_Nature_MoonKey" },
            { text = "Sub Option 2", value = "sub2" }
        }
    }
}
]]
function CreateStyledNestedDropdown(parent, width, items, defaultValue, onSelect, options)
    options = options or {}
    
    -- Use the enhanced CreateStyledDropdown which now supports nested menus
    local dropdown, dropdownBg = CreateStyledDropdown(parent, width, items, defaultValue, onSelect)
    
    -- Add additional configuration based on options
    if options.multiSelect then
        -- Store selected values for multi-select
        dropdown.selectedValues = {}
        
        -- Override the default selection behavior for multi-select
        local originalInit = dropdown:GetScript("OnShow")
        UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
            level = level or 1
            local itemList = menuList or items
            
            if type(itemList) == "table" then
                for _, item in ipairs(itemList) do
                    local info = UIDropDownMenu_CreateInfo()
                    
                    if type(item) == "string" then
                        info.text = item
                        info.value = item
                        info.checked = dropdown.selectedValues[item]
                        info.keepShownOnClick = true
                        info.func = function()
                            dropdown.selectedValues[item] = not dropdown.selectedValues[item]
                            if onSelect then
                                onSelect(item, dropdown.selectedValues)
                            end
                        end
                    elseif type(item) == "table" and not item.hasArrow and not item.isTitle and not item.disabled and not item.isSeparator then
                        -- Handle complex items for multi-select
                        info.text = item.text
                        info.value = item.value or item.text
                        info.checked = dropdown.selectedValues[info.value]
                        info.keepShownOnClick = true
                        info.func = function()
                            dropdown.selectedValues[info.value] = not dropdown.selectedValues[info.value]
                            if onSelect then
                                onSelect(info.value, dropdown.selectedValues)
                            end
                        end
                    end
                    
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        end)
        
        -- Add method to get all selected values
        dropdown.GetSelectedValues = function(self)
            local selected = {}
            for value, isSelected in pairs(self.selectedValues) do
                if isSelected then
                    table.insert(selected, value)
                end
            end
            return selected
        end
    end
    
    -- Configure close on select behavior
    if options.closeOnSelect == false then
        -- This would require overriding the menu behavior
        -- which is complex with UIDropDownMenuTemplate
    end
    
    return dropdown, dropdownBg
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["BasicDropdowns"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: BasicDropdowns module loaded")
end