ReputationRatesModule = {}

ReputationRatesModule.enabled = true -- disable the script with true or false
ReputationRatesModule.GMonly = false -- determine whether you want only GMs to be able to use said command

local function getPlayerCharacterGUID(player)
    return player:GetGUIDLow()
end

local function GMONLY(player)
    -- player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

function ReputationRatesModule.OnLogin(event, player)
    local aura = player:GetAura(80118)
    if aura then
        local RepRate = aura:GetStackAmount()
        player:SendBroadcastMessage(string.format("|cff5af304Your reputation rate is currently set to %dx|r", RepRate))
    end
end

function ReputationRatesModule.SetRepRate(event, player, command)
    local mingmrank = 3

    if command:find("rep") then
        local rate = tonumber(command:sub(5))

        if command == "rep" then
            player:SendBroadcastMessage("|cff5af304To set your reputation rate, type '.rep X' where X is a value between 1 and 10.|r")
            return false
        end

        if rate and rate >= 1 and rate <= 10 then
            if player:HasItem(800048, 1) then
                player:SendBroadcastMessage("|cffff0000You cannot use this command in Slow and Steady Mode.|r")
                return false
            end
            if ReputationRatesModule.GMonly and player:GetGMRank() < mingmrank then
                GMONLY(player)
                return false
            else
                player:RemoveAura(80118)
                if rate > 1 then
                    local aura = player:AddAura(80118, player)
                    aura:SetStackAmount(rate)
                end
                player:SendBroadcastMessage(string.format("|cff5af304You changed your reputation rate to %dx|r", rate))
                return false
            end
        else
            player:SendBroadcastMessage("|cffff0000Invalid reputation rate. Please enter a value between 1 and 10.|r")
            return false
        end
    end
end

if ReputationRatesModule.enabled then
    RegisterPlayerEvent(3, ReputationRatesModule.OnLogin)
    RegisterPlayerEvent(42, ReputationRatesModule.SetRepRate)
end
