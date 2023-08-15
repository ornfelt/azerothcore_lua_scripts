ACCOUNT_LEVEL = 2

local function SetCreatureHP(event, player, command)
        if (command:find("setnpc") ~= 1) then
                return
        elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
                return false
        end

        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)
        local target = player:GetSelection()
        local customizetype = tostring(parameters[2])
        local amount = tonumber(parameters[3])

        if (customizetype == "") then
                player:SendBroadcastMessage("Invalid type. You can change: hp, mana")
                return false
        elseif (amount == 0 or amount > 4294967295 or amount < 0) then
                player:SendBroadcastMessage("You need an amount.")
                return false
        end


        if (target == nil) then
                player:SendBroadcastMessage("You must have a target.")
                return false
        elseif (target:ToCreature() == nil) then
                player:SendBroadcastMessage("You must target a creature.")
                return false
        end


        if (customizetype == "hp") then
                target:SetMaxHealth(amount)
                player:SendBroadcastMessage("Set HP to " .. amount .. ".")
                return false
        elseif (customizetype == "mana") then
                target:SetMaxPower(0, amount)
                player:SendBroadcastMessage("Set Mana to " .. amount .. ".")
                return false
        end
end


RegisterPlayerEvent(42, SetCreatureHP)