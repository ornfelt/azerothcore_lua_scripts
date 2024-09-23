local NPC_HORDE_GUARD = 400105

local SPELL_REND = 6547

local function CastRend(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_REND, true)
end

local function HordeGuard_OnEnterCombat(event, creature, target)
	creature:RegisterEvent(CastRend, 100, 1)
    creature:RegisterEvent(CastRend, math.random(8000, 15000), 0)
end

local function HordeGuard_OnLeaveCombat(event, creature)
    creature:RemoveEvents() 
    creature:EmoteState(375)
end

local function HordeGuard_OnSpawn(event, creature)
    creature:EmoteState(375)
    creature:SetEquipmentSlots(6905, 0, 0)
end

RegisterCreatureEvent(NPC_HORDE_GUARD, 1, HordeGuard_OnEnterCombat)
RegisterCreatureEvent(NPC_HORDE_GUARD, 2, HordeGuard_OnLeaveCombat)
RegisterCreatureEvent(NPC_HORDE_GUARD, 5, HordeGuard_OnSpawn)
