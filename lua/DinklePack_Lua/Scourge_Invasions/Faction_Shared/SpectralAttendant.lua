local SpectralAttendantz = {}
SpectralAttendantz.NPC_ID = 400052

function SpectralAttendantz.OnSpawn(event, creature)
    --creature:SetMaxHealth(43240)
    creature:CastSpell(creature, 17683, true)
end

function SpectralAttendantz.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(SpectralAttendantz.Immolate, 6000, 0)
    creature:RegisterEvent(SpectralAttendantz.Incinerate, 12000, 0)
    creature:RegisterEvent(SpectralAttendantz.AOEFear, 30000, 0)
    creature:RegisterEvent(SpectralAttendantz.CastSpecialSpell, 1000, 0)
    creature:RegisterEvent(SpectralAttendantz.Teleport, math.random(12000,16000), 0)
end

function SpectralAttendantz.CastSpecialSpell(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    if not victim then
        return
    end
    if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
        creature:CastSpell(victim, 5, true)
    end
end

function SpectralAttendantz.Immolate(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 11668, true)
end

function SpectralAttendantz.Incinerate(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 29722, true)
end

function SpectralAttendantz.AOEFear(eventId, delay, calls, creature)
    creature:CastSpell(creature, 8122)
end

function SpectralAttendantz.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function SpectralAttendantz.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

function SpectralAttendantz.Teleport(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, 69904)
    creature:ClearThreatList()
end

RegisterCreatureEvent(SpectralAttendantz.NPC_ID, 5, SpectralAttendantz.OnSpawn)
RegisterCreatureEvent(SpectralAttendantz.NPC_ID, 1, SpectralAttendantz.OnEnterCombat)
RegisterCreatureEvent(SpectralAttendantz.NPC_ID, 2, SpectralAttendantz.OnLeaveCombat)
RegisterCreatureEvent(SpectralAttendantz.NPC_ID, 4, SpectralAttendantz.OnDied)
