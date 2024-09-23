-- Name this script "xprates.lua"
-- This script requires the CommandHandler script for XP command functionality

local Rates = {}

-- The default maximum XP rate that players can have
local defaultMaxRate = 7

-- The default XP rate for players
local defaultRate = 1

-- Called when a player logs in for the first time
function Rates.OnFirstLogin(event, player)
    -- Set the player's XP rate to the default value
    Rates.ProcessRate(player:GetGUIDLow(), defaultRate, defaultMaxRate)

    -- Send a message to the player telling them their XP rate has been set
    player:SendBroadcastMessage("Your XP rate has been set to "..defaultRate.."! To change this, type .xp")
end

-- Called when a player levels up
function Rates.OnLevelUp(event, player, oldLevel)
    -- Set the player's XP rate to the maximum value if they reach level 80
    if(player:GetLevel() == 80) then
        Rates.ProcessRate(player:GetGUIDLow(), defaultMaxRate, defaultMaxRate)
    end
end

-- Called when a player gains XP
function Rates.OnGainXP(event, player, amount, victim)
    -- Multiply the amount of XP by the player's XP rate if they are below level 80
    if(Rates["Cache"][player:GetGUIDLow()] and player:GetLevel() < 80) then
        amount = amount*Rates["Cache"][player:GetGUIDLow()][1]
        return amount;
    end
end

-- Loads information about XP rates from the "xprates" database table and stores it in the "Cache" field of the "Rates" table
function Rates.LoadCache()
    Rates["Cache"] = {}
       
    -- Query the "xprates" database table
    local Query = CharDBQuery("SELECT * FROM xprates;");
    if(Query)then
        repeat
            -- Store the XP rate information in the "Cache" field
            Rates["Cache"][Query:GetUInt32(0)] = {Query:GetUInt32(1), Query:GetUInt32(2)};
        until not Query:NextRow()
    end
end

-- Updates the XP rate for a player with the given "guid" in the "Cache" field and in the "xprates" database table
function Rates.ProcessRate(guid, rate, maxRate)
    Rates["Cache"][guid] = {rate, maxRate};
    CharDBExecute("REPLACE into xprates (guid, rate, maxRate) values("..guid..", "..rate..", "..maxRate..");");
end

-- Set the XP rate for the player object that calls this function
-- Optionally, the maximum XP rate can also be set
function Player:SetXPRate(rate, maxRate)
    if(maxRate == nil) then
        maxRate = Rates["Cache"][self:GetGUIDLow()][2];
    end
    
    Rates.ProcessRate(self:GetGUIDLow(), rate, maxRate)
end

-- Return the XP rate and maximum XP rate for the player object that calls this function
function Player:GetXPRateInfo()
    return Rates["Cache"][self:GetGUIDLow()];
end

-- Load the XP rate information from the "xprates" database table into the "Cache" field
Rates.LoadCache()

-- Register the "Rates.OnLevelUp" function to be called when a player levels up
RegisterPlayerEvent(13, Rates.OnLevelUp)

-- Register the "Rates.OnFirstLogin" function to be called when a player logs in for the first time
RegisterPlayerEvent(30, Rates.OnFirstLogin)

-- Register the "Rates.OnGainXP" function to be called when a player gains XP
RegisterPlayerEvent(12, Rates.OnGainXP)
