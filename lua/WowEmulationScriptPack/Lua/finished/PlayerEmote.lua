local function PlayerEmotePlay(event, player, command)
        if (command:find("emote") ~= 1) then
                return
        end

        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)
        local param2 = tostring(parameters[2])
        local param3 = tostring(parameters[3])

        if (param2 == "loop") then
                local emoteID = tonumber(param3)
                if (emoteID == nil or emoteID >= 477 or emoteID < 0) then
                        player:SendBroadcastMessage("Missing or invalid emote ID.")
                        return false
                else
                        player:EmoteState(emoteID)
                        return false
                end
        elseif (param2 == "stop") then
                player:Emote(0)
                player:EmoteState(0)
                return false
        else
                local emoteID = tonumber(param2)
                if (emoteID == nil or emoteID >= 477 or emoteID < 0) then
                        player:SendBroadcastMessage("Missing or invalid emote ID.")
                        return false
                else
                        player:Emote(emoteID)
                        return false
                end
        end


end

RegisterPlayerEvent(42, PlayerEmotePlay)