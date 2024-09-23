local RepairAllModule = {}

RepairAllModule.cmd = "repairall"

function RepairAllModule.OnCommand(event, player, command)
    if command == RepairAllModule.cmd then
        if not player:IsInCombat() then
            player:DurabilityRepairAll( false )
            player:SendBroadcastMessage("Your equipment has been repaired.")
        end
        return false
    end
end

RegisterPlayerEvent(42, RepairAllModule.OnCommand)
