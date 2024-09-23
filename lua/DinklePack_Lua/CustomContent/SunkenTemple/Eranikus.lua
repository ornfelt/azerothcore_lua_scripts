local Eranikus = {}
Eranikus.spellQueue = {}

function Eranikus.SpawnWhelps(creature)
    local spawnWhelps = {8319}
    local spawnLocations = {
        {dist = 7, angle = 0},
        {dist = 7, angle = math.pi / 3},
        {dist = 7, angle = 2 * math.pi / 3},
        {dist = 7, angle = math.pi},
        {dist = 7, angle = 4 * math.pi / 3}
    }

    local x, y, z, o = creature:GetLocation()
    for _, location in ipairs(spawnLocations) do
        local npc = spawnWhelps[math.random(#spawnWhelps)]
        local offsetX = location.dist * math.cos(location.angle)
        local offsetY = location.dist * math.sin(location.angle)
 local spawnedCreature = creature:SpawnCreature(npc, x + offsetX, y + offsetY, z, o, 2, 180000)
print("Spawned whelp:", spawnedCreature:GetEntry()) -- Add this line



        -- Find nearby players and start attacking
        local nearbyPlayers = spawnedCreature:GetPlayersInRange(40) -- Get players within 40-yard range
        if #nearbyPlayers > 0 then
            local randomPlayer = nearbyPlayers[math.random(#nearbyPlayers)] -- Select a random player from the list
            spawnedCreature:AttackStart(randomPlayer) -- Start attacking the selected player
        end
    end
end

local function QueueSpell(spell, targetType, target, emote, sound)
    table.insert(Eranikus.spellQueue, {spell = spell, targetType = targetType, target = target, emote = emote, sound = sound})
end

local function CastStun(eventId, delay, calls, creature)
    table.insert(Eranikus.spellQueue, {spell = 56, targetType = 'random', range = 40})
end

local function ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Eranikus.spellQueue > 0 then
        local nextSpell = table.remove(Eranikus.spellQueue, 1)
        local target

        if nextSpell.targetType == 'self' then
            target = creature
        elseif nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets(nextSpell.range or 0)
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, true)
        end
    end
end


local function CastAcidBreath(eventId, delay, calls, creature)
    QueueSpell(34268, "victim", nil, nil, nil)
end

local function CastNoxiousBreath(eventId, delay, calls, creature)
    QueueSpell(24818, "victim", nil, nil, nil)
end

local function CastDeepSlumber(eventId, delay, calls, creature)
    QueueSpell(12890, "victim", nil, nil, nil)
end

local function SpawnWhelps(eventId, delay, calls, creature)
    Eranikus.SpawnWhelps(creature)
end


local function AggroNearbyCreatures(creature)
    local npcIDs = {8319, 5283, 5277}
    
    for _, entryId in ipairs(npcIDs) do
        local creatures = creature:GetCreaturesInRange(1000, entryId) -- Get creatures within 1000-yard range with specified NPC ID
        
        for _, nearbyCreature in ipairs(creatures) do
            local players = nearbyCreature:GetPlayersInRange(40) -- Get players within 40-yard range
            if #players > 0 then
                local randomPlayer = players[math.random(#players)] -- Select a random player from the list
                nearbyCreature:AttackStart(randomPlayer) -- Start attacking the selected player
            end
        end
    end
end

local function OnEnterCombat(event, creature, target)
	creature:CallForHelp(150)
    creature:SetReactState(1)
    creature:SendUnitYell("You dare disturb my slumber? Face my wrath!", 0)
    creature:RegisterEvent(SpawnWhelps, 100, 1)
    creature:RegisterEvent(SpawnWhelps, 24000, 0) -- Spawn whelps every 24 seconds
    creature:RegisterEvent(CastAcidBreath, 10000, 0) -- Cast Acid Breath every 10 seconds
    creature:RegisterEvent(CastNoxiousBreath, 15000, 0) -- Cast Noxious Breath every 15 seconds
    creature:RegisterEvent(CastDeepSlumber, 20000, 0) -- Cast Deep Slumber every 20 seconds

    -- Cast Stun on a random player every 25 seconds with a 50% chance
    if math.random() <= 0.5 then
        creature:RegisterEvent(CastStun, 25000, 0)
    end

    creature:RegisterEvent(ProcessSpellQueue, 1000, 0) -- Process the spell queue every 1 second
    AggroNearbyCreatures(creature) -- Aggro nearby creatures with specified NPC IDs
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:SendUnitYell("The... nightmare... continues...", 0)
creature:RemoveEvents()
end

RegisterCreatureEvent(5709, 1, OnEnterCombat)
RegisterCreatureEvent(5709, 2, OnLeaveCombat)
RegisterCreatureEvent(5709, 4, OnDied)


local function OnCreature5710Died(event, creature, killer)
    local eranikus = creature:GetMap():GetWorldObject(5709) -- Get Eranikus by its NPC ID
    if eranikus then
        eranikus:SetNPCFlags(0) -- Make Eranikus selectable and attackable
        eranikus:SetReactState(1)
    end
end

RegisterCreatureEvent(5710, 4, OnCreature5710Died) -- Register the death event for the creature with NPC ID 5710

local function OnEranikusSpawn(event, creature)
    creature:SetNPCFlags(2) -- Make Eranikus non-selectable by default
    creature:SetReactState(0)
end


RegisterCreatureEvent(5709, 5, OnEranikusSpawn) -- Register the spawn event for Eranikus