local SpiritofThalgorath = {}

function SpiritofThalgorath.OnSpawn(event, creature)
    creature:SendUnitYell("You will not defeat me so easily!", 0)
end

function SpiritofThalgorath.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(SpiritofThalgorath.Charge, 1000, 1)
    creature:RegisterEvent(SpiritofThalgorath.Charge, 8000, 0)
    creature:RegisterEvent(SpiritofThalgorath.ShadowBolt, 2000, 1)
    creature:RegisterEvent(SpiritofThalgorath.ShadowBolt, 6000, 0)
end

function SpiritofThalgorath.Charge(eventId, delay, calls, creature)
    local targetList = creature:GetAITargets(5)
    local targetCount = #targetList

    if targetCount > 0 then
        local randomIndex = math.random(1, targetCount)
        local randomTarget = targetList[randomIndex]
        creature:CastSpell(randomTarget, 100, true)
    else
        creature:CastSpell(creature:GetVictim(), 100, true)
    end
end

function SpiritofThalgorath.ShadowBolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 9613, false)
end

function SpiritofThalgorath.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function SpiritofThalgorath.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400103, 5, SpiritofThalgorath.OnSpawn)
RegisterCreatureEvent(400103, 1, SpiritofThalgorath.OnEnterCombat)
RegisterCreatureEvent(400103, 2, SpiritofThalgorath.OnLeaveCombat)
RegisterCreatureEvent(400103, 4, SpiritofThalgorath.OnDied)
