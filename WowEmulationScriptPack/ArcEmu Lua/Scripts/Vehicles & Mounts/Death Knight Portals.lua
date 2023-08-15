--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DkstartDown_OnGossip(Unit, Event, Player)
Unit:GossipCreateMenu(100, Player, 0)
Unit:GossipMenuAddItem(0, "Take me to first floor", 1, 0)
Unit:GossipSendMenu(Player)
end

function DkstartDown_OnSelect(Unit, Event, Player, MenuId, id, Code)
	if (id == 1) then
		Player:Teleport(609, 2389.628906, -5641.217773, 378.1)
		Unit:GossipComplete(Player)
	end
end

function DkstartUp_OnGossip(Unit, Event, Player)
Unit:GossipCreateMenu(100, Player, 0)
Unit:GossipMenuAddItem(0, "Take me to second floor", 1, 0)
Unit:GossipSendMenu(Player)
end

function DkstartUp_OnSelect(Unit, Event, Player, MenuId, id, Code)
	if (id == 1) then
		Player:Teleport(609, 2383.65, -5645.2, 421.773)
		Unit:GossipComplete(Player)
	end
end

RegisterUnitGossipEvent(353535, 1, "DkstartDown_OnGossip")
RegisterUnitGossipEvent(353536, 1, "DkstartUp_OnGossip")
RegisterUnitGossipEvent(353535, 2, "DkstartDown_OnSelect")
RegisterUnitGossipEvent(353536, 2, "DkstartUp_OnSelect")