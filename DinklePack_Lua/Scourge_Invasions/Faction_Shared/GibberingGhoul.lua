local GibberingGhoul = {}
GibberingGhoul.NPC_ID = 8531

function GibberingGhoul.OnCombat(event, creature, target)
    creature:RegisterEvent(GibberingGhoul.Ability2, 100, 1)
    creature:RegisterEvent(GibberingGhoul.Ability1, 7000, 0)
    creature:RegisterEvent(GibberingGhoul.Ability2, 12000, 0)
end

function GibberingGhoul.Ability1(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 34113, true)
end

function GibberingGhoul.Ability2(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 12889, true)
end

function GibberingGhoul.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function GibberingGhoul.OnDeath(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(GibberingGhoul.NPC_ID, 1, GibberingGhoul.OnCombat)
RegisterCreatureEvent(GibberingGhoul.NPC_ID, 2, GibberingGhoul.OnLeaveCombat)
RegisterCreatureEvent(GibberingGhoul.NPC_ID, 4, GibberingGhoul.OnDeath)
