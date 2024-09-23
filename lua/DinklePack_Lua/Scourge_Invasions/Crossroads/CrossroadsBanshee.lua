BansheeModule = {}

local NPC_BANSHEE = 400112
local NPC_TARGET = 3338

local SPELLS = {
    BANSHEE_SCREAM = 8124,
    SHADOW_BOLT = 9613,
    CAST_DEATH = 5
}

local function castSpell(creature, target, spellId)
    creature:CastSpell(target, spellId, true)
end

local function CastShadowBolt(eventId, delay, calls, creature)
    castSpell(creature, creature:GetVictim(), SPELLS.SHADOW_BOLT)
end

local function CastBansheeScream(eventId, delay, calls, creature)
    castSpell(creature, creature:GetVictim(), SPELLS.BANSHEE_SCREAM)
end

local function CastSpellOnTarget(creature, targetNPC)
    castSpell(creature, targetNPC, SPELLS.CAST_DEATH)
end

function BansheeModule.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastShadowBolt, math.random(4000, 8000), 0)
    creature:RegisterEvent(CastBansheeScream, math.random(9000, 18000), 1)
    
    local targetNPC = creature:GetNearestCreature(50, NPC_TARGET)
    if targetNPC then
        CastSpellOnTarget(creature, targetNPC)
    end
end

function BansheeModule.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function BansheeModule.OnDied(event, creature, killer)
    creature:RemoveEvents()
	creature:DespawnOrUnsummon(10000)
end

RegisterCreatureEvent(NPC_BANSHEE, 1, BansheeModule.OnEnterCombat)
RegisterCreatureEvent(NPC_BANSHEE, 2, BansheeModule.OnLeaveCombat)
RegisterCreatureEvent(NPC_BANSHEE, 4, BansheeModule.OnDied)
