local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

local GMUtils = _G.GMUtils
local GMConfig = _G.GMConfig
local MenuItems = GMMenus.MenuItems
local MENU_CONFIG = GMConfig.MENU_CONFIG

-- Entity Menus Module
local EntityMenus = {}
GMMenus.MenuFactory = GMMenus.MenuFactory or {}
local MenuFactory = GMMenus.MenuFactory

function EntityMenus.createNpcMenu(entity)
    local trimmedEntry = GMUtils.trimSpaces(entity.entry)
    return {
        MenuItems.createTitle("Creature ID: " .. trimmedEntry),
        {
            text = "Spawn",
            func = function()
                local trimmedEntry = tonumber(GMUtils.trimSpaces(entity.entry))
                if trimmedEntry then
                    print("Spawning NPC with ID: " .. trimmedEntry)
                    AIO.Handle("GameMasterSystem", "spawnNpcEntity", trimmedEntry)
                else
                    print("Invalid NPC ID")
                end
            end,
            notCheckable = true,
        },
        {
            text = "|cFF00FF00Edit Nearby...|r",
            func = function()
                if _G.EntitySelectionDialog then
                    _G.EntitySelectionDialog.Open()
                else
                    print("[ERROR] EntitySelectionDialog not loaded!")
                end
            end,
            notCheckable = true,
            tooltipTitle = "Edit Nearby Entities",
            tooltipText = "Opens a dialog to select and edit nearby Creatures and Objects.\\n\\n"
                .. "|cFFFFFF00Features search, filtering, and context menus.|r",
            tooltipOnButton = true,
        },
        {
            text = "Edit Selected",
            func = function()
                -- Request to edit selected Creature
                AIO.Handle("GameMasterSystem", "getSelectedCreature")
            end,
            notCheckable = true,
            tooltipTitle = "Edit Selected Creature",
            tooltipText = "Edit the currently targeted Creature.\\n\\n"
                .. "|cFFFFFF00You must have a Creature targeted.|r",
            tooltipOnButton = true,
        },
        MenuItems.createDelete(MENU_CONFIG.TYPES.NPC, trimmedEntry, function(entry)
            AIO.Handle("GameMasterSystem", "deleteNpcEntity", entry)
        end),
        MenuItems.createCopyMenu(entity),
        {
            text = "Morphing",
            hasArrow = true,
            menuList = EntityMenus.createMorphingSubmenu(entity),
            notCheckable = true,
        },
        {
            text = "Duplicate to Database",
            func = function()
                print("Duplicating NPC with ID: " .. trimmedEntry)
                AIO.Handle("GameMasterSystem", "duplicateNpcEntity", trimmedEntry)
            end,
            notCheckable = true,
            tooltipTitle = "Duplicate to Database",
            tooltipText = "Duplicate this NPC to the database.\n\n"
                .. "This will create a new entry in the database with the same data as this NPC.\n\n"
                .. "You can then modify the new entry as needed.",
            tooltipOnButton = true,
        },
        MenuItems.CANCEL,
    }
end

function EntityMenus.createMorphingSubmenu(entity)
    local submenu = {
        {
            text = "Demorph",
            func = function()
                AIO.Handle("GameMasterSystem", "demorphNpcEntity")
            end,
            notCheckable = true,
        },
    }

    -- Add model IDs
    for i, modelId in ipairs(entity.modelid) do
        table.insert(submenu, 1, {
            text = "Model ID " .. i .. ": " .. modelId,
            func = function()
                AIO.Handle("GameMasterSystem", "morphNpcEntity", GMUtils.trimSpaces(modelId))
            end,
            notCheckable = true,
        })
    end

    return submenu
end

function EntityMenus.createGameObjectMenu(entity)
    local trimmedEntry = GMUtils.trimSpaces(entity.entry)
    return {
        MenuItems.createTitle("GameObject ID: " .. trimmedEntry),
        {
            text = "Spawn",
            func = function()
                local trimmedEntry = tonumber(GMUtils.trimSpaces(entity.entry))
                if trimmedEntry then
                    print("Spawning GameObject with ID: " .. trimmedEntry)
                    AIO.Handle("GameMasterSystem", "spawnGameObject", trimmedEntry)
                else
                    print("Invalid GameObject ID")
                end
            end,
            notCheckable = true,
        },
        {
            text = "|cFF00FF00Edit Nearby...|r",
            func = function()
                if _G.EntitySelectionDialog then
                    _G.EntitySelectionDialog.Open()
                else
                    print("[ERROR] EntitySelectionDialog not loaded!")
                end
            end,
            notCheckable = true,
            tooltipTitle = "Edit Nearby Entities",
            tooltipText = "Opens a dialog to select and edit nearby Creatures and Objects.\\n\\n"
                .. "|cFFFFFF00Features search, filtering, and context menus.|r",
            tooltipOnButton = true,
        },
        {
            text = "Edit Selected",
            func = function()
                -- Request to edit selected GameObject
                AIO.Handle("GameMasterSystem", "getSelectedGameObject")
            end,
            notCheckable = true,
            tooltipTitle = "Edit Selected GameObject",
            tooltipText = "Edit the currently targeted GameObject.\n\n"
                .. "|cFFFFFF00You must have a GameObject targeted.|r",
            tooltipOnButton = true,
        },
        MenuItems.createDelete(MENU_CONFIG.TYPES.GAMEOBJECT, trimmedEntry, function(entry)
            AIO.Handle("GameMasterSystem", "deleteGameObjectEntity", entry)
        end),
        MenuItems.createCopyMenu(entity),
        {
            text = "Duplicate to Database",
            func = function()
                print("Duplicating GameObject with ID: " .. trimmedEntry)
                AIO.Handle("GameMasterSystem", "duplicateGameObjectEntity", trimmedEntry)
            end,
            notCheckable = true,
            tooltipTitle = "Duplicate to Database",
            tooltipText = "Duplicate this GameObject to the database.\n\n"
                .. "This will create a new entry in the database with the same data as this GameObject.\n\n"
                .. "You can then modify the new entry as needed.",
            tooltipOnButton = true,
        },
        MenuItems.CANCEL,
    }
end

-- Create submenu for nearby objects (dynamic)
function EntityMenus.createNearbyObjectsSubmenu()
    -- This will be populated dynamically
    local submenu = {}
    
    -- Add loading entry initially
    table.insert(submenu, {
        text = "|cFF888888Loading nearby objects...|r",
        disabled = true,
        notCheckable = true,
    })
    
    -- Request nearby objects from server
    AIO.Handle("GameMasterSystem", "getNearbyGameObjects", 30) -- 30 yard range
    
    -- The submenu will be updated via handler when data arrives
    EntityMenus.nearbyObjectsMenu = submenu
    
    return submenu
end

-- Update nearby objects submenu (called from handler)
function EntityMenus.updateNearbyObjectsMenu(objects)
    if not EntityMenus.nearbyObjectsMenu then
        return
    end
    
    -- Clear current menu
    for k in pairs(EntityMenus.nearbyObjectsMenu) do
        EntityMenus.nearbyObjectsMenu[k] = nil
    end
    
    if not objects or #objects == 0 then
        table.insert(EntityMenus.nearbyObjectsMenu, {
            text = "|cFFFF0000No GameObjects nearby|r",
            disabled = true,
            notCheckable = true,
        })
        return
    end
    
    -- Add each object to menu
    for i, obj in ipairs(objects) do
        if i > 10 then break end -- Limit to 10 objects
        
        -- Color code by distance
        local color = "|cFF00FF00" -- Green for close
        if obj.distance > 20 then
            color = "|cFFFF0000" -- Red for far
        elseif obj.distance > 10 then
            color = "|cFFFFFF00" -- Yellow for medium
        end
        
        table.insert(EntityMenus.nearbyObjectsMenu, {
            text = string.format("%s[%d] %.1f yds|r", color, obj.entry, obj.distance),
            func = function()
                -- Request to edit this specific object
                AIO.Handle("GameMasterSystem", "getGameObjectForEdit", obj.guid)
            end,
            notCheckable = true,
            tooltipTitle = "GameObject ID: " .. obj.entry,
            tooltipText = string.format("Distance: %.1f yards\nGUID: %d\n\nClick to edit this object.", 
                obj.distance, obj.guid),
            tooltipOnButton = true,
        })
    end
    
    -- Add refresh option at bottom
    table.insert(EntityMenus.nearbyObjectsMenu, {
        text = "",
        disabled = true,
        notCheckable = true,
    }) -- Separator
    
    table.insert(EntityMenus.nearbyObjectsMenu, {
        text = "|cFF00FFFF[R] Refresh|r",
        func = function()
            AIO.Handle("GameMasterSystem", "getNearbyGameObjects", 30)
        end,
        notCheckable = true,
        tooltipTitle = "Refresh List",
        tooltipText = "Update the list of nearby GameObjects",
        tooltipOnButton = true,
    })
end

-- Create submenu for nearby creatures (dynamic)
function EntityMenus.createNearbyCreaturesSubmenu()
    -- This will be populated dynamically
    local submenu = {}
    
    -- Add loading entry initially
    table.insert(submenu, {
        text = "|cFF888888Loading nearby creatures...|r",
        disabled = true,
        notCheckable = true,
    })
    
    -- Request nearby creatures from server
    AIO.Handle("GameMasterSystem", "getNearbyCreatures", 30) -- 30 yard range
    
    -- The submenu will be updated via handler when data arrives
    EntityMenus.nearbyCreaturesMenu = submenu
    
    return submenu
end

-- Update nearby creatures submenu (called from handler)
function EntityMenus.updateNearbyCreaturesMenu(creatures)
    if not EntityMenus.nearbyCreaturesMenu then
        return
    end
    
    -- Clear current menu
    for k in pairs(EntityMenus.nearbyCreaturesMenu) do
        EntityMenus.nearbyCreaturesMenu[k] = nil
    end
    
    if not creatures or #creatures == 0 then
        table.insert(EntityMenus.nearbyCreaturesMenu, {
            text = "|cFFFF0000No Creatures nearby|r",
            disabled = true,
            notCheckable = true,
        })
        return
    end
    
    -- Add each creature to menu
    for i, creature in ipairs(creatures) do
        if i > 10 then break end -- Limit to 10 creatures
        
        -- Color code by distance
        local color = "|cFF00FF00" -- Green for close
        if creature.distance > 20 then
            color = "|cFFFF0000" -- Red for far
        elseif creature.distance > 10 then
            color = "|cFFFFFF00" -- Yellow for medium
        end
        
        local displayName = creature.name or ("Creature " .. creature.entry)
        table.insert(EntityMenus.nearbyCreaturesMenu, {
            text = string.format("%s%s [%.1f yds]|r", color, displayName, creature.distance),
            func = function()
                -- Request to edit this specific creature
                AIO.Handle("GameMasterSystem", "getCreatureForEdit", creature.guid)
            end,
            notCheckable = true,
            tooltipTitle = "Creature ID: " .. creature.entry,
            tooltipText = string.format("Name: %s\\nDistance: %.1f yards\\nGUID: %d\\n\\nClick to edit this creature.", 
                displayName, creature.distance, creature.guid),
            tooltipOnButton = true,
        })
    end
    
    -- Add refresh option at bottom
    table.insert(EntityMenus.nearbyCreaturesMenu, {
        text = "",
        disabled = true,
        notCheckable = true,
    }) -- Separator
    
    table.insert(EntityMenus.nearbyCreaturesMenu, {
        text = "|cFF00FFFF[R] Refresh|r",
        func = function()
            AIO.Handle("GameMasterSystem", "getNearbyCreatures", 30)
        end,
        notCheckable = true,
        tooltipTitle = "Refresh List",
        tooltipText = "Update the list of nearby Creatures",
        tooltipOnButton = true,
    })
end

-- Export functions to MenuFactory
MenuFactory.createNpcMenu = EntityMenus.createNpcMenu
MenuFactory.createMorphingSubmenu = EntityMenus.createMorphingSubmenu
MenuFactory.createGameObjectMenu = EntityMenus.createGameObjectMenu
MenuFactory.createNearbyObjectsSubmenu = EntityMenus.createNearbyObjectsSubmenu
MenuFactory.updateNearbyObjectsMenu = EntityMenus.updateNearbyObjectsMenu
MenuFactory.createNearbyCreaturesSubmenu = EntityMenus.createNearbyCreaturesSubmenu
MenuFactory.updateNearbyCreaturesMenu = EntityMenus.updateNearbyCreaturesMenu

-- Store reference for updates
_G.EntityMenus = EntityMenus

-- Entity menus module loaded