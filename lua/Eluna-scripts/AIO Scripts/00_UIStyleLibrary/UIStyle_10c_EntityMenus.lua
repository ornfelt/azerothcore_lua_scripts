local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY ENTITY MENUS MODULE
-- ===================================
-- Entity-specific context menus

--[[
Creates entity-specific context menu with common actions
@param entityType - Type of entity ("npc", "gameobject", "item", "spell", "player")
@param entity - Entity data table
@param additionalItems - Optional additional menu items to add
@return Menu items table formatted for context menu
]]
function CreateEntityContextMenu(entityType, entity, additionalItems)
    local menuItems = {}
    
    -- Add title
    table.insert(menuItems, {
        text = entityType:upper() .. " ACTIONS",
        isTitle = true
    })
    
    -- Add entity-specific items based on type
    if entityType == "npc" then
        -- NPC actions
        table.insert(menuItems, {
            text = "Spawn NPC",
            func = function()
                if entity.id then
                    print("Spawning NPC " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Go to NPC",
            func = function()
                if entity.id then
                    print("Going to NPC " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Delete NPC",
            func = function()
                if entity.id then
                    print("Deleting NPC " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, { isSeparator = true })
        
        table.insert(menuItems, {
            text = "Copy Entry ID",
            func = function()
                if entity.id then
                    print("Copied: " .. entity.id)
                end
            end
        })
        
    elseif entityType == "item" then
        -- Item actions
        table.insert(menuItems, {
            text = "Add Item",
            func = function()
                if entity.id then
                    print("Adding item " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Link Item",
            func = function()
                if entity.link then
                    print("Linking: " .. entity.link)
                end
            end
        })
        
        table.insert(menuItems, { isSeparator = true })
        
        table.insert(menuItems, {
            text = "Copy Item ID",
            func = function()
                if entity.id then
                    print("Copied: " .. entity.id)
                end
            end
        })
        
    elseif entityType == "spell" then
        -- Spell actions
        table.insert(menuItems, {
            text = "Learn Spell",
            func = function()
                if entity.id then
                    print("Learning spell " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Cast Spell",
            func = function()
                if entity.id then
                    print("Casting spell " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, { isSeparator = true })
        
        table.insert(menuItems, {
            text = "Copy Spell ID",
            func = function()
                if entity.id then
                    print("Copied: " .. entity.id)
                end
            end
        })
        
    elseif entityType == "player" then
        -- Player actions
        table.insert(menuItems, {
            text = "Teleport to Player",
            func = function()
                if entity.name then
                    print("Teleporting to " .. entity.name)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Summon Player",
            func = function()
                if entity.name then
                    print("Summoning " .. entity.name)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Whisper Player",
            func = function()
                if entity.name then
                    print("Whispering " .. entity.name)
                end
            end
        })
        
        table.insert(menuItems, { isSeparator = true })
        
        table.insert(menuItems, {
            text = "View Inventory",
            func = function()
                if entity.guid then
                    print("Viewing inventory of " .. entity.name)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Kick Player",
            func = function()
                if entity.name then
                    print("Kicking " .. entity.name)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Ban Player",
            func = function()
                if entity.name then
                    print("Banning " .. entity.name)
                end
            end
        })
        
    elseif entityType == "gameobject" then
        -- GameObject actions
        table.insert(menuItems, {
            text = "Spawn GameObject",
            func = function()
                if entity.id then
                    print("Spawning GameObject " .. entity.id)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Activate GameObject",
            func = function()
                if entity.guid then
                    print("Activating GameObject " .. entity.guid)
                end
            end
        })
        
        table.insert(menuItems, {
            text = "Delete GameObject",
            func = function()
                if entity.guid then
                    print("Deleting GameObject " .. entity.guid)
                end
            end
        })
        
        table.insert(menuItems, { isSeparator = true })
        
        table.insert(menuItems, {
            text = "Copy Entry ID",
            func = function()
                if entity.id then
                    print("Copied: " .. entity.id)
                end
            end
        })
    end
    
    -- Add additional custom items if provided
    if additionalItems and type(additionalItems) == "table" then
        if #menuItems > 0 then
            table.insert(menuItems, { isSeparator = true })
        end
        
        for _, item in ipairs(additionalItems) do
            table.insert(menuItems, item)
        end
    end
    
    -- Add cancel button at the end
    if #menuItems > 0 then
        table.insert(menuItems, { isSeparator = true })
    end
    
    table.insert(menuItems, {
        text = "Cancel",
        func = function()
            -- Just close the menu
        end
    })
    
    return menuItems
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["EntityMenus"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: EntityMenus module loaded")
end