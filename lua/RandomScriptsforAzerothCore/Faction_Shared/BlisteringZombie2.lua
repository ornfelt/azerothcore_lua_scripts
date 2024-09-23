local BlisteringZombie = {};

local NPC_HUT_FIRE = 29692 
local FIRE_SPAWN_CHANCE = 20
local FIRE_SPAWN_RADIUS = 35
local FIRE_DESPAWN_TIME = 400000

function BlisteringZombie.OnSpawn(event, creature)
    creature:SetMaxHealth(8224)
    creature:CastSpell(creature:GetVictim(), 17683, true)
end

function BlisteringZombie.OnCombat(event, creature, target)
    creature:RegisterEvent(BlisteringZombie.Ability1, 8000, 0)
end

function BlisteringZombie.Ability1(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 64153, true)
end

function BlisteringZombie.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function BlisteringZombie.OnWaypointReached(event, creature)
    local chance = math.random(1, 100)
    local areaId = creature:GetAreaId()
    if chance <= FIRE_SPAWN_CHANCE and (areaId == 380 or areaId == 69) then
        local x, y, z, o = creature:GetLocation()
        local xOffset = math.random(-FIRE_SPAWN_RADIUS, FIRE_SPAWN_RADIUS)
        local yOffset = math.random(-FIRE_SPAWN_RADIUS, FIRE_SPAWN_RADIUS)
        local nx, ny, nz = x + xOffset, y + yOffset, z
        creature:SpawnCreature(NPC_HUT_FIRE, nx, ny, nz, o, 3, FIRE_DESPAWN_TIME)
    end
end

function BlisteringZombie.OnDeath(event, creature, killer)
    creature:DespawnOrUnsummon(10000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400077, 1, BlisteringZombie.OnCombat)
RegisterCreatureEvent(400077, 2, BlisteringZombie.OnLeaveCombat)
RegisterCreatureEvent(400077, 4, BlisteringZombie.OnDeath)
RegisterCreatureEvent(400077, 5, BlisteringZombie.OnSpawn)
RegisterCreatureEvent(400077, 6, BlisteringZombie.OnWaypointReached)
