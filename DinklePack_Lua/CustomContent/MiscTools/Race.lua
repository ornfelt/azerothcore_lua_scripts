local function OnPlayerCommand(event, player, command)
    -- check if the command is .race
    if command:lower() == "race" then
        -- check if player has a target
        local target = player:GetSelection()
        if target then
            -- get target's race
            local race = target:GetRace()
            if race then
                -- send the race ID back to the player
                player:SendBroadcastMessage("Target's race ID: " .. race)
            else
                player:SendBroadcastMessage("Error: Unable to determine target's race.")
            end
        else
            player:SendBroadcastMessage("You must select a target to use this command.")
        end
        return false -- prevent command from being passed to the default handler
    end
end

RegisterPlayerEvent(42, OnPlayerCommand)
