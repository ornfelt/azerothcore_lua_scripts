--[[
This script reduces the level of selected NPCs and adjusts their healthpool accordingly. This is a variation of the other script.
]]--

local npcIds = {
-- An array of NPC IDs that will have their level and health adjusted.
400013,
400014,
68,
1976,
466,
}

local function CastSpellOnSpawn(event, creature)
-- The function that will be called when an NPC with an ID in npcIds is spawned.

if not creature then
-- Check if a creature was passed to the function.
print("Error: creature was not set!")
return
end

local originalLevel = creature:GetLevel()
-- Get the original level of the spawned NPC.

local randomLevel = math.random(originalLevel - 34, originalLevel -30)
-- Choose a random level between the original level minus 34 and minus 30.

local levelDiff = originalLevel - randomLevel
-- Calculate the difference between the original level and the new, random level.

creature:SetLevel(randomLevel)
-- Set the NPC's level to the random level.

creature:SetMaxHealth(creature:GetMaxHealth() * (1 - levelDiff * 0.03))
-- Adjust the NPC's healthpool by reducing it by 3% for each level difference.

creature:SetHealth(creature:GetMaxHealth())
-- Set the NPC's current health to its maximum health.

creature:CastSpell(creature, 100133, true)
-- Cast the teleport visual spell on the NPC.
end

for _, npcId in ipairs(npcIds) do
-- Loop through all the NPC IDs in the npcIds array.

RegisterCreatureEvent(npcId, 5, CastSpellOnSpawn)
-- Register the CastSpellOnSpawn function to be called when an NPC with the current ID is spawned.
end




