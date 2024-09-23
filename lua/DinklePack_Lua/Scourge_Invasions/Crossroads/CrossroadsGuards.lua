HordeGuardModule = {}

local NPC_HORDE_GUARD = 400105
local SPELL_REND = 6547

local function CastRend(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_REND, true)
end

function HordeGuardModule.OnEnterCombat(event, creature, target)
	creature:RegisterEvent(CastRend, 100, 1)
    creature:RegisterEvent(CastRend, math.random(8000, 15000), 0)
end

local function SetEmoteState(eventId, delay, calls, creature)
    creature:EmoteState(375)
end

function HordeGuardModule.OnLeaveCombat(event, creature)
    creature:RemoveEvents() 
    creature:RegisterEvent(SetEmoteState, 5000, 1)
end

function HordeGuardModule.OnSpawn(event, creature)
    creature:EmoteState(375)
    creature:SetEquipmentSlots(6905, 0, 0)
end

RegisterCreatureEvent(NPC_HORDE_GUARD, 1, HordeGuardModule.OnEnterCombat)
RegisterCreatureEvent(NPC_HORDE_GUARD, 2, HordeGuardModule.OnLeaveCombat)
RegisterCreatureEvent(NPC_HORDE_GUARD, 5, HordeGuardModule.OnSpawn)
