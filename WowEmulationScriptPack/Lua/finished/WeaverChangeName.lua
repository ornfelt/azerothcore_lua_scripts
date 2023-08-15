local ACCOUNT_LEVEL = 2

local function WeaverChangeName(event, player, command)
        if (command:find("wchangename") ~= 1) then
                return
        elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
                return false
        end
        player:SetAtLoginFlag(1)
        player:SendBroadcastMessage("Go to character select to change your name.")
        return false
end

RegisterPlayerEvent(42, WeaverChangeName)