local NPC_ENTRY_ID_1 = 400022
local NPC_ENTRY_ID_2 = 400023
local NPC_ENTRY_ID_3 = 400024
local NPC_ENTRY_ID_4 = 400025

function OnSpawn(event, creature)
    local npcEntry = creature:GetEntry()
    if npcEntry == NPC_ENTRY_ID_1 or npcEntry == NPC_ENTRY_ID_2 or npcEntry == NPC_ENTRY_ID_3 or npcEntry == NPC_ENTRY_ID_4 then
        creature:SetWalk(false) -- Set movement type to run
        creature:MoveWaypoint()
    end
end

RegisterCreatureEvent(NPC_ENTRY_ID_1, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY_ID_2, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY_ID_3, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY_ID_4, 5, OnSpawn)