local GAME_EVENT_ID = 17 -- Set the game event ID
local npcIds = {3085, 841, 348, 8965, 1678, 8962, 8963, 5608, 5607, 847, 791, 381, 3361, 789, 5620, 3089, 9982, 6727, 6166, 379, 346, 1680} -- Add your NPC entries here
local targetLocations = {
    {x = -9195.19, y = -2157.19, z = 57.186},
    {x = -9201.69, y = -2147.54, z = 71.211},
    {x = -9231.74, y = -2148.622, z = 71.211}
} -- Set the target locations

local function IsGameEventActive(eventId)
    local activeEvents = GetActiveGameEvents()
    for _, event in ipairs(activeEvents) do
        if event == eventId then
            return true
        end
    end
    return false
end

local function MoveNpcsToLocation(event, gameEventId)
    if gameEventId == GAME_EVENT_ID then
        local players = GetPlayersInWorld() -- Get all players in the world
        for _, player in ipairs(players) do
            for _, npcId in ipairs(npcIds) do
                local npcs = player:GetCreaturesInRange(1000, npcId) -- Get creatures within a radius of 1000 units from the player
                for _, npc in ipairs(npcs) do
                    local targetLocation = targetLocations[math.random(#targetLocations)] -- Choose a random target location
                    local randomX = targetLocation.x + math.random(-2, 2)
                    local randomY = targetLocation.y + math.random(-2, 2)
                    npc:MoveTo(0, randomX, randomY, targetLocation.z, true)
                end
            end
        end
    end
end

local function DespawnNpcs(event, gameEventId)
    if gameEventId == GAME_EVENT_ID then
        local players = GetPlayersInWorld() -- Get all players in the world
        for _, player in ipairs(players) do
            for _, npcId in ipairs(npcIds) do
                local npcs = player:GetCreaturesInRange(1000, npcId) -- Get creatures within a radius of 1000 units from the player
                for _, npc in ipairs(npcs) do
                    npc:DespawnOrUnsummon()
					npc:Respawn()
                    npc:MoveWaypoint()
                end
            end
        end
    end
end

local PLAYER_EVENT_ON_MAP_CHANGE = 27

local function MoveNpcsToLocationForPlayer(player)
    for _, npcId in ipairs(npcIds) do
        local npcs = player:GetCreaturesInRange(1000, npcId) -- Get creatures within a radius of 1000 units from the player
        for _, npc in ipairs(npcs) do
            local targetLocation = targetLocations[math.random(#targetLocations)] -- Choose a random target location
            local randomX = targetLocation.x + math.random(-2, 2)
            local randomY = targetLocation.y + math.random(-2, 2)
            npc:MoveTo(0, randomX, randomY, targetLocation.z, true)
        end
    end
end

local function OnPlayerMapChange(event, player, newMap, newZone)
    if IsGameEventActive(GAME_EVENT_ID) then
        MoveNpcsToLocationForPlayer(player)
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_MAP_CHANGE, OnPlayerMapChange)
RegisterServerEvent(34, MoveNpcsToLocation)
RegisterServerEvent(35, DespawnNpcs)
