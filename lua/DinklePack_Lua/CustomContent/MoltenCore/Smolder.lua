local Smolder = {}
Smolder.spellQueue = {}
Smolder.flameTsunamisEnabled = true -- Flame Tsunamis enabled by default


function ToggleFlameTsunamis(event, player, message, type, lang)
    if player:IsGM() then -- Check if the player has GM privileges
        if message == "tsunami on" then
            Smolder.flameTsunamisEnabled = true
            player:SendBroadcastMessage("Flame Tsunamis have been enabled.")
            return false
        elseif message == "tsunami off" then
            Smolder.flameTsunamisEnabled = false
            player:SendBroadcastMessage("Flame Tsunamis have been disabled.")
            return false
        end
    else
     --   player:SendBroadcastMessage("You do not have permission to use this command.")
    end
end
-- Ngl, this was a pain in the ass to script out.

--Defines preset positions for Flame Tsunamis to spawn. Flame Tsunamis are invisible creatures with auras added to them to look like walls of flame. 
function Smolder.SpawnCreatures(creature)
    local spawnLocations = {
        {npc = 83006, x = 839.37, y = -787.032, z = -227.45, o = 1.678}, 
        {npc = 83007, x = 805.319, y = -808.98, z = -228.176, o = 2.75}, 
        {npc = 83008, x = 847.4, y = -847.4, z = -229.12, o = 5.034}, 
        {npc = 83009, x = 849.7, y = -912.85, z = -227.85, o = 4.88}, 
        {npc = 83010, x = 897.17, y = -783.51, z = -228.29, o = 0.168},
        {npc = 83011, x = 907.66, y = -823.255, z = -228.336, o = 0.23},
        {npc = 83012, x = 811.47, y = -911.095, z = -226.18, o = 4.48},
		{npc = 83013, x = 757.92, y = -856.6, z = -224.29, o = 3.4},
		{npc = 83014, x = 747.76, y = -803.45, z = -226.14, o = 2.97},
		{npc = 83015, x = 771.34, y = -679, z = -213.04, o = 0.771},
		{npc = 83016, x = 770.67, y = -754.96, z = -220.55, o = 2.67},
    }
    for _, location in ipairs(spawnLocations) do
        creature:SpawnCreature(location.npc, location.x, location.y, location.z, location.o, 2, 6000) -- they spawn for 6 seconds. 2 is the spawntype. 2, // despawns after a specified time OR when the creature dies
    end
end

function Smolder.SpawnCreaturesTwo(creature)
    local spawnLocations = {
		{npc = 83017, x = 769, y = -682.53, z = -212.76, o = 4.04}, -- These are all set at the same position to block the entrance so players do not take Smolder outside. 
		{npc = 83018, x = 769, y = -682.53, z = -212.76, o = 4.04},
		{npc = 83019, x = 769, y = -682.53, z = -212.76, o = 4.04},
		{npc = 83020, x = 769, y = -682.53, z = -212.76, o = 4.04},
    }
    for _, location in ipairs(spawnLocations) do
        creature:SpawnCreature(location.npc, location.x, location.y, location.z, location.o, 2, 600000) -- they persist for a long time
    end
end

local function QueueSpell(spell, targetType, target, emote, sound) -- similar spell que system as Magmadar
    table.insert(Smolder.spellQueue, {spell = spell, targetType = targetType, target = target, emote = emote, sound = sound})
end

local function ProcessSpellQueue(eventId, delay, calls, creature)
    if #Smolder.spellQueue > 0 then
        local nextSpell = table.remove(Smolder.spellQueue, 1)
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
local function CastFlameBreath(eventId, delay, calls, creature)
    if creature:HealthBelowPct(15) then
        QueueSpell(23341, "victim", nil, nil, nil)
    end
end

local function CastCharredEarth(eventId, delay, calls, creature) -- Charred earth. Could have added to spell que system but didn't. This aoe effect persists on the ground for 1 minute.
    if isCastingSummonElemental then return end
    local targets = creature:GetAITargets()
    local meleeTarget, rangedTarget
    
    for _, target in pairs(targets) do -- targets one melee and one ranged.
        if not meleeTarget or not rangedTarget then
            local distance = creature:GetDistance(target)
            if distance <= 5 and not meleeTarget then
                meleeTarget = target
            elseif distance > 5 and not rangedTarget then
                rangedTarget = target
            end
        else
            break
        end
    end

    if meleeTarget then
        creature:CastSpell(meleeTarget, 80085, false)
    end

    if rangedTarget then
        creature:CastSpell(rangedTarget, 80085, false)
    end
end


local function CastPyroblast(eventId, delay, calls, creature) -- casts pyroblast on random targets 
    if isCastingSummonElemental then return end
    local targets = creature:GetAITargets()
    local validTargets = {}

    for _, target in pairs(targets) do
        
        table.insert(validTargets, target)
    end

    if #validTargets > 0 then
        for i = 1, 3 do
            local targetCount = #validTargets
            local randomTarget = math.random(1, targetCount)
            creature:CastSpell(validTargets[randomTarget], 27132, true)
        end
    end
end


local function CastSmolderBomb(eventId, delay, calls, creature) -- casts Smolder Bomb on random target
    if isCastingSummonElemental then return end
    local targets = creature:GetAITargets()
    local validTargets = {}

    for _, target in pairs(targets) do
        -- Removed the condition that checks if the target is a player
        table.insert(validTargets, target)
    end

    if #validTargets > 0 then
        for i = 1, 3 do
            local targetCount = #validTargets
            local randomTarget = math.random(1, targetCount)
            creature:CastSpell(validTargets[randomTarget], 80001, true)
        end
    end
end

local function CastSummonElemental(eventId, delay, calls, creature) -- periodically summons elementals
    QueueSpell(364728, "self", nil, "Minions of fire, rise and serve your master!", 20422)
	creature:PlayDirectSound(183258)
end

local function CastTailSweep(eventId, delay, calls, creature) -- periodically casts tail sweep
    QueueSpell(52144, "victim", nil, nil, nil)
end

local function CastScorch(eventId, delay, calls, creature) -- Casts Scorch on tank
    QueueSpell(42858, "victim", nil, nil, nil)
end

local function CastBellowingRoar(eventId, delay, calls, creature) -- casts aoe fear with emote
    QueueSpell(22686, "self", nil, "Feel the power of my roar!", 20421)
	creature:PlayDirectSound(183257)
end

local function OnEnterCombat(event, creature, target)
    if Smolder.flameTsunamisEnabled then
        creature:SendUnitYell("Feel the heat of my flame and know your end is near!", 0)
        creature:PlayDirectSound(183256)
        creature:RegisterEvent(function(event, delay, calls, capturedCreature) 
            Smolder.SpawnCreatures(capturedCreature)
        end, 25000, 0, creature)
        creature:RegisterEvent(function(event, delay, calls, capturedCreature)
            Smolder.SpawnCreatures(capturedCreature)
        end, 3000, 1, creature)
        creature:RegisterEvent(function(event, delay, calls, capturedCreature)
            Smolder.SpawnCreaturesTwo(capturedCreature)
        end, 100, 1, creature)
    end
	creature:RegisterEvent(CastSmolderBomb, 15000, 0)
    creature:RegisterEvent(CastScorch, 6000, 0)
    creature:RegisterEvent(CastFlameBreath, 13000, 0)
    creature:RegisterEvent(CastCharredEarth, 10000, 0)
    creature:RegisterEvent(CastPyroblast, 10000, 0)
    creature:RegisterEvent(CastSummonElemental, 43500, 0)
creature:RegisterEvent(CastTailSweep, 8000, 0)
creature:RegisterEvent(CastBellowingRoar, 31000, 0)
creature:RegisterEvent(ProcessSpellQueue, 1000, 0)
end

function Smolder.DespawnCreatures(creature) -- Despawns any flame tsunamis. I set this for on death and on leave combat
    local creatureEntryList = {83006, 83007, 83008, 83009, 83010, 83011, 83012, 83013, 83014, 83015, 83016, 83017, 83018, 83019, 83020, 387570, 12265}
    for _, entry in ipairs(creatureEntryList) do
        local nearbyCreatures = creature:GetCreaturesInRange(1000, entry) -- searches for them within 1000 yards
        for _, nearbyCreature in ipairs(nearbyCreatures) do
            if not nearbyCreature:IsInCombat() then -- this could probably be removed
                nearbyCreature:DespawnOrUnsummon(0) -- 0 is to despawn immediately
            end
        end
    end
end


local function OnLeaveCombat(event, creature)
    Smolder.DespawnCreatures(creature) -- despawns Tsunamis
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:SendUnitYell("My fire...extinguished...", 0)
    creature:PlayDirectSound(183259)
    Smolder.DespawnCreatures(creature)
    creature:RemoveEvents()
end

-- enrage function to check health each time damage is taken. Used to have him cast a spell but removed it as the fight was too hard.
local function OnDamageTaken(event, creature, attacker, damage)
if (creature:HealthBelowPct(20) and not Smolder.healthCheck) then
creature:SendUnitYell("My power is waning, but I will fight until my last flame burns out!", 0)
Smolder.healthCheck = true
end
end

local function OnSpawn(event, creature)
creature:SetMaxPower(0, 14379003) -- sets his mana so he can cast spells. I could have changed his class type in creature template to give him mana but this is better imo
end

RegisterCreatureEvent(83001, 1, OnEnterCombat)
RegisterCreatureEvent(83001, 2, OnLeaveCombat)
RegisterCreatureEvent(83001, 4, OnDied)
RegisterCreatureEvent(83001, 9, OnDamageTaken)
RegisterCreatureEvent(83001, 5, OnSpawn)
RegisterPlayerEvent(18, ToggleFlameTsunamis) -- 18 is for chat command events

