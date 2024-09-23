-- Name this script "CommandHandler.lua"
-- Declare required scripts below
require("xprates")

-- Table to store various functions and values
local Comm = {}

-- Helper function to determine whether an account is whitelisted to use the specific command in question
-- Takes an account ID and a whitelist table as arguments
-- Returns a boolean indicating whether the account ID is present in the whitelist
function Comm.IsAccountWhitelisted(accid, whitelist)
    for _, v in pairs(whitelist) do
        if(v == accid) then
            return true;
        end
    end
    
    return false;
end

-- Helper function to split a string into a table with each space separated string of the original string as its own value
-- Takes a string as an argument
-- Returns a table with each space-separated string of the original string as its own value
function Comm.SplitString(inputstr)
    local t = {}
    local e, i = 0, 1
    
    while true do
        local b = e+1
        b = inputstr:find("%S", b)
        
        if b == nil then
            break
        end
        
        if inputstr:sub(b,b) == "'" then
            e = inputstr:find("'", b+1)
            b = b+1
        elseif inputstr:sub(b,b) == '"' then
            e = inputstr:find('"', b+1)
            b = b+1
        else
            e = inputstr:find("%s", b+1)
        end
        
        if e == nil then 
            e = #inputstr+1
        end

        t[i] = inputstr:sub(b,e-1)
        i = i + 1
    end
    
    return t
end

-- Function to handle the "xp" command
-- Takes a command table and a player object as arguments
-- Sets the player's XP rate to a specified value if it is between 0 and the maximum allowed XP rate
function Comm.HandleXPCommand(com, player)
    local rateInfo = player:GetXPRateInfo();
    
    if(tonumber(com[2]) ~= nil) then
        if((tonumber(com[2]) >= 0) and (tonumber(com[2]) <= rateInfo[2])) then
            player:SetXPRate(tonumber(com[2]))
            player:SendBroadcastMessage("Your XP rate has now been set to "..math.ceil(com[2]).."!")
        else
            player:SendBroadcastMessage("You must set a valid XP rate between 0 and "..rateInfo[2].."! Default XP rate is 1.")
        end
    else
        player:SendBroadcastMessage("Command syntax: .xp <0-"..rateInfo[2].."> - Value must be between 0 and "..rateInfo[2].." depending on XP rate of your choice. Your current XP rate is "..rateInfo[1]..".")
    end
end

-- Function to handle raw commands
-- Looks up the appropriate command function from the table of registered commands and calls it if the player has sufficient permissions to use the command
function Comm.Handler(event, player, command)
    -- Split the command string into a table of individual words
    local commandTable = Comm.SplitString(command)
    
    -- Check if the command is present in the Comm.register table
    if(Comm["register"][commandTable[1]]) then
        if(player) then
            -- Get the security level and whitelist for the command
            local security, whitelist = Comm["register"][commandTable[1]][2], Comm.IsAccountWhitelisted(player:GetAccountId(), Comm["register"][commandTable[1]][3])
        
            -- Check the player's GM rank or whether their account ID is present in the command's whitelist
            if(player:GetGMRank() >= security or whitelist == true) then
                -- Call the command's associated command handler function with the command table and player object as arguments
                Comm["register"][commandTable[1]][1](commandTable, player)
            else
                player:SendBroadcastMessage("You do not have access to that command!")
            end
        else -- Assume sent from console
            -- Check if the command can be used from the console
            if(Comm["register"][commandTable[1]][2] >= 4) then
                Comm["register"][commandTable[1]][1](commandTable, nil)
            end
        end
        
        return false;
    end
end

-- Table to store registered commands and their associated command handler function, security level, and whitelist
Comm.register = {
    --["commandname"] = {CommandFunction, SecurityLevel, {WhiteListAccIds}}
    ["xp"] = {Comm.HandleXPCommand, 0, {}},
}

RegisterPlayerEvent(42, Comm.Handler)
