local SpectralAttendant = {}

function SpectralAttendant.OnEnterCombat(event, creature, target)
creature:RegisterEvent(SpectralAttendant.Cripple, 6000, 0)
creature:RegisterEvent(SpectralAttendant.AOEFear, 13000, 0)
creature:RegisterEvent(SpectralAttendant.Teleport, math.random(14000,16000), 0)
end


function SpectralAttendant.Cripple(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 11443, true)
end

function SpectralAttendant.AOEFear(eventId, delay, calls, creature)
creature:CastSpell(creature, 8122)
end

function SpectralAttendant.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function SpectralAttendant.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function SpectralAttendant.Teleport(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
if #targets == 0 then
  return
end
local target = targets[math.random(#targets)]
creature:CastSpell(target, 69904)
creature:ClearThreatList()
end



RegisterCreatureEvent(11873, 1, SpectralAttendant.OnEnterCombat)
RegisterCreatureEvent(11873, 2, SpectralAttendant.OnLeaveCombat)
RegisterCreatureEvent(11873, 4, SpectralAttendant.OnDied)