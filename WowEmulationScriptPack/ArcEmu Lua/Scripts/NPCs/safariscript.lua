function OnQuestAccept(event, pPlayer, questId, pQuestGiver)
	if questId == 960001 then
    		pPlayer:Teleport(209, 312.067, 1591.909, -271.452)
    		plr:SendBroadcastMessage("|2E8B57Goodluck hunting!|r")
	end
	
	if questId == 960002 then
    		pPlayer:Teleport(209, 2358.637, 1541.420, -17.081)
    
	end

	if questId == 960003 then
    		pPlayer:Teleport(209, -384.0272, 302.708, 53.231)
    
	end

	if questId == 960004 then
   		pPlayer:Teleport(209, -76.391, 1222.575, -51.526)
    
	end



	
end

RegisterServerHook(14, "OnQuestAccept")
