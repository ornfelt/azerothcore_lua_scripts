local OrgBerserker = {}

OrgBerserker.NPC_IDS = {400040, 400045, 14720}
OrgBerserker.SPELL_IDS = {
    WHIRL_WIND = 53361,
    ENRAGE = 12880,
    BUFF = 17683
}

function OrgBerserker.CastWhirlWind(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), OrgBerserker.SPELL_IDS.WHIRL_WIND, true)
end

function OrgBerserker.CastEnrage(eventId, delay, calls, creature)
    creature:CastSpell(creature, OrgBerserker.SPELL_IDS.ENRAGE, true)
end

function OrgBerserker.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(OrgBerserker.CastWhirlWind, 7000, 0)
    creature:RegisterEvent(OrgBerserker.CastEnrage, 10000, 0)
end

function OrgBerserker.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function OrgBerserker.OnSpawn(event, creature)
    creature:CastSpell(creature, OrgBerserker.SPELL_IDS.BUFF, true)
end

function OrgBerserker.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

for _, npcId in ipairs(OrgBerserker.NPC_IDS) do
    RegisterCreatureEvent(npcId, 1, OrgBerserker.OnEnterCombat)
    RegisterCreatureEvent(npcId, 2, OrgBerserker.OnLeaveCombat)
    RegisterCreatureEvent(npcId, 4, OrgBerserker.OnDied)
    RegisterCreatureEvent(npcId, 5, OrgBerserker.OnSpawn)
end
