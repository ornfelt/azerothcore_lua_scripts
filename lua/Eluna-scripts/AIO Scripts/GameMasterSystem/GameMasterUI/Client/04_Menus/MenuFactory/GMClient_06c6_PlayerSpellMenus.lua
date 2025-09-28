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
local MenuItems = GMMenus.MenuItems
local MenuFactory = GMMenus.MenuFactory

-- Player Spell Management Menus Module
local PlayerSpellMenus = {}

-- Create context menu for player spell management
function PlayerSpellMenus.createPlayerSpellMenu(spellData, playerName)
    local trimmedEntry = GMUtils.trimSpaces(tostring(spellData.id or 0))
    local spellName = spellData.name or "Unknown Spell"
    
    return {
        MenuItems.createTitle("Spell: " .. spellName),
        {
            text = "Cast Spell",
            hasArrow = true,
            menuList = PlayerSpellMenus.createCastSubmenu(playerName, trimmedEntry, spellName),
            notCheckable = true,
        },
        {
            text = "Apply as Aura",
            hasArrow = true,
            menuList = PlayerSpellMenus.createAuraSubmenu(playerName, trimmedEntry, spellName, spellData),
            notCheckable = true,
        },
        {
            text = "Cooldown Management",
            hasArrow = true,
            menuList = PlayerSpellMenus.createCooldownSubmenu(playerName, trimmedEntry),
            notCheckable = true,
        },
        {
            text = "Learn/Unlearn",
            hasArrow = true,
            menuList = PlayerSpellMenus.createLearnSubmenu(playerName, trimmedEntry, spellName),
            notCheckable = true,
        },
        MenuItems.createCopyMenu(spellData),
        MenuItems.CANCEL,
    }
end

function PlayerSpellMenus.createCastSubmenu(playerName, spellId, spellName)
    return {
        {
            text = "Cast on Player",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellCastOnSelf", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Cast on Player",
            tooltipText = "Make " .. playerName .. " cast this spell on themselves",
        },
        {
            text = "Cast on Target",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellCastOnTarget", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Cast on Target",
            tooltipText = "Make " .. playerName .. " cast this spell on their current target",
        },
        {
            text = "Cast from Player",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellCastFromPlayer", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Cast from Player",
            tooltipText = "Make " .. playerName .. " cast this spell on you",
        },
    }
end

function PlayerSpellMenus.createAuraSubmenu(playerName, spellId, spellName, spellData)
    return {
        {
            text = "Apply to Player",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellApplyAura", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Apply Aura",
            tooltipText = "Apply this spell as a persistent aura/buff on " .. playerName,
        },
        {
            text = "Apply with Duration",
            hasArrow = true,
            menuList = PlayerSpellMenus.createDurationSubmenu(playerName, spellId, spellName, spellData),
            notCheckable = true,
        },
        {
            text = "Remove This Aura",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellRemoveAura", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Remove Aura",
            tooltipText = "Remove only this specific aura from " .. playerName,
        },
        {
            text = "Check Aura Info",
            func = function()
                AIO.Handle("GameMasterSystem", "playerGetAuraInfo", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Aura Info",
            tooltipText = "Display duration, stacks, and caster information",
        },
    }
end

function PlayerSpellMenus.createDurationSubmenu(playerName, spellId, spellName, spellData)
    return {
        {
            text = "1 Minute",
            func = function()
                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spellId, 60000)
            end,
            notCheckable = true,
        },
        {
            text = "10 Minutes",
            func = function()
                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spellId, 600000)
            end,
            notCheckable = true,
        },
        {
            text = "1 Hour",
            func = function()
                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spellId, 3600000)
            end,
            notCheckable = true,
        },
        {
            text = "24 Hours",
            func = function()
                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spellId, 86400000)
            end,
            notCheckable = true,
        },
        {
            text = "Permanent",
            func = function()
                AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spellId, -1)
            end,
            notCheckable = true,
            tooltipTitle = "Permanent",
            tooltipText = "Apply until death or manual removal",
        },
        { isSeparator = true },
        {
            text = "Custom Duration...",
            func = function()
                -- Call back to PlayerSpells module if available
                if GameMasterSystem.PlayerSpells and GameMasterSystem.PlayerSpells.showCustomDurationDialog then
                    GameMasterSystem.PlayerSpells.showCustomDurationDialog(spellData)
                else
                    -- Fallback to popup
                    StaticPopup_Show("GM_CUSTOM_AURA_DURATION", spellName, spellId, {
                        playerName = playerName,
                        spellId = spellId,
                        spellName = spellName
                    })
                end
            end,
            notCheckable = true,
            tooltipTitle = "Custom Duration",
            tooltipText = "Enter a custom duration in seconds",
        },
    }
end

function PlayerSpellMenus.createCooldownSubmenu(playerName, spellId)
    return {
        {
            text = "Reset This Cooldown",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellResetCooldown", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Reset Cooldown",
            tooltipText = "Remove the cooldown from this specific spell",
        },
        {
            text = "Reset All Cooldowns",
            func = function()
                AIO.Handle("GameMasterSystem", "playerResetAllCooldowns", playerName)
            end,
            notCheckable = true,
            tooltipTitle = "Reset All",
            tooltipText = "Remove cooldowns from ALL spells for " .. playerName,
        },
        {
            text = "Check Cooldown Status",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellCheckCooldown", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Check Status",
            tooltipText = "Display remaining cooldown time for this spell",
        },
    }
end

function PlayerSpellMenus.createLearnSubmenu(playerName, spellId, spellName)
    return {
        {
            text = "Make Player Learn",
            func = function()
                AIO.Handle("GameMasterSystem", "playerSpellLearn", playerName, spellId)
            end,
            notCheckable = true,
            tooltipTitle = "Learn Spell",
            tooltipText = "Make " .. playerName .. " learn this spell permanently",
        },
        {
            text = "Make Player Unlearn",
            func = function()
                -- Use the custom unlearn confirmation dialog from PlayerSpells module
                if GameMasterSystem and GameMasterSystem.PlayerSpells and GameMasterSystem.PlayerSpells.showUnlearnConfirmation then
                    GameMasterSystem.PlayerSpells.showUnlearnConfirmation({
                        id = spellId,
                        name = spellName,
                        playerName = playerName
                    })
                else
                    -- Fallback if PlayerSpells module not loaded
                    print("[GM] Error: PlayerSpells module not available")
                end
            end,
            notCheckable = true,
            tooltipTitle = "Unlearn Spell",
            tooltipText = "Make " .. playerName .. " permanently unlearn this spell",
        },
    }
end

-- Export function to MenuFactory
MenuFactory.createPlayerSpellMenu = PlayerSpellMenus.createPlayerSpellMenu

-- Player spell menus module loaded