local NPC_UNDEAD_ROGUE = 400114
local NPC_TARGET = 3338
local NPC_ADDITIONAL_TARGET = 70000
local NPC_HUT_FIRE = 29692

local SPELL_SINISTER_STRIKE = 1752
local SPELL_EVASION = 5277
local SPELL_GOUGE = 12540
local SPELL_CAST_DEATH = 5

local FIRE_SPAWN_CHANCE = 20
local FIRE_SPAWN_RADIUS = 20
local FIRE_DESPAWN_TIME = 600000

local function CastSinisterStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SINISTER_STRIKE, true)
end

local function CastGouge(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_GOUGE, true)
end

local function CastSpellOnTarget(creature, targetNPC)
    creature:CastSpell(targetNPC, SPELL_CAST_DEATH, true)
end

local function UndeadRogue_OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastSinisterStrike, math.random(4000, 6000), 0)
    creature:RegisterEvent(CastGouge, math.random(14000, 18000), 0)
    
    local targetNPC = creature:GetNearestCreature(50, NPC_TARGET)
    if targetNPC then
        CastSpellOnTarget(creature, targetNPC)
    end

    local additionalTargetNPC = creature:GetNearestCreature(50, NPC_ADDITIONAL_TARGET)
    if additionalTargetNPC then
        CastSpellOnTarget(creature, additionalTargetNPC)
    end
end

local function UndeadRogue_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function UndeadRogue_OnWaypointReached(event, creature)
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

local function UndeadRogue_OnDamageTaken(event, creature, attacker, damage)
    local healthPct = creature:GetHealthPct()
    if healthPct <= 30 and not creature:HasAura(SPELL_EVASION) then
        creature:CastSpell(creature, SPELL_EVASION, true)
    end
end

local function UndeadRogue_OnDied(event, creature, killer)
    creature:RemoveEvents()
    creature:DespawnOrUnsummon(10000)
end

RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 1, UndeadRogue_OnEnterCombat)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 2, UndeadRogue_OnLeaveCombat)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 4, UndeadRogue_OnDied)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 9, UndeadRogue_OnDamageTaken)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 6, UndeadRogue_OnWaypointReached)