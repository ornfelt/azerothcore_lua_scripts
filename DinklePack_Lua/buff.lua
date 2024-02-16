local cmd = "buff"

local auras = { 71954 }

local function OnCommand(event, player, command)
    if command == cmd then
        if not player:IsInCombat() then
            for i = 2, #auras, 1 do
                player:AddAura(auras[i], player)
            end
            player:CastSpell(player, auras[1], true)
        else
            player:SendNotification("You're in combat!")
        end
        return false
    end
end
RegisterPlayerEvent(42, OnCommand)
