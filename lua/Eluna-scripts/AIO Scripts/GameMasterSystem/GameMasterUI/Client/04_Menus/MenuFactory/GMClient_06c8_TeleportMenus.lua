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

local MenuFactory = GMMenus.MenuFactory
if not MenuFactory then
    print("[ERROR] MenuFactory not found! Check load order.")
    return
end

local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem not found! Check load order.")
    return
end

-- Teleport Menu Integration
local TeleportMenus = {}

-- Add teleport options to player menu
function TeleportMenus.AddTeleportMenuItems(menuList, playerName)
    -- Add separator before teleport options
    table.insert(menuList, { text = "", disabled = true, notCheckable = true })
    
    -- Teleport submenu
    local teleportSubmenu = {
        text = "Teleport",
        hasArrow = true,
        menuList = {}
    }
    
    -- Teleport to player
    table.insert(teleportSubmenu.menuList, {
        text = "Teleport to Player",
        func = function()
            AIO.Handle("GameMasterSystem", "TeleportToPlayer", playerName)
        end,
        notCheckable = true
    })
    
    -- Summon player
    table.insert(teleportSubmenu.menuList, {
        text = "Summon Player Here",
        func = function()
            AIO.Handle("GameMasterSystem", "SummonPlayer", playerName)
        end,
        notCheckable = true
    })
    
    -- Separator
    table.insert(teleportSubmenu.menuList, { text = "", disabled = true, notCheckable = true })
    
    -- Teleport player to location
    table.insert(teleportSubmenu.menuList, {
        text = "Teleport to Location...",
        func = function()
            if GameMasterSystem.ShowTeleportList then
                GameMasterSystem.ShowTeleportList(playerName)
            end
        end,
        notCheckable = true
    })
    
    -- Advanced teleport search
    table.insert(teleportSubmenu.menuList, {
        text = "Advanced Search...",
        func = function()
            if GameMasterSystem.Teleport and GameMasterSystem.Teleport.ShowAdvancedSearch then
                GameMasterSystem.Teleport.ShowAdvancedSearch(playerName)
            end
        end,
        notCheckable = true
    })
    
    table.insert(menuList, teleportSubmenu)
end

-- Add quick teleport menu for GM toolbar
function TeleportMenus.CreateQuickTeleportMenu()
    local menuList = {}
    
    -- Common teleport locations
    table.insert(menuList, {
        text = "Quick Teleports",
        isTitle = true,
        notCheckable = true
    })
    
    -- Major cities
    local citiesMenu = {
        text = "Major Cities",
        hasArrow = true,
        menuList = {
            -- Alliance
            { text = "Alliance Cities", isTitle = true, notCheckable = true },
            { text = "Stormwind", func = function() TeleportMenus.TeleportToPreset("Stormwind") end, notCheckable = true },
            { text = "Ironforge", func = function() TeleportMenus.TeleportToPreset("Ironforge") end, notCheckable = true },
            { text = "Darnassus", func = function() TeleportMenus.TeleportToPreset("Darnassus") end, notCheckable = true },
            { text = "Exodar", func = function() TeleportMenus.TeleportToPreset("Exodar") end, notCheckable = true },
            
            { text = "", disabled = true, notCheckable = true },
            
            -- Horde
            { text = "Horde Cities", isTitle = true, notCheckable = true },
            { text = "Orgrimmar", func = function() TeleportMenus.TeleportToPreset("Orgrimmar") end, notCheckable = true },
            { text = "Thunder Bluff", func = function() TeleportMenus.TeleportToPreset("ThunderBluff") end, notCheckable = true },
            { text = "Undercity", func = function() TeleportMenus.TeleportToPreset("Undercity") end, notCheckable = true },
            { text = "Silvermoon", func = function() TeleportMenus.TeleportToPreset("Silvermoon") end, notCheckable = true },
            
            { text = "", disabled = true, notCheckable = true },
            
            -- Neutral
            { text = "Neutral Cities", isTitle = true, notCheckable = true },
            { text = "Shattrath", func = function() TeleportMenus.TeleportToPreset("Shattrath") end, notCheckable = true },
            { text = "Dalaran", func = function() TeleportMenus.TeleportToPreset("Dalaran") end, notCheckable = true },
        }
    }
    table.insert(menuList, citiesMenu)
    
    -- Starting zones
    local startingZonesMenu = {
        text = "Starting Zones",
        hasArrow = true,
        menuList = {
            { text = "Human - Northshire", func = function() TeleportMenus.TeleportToPreset("Northshire") end, notCheckable = true },
            { text = "Dwarf/Gnome - Coldridge", func = function() TeleportMenus.TeleportToPreset("ColdridgeValley") end, notCheckable = true },
            { text = "Night Elf - Shadowglen", func = function() TeleportMenus.TeleportToPreset("Shadowglen") end, notCheckable = true },
            { text = "Draenei - Ammen Vale", func = function() TeleportMenus.TeleportToPreset("AmmenVale") end, notCheckable = true },
            { text = "", disabled = true, notCheckable = true },
            { text = "Orc/Troll - Valley of Trials", func = function() TeleportMenus.TeleportToPreset("ValleyOfTrials") end, notCheckable = true },
            { text = "Tauren - Camp Narache", func = function() TeleportMenus.TeleportToPreset("CampNarache") end, notCheckable = true },
            { text = "Undead - Deathknell", func = function() TeleportMenus.TeleportToPreset("Deathknell") end, notCheckable = true },
            { text = "Blood Elf - Sunstrider Isle", func = function() TeleportMenus.TeleportToPreset("SunstriderIsle") end, notCheckable = true },
            { text = "Death Knight - Acherus", func = function() TeleportMenus.TeleportToPreset("Acherus") end, notCheckable = true },
        }
    }
    table.insert(menuList, startingZonesMenu)
    
    -- GM/Dev areas
    local gmAreasMenu = {
        text = "GM/Dev Areas",
        hasArrow = true,
        menuList = {
            { text = "GM Island", func = function() TeleportMenus.TeleportToPreset("GMIsland") end, notCheckable = true },
            { text = "Developer Land", func = function() TeleportMenus.TeleportToPreset("DeveloperLand") end, notCheckable = true },
            { text = "Programmer Isle", func = function() TeleportMenus.TeleportToPreset("ProgrammerIsle") end, notCheckable = true },
            { text = "Designer Island", func = function() TeleportMenus.TeleportToPreset("DesignerIsland") end, notCheckable = true },
        }
    }
    table.insert(menuList, gmAreasMenu)
    
    table.insert(menuList, { text = "", disabled = true, notCheckable = true })
    
    -- Open full teleport list
    table.insert(menuList, {
        text = "Browse All Locations...",
        func = function()
            if GameMasterSystem.ShowTeleportList then
                GameMasterSystem.ShowTeleportList()
            end
        end,
        notCheckable = true
    })
    
    -- Advanced search
    table.insert(menuList, {
        text = "Advanced Search...",
        func = function()
            if GameMasterSystem.Teleport and GameMasterSystem.Teleport.ShowAdvancedSearch then
                GameMasterSystem.Teleport.ShowAdvancedSearch()
            end
        end,
        notCheckable = true
    })
    
    return menuList
end

-- Teleport to preset location
function TeleportMenus.TeleportToPreset(locationName)
    AIO.Handle("GameMasterSystem", "TeleportToPreset", locationName)
end

-- Hook into existing player menu creation
local originalCreatePlayerMenu = MenuFactory.createPlayerMenu
if originalCreatePlayerMenu then
    MenuFactory.createPlayerMenu = function(playerName)
        local menuList = originalCreatePlayerMenu(playerName)
        
        -- Add teleport options
        TeleportMenus.AddTeleportMenuItems(menuList, playerName)
        
        return menuList
    end
end

-- Add quick teleport menu creator to MenuFactory
MenuFactory.createQuickTeleportMenu = TeleportMenus.CreateQuickTeleportMenu

-- Create global teleport button function
function GameMasterSystem.ShowQuickTeleportMenu()
    local menu = TeleportMenus.CreateQuickTeleportMenu()
    ShowStyledEasyMenu(menu, "cursor")
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterUI] Teleport menus module loaded")
end