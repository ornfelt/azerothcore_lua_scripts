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
400011,
400015,
400016,
300018,
400029
}

-- Table to store NPC IDs for group 2
local npcIds2 = {
400013,
400014,
68,
1976,
466,
400018,
400019,
400026,
400027
}

-- Boolean to enable or disable modifying health and level
local modifyHealthAndLevel = false

-- Function to be executed when an NPC from group 1 is spawned
local function CastSpellOnSpawnGroup1(event, creature)
if not creature then
print("Error: creature was not set!")
return
end

if modifyHealthAndLevel then
local originalLevel = creature:GetLevel()
local randomLevel = math.random(25, 30)
local levelDiff = originalLevel - randomLevel

creature:SetLevel(randomLevel)
creature:SetMaxHealth(creature:GetMaxHealth() * (1 - levelDiff * 0.015))
creature:SetHealth(creature:GetMaxHealth())
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

if modifyHealthAndLevel then
local originalLevel = creature:GetLevel()
local randomLevel = math.random(25, 30)
local levelDiff = originalLevel - randomLevel

creature:SetLevel(randomLevel)
creature:SetMaxHealth(creature:GetMaxHealth() * (1 - levelDiff * 0.015))
creature:SetHealth(creature:GetMaxHealth())
end

local spellId = 100133
creature:CastSpell(creature, spellId, true) -- rez visual
end

-- Function to be executed when an NPC from both groups leaves combat
local function CastSpellOnLeaveCombat(event, creature)
if not creature then
print("Error: creature was not set!")
return
end
end

-- Register the event for NPCs in group 1
for _, npcId in ipairs(npcIds1) do
RegisterCreatureEvent(npcId, 5, CastSpellOnSpawnGroup1)
RegisterCreatureEvent(npcId, 21, CastSpellOnLeaveCombat)
end

-- Register the event for NPCs in group 2
for _, npcId in ipairs(npcIds2) do
RegisterCreatureEvent(npcId, 5, CastSpellOnSpawnGroup2)
RegisterCreatureEvent(npcId, 21, CastSpellOnLeaveCombat)
end