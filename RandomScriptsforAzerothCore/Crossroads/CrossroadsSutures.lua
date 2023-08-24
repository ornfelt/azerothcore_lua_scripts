local NPC_SUTURES = 400113
local NPC_SPAWN_ON_DEATH = 400118
local SPAWN_DURATION = 1800000 -- 30 minutes in milliseconds

local SPELL_CLEAVE = 15284
local SPELL_ABOMINATION_SLAM = 1464
local SPELL_KNOCKBACK = 37317

local YELL_COMBAT_DIALOGUE = {
    "Sutures smash!",
    "Me make you hurt!",
    "You not escape Sutures!",
    "Why you bother Sutures?",
    "Sutures crush you!"
}

local function CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CLEAVE, true)
end

local function CastKnockback(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_KNOCKBACK, true)
end

local function CastAbominationSlam(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_ABOMINATION_SLAM, true)
end

local function Sutures_OnEnterCombat(event, creature, target)
    if math.random(1, 100) <= 50 then -- 50% chance to yell upon entering combat
        creature:SendUnitYell(YELL_COMBAT_DIALOGUE[math.random(1, #YELL_COMBAT_DIALOGUE)], 0)
    end
    creature:RegisterEvent(CastCleave, math.random(4000, 8000), 0)
    creature:RegisterEvent(CastAbominationSlam, math.random(8000, 12000), 0)
	 creature:RegisterEvent(CastKnockback, math.random(18000, 32000), 0)
end

local function Sutures_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function Sutures_OnDied(event, creature, killer)
    creature:RemoveEvents()
    creature:SendUnitSay("Sutures...fall...", 0)
    local x, y, z, o = creature:GetLocation()
    creature:SpawnCreature(NPC_SPAWN_ON_DEATH, x, y, z, o, 3, SPAWN_DURATION)
end

RegisterCreatureEvent(NPC_SUTURES, 1, Sutures_OnEnterCombat)
RegisterCreatureEvent(NPC_SUTURES, 2, Sutures_OnLeaveCombat)
RegisterCreatureEvent(NPC_SUTURES, 4, Sutures_OnDied)
