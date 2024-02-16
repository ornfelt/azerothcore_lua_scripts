local NPC_ID_BLISTER_TWO = 400077

BlisteringTwoZombie = {}

local NPC_HUT_FIRE = 29692 
local FIRE_SPAWN_CHANCE = 20
local FIRE_SPAWN_RADIUS = 35
local FIRE_DESPAWN_TIME = 400000

function BlisteringTwoZombie.OnSpawn(event, creature)
    --creature:SetMaxHealth(8224)
    creature:CastSpell(creature:GetVictim(), 17683, true)
end

function BlisteringTwoZombie.OnCombat(event, creature, target)
    creature:RegisterEvent(BlisteringTwoZombie.Ability1, 8000, 0)
end

function BlisteringTwoZombie.Ability1(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 64153, true)
end

function BlisteringTwoZombie.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function BlisteringTwoZombie.OnWaypointReached(event, creature)
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

function BlisteringTwoZombie.OnDeath(event, creature, killer)
    creature:DespawnOrUnsummon(10000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_ID_BLISTER_TWO, 1, BlisteringTwoZombie.OnCombat)
RegisterCreatureEvent(NPC_ID_BLISTER_TWO, 2, BlisteringTwoZombie.OnLeaveCombat)
RegisterCreatureEvent(NPC_ID_BLISTER_TWO, 4, BlisteringTwoZombie.OnDeath)
RegisterCreatureEvent(NPC_ID_BLISTER_TWO, 5, BlisteringTwoZombie.OnSpawn)
RegisterCreatureEvent(NPC_ID_BLISTER_TWO, 6, BlisteringTwoZombie.OnWaypointReached)
