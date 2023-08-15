--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////    Gossip for Drakes		////
--////  					    ////
--///	       					////
--//////////////////////////////////

function Belgaristrasz_OnGossip(Unit, event, player)                  
Unit:GossipCreateMenu(100, player, 0)
Unit:GossipMenuAddItem(0, "Give me the Ruby Essence!", 10, 0)
Unit:GossipSendMenu(player)
end

function Belgaristrasz_OnSelect(Unit, event, player, id, intid, code)
	if (intid == 10) then
	player:AddItem(37860, 1)
	Unit:GossipComplete()
end
end

RegisterUnitGossipEvent(27658, 1, "Belgaristrasz_OnGossip")
RegisterUnitGossipEvent(27658, 2, "Belgaristrasz_OnSelect")

function Verdisa_OnGossip(Unit, event, player)                  
Unit:GossipCreateMenu(100, player, 0)
Unit:GossipMenuAddItem(0, "Give me the Emerald Essence!", 10, 0)
Unit:GossipSendMenu(player)
end

function Verdisa_OnSelect(Unit, event, player, id, intid, code)
	if (intid == 10) then
	player:AddItem(37815, 1)
	Unit:GossipComplete()
end
end

RegisterUnitGossipEvent(27657, 1, "Verdisa_OnGossip")
RegisterUnitGossipEvent(27657, 2, "Verdisa_OnSelect")

function Eternos_OnGossip(Unit, event, player)                  
Unit:GossipCreateMenu(100, player, 0)
Unit:GossipMenuAddItem(0, "Give me the Amber Essence!", 10, 0)
Unit:GossipSendMenu(player)
end

function Eternos_OnSelect(Unit, event, player, id, intid, code)
	if (intid == 10) then
	player:AddItem(37859, 1)
	Unit:GossipComplete()
end
end

RegisterUnitGossipEvent(27659, 1, "Eternos_OnGossip")
RegisterUnitGossipEvent(27659, 2, "Eternos_OnSelect")

-- Should fix Emerald, Ruby, Amber drakes not being able to fly.

--//////////////////////////////////
--////   					    ////
--////       		            ////
--//// Drakos the Interrogator  ////
--////  					    ////
--///	       					////
--//////////////////////////////////