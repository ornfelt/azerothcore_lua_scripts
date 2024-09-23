local NecrolordVarkul = {}

NecrolordVarkul.NPC_ID = 400125
NecrolordVarkul.SPELL_IDS = {
    SHADOW_BOLT = 12739,
    FROST_NOVA = 9915,
    FROST_ARMOR = 10220,
    RAISE_DEAD = 52478,
    BLINK = 1953
}
NecrolordVarkul.YELL_IDS = {
    AGGRO = "The Scourge shall consume all who dare enter these depths!",
    RAISE_DEAD = "Rise, my minions! Feast on their flesh!",
    KILLED_PLAYER = "Your soul now belongs to the Scourge!"
}

function NecrolordVarkul.CastShadowBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), NecrolordVarkul.SPELL_IDS.SHADOW_BOLT, false)
end

function NecrolordVarkul.CastFrostNova(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), NecrolordVarkul.SPELL_IDS.FROST_NOVA, true)
end

function NecrolordVarkul.CastFrostArmor(event, delay, pCall, creature)
    creature:CastSpell(creature, NecrolordVarkul.SPELL_IDS.FROST_ARMOR, true)
end

function NecrolordVarkul.CastRaiseDead(event, delay, pCall, creature)
    creature:SendUnitYell(NecrolordVarkul.YELL_IDS.RAISE_DEAD, 0)
    creature:CastSpell(creature, NecrolordVarkul.SPELL_IDS.RAISE_DEAD, true)
end

function NecrolordVarkul.CastBlink(event, delay, pCall, creature)
    creature:CastSpell(creature, NecrolordVarkul.SPELL_IDS.BLINK, true)
    local nearestCreature = creature:GetNearestPlayer(30, 1)
    if nearestCreature ~= nil then
        creature:AttackStart(nearestCreature)
    end
end

function NecrolordVarkul.EnterCombat(event, creature, target)
    creature:SendUnitYell(NecrolordVarkul.YELL_IDS.AGGRO, 0)
    creature:RegisterEvent(NecrolordVarkul.CastShadowBolt, math.random(4000, 6000), 0)
    creature:RegisterEvent(NecrolordVarkul.CastFrostNova, math.random(10000, 14000), 0)
    creature:RegisterEvent(NecrolordVarkul.CastFrostArmor, 1000, 1)
    creature:RegisterEvent(NecrolordVarkul.CastRaiseDead, math.random(13000, 17000), 0)
    creature:RegisterEvent(NecrolordVarkul.CastBlink, math.random(16000, 20000), 0)
end

function NecrolordVarkul.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function NecrolordVarkul.KilledPlayer(event, creature, victim)
    creature:SendUnitYell(NecrolordVarkul.YELL_IDS.KILLED_PLAYER, 0)
end

function NecrolordVarkul.JustDied(event, creature, killer)
    creature:RemoveEvents()
end

function NecrolordVarkul.OnSpawn(event, creature)
    creature:SetEquipmentSlots(60132, 0, 0)
end

RegisterCreatureEvent(NecrolordVarkul.NPC_ID, 1, NecrolordVarkul.EnterCombat)
RegisterCreatureEvent(NecrolordVarkul.NPC_ID, 2, NecrolordVarkul.OnLeaveCombat)
RegisterCreatureEvent(NecrolordVarkul.NPC_ID, 3, NecrolordVarkul.KilledPlayer)
RegisterCreatureEvent(NecrolordVarkul.NPC_ID, 4, NecrolordVarkul.JustDied)
RegisterCreatureEvent(NecrolordVarkul.NPC_ID, 5, NecrolordVarkul.OnSpawn)
