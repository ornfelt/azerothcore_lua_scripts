local cmd = "repairall"

local function OnCommand(event, player, command)
    if command == cmd then
        if not player:IsInCombat() then
            player:DurabilityRepairAll( false )
            player:SendBroadcastMessage("Your equipment has been repaired.")
        end
        return false
    end
end
RegisterPlayerEvent(42, OnCommand)