-- Since using .sum summons a player to a relative position according to mmaps, we use this command to summon a player to an exact position.
-- Example: Summoning a player into a cage object will put them outside.

ACCOUNT_LEVEL = 2

local function SummonExactCommandHandler(event, player, command)
    if (command:find("sumexact") ~= 1) then
        return
    elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
        return
    else
        local x, y, z, o = player:GetLocation()
        local mapId = player:GetMapId()
        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        for parameter in string.gmatch(command, pattern) do -- Take the entire command and split it by spaces, put into a table.
            table.insert(parameters, parameter)
        end

        if (parameters[2] == nil) then -- if summoner wants to summon a target
            local target = player:GetSelection()
            if (target == nil or target:ToPlayer() == nil) then
                player:SendBroadcastMessage("You're missing a player name or a target.")
                return false
            else
                target:Teleport(mapId, x, y, z, o)
                player:SendBroadcastMessage("Player summoned to your location.")
                return false
           end
        elseif (parameters[2] ~= "") then -- if summoner types a name
            local target = GetPlayerByName(parameters[2])
            if (target == nil) then
                player:SendBroadcastMessage("Player not found.")
                return false
            else
                target:Teleport(mapId, x, y, z, o)
                player:SendBroadcastMessage("Player summoned to your location.")
                return false
            end
        end
    end
end




RegisterPlayerEvent(42, SummonExactCommandHandler)