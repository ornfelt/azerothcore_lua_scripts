local AlleriaWalk = {}

AlleriaWalk.NPC_ID = 400019

function AlleriaWalk.OnSpawn(event, creature)
    creature:SetWalk(true)
    creature:MoveWaypoint()
    creature:SetReactState(0)
end

RegisterCreatureEvent(AlleriaWalk.NPC_ID, 5, AlleriaWalk.OnSpawn)
