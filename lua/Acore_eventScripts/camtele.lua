-- PLAYER_EVENT_ON_LOGIN                   =     3,        // (event, player)
-- ELUNA_EVENT_ON_LUA_STATE_OPEN           =     33,       // (event) - triggers after all scripts are loaded

local PLAYER_EVENT_ON_LOGIN = 3
local ELUNA_EVENT_ON_LUA_STATE_OPEN = 33

local position = 0
local camCharName = "Chromie"     -- Only character to be teleported around
local delay = 300000              -- in ms. 300000 = 5min
local chatDelay = 15000           -- in ms. 15000 = 15sec
local minMoney = 20000            -- money in copper 20000 = 2 gold
local maxMoney = 50000            -- money in copper 50000 = 5 gold

local HasFound = {}

-- positions: 1) Shattrath, 2) Dark Portal
local mapId = { 530, 0}
local x = { -1882, -11826}
local y = { 5296, -3196}
local z = { 3, -25.6}
local o = { 0.33, 3.25}

local RandomChats1 = {
"Oh hello, ",
"Greetings, "
}

local Random Chats2 = {
"! Thank you for keeping me company.",
"! I appreciate you being around."
}

--calculates the amounts of time an event should be registered
local function GetAmount()
    local val = (delay / chatDelay) - 1
    if val < 1 then
      PrintError("Time between Chats is too small in cCamera teleport Lua.")
    end
end

local function ScheduleTPLogin( _, player )
    if player:GetName() == camCharName then
        ScheduleTeleport( player )
    end
end

local function ScheduleTPReload ( _ )
    local player = GetPlayerByName( name )
    ScheduleTeleport( player )
    -- wipe players having found Chromie already.
    HasFound = {}
end

local function GiveReward()
    playersInRange = WorldObject:GetPlayersInRange( 10, 2, 1 ) 		-- 10m range, friendly, alive
    if playersInRange then
      local player = playersInRange[ math.random( #myTable ) ]
    end
    if player then
        if HasFound[ player:GetGUIDLow() ] = 1 then
            chromie:SendUnitSay( "Please step aside, " .. player:GetName() .. ". Let me have a chat with the other time-travellers as well. Thank you!", 0 )
        end
        local chromime = GetPlayerByName( camCharName )
        if chromie then
	          local id = math.random(#RandomChats)
            chromie:SendUnitSay( RandomChats1[ id ] .. player:GetName(), RandomChats2[ id ], 0 )
            -- Give Reward
            player:ModifyMoney( math.random( minMoney, maxMoney ) )
            HasFound[ player:GetGUIDLow() ] = 1
        else
            PrintError("Could not give reward for the cam rotation.")
        end
    end
end

local function ScheduleTeleport( player )
    if player then
        position = position + 1
        if not mapId[position] then
            position = 1
        end
        Teleport( mapId[position], x[position], y[position], z[position], o[position])
        player:RegisterEvent( ScheduleTeleport, delay, 1 )
        player:RegisterEvent( GiveReward, chatDelay , GetAmount() )
    else
        PrintError("Could not schedule teleport for the cam rotation.")
    end
end

RegisterPlayerEvent( PLAYER_EVENT_ON_LOGIN, ScheduleTPLogin )
RegisterPlayerEvent( ELUNA_EVENT_ON_LUA_STATE_OPEN, ScheduleTPReload )
