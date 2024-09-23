local DefenderTura = {}

DefenderTura.NPC_ID = 400018
DefenderTura.SPELL_IDS = {
    SPELL_1 = 100138,
    SPELL_2 = 69930,
    SPELL_3 = 52386
}

DefenderTura.YELL_TEXT = {
    "DefenderTuras, forward! We end this beast here and now!",
    "We fight the Scourge to protect our homes, our families...I only hope we are not too late.",
    "",
    "Alleria...perfect timing as always.",
}

DefenderTura.waypointIndex = 0

function DefenderTura.OnReachWp(event, creature, waypoint)
    if DefenderTura.waypointIndex >= #DefenderTura.YELL_TEXT then
        return
    end
    creature:CastSpell(creature, DefenderTura.SPELL_IDS.SPELL_1, true)
    creature:CastSpell(creature, DefenderTura.SPELL_IDS.SPELL_2, true)
    creature:CastSpell(creature, DefenderTura.SPELL_IDS.SPELL_3, true)
    creature:SendUnitSay(DefenderTura.YELL_TEXT[DefenderTura.waypointIndex + 1], 0)
    DefenderTura.waypointIndex = DefenderTura.waypointIndex + 1
end

function DefenderTura.OnSpawn(event, creature)
    DefenderTura.waypointIndex = 0
    creature:MoveWaypoint()
    creature:SetReactState(0)
end

RegisterCreatureEvent(DefenderTura.NPC_ID, 5, DefenderTura.OnSpawn)
RegisterCreatureEvent(DefenderTura.NPC_ID, 6, DefenderTura.OnReachWp)
