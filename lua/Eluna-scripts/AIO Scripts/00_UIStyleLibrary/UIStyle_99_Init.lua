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
    "Core",
    "MenuManager", 
    "BasicWidgets",
    "QualityWidgets",
    "Scrolling",
    "BasicDropdowns",
    "CustomDropdowns",
    "FullyStyledDropdowns",
    "Tabs",
    "Input",
    "Cards",
    "Icons",
    "Dialogs",
    "ContextMenuBase",
    "ContextMenuAdvanced",
    "EntityMenus",
    "Lists",
    "StatusBars",
    "Tooltips",
    "Toasts",
    "Utils"
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
UISTYLE_LIBRARY_VERSION = "2.0.0"
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

-- Clean up temporary module tracker
if not UISTYLE_DEBUG then
    UISTYLE_LIBRARY_MODULES = nil
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Init"] = true