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
        MenuItems.createActionItem("Edit Nearby...", function()
            if _G.EntitySelectionDialog then
                -- Check state machine availability and use it for coordination
                local StateMachine = _G.GMStateMachine
                if StateMachine then
                    if not StateMachine.canOpenModal() then
                        print("[EntitySelectionDialog] Cannot open - system busy")
                        return
                    end
                    -- Use state machine for coordinated opening
                    if not StateMachine.openEntitySelection("nearby", nil) then
                        print("[EntitySelectionDialog] State machine transition failed - using fallback")
                        _G.EntitySelectionDialog.Open()
                        return
                    end
                    -- State machine succeeded, dialog already opened by onEnter callback
                    return
                else
                    -- No state machine, open directly
                    _G.EntitySelectionDialog.Open()
                end
            else
                print("[ERROR] EntitySelectionDialog not loaded!")
            end
        end, {
            title = "Edit Nearby Entities",
            text = "Opens a dialog to select and edit nearby Creatures and Objects.\\n\\n"
                .. "|cFFFFFF00Features search, filtering, and context menus.|r"
        }),
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
        MenuItems.createTemplateItem("Edit Template...", function()
            if _G.CreatureTemplateEditor then
                -- Check state machine availability and use it for coordination
                local StateMachine = _G.GMStateMachine
                if StateMachine then
                    if not StateMachine.canOpenModal() then
                        print("[CreatureTemplateEditor] Cannot open - system busy")
                        return
                    end
                    -- Use state machine for coordinated opening
                    if not StateMachine.openCreatureEditor(trimmedEntry) then
                        print("[CreatureTemplateEditor] State machine transition failed - using fallback")
                        _G.CreatureTemplateEditor.Open(trimmedEntry, false)
                        return
                    end
                    -- State machine succeeded, dialog already opened by onEnter callback
                    return
                else
                    -- No state machine, open directly
                    _G.CreatureTemplateEditor.Open(trimmedEntry, false)
                end
            else
                print("[ERROR] CreatureTemplateEditor not loaded!")
            end
        end, {
            title = "Edit Creature Template",
            text = "Edit the database template for this creature type.\n\n"
                .. "|cFFFF0000WARNING:|r Changes affect ALL creatures of this type!\n"
                .. "Use 'Duplicate with Editor' to create a modified copy instead."
        }),
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
        MenuItems.createDuplicateItem("Duplicate with Editor...", function()
            if _G.CreatureTemplateEditor then
                -- Check state machine availability and use it for coordination
                local StateMachine = _G.GMStateMachine
                if StateMachine then
                    if not StateMachine.canOpenModal() then
                        print("[CreatureTemplateEditor] Cannot open - system busy")
                        return
                    end
                    -- Use state machine for coordinated opening
                    if not StateMachine.openCreatureEditor(trimmedEntry) then
                        print("[CreatureTemplateEditor] State machine transition failed - using fallback")
                        _G.CreatureTemplateEditor.Open(trimmedEntry, true)
                        return
                    end
                    -- State machine succeeded, dialog already opened by onEnter callback
                    return
                else
                    -- No state machine, open directly
                    _G.CreatureTemplateEditor.Open(trimmedEntry, true)
                end
            else
                print("[ERROR] CreatureTemplateEditor not loaded!")
            end
        end, {
            title = "Duplicate with Template Editor",
            text = "Open the template editor to customize the creature before duplicating.\n\n"
                .. "|cFFFFFF00Edit all creature properties including:|r\n"
                .. "• Name, level, faction, rank\n"
                .. "• NPC flags, combat stats\n"
                .. "• Movement, loot settings\n"
                .. "• And much more!"
        }),
        {
            text = "Quick Duplicate",
            func = function()
                print("Quick duplicating NPC with ID: " .. trimmedEntry)
                AIO.Handle("GameMasterSystem", "duplicateNpcEntity", trimmedEntry)
            end,
            notCheckable = true,
            tooltipTitle = "Quick Duplicate",
            tooltipText = "Quickly duplicate this NPC to the database without modifications.\n\n"
                .. "The copy will have '(Clone)' added to its name.",
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
        MenuItems.createActionItem("Edit Nearby...", function()
                if _G.EntitySelectionDialog then
                    -- Check state machine availability and use it for coordination
                    local StateMachine = _G.GMStateMachine
                    if StateMachine then
                        if not StateMachine.canOpenModal() then
                            print("[EntitySelectionDialog] Cannot open - system busy")
                            return
                        end
                        -- Use state machine for coordinated opening
                        if not StateMachine.openEntitySelection("nearby", nil) then
                            print("[EntitySelectionDialog] State machine transition failed - using fallback")
                            _G.EntitySelectionDialog.Open()
                            return
                        end
                        -- State machine succeeded, dialog already opened by onEnter callback
                        return
                    else
                        -- No state machine, open directly
                        _G.EntitySelectionDialog.Open()
                    end
                else
                    print("[ERROR] EntitySelectionDialog not loaded!")
                end
            end, {
                title = "Edit Nearby Entities",
                text = "Opens a dialog to select and edit nearby Creatures and Objects.\\n\\n"
                    .. "|cFFFFFF00Features search, filtering, and context menus.|r"
            }),
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
        MenuItems.createTemplateItem("Edit Template...", function()
            if _G.GameObjectTemplateEditor then
                -- Check state machine availability and use it for coordination
                local StateMachine = _G.GMStateMachine
                if StateMachine then
                    if not StateMachine.canOpenModal() then
                        print("[GameObjectTemplateEditor] Cannot open - system busy")
                        return
                    end
                    -- Use state machine for coordinated opening
                    if not StateMachine.openGameObjectEditor(trimmedEntry) then
                        print("[GameObjectTemplateEditor] State machine transition failed - using fallback")
                        _G.GameObjectTemplateEditor.Open(trimmedEntry, false)
                        return
                    end
                    -- State machine succeeded, dialog already opened by onEnter callback
                    return
                else
                    -- No state machine, open directly
                    _G.GameObjectTemplateEditor.Open(trimmedEntry, false)
                end
            else
                print("[ERROR] GameObjectTemplateEditor not loaded!")
            end
        end, {
            title = "Edit GameObject Template",
            text = "Edit the database template for this GameObject type.\n\n"
                .. "|cFFFF0000WARNING:|r Changes affect ALL GameObjects of this type!\n"
                .. "Use 'Duplicate with Editor' to create a modified copy instead."
        }),
        MenuItems.createDelete(MENU_CONFIG.TYPES.GAMEOBJECT, trimmedEntry, function(entry)
            AIO.Handle("GameMasterSystem", "deleteGameObjectEntity", entry)
        end),
        MenuItems.createCopyMenu(entity),
        MenuItems.createDuplicateItem("Duplicate with Editor...", function()
            if _G.GameObjectTemplateEditor then
                -- Check state machine availability and use it for coordination
                local StateMachine = _G.GMStateMachine
                if StateMachine then
                    if not StateMachine.canOpenModal() then
                        print("[GameObjectTemplateEditor] Cannot open - system busy")
                        return
                    end
                    -- Use state machine for coordinated opening
                    if not StateMachine.openGameObjectEditor(trimmedEntry) then
                        print("[GameObjectTemplateEditor] State machine transition failed - using fallback")
                        _G.GameObjectTemplateEditor.Open(trimmedEntry, true)
                        return
                    end
                    -- State machine succeeded, dialog already opened by onEnter callback
                    return
                else
                    -- No state machine, open directly
                    _G.GameObjectTemplateEditor.Open(trimmedEntry, true)
                end
            else
                print("[ERROR] GameObjectTemplateEditor not loaded!")
            end
        end, {
            title = "Duplicate with Template Editor",
            text = "Open the template editor to customize the GameObject before duplicating.\n\n"
                .. "|cFFFFFF00Edit all GameObject properties including:|r\n"
                .. "• Name, type, display ID\n"
                .. "• GameObject flags, size\n"
                .. "• Type-specific data fields\n"
                .. "• And much more!"
        }),
        {
            text = "Quick Duplicate",
            func = function()
                print("Quick duplicating GameObject with ID: " .. trimmedEntry)
                AIO.Handle("GameMasterSystem", "duplicateGameObjectEntity", trimmedEntry)
            end,
            notCheckable = true,
            tooltipTitle = "Quick Duplicate",
            tooltipText = "Quickly duplicate this GameObject to the database without modifications.\n\n"
                .. "The copy will have '(Clone)' added to its name.",
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
        text = "Loading nearby objects...",
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
            text = "No GameObjects nearby",
            disabled = true,
            notCheckable = true,
        })
        return
    end
    
    -- Add each object to menu
    for i, obj in ipairs(objects) do
        if i > 10 then break end -- Limit to 10 objects
        
        table.insert(EntityMenus.nearbyObjectsMenu, {
            text = string.format("[%d] %.1f yds", obj.entry, obj.distance),
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
        text = "[R] Refresh",
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
        text = "Loading nearby creatures...",
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
            text = "No Creatures nearby",
            disabled = true,
            notCheckable = true,
        })
        return
    end
    
    -- Add each creature to menu
    for i, creature in ipairs(creatures) do
        if i > 10 then break end -- Limit to 10 creatures
        
        local displayName = creature.name or ("Creature " .. creature.entry)
        table.insert(EntityMenus.nearbyCreaturesMenu, {
            text = string.format("%s [%.1f yds]", displayName, creature.distance),
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
        text = "[R] Refresh",
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