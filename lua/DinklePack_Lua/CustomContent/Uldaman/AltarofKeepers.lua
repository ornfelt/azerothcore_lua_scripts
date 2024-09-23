local Stonekeepers = {}

Stonekeepers.NPC_ID = 4857
Stonekeepers.ALTAR_ID = 130511
Stonekeepers.HOSTILE_FACTION = 14 
Stonekeepers.DOOR_ID = 124367

local function BecomingHostile(target, stonekeeper, attack)
    if stonekeeper and stonekeeper:IsAlive() and not stonekeeper:IsInCombat() then
        stonekeeper:SetFaction(Stonekeepers.HOSTILE_FACTION)
        stonekeeper:SetReactState(1) 
        if attack then
            stonekeeper:AttackStart(target)
        else
            stonekeeper:SetInCombatWith(target) 
        end
    end
end

local function compareDistance(a, b)
    return a.distance < b.distance
end

local function getSortedStonekeepers(target, stonekeepers)
    local sortedStonekeepers = {}
    for _, stonekeeper in ipairs(stonekeepers) do
        table.insert(sortedStonekeepers, {creature = stonekeeper, distance = target:GetDistance(stonekeeper)})
    end
    table.sort(sortedStonekeepers, compareDistance)
    return sortedStonekeepers
end

local function getNearestTarget(creature, range)
    local nearestTarget = nil
    local minDistance = math.huge
    local targets = creature:GetPlayersInRange(range)
    for _, target in ipairs(targets) do
        local distance = creature:GetDistance(target)
        if distance < minDistance then
            minDistance = distance
            nearestTarget = target
        end
    end
    return nearestTarget
end

function Stonekeepers.OnDied(event, creature)
    local nearestTarget = getNearestTarget(creature, 100)
    if not nearestTarget then return end
    
    local stonekeepers = nearestTarget:GetCreaturesInRange(100, Stonekeepers.NPC_ID)
    local sortedStonekeepers = getSortedStonekeepers(nearestTarget, stonekeepers)
    local aliveCount = 0

    for _, stonekeeperData in ipairs(sortedStonekeepers) do
        local stonekeeper = stonekeeperData.creature
        if stonekeeper:IsAlive() then
            aliveCount = aliveCount + 1
            if not stonekeeper:IsInCombat() then
                BecomingHostile(nearestTarget, stonekeeper, true)
                break
            end
        end
    end

    if aliveCount == 0 then
        local door = creature:GetNearObjects(100, 5, Stonekeepers.DOOR_ID)
        if door and door[1] then
            door[1]:UseDoorOrButton(1)
        end
    end
end

function Stonekeepers.AltarOfTheKeepersUse(event, go, player)
    if not player:IsInCombat() then
        player:SendBroadcastMessage("The Stonekeepers are waking up...")

        local stonekeepers = player:GetCreaturesInRange(100, Stonekeepers.NPC_ID)
        local sortedStonekeepers = getSortedStonekeepers(player, stonekeepers)

        for i, stonekeeperData in ipairs(sortedStonekeepers) do
            local stonekeeper = stonekeeperData.creature
            if i == 1 then
                BecomingHostile(player, stonekeeper, true)
            else
                BecomingHostile(player, stonekeeper, false)
            end
        end
    else
        player:SendBroadcastMessage("You cannot use the Altar of the Keepers while in combat.")
    end
    return true
end

RegisterGameObjectEvent(Stonekeepers.ALTAR_ID, 14, Stonekeepers.AltarOfTheKeepersUse)
RegisterCreatureEvent(Stonekeepers.NPC_ID, 4, Stonekeepers.OnDied)
