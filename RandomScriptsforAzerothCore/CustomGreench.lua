--Needs lots and lots of work. Register health check to event 9. 
--Add true false statements to check if he's reached below 50.
--Don't remove events unnecessarily 

local AbominableGreench = {};

function AbominableGreench.OnDie(event, creature)
creature:SendUnitYell("Argh... I'll be back!", 0)
end

function AbominableGreench.Enrage(event, delay, calls, creature)
if (creature:GetHealthPct() <= 50) then
creature:RemoveEvents()
creature:CastSpell(creature, 61369, true)
creature:RegisterEvent(AbominableGreench.FrostAttack, 4000, 0)
end
end

function AbominableGreench.FrostAttack(event, delay, calls, creature)
local TARGET = creature:GetAITarget(1, true, 0, 45)
creature:CastSpell(TARGET, 35263, true)
end

function AbominableGreench.OnEnterCombat(event, creature, target)
local TARGET = creature:GetAITarget(1, true, 0, 45)
creature:CastSpell(TARGET, 33547, true)
creature:SendUnitYell("You can try to stop me, but it's just a waste of time. I'm the king of Winter Veil crime!", 0)
creature:RegisterEvent(AbominableGreench.Enrage, 1000, 0)
end

function AbominableGreench.OnLeaveCombat(event, creature)
creature:SendUnitYell("What's the matter? Don't you like my holiday spirit?", 0)
creature:RemoveEvents()
end

RegisterCreatureEvent(13602, 1, AbominableGreench.OnEnterCombat)
RegisterCreatureEvent(13602, 2, AbominableGreench.OnLeaveCombat)
RegisterCreatureEvent(13602, 4, AbominableGreench.OnDie)