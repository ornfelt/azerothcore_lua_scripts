local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY INITIALIZATION
-- ===================================
-- Final initialization and verification

-- Verify all modules loaded
local requiredModules = {
    -- 00_Foundation
    "Core",
    "Textures",
    "Utils",
    -- 01_Widgets
    "BasicWidgets",
    "QualityWidgets",
    "Scrolling",
    "Icons",
    "StatusBars",
    -- 02_Input
    "SearchBox",
    "EditBoxSliders",
    -- 03_Dropdowns
    "BasicDropdowns",
    "CustomDropdowns",
    "DropdownHelpers",
    "DropdownSearch",
    "FullyStyledDropdowns",
    -- EnumSelector and EnumData are optional data modules (no registration)
    -- 04_Menus
    "MenuManager",
    "ContextMenuBase",
    "ContextMenuAdvanced",
    "EntityMenus",
    -- 05_Layouts
    "Tabs",
    "DropZone",
    "Cards",
    "Lists",
    "Dialogs",
    "Tooltips",
    -- 06_Notifications
    "Toasts",
    -- 07_Animations
    "AnimationsCore",
    "AnimationsEasing",
    "AnimationsEffects",
    "AnimationsContinuous",
    "AnimationsDecorators",
    "AnimationsDecorAdvanced",
}

-- Check each module
local allLoaded = true
for _, moduleName in ipairs(requiredModules) do
    if not UISTYLE_LIBRARY_MODULES[moduleName] then
        if UISTYLE_DEBUG then
            print("UIStyleLibrary ERROR: Module '" .. moduleName .. "' failed to load!")
        end
        allLoaded = false
    end
end

-- Set library version
UISTYLE_LIBRARY_VERSION = "2.1.0"
UISTYLE_LIBRARY_REFACTORED = true

-- Success message
if UISTYLE_DEBUG then
    if allLoaded then
        print("UIStyleLibrary: All modules loaded successfully! Version " .. UISTYLE_LIBRARY_VERSION)
        print("UIStyleLibrary: " .. #requiredModules .. " modules initialized")
    else
        print("UIStyleLibrary: WARNING - Some modules failed to load!")
    end
end

-- Register this module (BEFORE cleanup to avoid the nil-then-recreate bug)
UISTYLE_LIBRARY_MODULES["Init"] = true

-- Clean up temporary module tracker (after registration)
if not UISTYLE_DEBUG then
    UISTYLE_LIBRARY_MODULES = nil
end
