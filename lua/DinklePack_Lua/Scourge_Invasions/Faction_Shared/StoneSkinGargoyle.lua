local StoneskinGargoyle = {}
StoneskinGargoyle.NPC_ID = 400053  

function StoneskinGargoyle.GustOfWind(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 61663, true)
end

function StoneskinGargoyle.StoneStomp(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, 49675, true)
end

function StoneskinGargoyle.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(StoneskinGargoyle.GustOfWind, 15000, 0)
    creature:RegisterEvent(StoneskinGargoyle.StoneStomp, 8000, 0)
end

function StoneskinGargoyle.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function StoneskinGargoyle.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(StoneskinGargoyle.NPC_ID, 1, StoneskinGargoyle.OnEnterCombat)
RegisterCreatureEvent(StoneskinGargoyle.NPC_ID, 2, StoneskinGargoyle.OnLeaveCombat)
RegisterCreatureEvent(StoneskinGargoyle.NPC_ID, 4, StoneskinGargoyle.OnDied)
