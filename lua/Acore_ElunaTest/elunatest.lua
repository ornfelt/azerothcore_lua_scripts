--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 29/10/2021
-- Time: 20:36
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


-- Test Eluna hooks in Azerothcore
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE: - compile the core with ElunaLua module
--              - add this script to ../lua_scripts/
------------------------------------------------------------------------------------------------
-- USAGE:       - Create a Human Warlock named Luatest and login
--              - Wait
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- Config
------------------------------------------------------------------------------------------------

local combatNpcEntry = 299
local gossipNpcEntry = 1199000

local nonExistantCreatureEvents = {11,16,17,18,25,28,29,32,33 }     -- in the range of 1-37
local nonExistantPlayerEvents = {40,41}                             -- in the range of 1-43


------------------------------------------------------------------------------------------------
-- /Config
------------------------------------------------------------------------------------------------

local cancelEvent
local nextTest = 1
local ChromieObject
local ChromieGuid

local testsDone = {}
local startupTime = tostring(GetGameTime())

-- Creature Init:
local creatureFunctionTested = {}

--init all functions untested
for n = 1,37,1 do
    creatureFunctionTested[n] = 0
end

--hardcoded marking as done what doesn't exist
local function solveNonExistantCreatureEvents()
    for _,value in ipairs(nonExistantCreatureEvents) do
        creatureFunctionTested[value] = 1
    end
end

solveNonExistantCreatureEvents()

-- Player Init:
local playerFunctionTested = {}
local status_EVENT = {}
local n

--init all functions untested
for n = 1,43,1 do
    playerFunctionTested[n] = 0
    status_EVENT[n] = nil
end

--hardcoded marking as done what doesn't exist
local function solveNonExistantPlayerEvents()
    for _,value in ipairs(nonExistantPlayerEvents) do
        playerFunctionTested[value] = 1
    end
end

solveNonExistantPlayerEvents()

local function log(line, chatHandler, logToConsole)
    local f = io.open(debug.getinfo(1).source:match("@?(.*/)").."/"..startupTime.."_luatest.log", "a")
    f:write(line)
    f:write("\n")
    f:close()

    if logToConsole == nil or logToConsole == true then
        if chatHandler ~= nil then
            chatHandler:SendSysMessage("[LuaTest] " .. line)
        else
            print("[LuaTest] " .. line)
        end
    end
end

------------------------------------------------------------------------------------------------
-- PLAYEREVENTS
------------------------------------------------------------------------------------------------

PLAYER_EVENT_ON_CHARACTER_CREATE = 1        --(event, player)
PLAYER_EVENT_ON_CHARACTER_DELETE = 2        --(event, guid)
PLAYER_EVENT_ON_LOGIN = 3                   --(event, player)
PLAYER_EVENT_ON_LOGOUT = 4                  --(event, player)
PLAYER_EVENT_ON_SPELL_CAST = 5              --(event, player, spell, skipCheck)
PLAYER_EVENT_ON_KILL_PLAYER = 6             --(event, killer, killed)
PLAYER_EVENT_ON_KILL_CREATURE = 7           --(event, killer, killed)
PLAYER_EVENT_ON_KILLED_BY_CREATURE = 8      --(event, killer, killed)
PLAYER_EVENT_ON_DUEL_REQUEST = 9            --(event, target, challenger)
PLAYER_EVENT_ON_DUEL_START = 10             --(event, player1, player2)
PLAYER_EVENT_ON_DUEL_END = 11               --(event, winner, loser, type)
PLAYER_EVENT_ON_GIVE_XP = 12                --(event, player, amount, victim) - Can return new XP amount
PLAYER_EVENT_ON_LEVEL_CHANGE = 13           --(event, player, oldLevel)
PLAYER_EVENT_ON_MONEY_CHANGE = 14           --(event, player, amount) - Can return new money amount
PLAYER_EVENT_ON_REPUTATION_CHANGE = 15      --(event, player, factionId, standing, incremental) - Can return new standing
PLAYER_EVENT_ON_TALENTS_CHANGE = 16         --(event, player, points)
PLAYER_EVENT_ON_TALENTS_RESET = 17          --(event, player, noCost)
PLAYER_EVENT_ON_CHAT = 18                   --(event, player, msg, Type, lang) - Can return false, newMessage
PLAYER_EVENT_ON_WHISPER = 19                --(event, player, msg, Type, lang, receiver) - Can return false, newMessage
PLAYER_EVENT_ON_GROUP_CHAT = 20             --(event, player, msg, Type, lang, group) - Can return false, newMessage
PLAYER_EVENT_ON_GUILD_CHAT = 21             --(event, player, msg, Type, lang, guild) - Can return false, newMessage
PLAYER_EVENT_ON_CHANNEL_CHAT = 22           --(event, player, msg, Type, lang, channel) - Can return false, newMessage
PLAYER_EVENT_ON_EMOTE = 23                  --(event, player, emote) - Not triggered on any known emote
PLAYER_EVENT_ON_TEXT_EMOTE = 24             --(event, player, textEmote, emoteNum, guid)
PLAYER_EVENT_ON_SAVE = 25                   --(event, player)
PLAYER_EVENT_ON_BIND_TO_INSTANCE = 26       --(event, player, difficulty, mapid, permanent)
PLAYER_EVENT_ON_UPDATE_ZONE = 27            --(event, player, newZone, newArea)
PLAYER_EVENT_ON_MAP_CHANGE = 28             --(event, player)
-- Custom
PLAYER_EVENT_ON_EQUIP = 29                  --(event, player, item, bag, slot)
PLAYER_EVENT_ON_FIRST_LOGIN = 30            --(event, player)
PLAYER_EVENT_ON_CAN_USE_ITEM = 31           --(event, player, itemEntry) - Can return InventoryResult enum value
PLAYER_EVENT_ON_LOOT_ITEM = 32              --(event, player, item, count)
PLAYER_EVENT_ON_ENTER_COMBAT = 33           --(event, player, enemy)
PLAYER_EVENT_ON_LEAVE_COMBAT = 34           --(event, player)
PLAYER_EVENT_ON_REPOP = 35                  --(event, player)
PLAYER_EVENT_ON_RESURRECT = 36              --(event, player)
PLAYER_EVENT_ON_LOOT_MONEY = 37             --(event, player, amount)
PLAYER_EVENT_ON_QUEST_ABANDON = 38          --(event, player, questId)
PLAYER_EVENT_ON_LEARN_TALENTS = 39          --(event, player, talentId, talentRank, spellid)
-- UNUSED                     = 40          --(event, player)
-- UNUSED                     = 41          --(event, player)
PLAYER_EVENT_ON_COMMAND = 42                --(event, player, command, chatHandler) - player is nil if command used from console. Can return false
PLAYER_EVENT_ON_PET_SPAWNED = 43            --(event, player, pet)

local function function_PLAYER_EVENT_ON_CHARACTER_CREATE(event, player)
    playerFunctionTested[1] = 1
    print('PLAYER_EVENT_ON_CHARACTER_CREATE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_CHARACTER_DELETE(event, guid)
    playerFunctionTested[2] = 1
    print('PLAYER_EVENT_ON_CHARACTER_DELETE has fired:')
    print('event: '..event..'  player GUID: '..guid)
end

local function function_PLAYER_EVENT_ON_LOGIN(event, player)
    playerFunctionTested[3] = 1
    print('PLAYER_EVENT_ON_LOGIN has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_LOGOUT(event, player)
    playerFunctionTested[4] = 1
    print('PLAYER_EVENT_ON_LOGOUT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_SPELL_CAST(event, player, spell, skipCheck)
    playerFunctionTested[5] = 1
    print('PLAYER_EVENT_ON_SPELL_CAST has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_KILL_PLAYER(event, killer, killed)
    playerFunctionTested[6] = 1
    print('PLAYER_EVENT_ON_KILL_PLAYER has fired:')
    print('event: '..event..'  killer: '..killer:GetName()..'  killed: '..killed:GetName())
end

local function function_PLAYER_EVENT_ON_KILL_CREATURE(event, killer, killed)
    playerFunctionTested[7] = 1
    print('PLAYER_EVENT_ON_KILL_CREATURE has fired:')
    print('event: '..event..'  killer: '..killer:GetName()..'  killed: '..killed:GetName())
end

local function function_PLAYER_EVENT_ON_KILLED_BY_CREATURE(event, killer, killed)
    playerFunctionTested[8] = 1
    print('PLAYER_EVENT_ON_KILLED_BY_CREATURE has fired:')
    print('event: '..event..'  killer: '..killer:GetName()..'  killed: '..killed:GetName())
end

local function function_PLAYER_EVENT_ON_DUEL_REQUEST(event, target, challenger)
    playerFunctionTested[9] = 1
    print('PLAYER_EVENT_ON_DUEL_REQUEST has fired:')
    print('event: '..event..'  target: '..target:GetName()..'  challenger: '..challenegr:GetName())
end

local function function_PLAYER_EVENT_ON_DUEL_START(event, player1, player2)
    playerFunctionTested[10] = 1
    print('PLAYER_EVENT_ON_DUEL_START has fired:')
    print('event: '..event..'  player1: '..player1:GetName()..'  player2: '..player2:GetName())
end

local function function_PLAYER_EVENT_ON_DUEL_END(event, winner, loser, type)
    playerFunctionTested[11] = 1
    print('PLAYER_EVENT_ON_DUEL_END has fired:')
    print('event: '..event..'  winnder: '..winner:GetName()..'  loser: '..loser:GetName()..'  type: '..type)
end

local function function_PLAYER_EVENT_ON_GIVE_XP(event, player, amount, victim) -- Can return new XP amount
    playerFunctionTested[12] = 1
    print('PLAYER_EVENT_ON_GIVE_XP has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    print('amount: '..amount..'  killed: '..victim:GetName())
    print('Overriding xp amount to 123')
    return 123
end

local function function_PLAYER_EVENT_ON_LEVEL_CHANGE(event, player, oldLevel)
    playerFunctionTested[13] = 1
    print('PLAYER_EVENT_ON_LEVEL_CHANGE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    print('oldLevel: '..oldLevel)
end

local function function_PLAYER_EVENT_ON_MONEY_CHANGE(event, player, amount) -- Can return new money amount
    playerFunctionTested[14] = 1
    print('PLAYER_EVENT_ON_MONEY_CHANGE has fired:')
    print('event: '..event..'  playername: '..player:GetName()..'  amount: '..amount)
    print('Overriding money amount to 1g23s45c')
    return 12345
end

local function function_PLAYER_EVENT_ON_REPUTATION_CHANGE(event, player, factionId, standing, incremental) -- Can return new standing
    playerFunctionTested[15] = 1
    print('PLAYER_EVENT_ON_REPUTATION_CHANGE has fired:')
    print('event: '..event..'  playername: '..player:GetName()..'  factionId: '..factionId..'  standing: '..standing..'  incremental: '..incremental)
    print('Overriding standing to 50')
    return 50
end

local function function_PLAYER_EVENT_ON_TALENTS_CHANGE(event, player, points)
    playerFunctionTested[16] = 1
    print('PLAYER_EVENT_ON_TALENTS_CHANGE has fired:')
    print('event: '..event..'  playername: '..player:GetName()..'  points: '..points)
end

local function function_PLAYER_EVENT_ON_TALENTS_RESET(event, player, noCost)
    playerFunctionTested[17] = 1
    print('PLAYER_EVENT_ON_TALENTS_RESET has fired:')
    print('event: '..event..'  playername: '..player:GetName()..'  noCost: '..noCost)
end

local function function_PLAYER_EVENT_ON_CHAT(event, player, msg, Type, lang) -- Can return false, newMessage
    if player:GetName() == 'Luatest' then
        return
    end
    print('PLAYER_EVENT_ON_CHAT has fired:')
    print('event: '..event..'  playername: '..player:GetName()..'  msg: '..msg..'  Type: '..Type..'  lang: '..lang)
    if status_EVENT[18] == nil then
        status_EVENT[18] = 1
        print('1st test: return false')
        return false
    else
        if status_EVENT[18] == 1 then
            status_EVENT[18] = status_EVENT[18] + 1
            print('1st test: return false')
            return false
        elseif status_EVENT[18] == 2 then
            status_EVENT[18] = status_EVENT[18] + 1
            playerFunctionTested[18] = 1
            print('2nd test: return "Testmessage"')
            return 'Testmessage'
        end
    end
end

local function function_PLAYER_EVENT_ON_WHISPER(event, player, msg, Type, lang, receiver) -- Can return false, newMessage
    print('PLAYER_EVENT_ON_WHISPER has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    if status_EVENT[19] == nil then
        status_EVENT[19] = 1
        print('1st test: return false')
        return false
    else
        if status_EVENT[19] == 1 then
            status_EVENT[19] = status_EVENT[19] + 1
            print('1st test: return false')
            return false
        elseif status_EVENT[19] == 2 then
            status_EVENT[19] = status_EVENT[19] + 1
            playerFunctionTested[19] = 1
            print('2nd test: return "Testmessage"')
            return 'Testmessage'
        end
    end
end

local function function_PLAYER_EVENT_ON_GROUP_CHAT(event, player, msg, Type, lang, group) -- Can return false, newMessage
    print('PLAYER_EVENT_ON_GROUP_CHAT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    if status_EVENT[20] == nil then
        status_EVENT[20] = 1
        print('1st test: return false')
        return false
    else
        if status_EVENT[20] == 1 then
            status_EVENT[20] = status_EVENT[20] + 1
            print('1st test: return false')
            return false
        elseif status_EVENT[20] == 2 then
            status_EVENT[20] = status_EVENT[20] + 1
            playerFunctionTested[20] = 1
            print('2nd test: return "Testmessage"')
            return 'Testmessage'
        end
    end
end

local function function_PLAYER_EVENT_ON_GUILD_CHAT(event, player, msg, Type, lang, guild) -- Can return false, newMessage
    print('PLAYER_EVENT_ON_GUILD_CHAT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    if status_EVENT[21] == nil then
        status_EVENT[21] = 1
        print('1st test: return false')
        return false
    else
        if status_EVENT[21] == 1 then
            status_EVENT[21] = status_EVENT[21] + 1
            print('1st test: return false')
            return false
        elseif status_EVENT[21] == 2 then
            status_EVENT[21] = status_EVENT[21] + 1
            playerFunctionTested[21] = 1
            print('2nd test: return "Testmessage"')
            return 'Testmessage'
        end
    end
end

local function function_PLAYER_EVENT_ON_CHANNEL_CHAT(event, player, msg, Type, lang, channel) -- Can return false, newMessage
    print('PLAYER_EVENT_ON_CHANNEL_CHAT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    if status_EVENT[22] == nil then
        status_EVENT[22] = 1
        print('1st test: return false')
        return false
    else
        if status_EVENT[22] == 1 then
            status_EVENT[22] = status_EVENT[22] + 1
            print('1st test: return false')
            return false
        elseif status_EVENT[22] == 2 then
            status_EVENT[22] = status_EVENT[22] + 1
            playerFunctionTested[22] = 1
            print('2nd test: return "Testmessage"')
            return 'Testmessage'
        end
    end
end

local function function_PLAYER_EVENT_ON_EMOTE(event, player, emote) -- Not triggered on any known emote
    playerFunctionTested[23] = 1
    print('PLAYER_EVENT_ON_EMOTE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_TEXT_EMOTE(event, player, textEmote, emoteNum, guid)
    playerFunctionTested[24] = 1
    print('PLAYER_EVENT_ON_TEXT_EMOTE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_SAVE(event, player)
    playerFunctionTested[25] = 1
    print('PLAYER_EVENT_ON_SAVE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_BIND_TO_INSTANCE(event, player, difficulty, mapid, permanent)
    playerFunctionTested[26] = 1
    print('PLAYER_EVENT_ON_BIND_TO_INSTANCE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_UPDATE_ZONE(event, player, newZone, newArea)
    playerFunctionTested[27] = 1
    print('PLAYER_EVENT_ON_UPDATE_ZONE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_MAP_CHANGE(event, player)
    playerFunctionTested[28] = 1
    print('PLAYER_EVENT_ON_MAP_CHANGE has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_EQUIP(event, player, item, bag, slot)
    playerFunctionTested[29] = 1
    print('PLAYER_EVENT_ON_EQUIP has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_FIRST_LOGIN(event, player)
    playerFunctionTested[30] = 1
    print('PLAYER_EVENT_ON_FIRST_LOGIN has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_CAN_USE_ITEM(event, player, itemEntry) -- Can return InventoryResult enum value
    playerFunctionTested[31] = 1
    print('PLAYER_EVENT_ON_CAN_USE_ITEM has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_LOOT_ITEM(event, player, item, count)
    playerFunctionTested[32] = 1
    print('PLAYER_EVENT_ON_LOOT_ITEM has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_ENTER_COMBAT(event, player, enemy)
    playerFunctionTested[33] = 1
    print('PLAYER_EVENT_ON_ENTER_COMBAT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_LEAVE_COMBAT(event, player)
    playerFunctionTested[34] = 1
    print('PLAYER_EVENT_ON_LEAVE_COMBAT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_REPOP(event, player)
    print('PLAYER_EVENT_ON_REPOP has fired:')
    print('event: '..event..'  playername: '..player:GetName())
    playerFunctionTested[35] = 1
end

local function function_PLAYER_EVENT_ON_RESURRECT(event, player)
    playerFunctionTested[36] = 1
    print('PLAYER_EVENT_ON_RESURRECT has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_LOOT_MONEY(event, player, amount)
    playerFunctionTested[37] = 1
    print('PLAYER_EVENT_ON_LOOT_MONEY has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_QUEST_ABANDON(event, player, questId)
    playerFunctionTested[38] = 1
    print('PLAYER_EVENT_ON_QUEST_ABANDON has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_LEARN_TALENTS(event, player, talentId, talentRank, spellid)
    playerFunctionTested[39] = 1
    print('PLAYER_EVENT_ON_LEARN_TALENTS has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end

local function function_PLAYER_EVENT_ON_COMMAND(event, player, command, chatHandler) -- player is nil if command used from console. Can return false
    chatHandler:SendSysMessage('PLAYER_EVENT_ON_COMMAND has fired:')
    if player == nil then
        chatHandler:SendSysMessage('event: '..event..'  playername: Console')
    else
        chatHandler:SendSysMessage('event: '..event..'  playername: '..player:GetName())
    end
    chatHandler:SendSysMessage('command: '..command)
    if command == "resetluatest" then
        for n = 1,43,1 do
            playerFunctionTested[n] = 0
            status_EVENT[n] = nil
        end
        for n = 1,37,1 do
            creatureFunctionTested[n] = 0
        end

        --hardcoded marking as done what doesn't exist
        solveNonExistantPlayerEvents()
        solveNonExistantCreatureEvents()

        playerFunctionTested[42] = 1
        return false

    elseif command == "playertest" then
        local todoString = ''
        for n = 1,43,1 do
            if playerFunctionTested[n] == 0 then
                if todoString == '' then
                    todoString = 'Untested player events: '..n
                else
                    todoString = todoString..', '..n
                end
            end
        end

        chatHandler:SendSysMessage(todoString)

        playerFunctionTested[42] = 1
        return false

    elseif command == "creaturetest" then
        local todoString = ''
        for n = 1,37,1 do
            if creatureFunctionTested[n] == 0 then
                if todoString == '' then
                    todoString = 'Untested creature events: '..n
                else
                    todoString = todoString..', '..n
                end
            end
        end

        chatHandler:SendSysMessage(todoString)

        playerFunctionTested[42] = 1
        return false
    end

    playerFunctionTested[42] = 1
    return
end

local function function_PLAYER_EVENT_ON_PET_SPAWNED(event, player, pet)
    playerFunctionTested[43] = 1
    print('PLAYER_EVENT_ON_PET_SPAWNED has fired:')
    print('event: '..event..'  playername: '..player:GetName())
end


RegisterPlayerEvent(PLAYER_EVENT_ON_CHARACTER_CREATE, function_PLAYER_EVENT_ON_CHARACTER_CREATE)
RegisterPlayerEvent(PLAYER_EVENT_ON_CHARACTER_DELETE, function_PLAYER_EVENT_ON_CHARACTER_DELETE)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, function_PLAYER_EVENT_ON_LOGIN)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGOUT, function_PLAYER_EVENT_ON_LOGOUT)
RegisterPlayerEvent(PLAYER_EVENT_ON_SPELL_CAST, function_PLAYER_EVENT_ON_SPELL_CAST)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILL_PLAYER, function_PLAYER_EVENT_ON_KILL_PLAYER)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILL_CREATURE, function_PLAYER_EVENT_ON_KILL_CREATURE)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILLED_BY_CREATURE, function_PLAYER_EVENT_ON_KILLED_BY_CREATURE)
RegisterPlayerEvent(PLAYER_EVENT_ON_DUEL_REQUEST, function_PLAYER_EVENT_ON_DUEL_REQUEST)
RegisterPlayerEvent(PLAYER_EVENT_ON_DUEL_START, function_PLAYER_EVENT_ON_DUEL_START)
RegisterPlayerEvent(PLAYER_EVENT_ON_DUEL_END, function_PLAYER_EVENT_ON_DUEL_END)
RegisterPlayerEvent(PLAYER_EVENT_ON_GIVE_XP, function_PLAYER_EVENT_ON_GIVE_XP)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEVEL_CHANGE, function_PLAYER_EVENT_ON_LEVEL_CHANGE)
RegisterPlayerEvent(PLAYER_EVENT_ON_MONEY_CHANGE, function_PLAYER_EVENT_ON_MONEY_CHANGE)
RegisterPlayerEvent(PLAYER_EVENT_ON_REPUTATION_CHANGE, function_PLAYER_EVENT_ON_REPUTATION_CHANGE)
RegisterPlayerEvent(PLAYER_EVENT_ON_TALENTS_CHANGE, function_PLAYER_EVENT_ON_TALENTS_CHANGE)
RegisterPlayerEvent(PLAYER_EVENT_ON_TALENTS_RESET, function_PLAYER_EVENT_ON_TALENTS_RESET)
RegisterPlayerEvent(PLAYER_EVENT_ON_CHAT, function_PLAYER_EVENT_ON_CHAT)
RegisterPlayerEvent(PLAYER_EVENT_ON_WHISPER, function_PLAYER_EVENT_ON_WHISPER)
RegisterPlayerEvent(PLAYER_EVENT_ON_GROUP_CHAT, function_PLAYER_EVENT_ON_GROUP_CHAT)
RegisterPlayerEvent(PLAYER_EVENT_ON_GUILD_CHAT, function_PLAYER_EVENT_ON_GUILD_CHAT)
RegisterPlayerEvent(PLAYER_EVENT_ON_CHANNEL_CHAT, function_PLAYER_EVENT_ON_CHANNEL_CHAT)
RegisterPlayerEvent(PLAYER_EVENT_ON_EMOTE, function_PLAYER_EVENT_ON_EMOTE)
RegisterPlayerEvent(PLAYER_EVENT_ON_TEXT_EMOTE, function_PLAYER_EVENT_ON_TEXT_EMOTE)
RegisterPlayerEvent(PLAYER_EVENT_ON_SAVE, function_PLAYER_EVENT_ON_SAVE)
RegisterPlayerEvent(PLAYER_EVENT_ON_BIND_TO_INSTANCE, function_PLAYER_EVENT_ON_BIND_TO_INSTANCE)
RegisterPlayerEvent(PLAYER_EVENT_ON_UPDATE_ZONE, function_PLAYER_EVENT_ON_UPDATE_ZONE)
RegisterPlayerEvent(PLAYER_EVENT_ON_MAP_CHANGE, function_PLAYER_EVENT_ON_MAP_CHANGE)
RegisterPlayerEvent(PLAYER_EVENT_ON_EQUIP, function_PLAYER_EVENT_ON_EQUIP)
RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, function_PLAYER_EVENT_ON_FIRST_LOGIN)
RegisterPlayerEvent(PLAYER_EVENT_ON_CAN_USE_ITEM, function_PLAYER_EVENT_ON_CAN_USE_ITEM)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOOT_ITEM, function_PLAYER_EVENT_ON_LOOT_ITEM)
RegisterPlayerEvent(PLAYER_EVENT_ON_ENTER_COMBAT, function_PLAYER_EVENT_ON_ENTER_COMBAT)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEAVE_COMBAT, function_PLAYER_EVENT_ON_LEAVE_COMBAT)
RegisterPlayerEvent(PLAYER_EVENT_ON_REPOP, function_PLAYER_EVENT_ON_REPOP)
RegisterPlayerEvent(PLAYER_EVENT_ON_RESURRECT, function_PLAYER_EVENT_ON_RESURRECT)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOOT_MONEY, function_PLAYER_EVENT_ON_LOOT_MONEY)
RegisterPlayerEvent(PLAYER_EVENT_ON_QUEST_ABANDON, function_PLAYER_EVENT_ON_QUEST_ABANDON)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEARN_TALENTS, function_PLAYER_EVENT_ON_LEARN_TALENTS)
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, function_PLAYER_EVENT_ON_COMMAND)
RegisterPlayerEvent(PLAYER_EVENT_ON_PET_SPAWNED, function_PLAYER_EVENT_ON_PET_SPAWNED)


------------------------------------------------------------------------------------------------
-- CREATURE GOSSIP EVENTS
------------------------------------------------------------------------------------------------

local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2
local OPTION_ICON_CHAT = 0

local function GossipTestHello(event, player, object)
    if player:GetName() == 'Luatest' then
        return
    end
    print('GOSSIP_EVENT_ON_HELLO fired')
    print('event: '..event..'  playername: '..player:GetName())
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Test", gossipNpcEntry, 0)
    player:GossipSendMenu(1, object, 0)
end

local function GossipTestSelect(event, player, object, sender, intid, code, menu_id)
    print('GOSSIP_EVENT_ON_SELECT fired')
    print('event: '..event..'  playername: '..player:GetName()..'   intid: '..intid)
end


RegisterCreatureGossipEvent(gossipNpcEntry, GOSSIP_EVENT_ON_SELECT, GossipTestSelect)
RegisterCreatureGossipEvent(gossipNpcEntry, GOSSIP_EVENT_ON_HELLO, GossipTestHello)


------------------------------------------------------------------------------------------------
-- CREATURE EVENTS
------------------------------------------------------------------------------------------------
CREATURE_EVENT_ON_ENTER_COMBAT = 1
CREATURE_EVENT_ON_LEAVE_COMBAT = 2
CREATURE_EVENT_ON_TARGET_DIED = 3
CREATURE_EVENT_ON_DIED = 4
CREATURE_EVENT_ON_SPAWN = 5
CREATURE_EVENT_ON_REACH_WP = 6
CREATURE_EVENT_ON_AIUPDATE = 7
CREATURE_EVENT_ON_RECEIVE_EMOTE = 8
CREATURE_EVENT_ON_DAMAGE_TAKEN = 9
CREATURE_EVENT_ON_PRE_COMBAT = 10
-- 11: unused
CREATURE_EVENT_ON_OWNER_ATTACKED = 12
CREATURE_EVENT_ON_OWNER_ATTACKED_AT = 13
CREATURE_EVENT_ON_HIT_BY_SPELL = 14
CREATURE_EVENT_ON_SPELL_HIT_TARGET = 15
-- 16: unused
-- 17: unused
-- 18: unused
CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE = 19
CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN = 20
CREATURE_EVENT_ON_SUMMONED_CREATURE_DIED = 21
CREATURE_EVENT_ON_SUMMONED = 22
CREATURE_EVENT_ON_RESET = 23
CREATURE_EVENT_ON_REACH_HOME = 24
-- 25: unused
CREATURE_EVENT_ON_CORPSE_REMOVED = 26
CREATURE_EVENT_ON_MOVE_IN_LOS = 27
-- 28: unused
-- 29: unused
CREATURE_EVENT_ON_DUMMY_EFFECT = 30
CREATURE_EVENT_ON_QUEST_ACCEPT = 31
-- 32: unused
-- 33: unused
CREATURE_EVENT_ON_QUEST_REWARD = 34
CREATURE_EVENT_ON_DIALOG_STATUS = 35
CREATURE_EVENT_ON_ADD = 36
CREATURE_EVENT_ON_REMOVE = 37


local function function_CREATURE_EVENT_ON_ENTER_COMBAT(event, creature, target)
    creatureFunctionTested[1] = 1
    print('CREATURE_EVENT_ON_ENTER_COMBAT fired (1)')
    print('event: '..event..'  creature: '..creature:GetName())
    if nextTest == 5 then
        target:Say("Combat started.",0)
        log('--------------------------------------------------')
        log('-- Test 5                                       --')
        log('1) Creature ON_ENTER_COMBAT triggered')
        nextTest = '5b'
    end
end

local function function_CREATURE_EVENT_ON_LEAVE_COMBAT(event, creature)
    creatureFunctionTested[2] = 1
    print('CREATURE_EVENT_ON_LEAVE_COMBAT fired (2)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_TARGET_DIED(event, creature, victim)
    creatureFunctionTested[3] = 1
    print('CREATURE_EVENT_ON_TARGET_DIED fired (3)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_DIED(event, creature, killer)
    creatureFunctionTested[4] = 1
    print('CREATURE_EVENT_ON_DIED fired (4)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_SPAWN(event, creature)
    creatureFunctionTested[5] = 1
    print('CREATURE_EVENT_ON_SPAWN fired (5)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_REACH_WP(event, creature, type, id)
    creatureFunctionTested[6] = 1
    print('CREATURE_EVENT_ON_REACH_WP fired (6')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_AIUPDATE(event, creature, diff)
    if creatureFunctionTested[7] ~= 1 then
        creatureFunctionTested[7] = 1
        print('CREATURE_EVENT_ON_AIUPDATE fired (7)')
        print('event: '..event..'  creature: '..creature:GetName())
    end
end

local function function_CREATURE_EVENT_ON_RECEIVE_EMOTE(event, creature, player, emoteid)
    creatureFunctionTested[8] = 1
    print('CREATURE_EVENT_ON_RECEIVE_EMOTE fired (8)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_DAMAGE_TAKEN(event, creature, attacker, damage)
    creatureFunctionTested[9] = 1
    print('CREATURE_EVENT_ON_DAMAGE_TAKEN fired (9)')
    print('event: '..event..'  creature: '..creature:GetName())
    if nextTest == '5c' then
        attacker:Say("Damage was taken",0)
        log('3) Creature EVENT_ON_DAMAGE_TAKEN triggered')
        nextTest = '5d'
    end
end

local function function_CREATURE_EVENT_ON_PRE_COMBAT(event, creature, target)
    if creatureFunctionTested[10] ~= 1 then
        creatureFunctionTested[10] = 1
        print('CREATURE_EVENT_ON_PRE_COMBAT fired (10)')
        print('event: '..event..'  creature: '..creature:GetName())
    end
end

local function function_CREATURE_EVENT_ON_OWNER_ATTACKED(event, creature, target)
    creatureFunctionTested[12] = 1
    print('CREATURE_EVENT_ON_OWNER_ATTACKED fired (12)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_OWNER_ATTACKED_AT(event, creature, attacker)
    creatureFunctionTested[13] = 1
    print('CREATURE_EVENT_ON_OWNER_ATTACKED_AT fired (13)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_HIT_BY_SPELL(event, creature, caster, spellid)
    creatureFunctionTested[14] = 1
    print('CREATURE_EVENT_ON_HIT_BY_SPELL fired (14)')
    print('event: '..event..'  creature: '..creature:GetName())
    if nextTest == '5b' then
        caster:Say("Spell has hit. Keep casting until target is dead.",0)
        log('2) Creature ON_HIT_BY_SPELL triggered')
        nextTest = '5c'
    end
end

local function function_CREATURE_EVENT_ON_SPELL_HIT_TARGET(event, creature, target, spellid)
    creatureFunctionTested[15] = 1
    print('CREATURE_EVENT_ON_SPELL_HIT_TARGET fired (15)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE(event, creature, summon)
    creatureFunctionTested[19] = 1
    print('CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE fired (19)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN(event, creature, summon)
    creatureFunctionTested[20] = 1
    print('CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN fired (20)')
    print('event: '..event..'  creature: '..creature:GetName())
end
local function function_CREATURE_EVENT_ON_SUMMONED_CREATURE_DIED(event, creature, summon, killer)
    creatureFunctionTested[21] = 1
    print('CREATURE_EVENT_ON_SUMMONED_CREATURE_DIED fired (21)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_SUMMONED(event, creature, summoner)
    creatureFunctionTested[22] = 1
    print('CREATURE_EVENT_ON_SUMMONED fired (22)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_RESET(event, creature)
    creatureFunctionTested[23] = 1
    print('CREATURE_EVENT_ON_RESET fired (23)')
    print('event: '..event..'  creature: '..creature:GetName())
end
local function function_CREATURE_EVENT_ON_REACH_HOME(event, creature)
    creatureFunctionTested[24] = 1
    print('CREATURE_EVENT_ON_REACH_HOME fired (24)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_CORPSE_REMOVED(event, creature, respawndelay)
    creatureFunctionTested[26] = 1
    print('CREATURE_EVENT_ON_CORPSE_REMOVED fired (26)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_MOVE_IN_LOS(event, creature, unit)
    creatureFunctionTested[27] = 1
    print('CREATURE_EVENT_ON_MOVE_IN_LOS fired (27)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_DUMMY_EFFECT(event, caster, spellid, effindex, creature)
    creatureFunctionTested[30] = 1
    print('CREATURE_EVENT_ON_DUMMY_EFFECT fired (30)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_QUEST_ACCEPT(event, player, creature, quest)
    creatureFunctionTested[31] = 1
    print('CREATURE_EVENT_ON_QUEST_ACCEPT fired (31)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_QUEST_REWARD(event, player, creature, quest, opt)
    creatureFunctionTested[34] = 1
    print('CREATURE_EVENT_ON_QUEST_REWARD fired (34)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_DIALOG_STATUS(event, player, creature)
    creatureFunctionTested[35] = 1
    print('CREATURE_EVENT_ON_DIALOG_STATUS fired (35)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_ADD(event, creature)
    creatureFunctionTested[36] = 1
    print('CREATURE_EVENT_ON_ADD fired (36)')
    print('event: '..event..'  creature: '..creature:GetName())
end

local function function_CREATURE_EVENT_ON_REMOVE(event, creature)
    creatureFunctionTested[37] = 1
    print('CREATURE_EVENT_ON_REMOVE fired (37)')
    print('event: '..event..'  creature: '..creature:GetName())
end

RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_ENTER_COMBAT, function_CREATURE_EVENT_ON_ENTER_COMBAT)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_LEAVE_COMBAT, function_CREATURE_EVENT_ON_LEAVE_COMBAT)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_TARGET_DIED, function_CREATURE_EVENT_ON_TARGET_DIED)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_DIED, function_CREATURE_EVENT_ON_DIED)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_SPAWN, function_CREATURE_EVENT_ON_SPAWN)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_REACH_WP, function_CREATURE_EVENT_ON_REACH_WP)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_AIUPDATE, function_CREATURE_EVENT_ON_AIUPDATE)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_RECEIVE_EMOTE, function_CREATURE_EVENT_ON_RECEIVE_EMOTE)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_DAMAGE_TAKEN, function_CREATURE_EVENT_ON_DAMAGE_TAKEN)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_PRE_COMBAT, function_CREATURE_EVENT_ON_PRE_COMBAT)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_OWNER_ATTACKED, function_CREATURE_EVENT_ON_OWNER_ATTACKED)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_OWNER_ATTACKED_AT, function_CREATURE_EVENT_ON_OWNER_ATTACKED_AT)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_HIT_BY_SPELL, function_CREATURE_EVENT_ON_HIT_BY_SPELL)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_SPELL_HIT_TARGET, function_CREATURE_EVENT_ON_SPELL_HIT_TARGET)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE, function_CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN, function_CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_SUMMONED_CREATURE_DIED, function_CREATURE_EVENT_ON_SUMMONED_CREATURE_DIED)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_SUMMONED, function_CREATURE_EVENT_ON_SUMMONED)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_RESET, function_CREATURE_EVENT_ON_RESET)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_REACH_HOME, function_CREATURE_EVENT_ON_REACH_HOME)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_CORPSE_REMOVED, function_CREATURE_EVENT_ON_CORPSE_REMOVED)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_MOVE_IN_LOS, function_CREATURE_EVENT_ON_MOVE_IN_LOS)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_DUMMY_EFFECT, function_CREATURE_EVENT_ON_DUMMY_EFFECT)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_QUEST_ACCEPT, function_CREATURE_EVENT_ON_QUEST_ACCEPT)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_QUEST_REWARD, function_CREATURE_EVENT_ON_QUEST_REWARD)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_DIALOG_STATUS, function_CREATURE_EVENT_ON_DIALOG_STATUS)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_ADD, function_CREATURE_EVENT_ON_ADD)
RegisterCreatureEvent(combatNpcEntry, CREATURE_EVENT_ON_REMOVE, function_CREATURE_EVENT_ON_REMOVE)

--worldobject:ToPlayer():RemoveEventById(cancelEvent)

------------------------------------------------------------------------------------------------
-- Tests
------------------------------------------------------------------------------------------------
-- Test 5)
local function teleportToWolf5(eventid, delay, repeats, worldobject)
    worldobject:ToPlayer():Say("Teleported to Wolfs. Cast Shadowbolt (Rank 1) on a wolf.",0)
end

------------------------------------------------------------------------------------------------
-- Test 4)
local function gossipTestSelect4(event, player, object, sender, intid, code, menu_id)
    player:Say("Gossip tests concluded.",0)
    log('--------------------------------------------------')
    log('-- Test 4                                       --')
    log('Gossip OnSelect succesfully triggered.')
    ClearCreatureGossipEvents(gossipNpcEntry)
    nextTest = 5
    player:Teleport(0,-8975,-80,87,0.38)
    cancelEvent = player:RegisterEvent(teleportToWolf5,3000,1)
end

------------------------------------------------------------------------------------------------
-- Test 3)
local function gossipTestHello3(event, player, object)
    player:Say("Select the test-gossip to continue.",0)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Test", gossipNpcEntry, 0)
    player:GossipSendMenu(1, object, 0)
    ClearCreatureGossipEvents(gossipNpcEntry)
    cancelEvent = RegisterCreatureGossipEvent(gossipNpcEntry, GOSSIP_EVENT_ON_SELECT, gossipTestSelect4)
    log('--------------------------------------------------')
    log('-- Test 3                                       --')
    log('Gossip OnHello succesfully triggered.')
    nextTest = 4
end

------------------------------------------------------------------------------------------------
-- Test 2)
local function teleportToMarissa2(eventid, delay, repeats, worldobject)
    worldobject:ToPlayer():Say("I've been teleported and i am facing Chromie. Right-click Chromie to continue.",0)
    cancelEvent = RegisterCreatureGossipEvent(gossipNpcEntry, GOSSIP_EVENT_ON_HELLO, gossipTestHello3)
    log('--------------------------------------------------')
    log('-- Test 2                                       --')
    if worldobject:ToPlayer():GetX() < -8999 and worldobject:ToPlayer():GetX() > -9001 and worldobject:ToPlayer():GetY() < -84 and worldobject:ToPlayer():GetY() > -86 then
        log('Player was succesfully teleported')
    else
        log('!!!!!! Player has wrong position: '..worldobject:ToPlayer():GetX()..', '..worldobject:ToPlayer():GetY()..'.')
    end
    nextTest = 3
end

------------------------------------------------------------------------------------------------
-- Test 1)
local function onLuatestLogin1(event, player)
    if player:GetName() ~= 'Luatest' then
        return
    end
    local errorMessage = 'A fresh human level 1 warlock character is required for testing. Logout, delete it and start over.'
    if player:GetRace() ~= 1 or player:GetLevel() ~= 1 or player:GetClass() ~= 9 then
        print(errorMessage)
        return
    end
    player:SetLevel(60)
    player:Teleport(0,-9000,-85,86,2.82)
    ChromieObject = PerformIngameSpawn(1,1199000,0,0,-9004,-84,86.3,5.8)
    ChromieGuid = ChromieObject:GetGUID()
    cancelEvent = player:RegisterEvent(teleportToMarissa2,5000,1)
    log('--------------------------------------------------')
    log('-- Test 1                                       --')
    if player:GetLevel() == 60 then
        log('Player is Level 60.')
    else
        log('!!!!!! Player has wrong level: '..player:GetLevel()..'.')
    end
    nextTest = 2
end

cancelEvent = RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, onLuatestLogin1)
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- /Tests
------------------------------------------------------------------------------------------------
local function CloseLua(CloseLua)
    if ChromieGuid ~= nil then
        local map
        map = GetMapById(0)
        ChromieObject = map:GetWorldObject(ChromieGuid):ToCreature()
        ChromieObject:DespawnOrUnsummon(0)
    end
end

local ELUNA_EVENT_ON_LUA_STATE_CLOSE = 16
RegisterServerEvent(ELUNA_EVENT_ON_LUA_STATE_CLOSE, CloseLua, 0)
