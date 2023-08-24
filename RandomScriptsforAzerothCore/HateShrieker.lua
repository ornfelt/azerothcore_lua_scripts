local HateShrieker = {}

function HateShrieker.OnEnterCombat(event, creature, target)
creature:RegisterEvent(HateShrieker.Screech, 7000, 0)
creature:RegisterEvent(HateShrieker.ShadowWordPain, math.random(11000,16000), 0)
end


function HateShrieker.Screech(eventId, delay, calls, creature)
creature:CastSpell(creature, 3589)
end

function HateShrieker.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function HateShrieker.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function HateShrieker.ShadowWordPain(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
if #targets == 0 then
  return
end
local target = targets[math.random(#targets)]
creature:CastSpell(target, 10893)
creature:ClearThreatList()
end



RegisterCreatureEvent(8541, 1, HateShrieker.OnEnterCombat)
RegisterCreatureEvent(8541, 2, HateShrieker.OnLeaveCombat)
RegisterCreatureEvent(8541, 4, HateShrieker.OnDied)