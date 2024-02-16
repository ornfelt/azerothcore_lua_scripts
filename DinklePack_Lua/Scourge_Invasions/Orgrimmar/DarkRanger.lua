local DarkRanger = {}

DarkRanger.NPC_IDS = {400072, 400073}
DarkRanger.SPELL_IDS = {
    SHOOT = 37770,
    BLACK_ARROW = 63671,
    EXPLODING_SHOT = 33792,
    BARRAGE = 10188
}

function DarkRanger.CastShoot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkRanger.SPELL_IDS.SHOOT, true) -- cast shoot on target
end

function DarkRanger.CastBlackArrow(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkRanger.SPELL_IDS.BLACK_ARROW, true)
end

function DarkRanger.CastExplodingShot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkRanger.SPELL_IDS.EXPLODING_SHOT, true)
end

function DarkRanger.CastBarrage(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkRanger.SPELL_IDS.BARRAGE, true)
end

function DarkRanger.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DarkRanger.CastShoot, 750, 0)
    creature:RegisterEvent(DarkRanger.CastBlackArrow, 16000, 0)
    creature:RegisterEvent(DarkRanger.CastBarrage, 10000, 0)
    creature:RegisterEvent(DarkRanger.CastExplodingShot, 7000, 0)
end

function DarkRanger.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DarkRanger.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

for _, npcId in ipairs(DarkRanger.NPC_IDS) do
    RegisterCreatureEvent(npcId, 1, DarkRanger.OnEnterCombat)
    RegisterCreatureEvent(npcId, 2, DarkRanger.OnLeaveCombat)
    RegisterCreatureEvent(npcId, 4, DarkRanger.OnDied)
end
