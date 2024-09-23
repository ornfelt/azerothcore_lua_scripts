local BWLBoneConstruct = {}

BWLBoneConstruct.NPC_ID = 14605
BWLBoneConstruct.SPELL_ID = 8355

function BWLBoneConstruct.ExploitWeakness(eventId, delay, repeats, creature)
    local target = creature:GetVictim()

    if target then
        creature:CastSpell(target, BWLBoneConstruct.SPELL_ID, false)
    end
end

function BWLBoneConstruct.OnSpawn(event, creature)
    local playersInRange = creature:GetPlayersInRange(100, 1) -- 100 yards range, hostile players

    for _, player in pairs(playersInRange) do
        creature:AttackStart(player)
        break -- Attack only one player
    end
end

function BWLBoneConstruct.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(BWLBoneConstruct.ExploitWeakness, 6000, 0) -- Every 6 seconds
end

function BWLBoneConstruct.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BWLBoneConstruct.NPC_ID, 5, BWLBoneConstruct.OnSpawn)
RegisterCreatureEvent(BWLBoneConstruct.NPC_ID, 1, BWLBoneConstruct.OnEnterCombat)
RegisterCreatureEvent(BWLBoneConstruct.NPC_ID, 2, BWLBoneConstruct.OnLeaveCombat)
