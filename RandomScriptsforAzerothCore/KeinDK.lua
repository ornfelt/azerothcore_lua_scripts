-- Just for you, Kein666
-- This script allows dks to equip shields and dw 2h without db edits.

local ENABLE_SCRIPT = false -- Set to true to enable the script, false to disable it

local EVENT_ON_LOGIN = 3
local DEATH_KNIGHT_CLASS = 6
local SHIELD_SKILL_ID = 433

local function SetShieldSkillForDeathKnights(event, player)
    if ENABLE_SCRIPT and player:GetClass() == DEATH_KNIGHT_CLASS then
        player:SetSkill(SHIELD_SKILL_ID, 1, 1, 1) 
        player:LearnSpell(46917) -- Titan's Grip spells
        player:LearnSpell(49152)
        player:LearnSpell(50483)
    end
end

RegisterPlayerEvent(EVENT_ON_LOGIN, SetShieldSkillForDeathKnights)
