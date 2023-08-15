--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function On_Gossip(unit, event, player)
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(0, "Riding Skills!", 1, 0)
unit:GossipMenuAddItem(0, "Not working? Click here!", 2, 0)
unit:GossipSendMenu(player)
end

function Gossip_Submenus(unit, event, player, id, intid, code)
    if(intid == 1) then
    player:LearnSpell(33388)
    player:LearnSpell(33391)
    player:LearnSpell(34090)
    player:LearnSpell(34091)
    player:LearnSpell(54197)
    player:GossipComplete()
    end
	if(intid == 2) then
	player:LearnSpell(33388)
    player:LearnSpell(33391)
    player:LearnSpell(34090)
    player:LearnSpell(34091)
    player:LearnSpell(54197)
    player:GossipComplete()
    end
end

RegisterUnitGossipEvent(7000004, 1, "On_Gossip")
RegisterUnitGossipEvent(7000004, 2, "Gossip_Submenus")