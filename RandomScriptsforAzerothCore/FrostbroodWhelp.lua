local frostbroodWhelps = {};

function frostbroodWhelps.OnSpawn(event, creature)
creature:CanFly(true)
creature:SetDisableGravity(true)
end

RegisterCreatureEvent(400057, 5, frostbroodWhelps.OnSpawn)

RegisterCreatureEvent(16531, 5, frostbroodWhelps.OnSpawn)