local GAME_EVENT_ID = 17 
local npcIds = {777, 790, 415, 956, 3356, 341, 793, 343, 342, 812, 1671, 10037, 859, 382, 1070, 931, 932, 903, 935, 68, 8991, 12480, 12481, 3479, 3483, 3477, 3486, 3478, 3431, 3481, 3482, 3464, 3489, 3432, 3480}
local secondNpcIds = {3088}
local thirdNpcIds = {3501, 3615} 
local EMOTE_ID = 333 -- 1h ready
local SECOND_EMOTE_ID = 214 -- rifle ready
local THIRD_EMOTE_ID = 375 -- 2h ready


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
            local npcs = player:GetCreaturesInRange(1000, npcId) 
			
            for _, npc in ipairs(npcs) do
                npc:EmoteState(emoteId)
            end
        end
    end
end

local function SetNpcsEmoteState(event, gameEventId)
    if gameEventId == GAME_EVENT_ID then
        local players = GetPlayersInWorld()
        ApplyEmoteToNpcs(players, npcIds, EMOTE_ID)
        ApplyEmoteToNpcs(players, secondNpcIds, SECOND_EMOTE_ID)
        ApplyEmoteToNpcs(players, thirdNpcIds, THIRD_EMOTE_ID) 
    end
end

local function ResetNpcsEmoteState(event, gameEventId)
    if gameEventId == GAME_EVENT_ID then
        local players = GetPlayersInWorld()
        ApplyEmoteToNpcs(players, npcIds, 0)
        ApplyEmoteToNpcs(players, secondNpcIds, 0)
        ApplyEmoteToNpcs(players, thirdNpcIds, 0) 
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
