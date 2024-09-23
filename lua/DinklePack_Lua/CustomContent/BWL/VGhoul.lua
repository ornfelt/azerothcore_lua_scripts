local VGhoul = {}

VGhoul.NPC_ID = 400151
VGhoul.SPELL_IDS = {
    PLAGUE = 45462,
    STUN = 56
}

function VGhoul.CastPlague(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), VGhoul.SPELL_IDS.PLAGUE, true)
end

function VGhoul.CastStun(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    local closeTargets = {}
    
    for _, target in pairs(targets) do
        if creature:GetDistance(target) <= 5 then
            table.insert(closeTargets, target)
        end
    end
    
    if #closeTargets > 0 then
        local randomTarget = closeTargets[math.random(1, #closeTargets)]
        creature:CastSpell(randomTarget, VGhoul.SPELL_IDS.STUN, true)
    end
end

function VGhoul.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(VGhoul.CastPlague, math.random(8000, 12000), 0)
    creature:RegisterEvent(VGhoul.CastStun, math.random(10000, 15000), 0)
end

function VGhoul.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function VGhoul.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

function VGhoul.OnSpawn(event, creature)
    creature:PerformEmote(449)
end

RegisterCreatureEvent(VGhoul.NPC_ID, 1, VGhoul.OnEnterCombat)
RegisterCreatureEvent(VGhoul.NPC_ID, 2, VGhoul.OnLeaveCombat)
RegisterCreatureEvent(VGhoul.NPC_ID, 4, VGhoul.OnDied)
RegisterCreatureEvent(VGhoul.NPC_ID, 5, VGhoul.OnSpawn)

