local EyeTentacle = {}

EyeTentacle.NPC_ID = 15726
EyeTentacle.SPELL_IDS = {
    MIND_FLAY = 26143
}

function EyeTentacle.CastMindFlay(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(100)
    
    if #targets > 0 then
        local target = targets[math.random(1, #targets)]
        creature:CastSpell(target, EyeTentacle.SPELL_IDS.MIND_FLAY, false)
    end
end

function EyeTentacle.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(EyeTentacle.CastMindFlay, math.random(10000, 15000), 0)
end

function EyeTentacle.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(EyeTentacle.NPC_ID, 1, EyeTentacle.OnEnterCombat)
RegisterCreatureEvent(EyeTentacle.NPC_ID, 2, EyeTentacle.OnLeaveCombat)
