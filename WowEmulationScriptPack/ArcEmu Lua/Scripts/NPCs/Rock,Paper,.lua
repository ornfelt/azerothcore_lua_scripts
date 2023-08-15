function RPS_OnGossipTalk(Unit,event,player)
		Unit:GossipCreateMenu(99,player,0)
		Unit:GossipMenuAddItem(1,"I choose Rock.",1,0)
		Unit:GossipMenuAddItem(1,"I choose Paper.",2,0)
		Unit:GossipMenuAddItem(1,"I choose Scissors.",3,0)
		Unit:GossipMenuAddItem(0,"Nevermind, I would not like to take the risk!",4,0)
		Unit:GossipSendMenu(player)
end

function RPS_OnGossipSelect(Unit,event,player,id,intid,code)
	if (intid == 1) then
		local m = math.random(1,3)
		if (m == 1) then
			player:SendBroadcastMessage("We both chose rock, we tied!")
			player:GossipComplete()
	end
		if (m == 2) then
			player:SendBroadcastMessage("I chose paper, I win!")
			player:GossipComplete()
	end
		if (m == 3) then
			player:SendBroadcastMessage("I chose scissors, QQ.")
			player:GossipComplete()
	end
end

	if (intid == 2) then
		local m = math.random(1,3)
		if (m == 1) then
			player:SendBroadcastMessage("I chose rock, you win.")
			player:GossipComplete()
	end
		if (m == 2) then
			player:SendBroadcastMessage("We both chose paper, tie!")
			player:GossipComplete()
	end
		if (m == 3) then
			player:SendBroadcastMessage("I chose scissors and cut through your paper like butter.")
			player:GossipComplete()
	end
end

	if (intid == 3) then
		local m = math.random(1,3)
		if (m == 1) then
			player:SendBroadcastMessage("I chose rock and crushed your puny scissors, I win!")
			player:GossipComplete()
	end
		if (m == 2) then
			player:SendBroadcastMessage("Aww... Your scissors cut through my paper.")
			player:GossipComplete()
	end
		if (m == 3) then
			player:SendBroadcastMessage("Parry, we tied!!")
			player:GossipComplete()
	end
end

	if (intid == 4) then
		player:GossipComplete()
	end
end
	
	
	
RegisterUnitGossipEvent(5000012,1,"RPS_OnGossipTalk")
RegisterUnitGossipEvent(5000012,2,"RPS_OnGossipSelect")