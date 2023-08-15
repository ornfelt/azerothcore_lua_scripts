function On_Gossip(unit, event, player)
	unit:GossipCreateMenu(100, player, 0)
	unit:GossipMenuAddItem(0,"Light's Hammer", 1, 0)
	unit:GossipMenuAddItem(0,"Oratory of the Damned", 2, 0)
	unit:GossipMenuAddItem(0,"Rampart of Skulls", 3, 0)
	unit:GossipMenuAddItem(0,"Deathbringer's Rise", 4, 0)
	unit:GossipMenuAddItem(0,"The Plagueworks", 5, 0)
	unit:GossipMenuAddItem(0,"The Crimson Hall", 6, 0)
	unit:GossipMenuAddItem(0,"The Frostwing Halls", 7, 0)
	unit:GossipMenuAddItem(0,"The Frost Queen's Lair", 8, 0)
	unit:GossipSendMenu(player)
end
	
function Gossip_Submenus(unit, event, player, id, intid, code)
	if(intid == 0) then
		unit:GossipCreateMenu(101, player, 0)
		unit:GossipMenuAddItem(0,"Light's Hammer", 1, 0)
		unit:GossipMenuAddItem(0,"Oratory of the Damned", 2, 0)
		unit:GossipMenuAddItem(0,"Rampart of Skulls", 3, 0)
		unit:GossipMenuAddItem(0,"Deathbringer's Rise", 4, 0)
		unit:GossipMenuAddItem(0,"The Plagueworks", 5, 0)
		unit:GossipMenuAddItem(0,"The Crimson Hall", 6, 0)
		unit:GossipMenuAddItem(0,"The Frostwing Halls", 7, 0)
		unit:GossipMenuAddItem(0,"The Frost Queen's Lair", 8, 0)
		unit:GossipSendMenu(player)
	end
	if(intid == 1) then
		player:Teleport(631, -17.856115, 2211.640137, 30.115812)
	end
	if(intid == 2) then
		player:Teleport(631, -503.632599, 2211.219971, 62.823246)
	end
	if(intid == 3) then
		player:Teleport(631, -615.098267, 2211.509766, 199.973083)
	end
	if(intid == 4) then
		player:Teleport(631, -549.151001, 2211.463967, 539.290222)
	end
	if(intid == 5) then
		player:Teleport(631, 4356.780273, 2863.636230, 349.337982)
	end
	if(intid == 6) then
		player:Teleport(631, 4453.248535, 2769.325684, 349.347473)
	end
	if(intid == 7) then
		player:Teleport(631, 4356.853516, 2674.143311, 349.340118)
	end
	if(intid == 8) then
		player:Teleport(631, 4356.527344, 2402.710205, 220.462723)
	end
end

RegisterUnitGossipEvent(NPC ID HERE, 1, "On_Gossip")
RegisterUnitGossipEvent(NPC ID HERE, 2, "Gossip_Submenus")