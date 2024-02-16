local NefariousWhelpling = {}

NefariousWhelpling.NPC_ID = 400154
NefariousWhelpling.SPELL_IDS = {
    SHADOW_WEAKNESS = 80041,
    SHADOW_BOLT = 11659
}

local function CastShadowWeaknessOnVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, NefariousWhelpling.SPELL_IDS.SHADOW_WEAKNESS, true)
    end
end

local function CastShadowBoltOnVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, NefariousWhelpling.SPELL_IDS.SHADOW_BOLT, true)
    end
end

function NefariousWhelpling.OnEnterCombat(event, creature)
    creature:RegisterEvent(CastShadowWeaknessOnVictim, 5000, 0) -- every 5 seconds
    creature:RegisterEvent(CastShadowBoltOnVictim, 6000, 0) -- every 6 seconds
end

function NefariousWhelpling.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function NefariousWhelpling.OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

-- Register the event handlers for Nefarious Whelpling
RegisterCreatureEvent(NefariousWhelpling.NPC_ID, 1, NefariousWhelpling.OnEnterCombat)
RegisterCreatureEvent(NefariousWhelpling.NPC_ID, 2, NefariousWhelpling.OnLeaveCombat)
RegisterCreatureEvent(NefariousWhelpling.NPC_ID, 4, NefariousWhelpling.OnCreatureDeath)

