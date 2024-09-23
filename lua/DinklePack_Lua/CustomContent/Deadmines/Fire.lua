local CREATURE_ENTRY = 29692
local GAMEOBJECT_ENTRY = 16398
local DESPAWN_TIME = 5 * 60 * 1000 -- 5 minutes in milliseconds
local SPAWN_TYPE = 3 -- TEMPSUMMON_TIMED_DESPAWN
local SPAWN_LOCATIONS = {
    {-91, -692, 8.28},
    {-102, -706, 9.16},
    {-96, -723, 8.4},
    {-67, -735, 8.3},
    {-46, -824.66, 8.86},
    {-57, -732, 9.18},
    {-78.77, -726.15, 9},
    {-56.18, -723.75, 8.754},
    {-48.07, -729.73, 9.18},
    {-93.244, -703, 8.91}
}

local function FireSpawnCreatures(event, go, player)
    for _, location in ipairs(SPAWN_LOCATIONS) do
        go:SpawnCreature(CREATURE_ENTRY, location[1], location[2], location[3], 0, SPAWN_TYPE, DESPAWN_TIME)
    end
end

RegisterGameObjectEvent(GAMEOBJECT_ENTRY, 14, FireSpawnCreatures)
