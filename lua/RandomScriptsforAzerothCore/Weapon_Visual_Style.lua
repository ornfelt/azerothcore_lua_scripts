-- Enchant display (Visual) system for weapons:
-- First create the database, the SQL is provided below. After that import script, reload eluna. And type in game ''enchant'' to open menu. Enjoy
-- Created by: Poszer
 
--[[
-- SQL:
    CREATE TABLE `custom_item_enchant_visuals` (
        `iguid` INT(10) UNSIGNED NOT NULL COMMENT 'item DB guid',
        `display` INT(10) UNSIGNED NOT NULL COMMENT 'enchantID',
        PRIMARY KEY (`iguid`)
    )
    COMMENT='stores the enchant IDs for the visuals'
    COLLATE='latin1_swedish_ci'
    ENGINE=InnoDB;
]]
 
-- script variables:
local EQUIPMENT_SLOT_MAINHAND = 15
local EQUIPMENT_SLOT_OFFHAND = 16
local PLAYER_VISIBLE_ITEM_1_ENCHANTMENT = 284
local PERM_ENCHANTMENT_SLOT = 0
local DD = {}
 
-- functions
local LoadDB, setVisual, applyVisuals, LOGOUT, LOGIN
 
function LoadDB()
    DD = {}
    CharDBQuery("DELETE FROM custom_item_enchant_visuals WHERE NOT EXISTS(SELECT 1 FROM item_instance WHERE custom_item_enchant_visuals.iguid = item_instance.guid)")
    local Q = CharDBQuery("SELECT iguid, display FROM custom_item_enchant_visuals")
    if(Q) then
        repeat
            local iguid, display = Q:GetUInt32(0), Q:GetUInt32(1)
            DD[iguid] = display
        until not Q:NextRow()
    end
end
LoadDB()
 
function setVisual(player, item, display)
    if(not player or not item or not item:IsEquipped()) then return false end
    local iguid = item:GetGUIDLow()
    if(not display) then
        if(not DD[iguid]) then return false end
        display = DD[iguid]
    elseif(display ~= 0) then
        CharDBExecute("REPLACE INTO custom_item_enchant_visuals (iguid, display) VALUES ("..iguid..", "..display..")")
        DD[iguid] = display
    end
    if(display == 0) then
        display = item:GetEnchantmentId(PERM_ENCHANTMENT_SLOT) or 0
        if(DD[iguid]) then
            CharDBExecute("DELETE FROM custom_item_enchant_visuals WHERE iguid = "..iguid)
            DD[iguid] = nil
        end
    end
    player:SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (item:GetSlot() * 2), 0, display)
    return true
end
 
function applyVisuals(player)
    if(not player) then return end
    for i = EQUIPMENT_SLOT_MAINHAND, EQUIPMENT_SLOT_OFFHAND do
        setVisual(player, player:GetItemByPos(255, i))
    end
end
 
function LOGIN(event, player)
    applyVisuals(player)
end
 
RegisterPlayerEvent(3, LOGIN)
RegisterPlayerEvent(29, function(e,p,i,b,s) setVisual(p, i) end)
 
-- Enchant display gossip:
 
-- Enchant IDs and their names
local E = {
    {0, "Reset"},
    {3789, "Berserking"},
    {3854, "Spell Power"},
    {3273, "Deathfrost"},
    {3225, "Executioner"},
    {3870, "Blood Draining"},
    {1899, "Unholy Weapon"},
    {2674, "Spellsurge"},
    {2675, "Battlemaster"},
    {2671, "Arcane and Fire Spell Power"},
    {2672, "Shadow and Frost Spell Power"},
    {3365, "Rune of Swordshattering"},
    {2673, "Mongoose"},
    {2343, "Spell Power"},
    {425, "Black Temple Dummy"},
    {3855, "Spell Power"},
    {1894, "Icy Weapon"},
    {1103, "Agility"},
    {1898, "Lifestealing"},
    {3345, "Earthliving 1"},
    {1743, "MHTest02"},
    {3093, "Attack Power vs Undead and Demons"},
    {1900, "Crusader"},
    {3846, "Spell Power"},
    {1606, "Attack Power"},
    {283, "Windfury 1"},
    {1, "Rockbiter 3"},
    {3265, "Blessed Weapon Coating"},
    {2, "Frostbrand 1"},
    {3, "Flametongue 3"},
    {3266, "Righteous Weapon Coating"},
    {1903, "Spirit"},
    {13, "Sharpened (+3 Damage)"},
    {26, "Frost Oil"},
    {7, "Deadly Poison"},
    {803, "Fiery Weapon"},
    {1896, "Weapon Damage"},
    {2666, "Intellect"},
    {25, "Shadow Oil"},
}
 
-- script variables:
local chatCommand = "enchant"
local maxGossipItems = 14 -- per page
local menu_id = 123
 
local safeGossipItems = 100 -- main menu: sender = safeGossipItems-1
local EQUIPMENT_SLOT_MAINHAND = 15
local EQUIPMENT_SLOT_OFFHAND = 16
local D = {}
 
-- functions:
local showItems, HELLO, SELECT, CHAT
 
function showItems(player, unit, offset)
    local temp = (maxGossipItems)*offset+1
    for i = temp, temp+maxGossipItems-1 do
        local v = E[i]
        if(not v) then break end
        player:GossipMenuAddItem(9, v[2], safeGossipItems+offset, v[1]+1)
    end
    if(temp+maxGossipItems-1 < #E) then
        player:GossipMenuAddItem(7, "Next..", safeGossipItems+offset+1, 0)
    end
    player:GossipMenuAddItem(7, "Back..", safeGossipItems+offset-1, 0)
    player:GossipSendMenu(100, unit, menu_id)
end
   
function HELLO(event, player, unit)
    player:GossipMenuAddItem(9, "Main hand", 0, EQUIPMENT_SLOT_MAINHAND)
    player:GossipMenuAddItem(9, "Off hand", 0, EQUIPMENT_SLOT_OFFHAND)
    player:GossipSendMenu(100, unit, menu_id)
end
 
function CHAT(event, player, msg, Type, lang)
    if(msg == chatCommand) then
        player:GossipClearMenu()
        HELLO(1, player, player)
        return false
    end
end
 
function SELECT(event, player, unit, sender, action, code)
    local guid = player:GetGUIDLow()
    if(not D[guid]) then
        D[guid] = {}
    end
    if(sender == safeGossipItems-1 and action == 0) then
        HELLO(event, player, unit)
    elseif(sender >= safeGossipItems) then
        if(action ~= 0) then
            D[guid].display = action-1
            if(D[guid].slot and D[guid].display) then
                local item = player:GetItemByPos(255, D[guid].slot)
                if(not item) then
                    player:SendNotification("No item equipped in selected slot")
                else
                    setVisual(player, item, D[guid].display)
                end
            end
        end
        showItems(player, unit, sender-safeGossipItems)
    elseif(sender == 0) then
        D[guid].slot = action
        showItems(player, unit, 0)
    else
        player:GossipCloseMenu()
    end
end
 
function LOGOUT(event, player)
    D[player:GetGUIDLow()] = nil
end
 
RegisterPlayerEvent(4, LOGOUT)
RegisterPlayerEvent(18, CHAT)
RegisterPlayerGossipEvent(menu_id, 2, SELECT)