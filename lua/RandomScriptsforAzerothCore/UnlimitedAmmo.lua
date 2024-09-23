-- This script was made by Dinkledork
-- Fun fact: I'm too lazy to finish this script right now
-- Make sure you only have one type of ammo on your character

local ENABLED = false -- Set this to false to disable the script

local ARROW_ITEM_IDS = {2516, 2519} -- Replace these with actual ammo IDs
local SPELL_IDS = {75} -- Add more spell IDs to this table such as serpent sting arcane shot etc, separated by commas. Right now it triggers on auto shot.

local function GetArrowItemId(player)
    for _, arrowId in ipairs(ARROW_ITEM_IDS) do
        if player:HasItem(arrowId) then
            return arrowId
        end
    end
    return nil
end

local function IsRelevantSpell(spellId)
    for _, id in ipairs(SPELL_IDS) do
        if spellId == id then
            return true
        end
    end
    return false
end

local function OnPlayerSpellCast(event, player, spell, skipCheck)
    if not ENABLED then
        return
    end

    local spellId = spell:GetEntry()
    if IsRelevantSpell(spellId) then
        local arrowItemId = GetArrowItemId(player)
        if arrowItemId then
            player:AddItem(arrowItemId, 1) --can change this number to 2 or 3 or whatever if you're too lazy to add spells in. 
        end
    end
end

RegisterPlayerEvent(5, OnPlayerSpellCast)