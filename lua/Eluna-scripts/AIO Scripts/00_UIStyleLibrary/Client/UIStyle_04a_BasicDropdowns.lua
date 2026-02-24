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
    local dropdownBg = CreateStyledFrame(parent, UISTYLE_COLORS.ButtonBg)
    dropdownBg:SetSize(width + 30, 32)

    -- Removed inner shadow for flat design

    -- Create dropdown with global name
    local dropdown = CreateFrame("Frame", dropdownName, dropdownBg, "UIDropDownMenuTemplate")
    dropdown:SetPoint("CENTER", dropdownBg, "CENTER", -16, 0)

    -- Style the dropdown text
    local dropdownText = _G[dropdownName .. "Text"]
    if dropdownText then
        dropdownText:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
        dropdownText:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
    end

    -- Create a minimal highlight overlay for flat design
    local highlightOverlay = dropdownBg:CreateTexture(nil, "HIGHLIGHT")
    highlightOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")
    highlightOverlay:SetVertexColor(1, 1, 1, 0.02)
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

-- ===================================
-- DROPDOWN MENU LIST STYLING
-- ===================================
-- Style the WoW native dropdown menus (DropDownList1, etc.) to match our dark theme

local function StyleDropDownMenuList(menu)
    if not menu then return end
    
    -- Style the menu backdrop
    local backdrop = menu.Backdrop or menu
    if backdrop and backdrop.SetBackdropColor then
        backdrop:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
        backdrop:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    end
    
    -- Style menu buttons
    for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
        local button = _G["DropDownList" .. (menu:GetID() or 1) .. "Button" .. i]
        if button then
            -- Style button backgrounds
            local normalTexture = button:GetNormalTexture()
            local highlightTexture = button:GetHighlightTexture()
            
            if normalTexture then
                normalTexture:SetVertexColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 0)
            end
            
            if highlightTexture then
                highlightTexture:SetVertexColor(1, 1, 1, 0.03)
            end
            
            -- Style button text
            local text = _G["DropDownList" .. (menu:GetID() or 1) .. "Button" .. i .. "NormalText"]
            if text then
                text:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
            end
            
            -- Style disabled text
            local disabledText = _G["DropDownList" .. (menu:GetID() or 1) .. "Button" .. i .. "DisabledText"]
            if disabledText then
                disabledText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
            end
        end
    end
end

-- Style any existing dropdown buttons that might be using default WoW styling
local function StyleExistingDropDownButtons()
    -- Find and style any UIDropDownMenuTemplate instances
    for i = 1, 100 do -- Check a reasonable number of potential dropdowns
        local dropdownName = "UIStyleDropdown" .. i
        local dropdown = _G[dropdownName]
        if dropdown then
            -- Style the dropdown button background
            local parent = dropdown:GetParent()
            if parent and parent.SetBackdropColor then
                parent:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
                parent:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
            end
        end
    end
end

-- Hook into dropdown list creation and showing
local function InitializeDropDownStyling()
    -- Style existing dropdown lists
    for i = 1, UIDROPDOWNMENU_MAXLEVELS do
        local menu = _G["DropDownList" .. i]
        if menu then
            StyleDropDownMenuList(menu)
            -- Hook OnShow to reapply styling
            if not menu.styledHooked then
                menu:HookScript("OnShow", function(self)
                    StyleDropDownMenuList(self)
                end)
                menu.styledHooked = true
            end
        end
    end
    
    -- Also style any existing dropdown buttons
    StyleExistingDropDownButtons()
end

-- Apply styling when module loads
local styleFrame = CreateFrame("Frame")
styleFrame:RegisterEvent("ADDON_LOADED")
styleFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" then
        InitializeDropDownStyling()
    end
end)

-- Also run immediately in case we're loaded after addon load
CreateTimer(0.1, InitializeDropDownStyling)

-- Create a repeating timer to catch any dynamically created dropdowns
local styleFrame = CreateFrame("Frame")
local elapsed = 0
styleFrame:SetScript("OnUpdate", function(self, delta)
    elapsed = elapsed + delta
    if elapsed >= 2 then
        elapsed = 0
        StyleExistingDropDownButtons()
        InitializeDropDownStyling()
    end
end)

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["BasicDropdowns"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: BasicDropdowns module loaded with menu styling")
end