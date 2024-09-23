local Sever = {}

function Sever.CastDiseasedSpit(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 17745, true)
end

function Sever.CastIntimidatingRoar(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 16508, true)
end

function Sever.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Sever.CastDiseasedSpit, 10000, 0)
creature:RegisterEvent(Sever.CastIntimidatingRoar, 30000, 0)
end

function Sever.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Sever.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Sever.OnDamageTaken(event, creature, attacker, damage)
if (creature:HealthBelowPct(50) and not creature:HasAura(41305)) then
creature:CastSpell(creature, 41305, true)
creature:SendUnitYell("", 0)
end
end

RegisterCreatureEvent(14682, 1, Sever.OnEnterCombat)
RegisterCreatureEvent(14682, 2, Sever.OnLeaveCombat)
RegisterCreatureEvent(14682, 4, Sever.OnDied)
RegisterCreatureEvent(14682, 9, Sever.OnDamageTaken)

