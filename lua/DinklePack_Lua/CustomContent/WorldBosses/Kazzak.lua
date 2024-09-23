local Kazzak = {}
Kazzak.spellQueue = {}

function Kazzak.SpawnCreatures(creature)
    local spawnNPCs = {12396, 8717, 8718}
    local spawnLocations = {
        {dist = 7, angle = 0},
        {dist = 7, angle = math.pi / 3},
        {dist = 7, angle = 2 * math.pi / 3},
        {dist = 7, angle = math.pi},
        {dist = 7, angle = 4 * math.pi / 3},
        {dist = 7, angle = 5 * math.pi / 3}
    }

    local x, y, z, o = creature:GetLocation()
    for _, location in ipairs(spawnLocations) do
        local npc = spawnNPCs[math.random(#spawnNPCs)]
        local offsetX = location.dist * math.cos(location.angle)
        local offsetY = location.dist * math.sin(location.angle)
        local spawnedCreature = creature:SpawnCreature(npc, x + offsetX, y + offsetY, z, o, 2, 180000)

        -- Find nearby players and start attacking
        local nearbyPlayers = spawnedCreature:GetPlayersInRange(40) -- Get players within 40-yard range
        if #nearbyPlayers > 0 then
            local randomPlayer = nearbyPlayers[math.random(#nearbyPlayers)] -- Select a random player from the list
            spawnedCreature:AttackStart(randomPlayer) -- Start attacking the selected player
        end
    end
end


local function QueueSpell(spell, targetType, target, emote, sound)
    table.insert(Kazzak.spellQueue, {spell = spell, targetType = targetType, target = target, emote = emote, sound = sound})
end

local function ProcessSpellQueue(eventId, delay, calls, creature)
    if #Kazzak.spellQueue > 0 then
        local nextSpell = table.remove(Kazzak.spellQueue, 1)
        local target = nextSpell.target

        if nextSpell.targetType == "self" then
            target = creature
        elseif nextSpell.targetType == "victim" then
            target = creature:GetVictim()
        end

        creature:CastSpell(target, nextSpell.spell, true)

        if nextSpell.emote then
            creature:SendUnitYell(nextSpell.emote, 0)
        end

        if nextSpell.sound then
            creature:PlayDirectSound(nextSpell.sound)
        end
    end
end

-- Updated spell casting functions to use the spell queue system
local function CastShadowboltVolley(eventId, delay, calls, creature)
    QueueSpell(21341, "victim", nil, nil, nil)
end

local function CastCleave(eventId, delay, calls, creature)
    QueueSpell(20691, "victim", nil, nil, nil)
end

local function CastThunderclap(eventId, delay, calls, creature)
    QueueSpell(26554, "victim", nil, nil, nil)
end

local function CastVoidBolt(eventId, delay, calls, creature)
    QueueSpell(22709, "victim", nil, nil, nil)
end

local function CastEnrage(eventId, delay, calls, creature)
    if creature:HealthBelowPct(30) then
        QueueSpell(72525, "self", nil, "I am growing stronger!", nil)
    end
end

local function SpawnMinions(eventId, delay, calls, creature)
    Kazzak.SpawnCreatures(creature)
end

function CastMarkOfKazzak(eventId, delay, calls, creature)
    local players = creature:GetPlayersInRange(100) -- Get players within 40-yard range
    if #players > 0 then
        local randomPlayer = players[math.random(#players)] -- Select a random player from the list
        QueueSpell(21058, "target", randomPlayer, nil, nil) -- Queue Mark of Kazzak
    end
end

local function KazzakOnEnterCombat(event, creature, target)
    creature:SendUnitYell("All mortals will perish!", 0)
	creature:RegisterEvent(SpawnMinions, 100, 1)
    creature:RegisterEvent(SpawnMinions, 24000, 0) -- Spawn minions every 20 seconds
    creature:RegisterEvent(CastShadowboltVolley, 10000, 0)
    creature:RegisterEvent(CastCleave, 7000, 0)
    creature:RegisterEvent(CastThunderclap, 13000, 0)
    creature:RegisterEvent(CastVoidBolt, 17000, 0)
    creature:RegisterEvent(CastEnrage, 1000, 0)
	creature:RegisterEvent(CastMarkOfKazzak, 30000, 0)
    creature:RegisterEvent(ProcessSpellQueue, 1000, 0)
end


local function KazzakOnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function KazzakOnDied(event, creature, killer)
    creature:SendUnitYell("Your victory is... temporary...", 0)
    creature:RemoveEvents()
end

RegisterCreatureEvent(12397, 1, KazzakOnEnterCombat)
RegisterCreatureEvent(12397, 2, KazzakOnLeaveCombat)
RegisterCreatureEvent(12397, 4, KazzakOnDied)