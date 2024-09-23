local DeathStalker = {}

function DeathStalker.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DeathStalker.Cripple, 1000, 1)
    creature:RegisterEvent(DeathStalker.Cripple, 8000, 0)
end

function DeathStalker.Cripple(eventId, delay, calls, creature)
    local targetList = creature:GetAITargets(5)
    local targetCount = #targetList

    if targetCount > 0 then
        local randomIndex = math.random(1, targetCount)
        local randomTarget = targetList[randomIndex]
        creature:CastSpell(randomTarget, 6217, true)
    else
        creature:CastSpell(creature:GetVictim(), 6217, true)
    end
end

function DeathStalker.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DeathStalker.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400102, 1, DeathStalker.OnEnterCombat)
RegisterCreatureEvent(400102, 2, DeathStalker.OnLeaveCombat)
RegisterCreatureEvent(400102, 4, DeathStalker.OnDied)
