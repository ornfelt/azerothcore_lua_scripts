local MyCreature = {}

MyCreature.CREATURE_ID = 387570
MyCreature.SPELL_ID = 100148

function MyCreature.OnSpawn(event, creature)
    creature:CastSpell(creature, MyCreature.SPELL_ID, true)
end

RegisterCreatureEvent(MyCreature.CREATURE_ID, 5, MyCreature.OnSpawn)
