local npcid = 400019

function OnSpawn(event, creature)
    creature:SetWalk(true)
    creature:MoveWaypoint()
    creature:SetReactState(0)
end

RegisterCreatureEvent(npcid, 5, OnSpawn)