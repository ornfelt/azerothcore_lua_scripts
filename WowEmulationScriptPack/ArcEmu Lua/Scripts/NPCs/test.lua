-- Message function
		
function GameAnnouncer(Message)
	local tbl = GetPlayersInMap(169)
	for k,v in pairs(tbl) do
		v:SendBroadcastMessage(Message)
	end
end