local NPC_CAPTAIN_RATTLEBONES = 401116

local SPELL_SHADOW_BOLT = 20791
local SPELL_CURSE_OF_THE_PIRATE_KING = 70542
local SPELL_PIRATES_CLEAVE = 40505
local SPELL_CANNONBALL_BARRAGE = 6251

local YELL_AGGRO_DIALOGUE = {
    "Ye be treadin' on dangerous waters!",
    "Yarr, ye landlubbers be meetin' yer doom!",
    "Arrr, ye won't leave me ship alive!",
    "I be sendin' ye to the depths of the sea!",
    "Ye be facin' the wrath of Captain Rattlebones!"
}

local YELL_DEATH_DIALOGUE = "Me ship...me crew...I be joinin' ye soon..."

local function CastShadowBolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_BOLT, true)
end

local function CastCurseOfThePirateKing(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CURSE_OF_THE_PIRATE_KING, true)
end

local function CastPiratesCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_PIRATES_CLEAVE, true)
end

local function CastCannonballBarrage(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CANNONBALL_BARRAGE, true)
end

local function CaptainRattlebones_OnEnterCombat(event, creature, target)
    creature:SendUnitYell(YELL_AGGRO_DIALOGUE[math.random(1, #YELL_AGGRO_DIALOGUE)], 0)
    creature:RegisterEvent(CastShadowBolt, 3000, 0)
    creature:RegisterEvent(CastCurseOfThePirateKing, 12000, 0)
    creature:RegisterEvent(CastPiratesCleave, 8000, 0)
    creature:RegisterEvent(CastCannonballBarrage, 18000, 0)
end

local function CaptainRattlebones_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function CaptainRattlebones_OnDied(event, creature, killer)
    creature:RemoveEvents()
    creature:SendUnitSay(YELL_DEATH_DIALOGUE, 0)
end

RegisterCreatureEvent(NPC_CAPTAIN_RATTLEBONES, 1, CaptainRattlebones_OnEnterCombat)
RegisterCreatureEvent(NPC_CAPTAIN_RATTLEBONES, 2, CaptainRattlebones_OnLeaveCombat)
RegisterCreatureEvent(NPC_CAPTAIN_RATTLEBONES, 4, CaptainRattlebones_OnDied)
