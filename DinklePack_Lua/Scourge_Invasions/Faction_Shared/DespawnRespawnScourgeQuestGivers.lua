local GAME_EVENT_ID = {17, 92} -- Set the game event IDs
local npcIdsscourgestart = {344, 12480, 1284, 400064, 234, 3429} -- Add your NPC entries here
local BROADCAST_MESSAGE = "The Scourge are attacking the people of Azeroth. Quickly adventurers, prepare yourselves for battle!"
local SOUND_ID = 13363
local excludedZones = {44} -- Replace these with the zone IDs where you don't want the sound to play

ScourgeInvasion = {}

ScourgeInvasion.YELL_MESSAGES = {
    "The Scourge have come!",
    "Beware, the Scourge approaches!",
    "Defend our home, the Scourge is upon us!",
    "To arms, the Scourge is here!",
    "All fighters ready the assault against the Scourge.",
    "The Scourge invasion has begun!",
    "The Lich Kings minions have come! Rally against the Scourge!",
    "The Scourge dares to attack us!",
    "Show the Scourge the might of the people of Azeroth!"
}

local function YellRandomMessage(npc)
    local messageIndex = math.random(1, #ScourgeInvasion.YELL_MESSAGES)
    npc:SendUnitYell(ScourgeInvasion.YELL_MESSAGES[messageIndex], 0)
end

local function valueExists(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function ScourgeInvasion.DespawnAndRespawnNpcs(event, gameEventId)
    if valueExists(GAME_EVENT_ID, gameEventId) then
        local players = GetPlayersInWorld() -- Get all players in the world
        if event == 34 then -- Game Event Start
            SendWorldMessage(BROADCAST_MESSAGE, 2) -- Broadcast the message with chat type 2 (SYSTEM)
            for _, player in ipairs(players) do
                local playerZoneId = player:GetZoneId()
                if not valueExists(excludedZones, playerZoneId) then
                    player:PlayDirectSound(SOUND_ID) -- Play the sound for each player
                end
            end
        end
        for _, player in ipairs(players) do
            for _, npcId in ipairs(npcIdsscourgestart) do
                local npcs = player:GetCreaturesInRange(1000, npcId) -- Get creatures within a radius of 1000 units from the player
                for _, npc in ipairs(npcs) do
                    if event == 34 then -- Game Event Start
                        YellRandomMessage(npc)
                    end
                    npc:DespawnOrUnsummon()
                    npc:Respawn()
                end
            end
        end
    end
end

RegisterServerEvent(34, ScourgeInvasion.DespawnAndRespawnNpcs) 
RegisterServerEvent(35, ScourgeInvasion.DespawnAndRespawnNpcs) 
