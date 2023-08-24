--lightning
local npcIds1 = {
8541,
10417,
4475,
11873,
8531,
11551,
10488,
10487,
1788,
10414,
10407,
400010,
400015,
400016,
300018,
16383,
16394,
400036,
400049,
400048,
16437,
16438,
400112
}

-- Rez Visual
local npcIds2 = {
400013,
400014,
68,
1976,
466,
400018,
400019,
400026,
400027,
400033,
400070,
400065,
400042,
400043
}

-- Shadowstep
local npcIds3 = {
400053,
400069,
400055,
400052,
400047,
400056,
400032,
400029,
400073,
400072,
400102,
400103,
16422,
16423,
400011,
400057
}

-- Function to be executed when an NPC from group 1 is spawned
local function CastSpellOnSpawnGroup1(event, creature)
if not creature then
print("Error: creature was not set!")
return
end

local spellId = 28234
creature:CastSpell(creature, spellId, true) -- minion visual
end

-- Function to be executed when an NPC from group 2 is spawned
local function CastSpellOnSpawnGroup2(event, creature)
if not creature then
print("Error: creature was not set!")
return
end

local spellId = 100133
creature:CastSpell(creature, spellId, true) -- rez visual
end

-- Function to be executed when an NPC from group 3 is spawned
local function CastSpellOnSpawnGroup3(event, creature)
if not creature then
print("Error: creature was not set!")
return
end

local spellId = 51908
creature:CastSpell(creature, spellId, true) -- shadowstep cosmetic
end

-- Register the event for NPCs in group 1
for _, npcId in ipairs(npcIds1) do
RegisterCreatureEvent(npcId, 5, CastSpellOnSpawnGroup1)
end

-- Register the event for NPCs in group 2
for _, npcId in ipairs(npcIds2) do
RegisterCreatureEvent(npcId, 5, CastSpellOnSpawnGroup2)
end

-- Register the event for NPCs in group 3
for _, npcId in ipairs(npcIds3) do
RegisterCreatureEvent(npcId, 5, CastSpellOnSpawnGroup3)
end