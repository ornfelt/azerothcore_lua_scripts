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
local MenuFactory = GMMenus.MenuFactory

-- Spell Menus Module
local SpellMenus = {}

function SpellMenus.createSpellMenu(entity)
    local trimmedEntry = GMUtils.trimSpaces(entity.spellID)
    return {
        MenuItems.createTitle("Spell ID: " .. trimmedEntry),
        {
            text = "Cast Spell",
            hasArrow = true,
            menuList = {
                {
                    text = "Cast on Self",
                    func = function()
                        AIO.Handle("GameMasterSystem", "castSelfSpellEntity", trimmedEntry)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Cast on Self",
                    tooltipText = "Cast this spell on yourself",
                },
                {
                    text = "Cast on Target",
                    func = function()
                        AIO.Handle("GameMasterSystem", "castOnTargetSpellEntity", trimmedEntry)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Cast on Target",
                    tooltipText = "Cast this spell on your current target",
                },
                {
                    text = "Cast from Target",
                    func = function()
                        AIO.Handle("GameMasterSystem", "castTargetSpellEntity", trimmedEntry)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Cast from Target",
                    tooltipText = "Make your target cast this spell on you",
                },
            },
            notCheckable = true,
        },
        {
            text = "Apply as Aura",
            hasArrow = true,
            menuList = SpellMenus.createAuraSubmenu(trimmedEntry),
            notCheckable = true,
        },
        {
            text = "Cooldown Management",
            hasArrow = true,
            menuList = SpellMenus.createCooldownSubmenu(trimmedEntry),
            notCheckable = true,
        },
        {
            text = "Learn/Unlearn",
            hasArrow = true,
            menuList = {
                {
                    text = "Learn Spell",
                    func = function()
                        AIO.Handle("GameMasterSystem", "learnSpellEntity", trimmedEntry)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Learn Spell",
                    tooltipText = "Permanently learn this spell",
                },
                {
                    text = "Remove Spell",
                    func = function()
                        AIO.Handle("GameMasterSystem", "deleteSpellEntity", trimmedEntry)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Remove Spell",
                    tooltipText = "Remove this spell from your spellbook",
                },
            },
            notCheckable = true,
        },
        {
            text = "Utilities",
            hasArrow = true,
            menuList = {
                {
                    text = "Copy Spell ID",
                    func = function()
                        GMMenus.copyToClipboard(trimmedEntry, "Spell ID")
                    end,
                    notCheckable = true,
                },
                {
                    text = "Copy Icon Path",
                    func = function()
                        GMMenus.copyIcon(entity)
                    end,
                    notCheckable = true,
                },
                {
                    text = "Delete from Database",
                    func = function()
                        GMMenus.showDeleteConfirmation(MENU_CONFIG.TYPES.SPELL, trimmedEntry)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Delete from Database",
                    tooltipText = "Permanently remove this spell from the custom database",
                },
            },
            notCheckable = true,
        },
        MenuItems.createCopyMenu(entity),
        MenuItems.CANCEL,
    }
end

function SpellMenus.createAuraSubmenu(spellId)
    return {
        {
            text = "Apply to Self",
            func = function()
                AIO.Handle("GameMasterSystem", "applyAuraToSelf", spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Apply Aura to Self",
            tooltipText = "Apply this spell as a persistent aura/buff on yourself",
        },
        {
            text = "Apply to Target",
            func = function()
                AIO.Handle("GameMasterSystem", "applyAuraToTarget", spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Apply Aura to Target",
            tooltipText = "Apply this spell as a persistent aura/buff on your target",
        },
        {
            text = "Apply with Duration",
            hasArrow = true,
            menuList = {
                {
                    text = "1 Minute",
                    func = function()
                        AIO.Handle("GameMasterSystem", "applyAuraWithDuration", spellId, 60000)
                    end,
                    notCheckable = true,
                },
                {
                    text = "10 Minutes",
                    func = function()
                        AIO.Handle("GameMasterSystem", "applyAuraWithDuration", spellId, 600000)
                    end,
                    notCheckable = true,
                },
                {
                    text = "1 Hour",
                    func = function()
                        AIO.Handle("GameMasterSystem", "applyAuraWithDuration", spellId, 3600000)
                    end,
                    notCheckable = true,
                },
                {
                    text = "24 Hours",
                    func = function()
                        AIO.Handle("GameMasterSystem", "applyAuraWithDuration", spellId, 86400000)
                    end,
                    notCheckable = true,
                },
                {
                    text = "Permanent",
                    func = function()
                        AIO.Handle("GameMasterSystem", "applyAuraWithDuration", spellId, -1)
                    end,
                    notCheckable = true,
                    tooltipTitle = "Permanent",
                    tooltipText = "Apply until death or manual removal",
                },
            },
            notCheckable = true,
        },
        {
            text = "Remove This Aura",
            func = function()
                AIO.Handle("GameMasterSystem", "removeSpecificAura", spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Remove Aura",
            tooltipText = "Remove only this specific aura from target",
        },
        {
            text = "Check Aura Info",
            func = function()
                AIO.Handle("GameMasterSystem", "getAuraInfo", spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Aura Info",
            tooltipText = "Display duration, stacks, and caster information",
        },
    }
end

function SpellMenus.createCooldownSubmenu(spellId)
    return {
        {
            text = "Reset This Cooldown",
            func = function()
                AIO.Handle("GameMasterSystem", "resetSpellCooldown", spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Reset Cooldown",
            tooltipText = "Remove the cooldown from this specific spell",
        },
        {
            text = "Reset All Cooldowns",
            func = function()
                AIO.Handle("GameMasterSystem", "resetAllCooldowns")
            end,
            notCheckable = true,
            tooltipTitle = "Reset All",
            tooltipText = "Remove cooldowns from ALL spells",
        },
        {
            text = "Check Cooldown Status",
            func = function()
                AIO.Handle("GameMasterSystem", "checkCooldownStatus", spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Check Status",
            tooltipText = "Display remaining cooldown time for this spell",
        },
    }
end

function SpellMenus.createSpellVisualMenu(entity)
    local trimmedEntry = GMUtils.trimSpaces(entity.spellVisualID)
    return {
        MenuItems.createTitle("SpellVisual ID: " .. trimmedEntry),
        {
            text = "Copy spellVisual",
            func = function()
                GMMenus.copyToClipboard(entity.FilePath, "SpellVisual Path")
            end,
            notCheckable = true,
        },
        MenuItems.createCopyMenu(entity),
        MenuItems.CANCEL,
    }
end

-- Export functions to MenuFactory
MenuFactory.createSpellMenu = SpellMenus.createSpellMenu
MenuFactory.createSpellVisualMenu = SpellMenus.createSpellVisualMenu

-- Spell menus module loaded