--[[

	This is created by Rochet2  :D

	© Copyright 2012
             
Command = .damage (123)     - 123 
stands for how much damage you want to do to that selected npc or player
]]

local function ON_CHAT(event, pPlayer, pMessage, pType, pLanguage, pMisc)
	if(pPlayer:CanUseCommand("az")) then
		local MSG = pMessage:lower()
		if(MSG:find("%.damage") == 1) then
			if(MSG:lower():find("%.damage %d+") == 1) then
				local target = pPlayer:GetSelection()
				if(not target) then
					pPlayer:SendAreaTriggerMessage("No target selected")
				else
					local damage = MSG:match("%.damage (%d+)")
					pPlayer:DealDamage(target, damage, 0)
				end
			else
				pPlayer:SendBroadcastMessage("Usage: .damage <amount>")
			end
			return false
		end
	end
end

RegisterServerHook(16, ON_CHAT)