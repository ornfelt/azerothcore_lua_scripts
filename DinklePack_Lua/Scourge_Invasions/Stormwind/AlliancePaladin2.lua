local AlliancePaladinTw = {}

AlliancePaladinTw.NPC_ID = 400030
AlliancePaladinTw.SPELL_IDS = {
    CRUSADER_STRIKE = 35395,
    CONSECRATION = 20924,
    DIVINE_STORM = 53385,
    JUDGEMENT_OF_LIGHT = 20271,
    AVENGING_WRATH = 31884,
    BLESSING_OF_KINGS = 20217
}

function AlliancePaladinTw.CastCS(eventId, delay, calls, creature)
    creature:CastSpell(creature, AlliancePaladinTw.SPELL_IDS.CRUSADER_STRIKE, true)
end

function AlliancePaladinTw.CastCons(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AlliancePaladinTw.SPELL_IDS.CONSECRATION, true)
end

function AlliancePaladinTw.CastDS(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AlliancePaladinTw.SPELL_IDS.DIVINE_STORM, true)
end

function AlliancePaladinTw.CastJOL(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AlliancePaladinTw.SPELL_IDS.JUDGEMENT_OF_LIGHT, true)
end

function AlliancePaladinTw.CastAvengingWrath(event, creature)
    creature:CastSpell(creature, AlliancePaladinTw.SPELL_IDS.AVENGING_WRATH, true)
end

function AlliancePaladinTw.CastKings(event, creature)
    creature:CastSpell(creature, AlliancePaladinTw.SPELL_IDS.BLESSING_OF_KINGS, true)
end

function AlliancePaladinTw.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(AlliancePaladinTw.CastCS, 6000, 0)
    creature:RegisterEvent(AlliancePaladinTw.CastCons, 8000, 0)
    creature:RegisterEvent(AlliancePaladinTw.CastDS, 10000, 0)
    creature:RegisterEvent(AlliancePaladinTw.CastJOL, 11000, 0)
end

function AlliancePaladinTw.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function AlliancePaladinTw.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function AlliancePaladinTw.OnSpawn(event, creature)
    creature:CastSpell(creature, AlliancePaladinTw.SPELL_IDS.BLESSING_OF_KINGS, true)
end

RegisterCreatureEvent(AlliancePaladinTw.NPC_ID, 1, AlliancePaladinTw.OnEnterCombat)
RegisterCreatureEvent(AlliancePaladinTw.NPC_ID, 2, AlliancePaladinTw.OnLeaveCombat)
RegisterCreatureEvent(AlliancePaladinTw.NPC_ID, 4, AlliancePaladinTw.OnDied)
RegisterCreatureEvent(AlliancePaladinTw.NPC_ID, 5, AlliancePaladinTw.OnSpawn)
