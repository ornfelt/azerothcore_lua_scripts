local ResetIdModule = {}

ResetIdModule.cmd = "resetid"

function ResetIdModule.OnCommand(event, player, command)
    if command == ResetIdModule.cmd then
        if not player:IsInCombat() then
            player:UnbindAllInstances()
            player:SendBroadcastMessage("Your instance ID's have been reset.")
        end
        return false
    end
end

RegisterPlayerEvent(42, ResetIdModule.OnCommand)
