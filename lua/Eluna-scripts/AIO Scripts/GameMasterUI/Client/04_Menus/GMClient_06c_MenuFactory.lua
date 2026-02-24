local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get the shared namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

-- Menu Factory Coordinator
local MenuFactory = {}
GMMenus.MenuFactory = MenuFactory

-- The subfolder modules will add their functions to MenuFactory
-- They are loaded after this file due to naming

-- Main menu show function
function MenuFactory.ShowMenu(menuType, anchor, entity)
    local menuCreators = {
        npc = MenuFactory.createNpcMenu,
        gameobject = MenuFactory.createGameObjectMenu,
        spell = MenuFactory.createSpellMenu,
        spellvisual = MenuFactory.createSpellVisualMenu,
        item = MenuFactory.createItemMenu,
        player = MenuFactory.createPlayerMenu,
    }

    local menuCreator = menuCreators[menuType]
    if menuCreator then
        -- Use styled EasyMenu for consistent dark theme
        ShowStyledEasyMenu(menuCreator(entity), "cursor")
    end
end

-- Menu factory coordinator loaded