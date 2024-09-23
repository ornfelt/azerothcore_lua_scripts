local frostbroodWhelps = {}

frostbroodWhelps.NPC_IDS = {
    FIRST_NPC = 400057,
    SECOND_NPC = 16531
}

function frostbroodWhelps.OnSpawn(event, creature)
    creature:CanFly(true)
    creature:SetDisableGravity(true)
end

RegisterCreatureEvent(frostbroodWhelps.NPC_IDS.FIRST_NPC, 5, frostbroodWhelps.OnSpawn)
RegisterCreatureEvent(frostbroodWhelps.NPC_IDS.SECOND_NPC, 5, frostbroodWhelps.OnSpawn)
