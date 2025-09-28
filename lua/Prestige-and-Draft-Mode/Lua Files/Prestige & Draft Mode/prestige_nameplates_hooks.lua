-- Send prestige level to nearby players and to self
local function SendPrestigeToNearbyPlayers(player)
    if not player:IsInWorld() then
        return
    end

    local guid = player:GetGUIDLow()
    local name = player:GetName()

    local results = CharDBQuery("SELECT prestige_level FROM prestige_stats WHERE player_id = " .. guid)
    if not results then
        return
    end

    local prestige = results:GetUInt32(0)
    local message = name .. ":" .. prestige

    -- Send to the player themselves
    player:SendAddonMessage("PRESTIGE", message, 0, player)

    -- Then send to nearby players
    local nearbyPlayers = player:GetPlayersInRange(100)
    for _, target in ipairs(nearbyPlayers) do
        if target ~= player then
            target:SendAddonMessage("PRESTIGE", message, 0, target)
        end
    end

    -- Also send to self (so client sees own prestige level)
    player:SendAddonMessage("PRESTIGE", message, 0, player)
end

-- Hooks to trigger prestige broadcast
local function OnLogin(event, player)
    SendPrestigeToNearbyPlayers(player)
end

local function OnMapChange(event, player)
    SendPrestigeToNearbyPlayers(player)
end

local function OnZoneUpdate(event, player)
    SendPrestigeToNearbyPlayers(player)
end

-- Timer to send prestige every 10 seconds
local function PrestigeUpdateTimer()
    local players = GetPlayersInWorld()
    for _, player in ipairs(players) do
        SendPrestigeToNearbyPlayers(player)
    end
end

-- Register events
RegisterPlayerEvent(3, OnLogin)           -- EVENT_ON_LOGIN
RegisterPlayerEvent(27, OnZoneUpdate)     -- EVENT_ON_UPDATE_ZONE
RegisterPlayerEvent(28, OnMapChange)      -- EVENT_ON_MAP_CHANGE

-- Register the 10-second repeating timer
CreateLuaEvent(PrestigeUpdateTimer, 10000, 0)
