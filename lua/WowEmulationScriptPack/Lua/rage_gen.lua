--[[
This script is for 'correcting' whatever I botched in the core while trying to create a classless system
I somehow broke just about every form of rage generation besides direct smacking a dude combat

The scipt just hooks onto a players OnCast and checks what spell it is, if its in my table somewhere it
    gives the player whatever rage value is assigned from the table. 
]]

local PLAYER_EVENT_ON_SPELL_CAST = 5

-- Spells are {SPELLID, INSTANT_RAGE, RAGEGEN, RAGE_PER_SEC}
local spelltable = {
    bloodrage = {29131, 200, true, 10},
    enrage = {5229, 200, true, 10},
    charger1 = {100, 90, false, 0},
    charger2 = {6178, 120, false, 0},
    charger3 = {11578, 150, false, 0},
}

-- Table for auras that periodically generate rage could probably use spelltable somehow but IUNNO
local rageauras = {
    bloodrage = 29131,
    enrage = 5229,
}
-- If spell is charge in SetRage, checks if player knows the Improved Charge talents
local chargetable = {
    charger1 = 100,
    charger2 = 6178,
    charger3 = 11578,
}

local ragegenerator = false -- Used to identify if a spell has a periodic rage gen. EG Bloodrage.

-- On Spell cast, for loops through spelltable, if spell is there, continue to SetRage
--[[local function OnCast(event, player, spell, skipCheck)
    spell = spell:GetEntry()
    player = player
    for i, v in pairs(spelltable) do
        if (spell == v[1]) then
            SetRage(player, v[2], v[1], v[3], v[4])
            break
        end
    end
end]]

-- Initially checks the type of spell, if charge, goes to CheckCharge for talent modifiers
-- Checks if spell was bloodrage, if it was, checks if player has either Improved Bloodrage talent, applies  percentage boost
-- Then applies the rage to the player
-- Then checks if the spell has ragegen as true, if true Jumps to BloodEnRage
function SetRage(player, rage, spell ,ragegen, rageps)
    for i, v in pairs(chargetable) do
        if (spell == v) then 
            rage = CheckCharge(player, rage)
            break
        end
    end
    
    if (spell == 29131 and player:HasSpell(12301)) then -- Improved bloodrage 1
        rage = rage + (rage * 0.25)
    elseif (spell == 29131 and player:HasSpell(12818)) then -- Improved bloodrage 2
        rage = rage + (rage * 0.50)
    end

    player:ModifyPower(rage, 1)

    player = player
    --[[if (ragegen == true) then
        ragepers = rageps
        auraid = spell
        prage = player:RegisterEvent(BloodEnRage, 1000, 10, player, ragepers, auraid) -- Runs BloodEnRage once per second 10 times
    end]]
end 

-- Checks if the player has the Improved Charge talents
-- If they do apply bonus rage
-- Gonna have to do this with all rage skills probably
-- Maybe make a universal function that applies a boost stated in the table for each spell
--      instead of creating a unique function for each thing that happens
function CheckCharge(player, rage)
    rage = rage
    if (player:HasSpell(12285)) then
        rage = rage + 50
    end
    if (player:HasSpell(12697)) then
        rage = rage + 100
    else return rage end
    return rage
end

-- Checks the rageauras table to be sure that the player still has the aura, if they do continue
--      if they dont, remove the event and bail
--[[function BloodEnRage(eventid, delay, repeats, object, rageps, spell)
    player = object
    for i,v in pairs(rageauras) do
        if (auraid == v and player:HasAura(v) == false) then
            player:RemoveEventById(prage)
            return
        end
    end
    player:ModifyPower(ragepers, 1)
end]]

--RegisterPlayerEvent(PLAYER_EVENT_ON_SPELL_CAST, OnCast)