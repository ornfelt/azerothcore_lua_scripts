local CustomCreature = {}
local NPC_ID = 400081
local MAX_HEALTH = 8432 -- Set the desired max health value


local ABILITY_1 = 16856
local ABILITY_2 = 676

function CustomCreature.OnSpawn(event, creature)
    creature:SetMaxHealth(MAX_HEALTH)
    creature:SetHealth(MAX_HEALTH)
end

function CustomCreature.OnCombat(event, creature, target)
    creature:RegisterEvent(CustomCreature.Ability1, 7000, 0)
    creature:RegisterEvent(CustomCreature.Ability2, 22000, 0)
end

function CustomCreature.Ability1(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ABILITY_1, true)
end

function CustomCreature.Ability2(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ABILITY_2, true)
end

function CustomCreature.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function CustomCreature.OnDeath(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_ID, 5, CustomCreature.OnSpawn)
RegisterCreatureEvent(NPC_ID, 1, CustomCreature.OnCombat)
RegisterCreatureEvent(NPC_ID, 2, CustomCreature.OnLeaveCombat)
RegisterCreatureEvent(NPC_ID, 4, CustomCreature.OnDeath)
