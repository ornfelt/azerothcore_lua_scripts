local Setis = {}
Setis.spellQueue = {}

function Setis.SpawnCreatures(creature)
    local spawnNPCs = {15324, 15338, 15462}
    local spawnLocations = {
        {dist = 10, angle = 0},
        {dist = 10, angle = math.pi / 2.5},
        {dist = 10, angle = 2 * math.pi / 2.5},
        {dist = 10, angle = 3 * math.pi / 2.5},
        {dist = 10, angle = 4 * math.pi / 2.5}
    }

    local x, y, z, o = creature:GetLocation()
    for _, location in ipairs(spawnLocations) do
        local npc = spawnNPCs[math.random(#spawnNPCs)]
        local offsetX = location.dist * math.cos(location.angle)
        local offsetY = location.dist * math.sin(location.angle)
        local spawnedCreature = creature:SpawnCreature(npc, x + offsetX, y + offsetY, z, o, 2, 180000)

        -- Find nearby players and start attacking
        local nearbyPlayers = spawnedCreature:GetPlayersInRange(100) -- Get players within 100-yard range
        if #nearbyPlayers > 0 then
            local randomPlayer = nearbyPlayers[math.random(#nearbyPlayers)] -- Select a random player from the list
            spawnedCreature:AttackStart(randomPlayer) -- Start attacking the selected player
        end
    end
end


local function QueueSpell(spell, targetType, target, emote, sound)
    table.insert(Setis.spellQueue, {spell = spell, targetType = targetType, target = target, emote = emote, sound = sound})
end

local function ProcessSpellQueue(eventId, delay, calls, creature)
    if #Setis.spellQueue > 0 then
        local nextSpell = table.remove(Setis.spellQueue, 1)
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

local function CastEarthquake(eventId, delay, calls, creature)
    QueueSpell(19798, "victim", nil, nil, nil)
end

local function CastBellowingRoar(eventId, delay, calls, creature)
    QueueSpell(22686, "victim", nil, nil, nil)
end


local function CastEnrage(eventId, delay, calls, creature)
    if creature:HealthBelowPct(30) then
        QueueSpell(72525, "self", nil, "I am growing stronger!", nil)
    end
end

local function SpawnMinions(eventId, delay, calls, creature)
    Setis.SpawnCreatures(creature)
end

function CastMeteor(eventId, delay, calls, creature)
    local players = creature:GetPlayersInRange(100) -- Get players within 40-yard range
    if #players > 0 then
        local randomPlayer = players[math.random(#players)] 
        QueueSpell(28884, "target", randomPlayer, nil, nil) 
    end
end

local function OnEnterCombatSetis(event, creature, target)
    creature:SendUnitYell("Your doom is upon you!", 0)
	creature:RegisterEvent(SpawnMinions, 100, 1)
    creature:RegisterEvent(SpawnMinions, 36000, 0) -- Spawn minions every 20 seconds
    creature:RegisterEvent(CastShadowboltVolley, 20000, 0)
    creature:RegisterEvent(CastEarthquake, 15000, 0)
    creature:RegisterEvent(CastBellowingRoar, 13000, 0)
    creature:RegisterEvent(CastEnrage, 1000, 0)
	creature:RegisterEvent(CastMeteor, 30000, 0)
    creature:RegisterEvent(ProcessSpellQueue, 1000, 0)
end


local function OnLeaveCombatSetis(event, creature)
    creature:RemoveEvents()
end

local function OnDiedSetis(event, creature, killer)
    creature:SendUnitYell("My death is... only the beginning...", 0)
    creature:RemoveEvents()
end

RegisterCreatureEvent(14471, 1, OnEnterCombatSetis)
RegisterCreatureEvent(14471, 2, OnLeaveCombatSetis)
RegisterCreatureEvent(14471, 4, OnDiedSetis)