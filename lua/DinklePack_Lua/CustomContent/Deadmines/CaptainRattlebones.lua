local CaptainRattlebones = {}

CaptainRattlebones.NPC_ID = 401116
CaptainRattlebones.SPELL_IDS = {
    SHADOW_BOLT = 20791,
    CURSE_OF_THE_PIRATE_KING = 70542,
    PIRATES_CLEAVE = 40505,
    CANNONBALL_BARRAGE = 6251
}

CaptainRattlebones.YELL_AGGRO_DIALOGUE = {
    "Ye be treadin' on dangerous waters!",
    "Yarr, ye landlubbers be meetin' yer doom!",
    "Arrr, ye won't leave me ship alive!",
    "I be sendin' ye to the depths of the sea!",
    "Ye be facin' the wrath of Captain Rattlebones!"
}

CaptainRattlebones.YELL_DEATH_DIALOGUE = "Me ship...me crew...I be joinin' ye soon..."

function CaptainRattlebones.CastShadowBolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CaptainRattlebones.SPELL_IDS.SHADOW_BOLT, true)
end

function CaptainRattlebones.CastCurseOfThePirateKing(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CaptainRattlebones.SPELL_IDS.CURSE_OF_THE_PIRATE_KING, true)
end

function CaptainRattlebones.CastPiratesCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CaptainRattlebones.SPELL_IDS.PIRATES_CLEAVE, true)
end

function CaptainRattlebones.CastCannonballBarrage(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CaptainRattlebones.SPELL_IDS.CANNONBALL_BARRAGE, true)
end

function CaptainRattlebones.OnEnterCombat(event, creature, target)
    creature:SendUnitYell(CaptainRattlebones.YELL_AGGRO_DIALOGUE[math.random(1, #CaptainRattlebones.YELL_AGGRO_DIALOGUE)], 0)
    creature:RegisterEvent(CaptainRattlebones.CastShadowBolt, 3000, 0)
    creature:RegisterEvent(CaptainRattlebones.CastCurseOfThePirateKing, 12000, 0)
    creature:RegisterEvent(CaptainRattlebones.CastPiratesCleave, 8000, 0)
    creature:RegisterEvent(CaptainRattlebones.CastCannonballBarrage, 18000, 0)
end

function CaptainRattlebones.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function CaptainRattlebones.OnDied(event, creature, killer)
    creature:RemoveEvents()
    creature:SendUnitSay(CaptainRattlebones.YELL_DEATH_DIALOGUE, 0)
end

RegisterCreatureEvent(CaptainRattlebones.NPC_ID, 1, CaptainRattlebones.OnEnterCombat)
RegisterCreatureEvent(CaptainRattlebones.NPC_ID, 2, CaptainRattlebones.OnLeaveCombat)
RegisterCreatureEvent(CaptainRattlebones.NPC_ID, 4, CaptainRattlebones.OnDied)
