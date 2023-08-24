CoreRager = {}

function CoreRager.CastMangle(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 19820, true)
end

function CoreRager.OnDamageTaken(event, creature, attacker, damage)
if creature:GetHealthPct() < 50 then
creature:CastSpell(creature, 17683, true)
creature:SendUnitEmote("Core Rager refuses to die while its master is in trouble.", 0)
end
end

function CoreRager.OnEnterCombat(event, creature, target)
creature:RegisterEvent(CoreRager.CastMangle, 7000, 0)
end

function CoreRager.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function CoreRager.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function CoreRager.OnSpawn(event, creature)
creature:SetMaxHealth(200000)
end

function CoreRager.OnGolemaggDeath(event, creature, boss)
local coreRagers = creature:GetCreaturesInRange(100, 11672)
for _, coreRager in pairs(coreRagers) do
coreRager:CastSpell(coreRager, 13520, true)
end
end

RegisterCreatureEvent(11672, 1, CoreRager.OnEnterCombat)
RegisterCreatureEvent(11672, 2, CoreRager.OnLeaveCombat)
RegisterCreatureEvent(11672, 4, CoreRager.OnDied)
RegisterCreatureEvent(11672, 5, CoreRager.OnSpawn)
RegisterCreatureEvent(11672, 9, CoreRager.OnDamageTaken)

RegisterCreatureEvent(11988, 4, CoreRager.OnGolemaggDeath)