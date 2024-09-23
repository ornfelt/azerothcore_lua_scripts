local function PlayerWhisperNearby(event, player, command)
    if (command:find("gw") ~= 1) then
            return
    end

    local pattern = "%S+" -- Separate by spaces
    local parameters = {}
    local parameters = getCommandParameters(command)
    local param2 = tostring(parameters[2])
    local message = string.match(command, "gw (.*)")
    local gwInRange = player:GetPlayersInRange(3)

    if (param2 == "nil" or param2 == nil) then
            player:SendBroadcastMessage("Use .gw inrange to see all players within group whisper range, or use .gw text to whisper 'text' to all players in range..")
    elseif next(gwInRange) == nil then
            player:SendBroadcastMessage("There is no-one in group whisper range.")
    elseif param2 == "inrange" then
            local gwInRangeNames = {}
            for index,playerInRange in pairs(gwInRange) do
                table.insert(gwInRangeNames, playerInRange:GetName())
            end
            player:SendBroadcastMessage("Characters in range of group whisper: " .. table.concat(gwInRangeNames,", ") .. ".")
    else
            for index,playerInRange in pairs(gwInRange) do
                player:Whisper(message, 0, playerInRange)
            end
    end
    return false
end

RegisterPlayerEvent(42, PlayerWhisperNearby)