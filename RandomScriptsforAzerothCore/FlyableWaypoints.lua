local Waypoint = {};

function Waypoint.OnSpawn(event, creature)
creature:CanFly(true)
creature:SetDisableGravity(true)
end

RegisterCreatureEvent(1, 5, Waypoint.OnSpawn)
