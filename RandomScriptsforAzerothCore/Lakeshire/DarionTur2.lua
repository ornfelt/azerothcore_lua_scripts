local NPC_ID_DAMION_TUR = 400079
local SOUND_ID = 20436

local function OnDamionTurSpawn(event, creature)
    creature:PlayDirectSound(SOUND_ID)
end

RegisterCreatureEvent(NPC_ID_DAMION_TUR, 5, OnDamionTurSpawn)
