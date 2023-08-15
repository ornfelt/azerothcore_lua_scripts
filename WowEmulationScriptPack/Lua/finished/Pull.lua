function Push(event, player, command)
	if (player:GetGMRank() < 3) then
		return
	elseif (command:find("pull") ~= 1) then
		return
	else
		if (command:find("pull dbc") == 1) then
			player:SendBroadcastMessage("Pulling DBC . . .")
			os.execute ('bash /embercore/data/dbc/PullDBC.sh &')
			player:SendBroadcastMessage("DBC has been pulled. You may need to restart the server before the changes can take affect.")
			return false
		elseif (command:find("pull lua") == 1) then -- Add support for branches!!!
			os.execute ('bash /embercore/bin/lua_scripts/PullLUA.sh')
			player:SendBroadcastMessage("LUA has been pulled. You may need to wait a minute or two before reloading to see the changes.")
			return false
		end
	end
end

RegisterPlayerEvent(42, Push)