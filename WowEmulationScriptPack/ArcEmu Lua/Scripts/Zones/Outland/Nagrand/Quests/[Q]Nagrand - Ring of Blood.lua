--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


local function NPC_GossipHello(pUnit, event, pPlayer)
	pUnit:GossipCreateMenu(100, pPlayer, 0)
	pUnit:GossipMenuAddItem(0, "Brokentoe Event", 1, 0)
	pUnit:GossipMenuAddItem(0, "Twin Event", 2, 0)
	pUnit:GossipSendMenu(pPlayer)
end
 
function NPC_GossipSelect(pUnit, event, pPlayer, id, intid, code)
	if (intid == 1) then
		pUnit:SpawnCreature(18069, -704.385620, 7875.663086, 45.374313, 2.016115, 31, 300000, 0 , 0,  0, 1, 0)
		pPlayer:GossipComplete()
	elseif (intid == 2) then
		pUnit:SendChatMessage(12, 0, "Bye!")
	end
end
 
RegisterUnitGossipEvent(18471, 1, NPC_GossipHello)
RegisterUnitGossipEvent(18471, 2, NPC_GossipSelect)
