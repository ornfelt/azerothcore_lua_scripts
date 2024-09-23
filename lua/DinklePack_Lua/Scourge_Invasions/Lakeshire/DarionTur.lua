local DarionTurOne = {}
DarionTurOne.NPC_ID = 400081
local DTMAX_HEALTH = 8432 -- Disabled

local ABILITY_1 = 16856
local ABILITY_2 = 676

function DarionTurOne.OnSpawn(event, creature)
  --  creature:SetMaxHealth(DTMAX_HEALTH)
   -- creature:SetHealth(DTMAX_HEALTH)
end

function DarionTurOne.OnCombat(event, creature, target)
    creature:RegisterEvent(DarionTurOne.Ability1, 7000, 0)
    creature:RegisterEvent(DarionTurOne.Ability2, 22000, 0)
end

DarionTurOne.Ability1 = function(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ABILITY_1, true)
end

DarionTurOne.Ability2 = function(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ABILITY_2, true)
end

function DarionTurOne.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DarionTurOne.OnDeath(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(DarionTurOne.NPC_ID, 5, DarionTurOne.OnSpawn)
RegisterCreatureEvent(DarionTurOne.NPC_ID, 1, DarionTurOne.OnCombat)
RegisterCreatureEvent(DarionTurOne.NPC_ID, 2, DarionTurOne.OnLeaveCombat)
RegisterCreatureEvent(DarionTurOne.NPC_ID, 4, DarionTurOne.OnDeath)
