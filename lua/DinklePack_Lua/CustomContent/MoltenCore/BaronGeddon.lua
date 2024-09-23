local BaronGedon = {}

BaronGedon.NPC_ID = 12056
BaronGedon.SPELL_IDS = {
    INFERNO = 19695,
    IGNITE_MANA = 19659,
    LIVING_BOMB = 20475,
    ARMAGEDDON = 20478
}
BaronGedon.spellQueue = {}
BaronGedon.armageddonCast = false

function BaronGedon.CastInferno(eventId, delay, calls, creature)
    table.insert(BaronGedon.spellQueue, {spell = BaronGedon.SPELL_IDS.INFERNO, targetType = 'self'})
end

function BaronGedon.CastIgniteMana(eventId, delay, calls, creature)
    table.insert(BaronGedon.spellQueue, {spell = BaronGedon.SPELL_IDS.IGNITE_MANA, targetType = 'victim'})
end

function BaronGedon.CastLivingBomb(eventId, delay, calls, creature)
    table.insert(BaronGedon.spellQueue, {spell = BaronGedon.SPELL_IDS.LIVING_BOMB, targetType = 'random'})
end

function BaronGedon.CastArmageddon(eventId, delay, calls, creature)
    table.insert(BaronGedon.spellQueue, {spell = BaronGedon.SPELL_IDS.ARMAGEDDON, targetType = 'self'})
end

function BaronGedon.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #BaronGedon.spellQueue > 0 then
        local nextSpell = table.remove(BaronGedon.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'self' then
            target = creature
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets()
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
        end
    end
end

function BaronGedon.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(BaronGedon.CastInferno, math.random(40000, 55000), 0)
    creature:RegisterEvent(BaronGedon.CastIgniteMana, math.random(18000, 27000), 0)
    creature:RegisterEvent(BaronGedon.CastLivingBomb, math.random(17000, 25000), 0)
    creature:RegisterEvent(BaronGedon.ProcessSpellQueue, 2000, 0)
    creature:SetData("BaronGedonHealthPct", 100)
end

function BaronGedon.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    BaronGedon.spellQueue = {}
    BaronGedon.armageddonCast = false
end

function BaronGedon.OnDamageTaken(event, creature, attacker, damage)
    if creature:GetHealthPct() <= 8 and creature:GetData("BaronGedonHealthPct") > 5 and not BaronGedon.armageddonCast then
        creature:SendUnitEmote("Baron Geddon performs one last service for Ragnaros...", 0)
        creature:RegisterEvent(BaronGedon.CastArmageddon, 1000, 1)
        BaronGedon.armageddonCast = true
    end
    creature:SetData("BaronGedonHealthPct", creature:GetHealthPct())
end

function BaronGedon.OnDied(event, creature, killer)
    creature:RemoveEvents()
    BaronGedon.spellQueue = {}
    BaronGedon.armageddonCast = false
end

RegisterCreatureEvent(BaronGedon.NPC_ID, 1, BaronGedon.OnEnterCombat)
RegisterCreatureEvent(BaronGedon.NPC_ID, 2, BaronGedon.OnLeaveCombat)
RegisterCreatureEvent(BaronGedon.NPC_ID, 9, BaronGedon.OnDamageTaken)
RegisterCreatureEvent(BaronGedon.NPC_ID, 4, BaronGedon.OnDied)
