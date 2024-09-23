local PumpkinKobold = {}

PumpkinKobold.GO_ID = 2883
PumpkinKobold.CREATURE_ID = 100168
PumpkinKobold.SPAWN_TYPE = TEMPSUMMON_TIMED_OR_DEAD_DESPAWN
PumpkinKobold.DESPAWN_TIMER = 60000

function PumpkinKobold.OnCreatureSpawn(event, creature)
    local player = creature:GetNearestPlayer()
    if player then
        creature:AttackStart(player)
        creature:SendUnitSay("You no take Pumpkin!", 0)
    end
end

function PumpkinKobold.OnGameObjectUse(event, go, player)
    local x, y, z, o = go:GetLocation()
    go:SpawnCreature(PumpkinKobold.CREATURE_ID, x, y, z, o, PumpkinKobold.SPAWN_TYPE, PumpkinKobold.DESPAWN_TIMER)
end

RegisterGameObjectEvent(PumpkinKobold.GO_ID, 14, PumpkinKobold.OnGameObjectUse)
RegisterCreatureEvent(PumpkinKobold.CREATURE_ID, 5, PumpkinKobold.OnCreatureSpawn)
