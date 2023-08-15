function GroupCheck(event, pPlayer, pMessage, pType, pLanguage, pMisc)
	if(pMessage:lower() == "#group") then
		local TON = pPlayer:GetGuildLeader()
		pPlayer:SendBroadcastMessage(""..TON.."")
		end
end

RegisterServerHook(16, "GroupCheck")