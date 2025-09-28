local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GameMasterSystem = _G.GameMasterSystem
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

local GMUtils = _G.GMUtils
local GMData = _G.GMData
local MenuItems = GMMenus.MenuItems
local MenuFactory = GMMenus.MenuFactory

-- Player Menus Module
local PlayerMenus = {}

function PlayerMenus.createPlayerMenu(entity)
    local playerName = GMUtils.trimSpaces(entity.name)
    local isOnline = entity.online ~= false  -- Default to true if not specified
    
    -- Build menu items based on online/offline status
    local menuItems = {
        MenuItems.createTitle("Player: " .. playerName .. (not isOnline and " (Offline)" or "")),
    }
    
    -- Show last seen for offline players
    if not isOnline and entity.lastSeen then
        table.insert(menuItems, {
            text = "Last Seen: " .. entity.lastSeen,
            isTitle = true,
            notCheckable = true,
        })
    end
    
    -- View Inventory (available for both online and offline)
    table.insert(menuItems, {
        text = "View Inventory & Equipment",
        func = function()
            -- Open player inventory and equipment modal
            if _G.PlayerInventory then
                _G.PlayerInventory.showInventoryModal(playerName)
            end
        end,
        notCheckable = true,
        tooltipTitle = "Inventory & Equipment",
        tooltipText = isOnline and "View the player's inventory items and equipped gear" 
                      or "View the offline player's last known inventory and equipped gear (read-only)",
    })
    
    -- Send Mail (available for both online and offline)
    table.insert(menuItems, {
        text = "Send Mail",
        func = function()
            -- Open mail composition dialog
            if GameMasterSystem.OpenMailDialog then
                GameMasterSystem.OpenMailDialog(playerName)
            end
        end,
        notCheckable = true,
        tooltipTitle = "Send Mail",
        tooltipText = isOnline and "Send mail to this player" 
                      or "Send mail to this offline player (will be received when they log in)",
    })
    
    -- Ban options (available for both online and offline)
    table.insert(menuItems, PlayerMenus.createBanSubmenu(playerName, isOnline))
    
    -- Online-only actions
    if isOnline then
        PlayerMenus.addOnlineActions(menuItems, playerName, entity)
    else
        -- Offline-only actions
        PlayerMenus.addOfflineActions(menuItems, playerName, entity)
    end
    
    -- Copy menu (available for both)
    table.insert(menuItems, MenuItems.createCopyMenu(entity))
    
    -- Cancel button
    table.insert(menuItems, MenuItems.CANCEL)
    
    return menuItems
end

function PlayerMenus.createBanSubmenu(playerName, isOnline)
    local banMenu = {
        text = "Ban Player",
        hasArrow = true,
        menuList = {
            {
                text = "Ban Account",
                func = function()
                    if GameMasterSystem.ShowBanDialog then
                        GameMasterSystem.ShowBanDialog(playerName, 0)
                    end
                end,
                notCheckable = true,
                tooltipTitle = "Ban Account",
                tooltipText = "Ban all characters on this player's account",
            },
            {
                text = "Ban Character",
                func = function()
                    if GameMasterSystem.ShowBanDialog then
                        -- Check if character bans are supported
                        if GMData.ServerCapabilities and not GMData.ServerCapabilities.supportsCharacterBan then
                            CreateStyledToast("Character bans are not supported on this server. Use Account ban instead.", 3, 0.5)
                            return
                        end
                        GameMasterSystem.ShowBanDialog(playerName, 1)
                    end
                end,
                notCheckable = true,
                tooltipTitle = "Ban Character", 
                tooltipText = GMData.ServerCapabilities and not GMData.ServerCapabilities.supportsCharacterBan 
                    and "NOT SUPPORTED - Character bans are not available on this server" 
                    or "Ban only this specific character",
                disabled = GMData.ServerCapabilities and not GMData.ServerCapabilities.supportsCharacterBan,
            },
        },
        notCheckable = true,
        tooltipTitle = "Ban Player",
        tooltipText = "Choose ban type: Account or Character",
    }
    
    -- Add Ban IP for online players
    if isOnline then
        table.insert(banMenu.menuList, {
            text = "Ban IP",
            func = function()
                if GameMasterSystem.ShowBanDialog then
                    GameMasterSystem.ShowBanDialog(playerName, 2)
                end
            end,
            notCheckable = true,
            tooltipTitle = "Ban IP",
            tooltipText = "Ban this player's IP address",
        })
    end
    
    return banMenu
end

function PlayerMenus.addOnlineActions(menuItems, playerName, entity)
    -- Apply Auras & Buffs
    table.insert(menuItems, 2, {  -- Insert after title
        text = "Apply Auras & Buffs",
        hasArrow = true,
        menuList = MenuFactory.createBuffSubmenu(playerName),
        notCheckable = true,
        tooltipTitle = "Auras & Buffs",
        tooltipText = "Apply buffs with custom durations or remove auras",
    })
    
    -- Manage Spells
    table.insert(menuItems, 3, {
        text = "Manage Spells",
        func = function()
            -- Open player spell management interface
            if GameMasterSystem.PlayerSpells then
                GameMasterSystem.PlayerSpells.openSpellManager(playerName, entity)
            end
        end,
        notCheckable = true,
        tooltipTitle = "Manage Spells",
        tooltipText = "View and manage all spells this player knows",
    })
    
    -- Give Gold
    table.insert(menuItems, {
        text = "Give Gold",
        func = function()
            -- Open styled dialog to give gold
            if GameMasterSystem.ShowGiveGoldDialog then
                GameMasterSystem.ShowGiveGoldDialog(playerName)
            end
        end,
        notCheckable = true,
        tooltipTitle = "Give Gold",
        tooltipText = "Give gold to this player with preset amounts or custom value",
    })
    
    -- Give Item
    table.insert(menuItems, {
        text = "Give Item",
        func = function()
            -- Open new item selection modal
            if GMMenus.ItemSelection then
                GMMenus.ItemSelection.createDialog(playerName)
            end
        end,
        notCheckable = true,
    })
    
    -- Cast Spell
    table.insert(menuItems, PlayerMenus.createCastSpellSubmenu(playerName))
    
    -- Full Heal & Restore
    table.insert(menuItems, {
        text = "Full Heal & Restore",
        func = function()
            AIO.Handle("GameMasterSystem", "healAndRestorePlayer", playerName)
        end,
        notCheckable = true,
        tooltipTitle = "Full Restore",
        tooltipText = "Fully heal and restore the player's health, mana, and remove debuffs",
    })
    
    -- Teleport To Player
    table.insert(menuItems, {
        text = "Teleport To Player",
        func = function()
            AIO.Handle("GameMasterSystem", "teleportToPlayer", playerName)
        end,
        notCheckable = true,
    })
    
    -- Summon Player
    table.insert(menuItems, {
        text = "Summon Player",
        func = function()
            AIO.Handle("GameMasterSystem", "summonPlayer", playerName)
        end,
        notCheckable = true,
    })
    
    -- Kick Player
    table.insert(menuItems, {
        text = "Kick Player",
        func = function()
            StaticPopup_Show("GM_KICK_PLAYER", playerName, nil, {name = playerName})
        end,
        notCheckable = true,
    })
end

function PlayerMenus.createCastSpellSubmenu(playerName)
    return {
        text = "Cast Spell",
        hasArrow = true,
        menuList = {
            {
                text = "Make Player Cast on Self",
                func = function()
                    if GMMenus.SpellSelection then
                        GMMenus.SpellSelection.createDialog(playerName, "self")
                    end
                end,
                notCheckable = true,
                tooltipTitle = "Cast on Self",
                tooltipText = "Make the player cast a spell on themselves",
            },
            {
                text = "Make Player Cast on Target",
                func = function()
                    if GMMenus.SpellSelection then
                        GMMenus.SpellSelection.createDialog(playerName, "target")
                    end
                end,
                notCheckable = true,
                tooltipTitle = "Cast on Target",
                tooltipText = "Make the player cast a spell on their current target",
            },
            {
                text = "Cast Spell on Player",
                func = function()
                    if GMMenus.SpellSelection then
                        GMMenus.SpellSelection.createDialog(playerName, "onplayer")
                    end
                end,
                notCheckable = true,
                tooltipTitle = "Cast on Player",
                tooltipText = "You cast a spell on the player",
            },
            {
                text = "Custom Spell ID...",
                func = function()
                    StaticPopup_Show("GM_PLAYER_CAST_SELF", playerName, nil, {name = playerName})
                end,
                notCheckable = true,
                tooltipTitle = "Custom Spell",
                tooltipText = "Enter a custom spell ID to cast",
            },
        },
        notCheckable = true,
    }
end

function PlayerMenus.addOfflineActions(menuItems, playerName, entity)
    -- Delete Character (offline only)
    table.insert(menuItems, {
        text = "Delete Character",
        func = function()
            StaticPopup_Show("GM_DELETE_OFFLINE_CHARACTER", playerName, nil, {name = playerName, guid = entity.guid})
        end,
        notCheckable = true,
        tooltipTitle = "Delete Character",
        tooltipText = "Permanently delete this offline character from the database",
    })
end

-- Export functions to MenuFactory
MenuFactory.createPlayerMenu = PlayerMenus.createPlayerMenu

-- Player menus module loaded