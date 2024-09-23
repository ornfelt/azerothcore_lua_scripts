UndeadRogueModule = {}

local NPC_UNDEAD_ROGUE = 400114
local NPC_TARGET = 3338
local NPC_ADDITIONAL_TARGET = 70000
local NPC_HUT_FIRE = 29692

local SPELLS = {
    SINISTER_STRIKE = 1752,
    EVASION = 5277,
    GOUGE = 12540,
    CAST_DEATH = 5
}

local FIRE_SPAWN_CHANCE = 20
local FIRE_SPAWN_RADIUS = 20
local FIRE_DESPAWN_TIME = 600000

local NEAREST_CREATURE_DISTANCE = 50
local DESPAWN_TIME_AFTER_DEATH = 10000

local function castSpell(creature, target, spellId)
    creature:CastSpell(target, spellId, true)
end

local function CastSinisterStrike(eventId, delay, calls, creature)
    castSpell(creature, creature:GetVictim(), SPELLS.SINISTER_STRIKE)
end

local function CastGouge(eventId, delay, calls, creature)
    castSpell(creature, creature:GetVictim(), SPELLS.GOUGE)
end

local function CastSpellOnTarget(creature, targetNPC)
    castSpell(creature, targetNPC, SPELLS.CAST_DEATH)
end

function UndeadRogueModule.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastSinisterStrike, math.random(4000, 6000), 0)
    creature:RegisterEvent(CastGouge, math.random(14000, 18000), 0)
    
    local targetNPC = creature:GetNearestCreature(NEAREST_CREATURE_DISTANCE, NPC_TARGET)
    if targetNPC then
        CastSpellOnTarget(creature, targetNPC)
    end

    local additionalTargetNPC = creature:GetNearestCreature(NEAREST_CREATURE_DISTANCE, NPC_ADDITIONAL_TARGET)
    if additionalTargetNPC then
        CastSpellOnTarget(creature, additionalTargetNPC)
    end
end

function UndeadRogueModule.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function UndeadRogueModule.OnWaypointReached(event, creature)
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

function UndeadRogueModule.OnDamageTaken(event, creature, attacker, damage)
    local healthPct = creature:GetHealthPct()
    if healthPct <= 30 and not creature:HasAura(SPELLS.EVASION) then
        castSpell(creature, creature, SPELLS.EVASION)
    end
end

function UndeadRogueModule.OnDied(event, creature, killer)
    creature:RemoveEvents()
    creature:DespawnOrUnsummon(DESPAWN_TIME_AFTER_DEATH)
end

RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 1, UndeadRogueModule.OnEnterCombat)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 2, UndeadRogueModule.OnLeaveCombat)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 4, UndeadRogueModule.OnDied)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 9, UndeadRogueModule.OnDamageTaken)
RegisterCreatureEvent(NPC_UNDEAD_ROGUE, 6, UndeadRogueModule.OnWaypointReached)
