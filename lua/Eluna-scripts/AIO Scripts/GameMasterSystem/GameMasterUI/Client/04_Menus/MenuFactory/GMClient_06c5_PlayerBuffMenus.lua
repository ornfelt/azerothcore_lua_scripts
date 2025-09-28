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

local GMConfig = _G.GMConfig
local MenuFactory = GMMenus.MenuFactory

-- Player Buff Menus Module
local PlayerBuffMenus = {}

function PlayerBuffMenus.createBuffSubmenu(playerName)
    local submenu = {}
    
    -- Quick Apply with Duration
    table.insert(submenu, {
        text = "Apply Aura with Duration",
        hasArrow = true,
        menuList = {
            {
                text = "Browse Spells...",
                func = function()
                    if GMMenus.SpellSelection then
                        GMMenus.SpellSelection.createDialog(playerName, "buffWithDuration")
                    end
                end,
                notCheckable = true,
                tooltipTitle = "Browse Spells",
                tooltipText = "Select a spell to apply with duration",
            },
            { isSeparator = true },
            {
                text = "Quick Duration (Any Spell ID)",
                hasArrow = true,
                menuList = PlayerBuffMenus.createQuickDurationMenu(playerName),
                notCheckable = true,
            },
        },
        notCheckable = true,
    })
    
    -- Add buff categories from config
    table.insert(submenu, { isSeparator = true })
    table.insert(submenu, { text = "Quick Buffs", isTitle = true, notCheckable = true })
    
    for _, category in ipairs(GMConfig.SPELL_CATEGORIES) do
        local categoryMenu = {
            text = category.name,
            hasArrow = true,
            menuList = {},
            notCheckable = true,
        }
        
        -- Add spells in this category with duration options
        for _, spell in ipairs(category.spells) do
            table.insert(categoryMenu.menuList, PlayerBuffMenus.createSpellDurationMenu(playerName, spell))
        end
        
        table.insert(submenu, categoryMenu)
    end
    
    -- Aura Management
    table.insert(submenu, { isSeparator = true })
    table.insert(submenu, {
        text = "Remove All Auras",
        func = function()
            AIO.Handle("GameMasterSystem", "removePlayerAuras", playerName)
        end,
        notCheckable = true,
        tooltipTitle = "Remove All",
        tooltipText = "Remove all buffs and debuffs from the player",
    })
    
    -- Custom spell options
    table.insert(submenu, { isSeparator = true })
    table.insert(submenu, {
        text = "Custom Spell ID...",
        func = function()
            StaticPopup_Show("GM_APPLY_CUSTOM_BUFF", playerName, nil, {name = playerName})
        end,
        notCheckable = true,
        tooltipTitle = "Custom ID",
        tooltipText = "Enter a specific spell ID to apply",
    })
    
    return submenu
end

function PlayerBuffMenus.createQuickDurationMenu(playerName)
    return {
        {
            text = "1 Minute",
            func = function()
                StaticPopup_Show("GM_APPLY_BUFF_DURATION", playerName, "60000", {name = playerName, duration = 60000})
            end,
            notCheckable = true,
        },
        {
            text = "10 Minutes",
            func = function()
                StaticPopup_Show("GM_APPLY_BUFF_DURATION", playerName, "600000", {name = playerName, duration = 600000})
            end,
            notCheckable = true,
        },
        {
            text = "1 Hour",
            func = function()
                StaticPopup_Show("GM_APPLY_BUFF_DURATION", playerName, "3600000", {name = playerName, duration = 3600000})
            end,
            notCheckable = true,
        },
        {
            text = "24 Hours",
            func = function()
                StaticPopup_Show("GM_APPLY_BUFF_DURATION", playerName, "86400000", {name = playerName, duration = 86400000})
            end,
            notCheckable = true,
        },
        {
            text = "Permanent",
            func = function()
                StaticPopup_Show("GM_APPLY_BUFF_DURATION", playerName, "Permanent", {name = playerName, duration = -1})
            end,
            notCheckable = true,
        },
    }
end

function PlayerBuffMenus.createSpellDurationMenu(playerName, spell)
    return {
        text = spell.name,
        hasArrow = true,
        menuList = {
            {
                text = "Apply (Default Duration)",
                func = function()
                    AIO.Handle("GameMasterSystem", "applyBuffToPlayer", playerName, spell.spellId)
                end,
                notCheckable = true,
            },
            { isSeparator = true },
            {
                text = "1 Minute",
                func = function()
                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spell.spellId, 60000)
                end,
                notCheckable = true,
            },
            {
                text = "10 Minutes",
                func = function()
                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spell.spellId, 600000)
                end,
                notCheckable = true,
            },
            {
                text = "1 Hour",
                func = function()
                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spell.spellId, 3600000)
                end,
                notCheckable = true,
            },
            {
                text = "24 Hours",
                func = function()
                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spell.spellId, 86400000)
                end,
                notCheckable = true,
            },
            {
                text = "Permanent",
                func = function()
                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", playerName, spell.spellId, -1)
                end,
                notCheckable = true,
            },
        },
        notCheckable = true,
        icon = spell.icon,
    }
end

-- Export function to MenuFactory
MenuFactory.createBuffSubmenu = PlayerBuffMenus.createBuffSubmenu

-- Player buff menus module loaded