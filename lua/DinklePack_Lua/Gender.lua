GenderSwitchModule = {}
GenderSwitchModule.MSG_GEN = "#gender"

GenderSwitchModule.Cost = 0 --This is in copper so the value that is now 100g so 1000000c
GenderSwitchModule.Gold = 0 -- Gold value for visual on screen to showup. Can probably improve this later

local function SwitchGender(event, player, msg, Type, lang)
    if (msg:find(GenderSwitchModule.MSG_GEN)) then
        local gmRank = player:GetGMRank()
        if (gmRank <= 0) then -- change number (0-3) 0 - to all  1,2,3 GM with rank
            player:SendAreaTriggerMessage("You Dont have access to this.")
            return
        end

        if player:GetCoinage() < GenderSwitchModule.Cost then
            player:SendAreaTriggerMessage("You require " .. GenderSwitchModule.Gold .. " Gold")
            return false
        end

        player:SetCoinage(player:GetCoinage() - GenderSwitchModule.Cost)
        player:SendAreaTriggerMessage(GenderSwitchModule.Gold .. " Gold has been taken")

        if player:GetGender() == 0 then
            player:SetGender(1)
            return false
        end

        if player:GetGender() == 1 then
            player:SetGender(0)
            return false
        end
    end
end
RegisterPlayerEvent(18, SwitchGender)
