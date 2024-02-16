local Scorn = {}

Scorn.NPC_ID = 400075
Scorn.SPELL_IDS = {
    LICH_SLAP = 28873,
    ENRAGE = 15716,
    FROSTBOLT_VOLLEY = 22643,
    FROST_NOVA = 15531,
    MIND_FLAY = 17318,
    MANA_BURN = 8129
}

function Scorn.LichSlap(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature:GetVictim(), Scorn.SPELL_IDS.LICH_SLAP, true)
    end
end

function Scorn.Enrage(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature, Scorn.SPELL_IDS.ENRAGE, true)
    end
end

function Scorn.FrostboltVolley(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature, Scorn.SPELL_IDS.FROSTBOLT_VOLLEY, true)
    end
end

function Scorn.FrostNova(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature, Scorn.SPELL_IDS.FROST_NOVA, true)
    end
end

function Scorn.MindFlay(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        local targets = creature:GetAITargets(5)
        if #targets == 0 then
            return
        end
        local target = targets[math.random(#targets)]
        creature:CastSpell(target, Scorn.SPELL_IDS.MIND_FLAY, true)
    end
end

function Scorn.ManaBurn(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        local targets = creature:GetAITargets(5)
        if #targets == 0 then
            return
        end
        local target = targets[math.random(#targets)]
        creature:CastSpell(target, Scorn.SPELL_IDS.MANA_BURN, true)
    end
end

function Scorn.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Scorn.LichSlap, math.random(8000,12000), 0)
    creature:RegisterEvent(Scorn.MindFlay, math.random(14000,18000), 0)
    creature:RegisterEvent(Scorn.FrostboltVolley, math.random(7000,11000), 0)
    creature:RegisterEvent(Scorn.FrostNova, 1000, 1)
    creature:RegisterEvent(Scorn.FrostNova, math.random(6000,9000), 0)
    creature:RegisterEvent(Scorn.ManaBurn, math.random(17000,24000), 0)
end

function Scorn.OnHealthUpdate(event, creature, value)
    if (creature:GetHealthPct() <= 20) then
        creature:RemoveEvents()
        creature:RegisterEvent(Scorn.Enrage, 100, 1)
    end
end

function Scorn.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Scorn.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(Scorn.NPC_ID, 1, Scorn.OnEnterCombat)
RegisterCreatureEvent(Scorn.NPC_ID, 9, Scorn.OnHealthUpdate)
RegisterCreatureEvent(Scorn.NPC_ID, 2, Scorn.OnLeaveCombat)
RegisterCreatureEvent(Scorn.NPC_ID, 4, Scorn.OnDied)
