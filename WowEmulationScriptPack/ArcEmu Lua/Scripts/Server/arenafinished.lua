Function ArenaFinished(event, pPlayer, pTeamName, bWinner, bRated)

	
	for k,v in pairs(GetPlayersInWorld()) do
	v:SendBroadcastMessage(pTeamName) 
	v:SendBroadcastMessage(bWinner) 
	v:SendBroadcastMessage(bRated) 
	v:SendBroadcastMessage(pPlayer) 	
	end
	





RegisterServerHook(24, ArenaFinished)