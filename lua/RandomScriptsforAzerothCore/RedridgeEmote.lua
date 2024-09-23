local GAME_EVENT_ID = 17 -- Set the game event ID
local npcIds = {777, 790, 415, 956, 3356, 341, 793, 343, 342, 812, 1671, 10037, 859, 382, 1070, 931, 932, 903, 935, 68, 12480, 12481} -- Add your NPC entries here
local secondNpcIds = {3088} -- Add your second set of NPC entries here
local EMOTE_ID = 333 -- Set the emote ID
local SECOND_EMOTE_ID = 214 -- Set the second emote ID


local function IsGameEventActive(eventId)
    local activeEvents = GetActiveGameEvents()
    for _, event in ipairs(activeEvents) do
        if event == eventId then
            return true
        end
    end
    return false
end

local function ApplyEmoteToNpcs(players, npcIds, emoteId)
    for _, player in ipairs(players) do
        for _, npcId in ipairs(npcIds) do
            local npcs = player:GetCreaturesInRange(1000, npcId) -- Get creatures within a radius of 1000 units
			
            for _, npc in ipairs(npcs) do
                npc:EmoteState(emoteId)
            end
        end
    end
end

local function SetNpcsEmoteState(event, gameEventId)
    if gameEventId == GAME_EVENT_ID then
        local players = GetPlayersInWorld() -- Get all players in the world
        ApplyEmoteToNpcs(players, npcIds, EMOTE_ID)
        ApplyEmoteToNpcs(players, secondNpcIds, SECOND_EMOTE_ID)
    end
end

local function ResetNpcsEmoteState(event, gameEventId)
    if gameEventId == GAME_EVENT_ID then
        local players = GetPlayersInWorld() -- Get all players in the world
        ApplyEmoteToNpcs(players, npcIds, 0) -- Reset emote state for the first set of NPCs
        ApplyEmoteToNpcs(players, secondNpcIds, 0) -- Reset emote state for the second set of NPCs
    end
end


local function OnPlayerMapChange(event, player, newMap, newZone)
    if IsGameEventActive(GAME_EVENT_ID) then
        ApplyEmoteToNpcs({player}, npcIds, EMOTE_ID)
        ApplyEmoteToNpcs({player}, secondNpcIds, SECOND_EMOTE_ID)
    end
end

RegisterPlayerEvent(27, OnPlayerMapChange)
RegisterServerEvent(34, SetNpcsEmoteState)
RegisterServerEvent(35, ResetNpcsEmoteState)
