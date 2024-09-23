local SpectralAttendantTwos = {}
SpectralAttendantTwos.NPC_ID = 11873

function SpectralAttendantTwos.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(SpectralAttendantTwos.Cripple, 6000, 0)
    creature:RegisterEvent(SpectralAttendantTwos.AOEFear, 13000, 0)
    creature:RegisterEvent(SpectralAttendantTwos.Teleport, math.random(14000,16000), 0)
end

function SpectralAttendantTwos.Cripple(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 11443, true)
end

function SpectralAttendantTwos.AOEFear(eventId, delay, calls, creature)
    creature:CastSpell(creature, 8122)
end

function SpectralAttendantTwos.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function SpectralAttendantTwos.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function SpectralAttendantTwos.Teleport(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, 69904)
    creature:ClearThreatList()
end

RegisterCreatureEvent(SpectralAttendantTwos.NPC_ID, 1, SpectralAttendantTwos.OnEnterCombat)
RegisterCreatureEvent(SpectralAttendantTwos.NPC_ID, 2, SpectralAttendantTwos.OnLeaveCombat)
RegisterCreatureEvent(SpectralAttendantTwos.NPC_ID, 4, SpectralAttendantTwos.OnDied)
