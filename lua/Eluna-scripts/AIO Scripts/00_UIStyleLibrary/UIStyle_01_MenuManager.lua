local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY MENU MANAGER MODULE
-- ===================================
-- Manages all open menus to prevent z-order conflicts

-- ===================================
-- GLOBAL MENU MANAGER
-- ===================================
GlobalMenuManager = {
    currentMenu = nil,
    currentCloseHandler = nil,
    activeSubmenus = {},
}

-- Close all open menus
function GlobalMenuManager:CloseAll()
    if self.currentMenu then
        self.currentMenu:Hide()
        self.currentMenu = nil
    end
    
    for _, submenu in pairs(self.activeSubmenus) do
        if submenu then
            submenu:Hide()
        end
    end
    wipe(self.activeSubmenus)
    
    if self.currentCloseHandler then
        self.currentCloseHandler:Hide()
        self.currentCloseHandler = nil
    end
end

-- Register a new menu as active
function GlobalMenuManager:RegisterMenu(menu, closeHandler)
    -- Close any existing menu first
    self:CloseAll()
    
    self.currentMenu = menu
    self.currentCloseHandler = closeHandler
    
    -- Ensure the menu is on top
    if menu.SetToplevel then
        menu:SetToplevel(true)
    end
end

-- Register a submenu
function GlobalMenuManager:RegisterSubmenu(submenu, level)
    self.activeSubmenus[level] = submenu
    
    -- Ensure the submenu is on top
    if submenu.SetToplevel then
        submenu:SetToplevel(true)
    end
end

-- Get or create the shared close handler
function GlobalMenuManager:GetCloseHandler()
    if not self.sharedCloseHandler then
        self.sharedCloseHandler = CreateFrame("Button", "UIStyleLibraryCloseHandler", UIParent)
        self.sharedCloseHandler:SetAllPoints(UIParent)
        self.sharedCloseHandler:SetFrameStrata("FULLSCREEN")
        self.sharedCloseHandler:EnableMouse(true)
        self.sharedCloseHandler:Hide()
        
        self.sharedCloseHandler:SetScript("OnClick", function()
            GlobalMenuManager:CloseAll()
        end)
    end
    return self.sharedCloseHandler
end

-- Export globally for access
_G.UIStyleMenuManager = GlobalMenuManager

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["MenuManager"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: MenuManager module loaded")
end