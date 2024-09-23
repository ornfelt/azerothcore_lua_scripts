local NecrofiendTwo = {}
NecrofiendTwo.NPC_ID = 11551

function NecrofiendTwo.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(NecrofiendTwo.WebSpray, 12000, 0, creature)
    creature:RegisterEvent(NecrofiendTwo.CastBanefulPoison, 7000, 0, creature)
    creature:RegisterEvent(NecrofiendTwo.DeadlyPoison, 10000, 0, creature)
end

function NecrofiendTwo.WebSpray(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 55508, true)
end

function NecrofiendTwo.DeadlyPoison(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 34616, true)
end

function NecrofiendTwo.CastBanefulPoison(event, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, 15475, true)
end

function NecrofiendTwo.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function NecrofiendTwo.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NecrofiendTwo.NPC_ID, 1, NecrofiendTwo.OnEnterCombat)
RegisterCreatureEvent(NecrofiendTwo.NPC_ID, 2, NecrofiendTwo.OnLeaveCombat)
RegisterCreatureEvent(NecrofiendTwo.NPC_ID, 4, NecrofiendTwo.OnDied)
