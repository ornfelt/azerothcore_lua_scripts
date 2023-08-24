local NPC_BANSHEE = 400112
local NPC_TARGET = 3338

local SPELL_BANSHEE_SCREAM = 8124
local SPELL_SHADOW_BOLT = 9613
local SPELL_CAST_DEATH = 5

local function CastShadowBolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_BOLT, true)
end

local function CastBansheeScream(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_BANSHEE_SCREAM, true)
end

local function CastSpellOnTarget(creature, targetNPC)
    creature:CastSpell(targetNPC, SPELL_CAST_DEATH, true)
end

local function Banshee_OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastShadowBolt, math.random(4000, 8000), 0)
    creature:RegisterEvent(CastBansheeScream, math.random(9000, 18000), 1)
    
    local targetNPC = creature:GetNearestCreature(50, NPC_TARGET)
    if targetNPC then
        CastSpellOnTarget(creature, targetNPC)
    end
end

local function Banshee_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function Banshee_OnDied(event, creature, killer)
    creature:RemoveEvents()
	creature:DespawnOrUnsummon(10000)
end

RegisterCreatureEvent(NPC_BANSHEE, 1, Banshee_OnEnterCombat)
RegisterCreatureEvent(NPC_BANSHEE, 2, Banshee_OnLeaveCombat)
RegisterCreatureEvent(NPC_BANSHEE, 4, Banshee_OnDied)
