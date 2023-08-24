local INVISIBLE_BUNNY_ENTRY = 400099
local SPELL_TO_CAST = 364735

local InvisibleBunny = {}

function InvisibleBunny.OnSpawn(event, creature)
    creature:RegisterEvent(InvisibleBunny.CastSpellRandomly, math.random(18000, 34000), 4)
end

function InvisibleBunny.CastSpellRandomly(event, delay, calls, creature)
    creature:CastSpell(creature, SPELL_TO_CAST, true)
    
end

RegisterCreatureEvent(INVISIBLE_BUNNY_ENTRY, 5, InvisibleBunny.OnSpawn) 
