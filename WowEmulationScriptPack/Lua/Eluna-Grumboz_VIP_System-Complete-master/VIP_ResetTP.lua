-- use local chat "/say #reset"
local command = "#reset"

function VIPresetTP(event, player, message, type, language)

local Paccid = player:GetAccountId()

	if(message == command) then
		player:ResetTalents()
		local Tp = (78+(ACCT[Paccid].Vip*ACCT["SERVER"].Tp_mod))
		player:SetFreeTalentPoints(Tp, 0)
		player:SetFreeTalentPoints(Tp, 1)
		player:SendBroadcastMessage("|cff00cc00All your talents are reset!|r")
		return false;
	end
end

RegisterPlayerEvent(18, VIPresetTP)

function VIP_reset_comm(event, player, message, type, language)
    if(message:lower() == ACCT["SERVER"].Commands) then
    	player:SendBroadcastMessage("/say "..command.." |cff00cc00To reset your talent points and apply a point bonus.|r")
	end
return;
end
RegisterPlayerEvent(18, VIP_reset_comm)

print("Grumbo'z VIP Reset TP loaded.")
