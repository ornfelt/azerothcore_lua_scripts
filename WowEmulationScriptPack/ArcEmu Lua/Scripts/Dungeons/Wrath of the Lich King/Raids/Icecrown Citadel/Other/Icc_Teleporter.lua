logcol(10)
logcol(7)

function Teleport_TeleportOnViewAllIcc(pUnit, event, player)
pUnit:GossipObjectCreateMenu(4259, player, 0)
pUnit:GossipMenuAddItem(0, "TheLowerCitadel.", 3, 0)
pUnit:GossipMenuAddItem(0, "The Spire.", 6, 0)
pUnit:GossipMenuAddItem(0, "Rampart of Skulls.", 4, 0)
pUnit:GossipMenuAddItem(0, "The Frost Queen' Lair.", 7, 0)
pUnit:GossipMenuAddItem(0, "Deathbringer' Rise.", 5, 0)
pUnit:GossipMenuAddItem(0, "TheUpperReaches.", 2 ,0)
pUnit:GossipMenuAddItem(0, "RoyalQuaters.", 8, 0)
pUnit:GossipMenuAddItem(0, "TheFrozenThrone.", 9, 0)
pUnit:GossipSendMenu(player)
end

function GossipOnSelectAllIcc(Unit, Event, player, id, intid, code, pMisc)
if (intid == 1) then
player:Teleport(631, 4356.93, 2769.41, 355.955)
player:GossipComplete()
end

if (intid == 2) then
player:Teleport(631, 4199.35, 2769.42, 350.977)
player:GossipComplete()
end

if (intid == 3) then
player:Teleport(631, -17.0711, 2211.47, 30.0546)
player:GossipComplete()

end
if (intid == 4) then
player:Teleport(631, -615.146, 2211.47, 199.909)
player:GossipComplete()

end
if (intid == 5) then
player:Teleport(631, -549.073, 2211.29, 539.223)
player:GossipComplete()

end
if (intid == 6) then
player:Teleport(631, -503.593, 2211.47, 62.7621)
player:GossipComplete()

end
if (intid == 7) then
player:Teleport(631, 4356.58, 2565.75, 220.402)
player:GossipComplete()

end
if (intid == 8) then
player:Teleport(631, 4582.67, 2769.32, 400.14)
player:GossipComplete()

end
if (intid == 9) then
player:Teleport(631, 541.037537, -2080.644775, 1064.325439)
player:GossipComplete()

end
if (intid == 10) then
player:Teleport(631, 4356.58, 2565.75, 220.402)
player:GossipComplete()

 end
end

RegisterGameObjectEvent (202223, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202223, 2, "GossipOnSelectAllIcc")
RegisterGameObjectEvent (202235, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202235, 2, "GossipOnSelectAllIcc")
RegisterGameObjectEvent (202242, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202242, 2, "GossipOnSelectAllIcc")
RegisterGameObjectEvent (202243, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202243, 2, "GossipOnSelectAllIcc")
RegisterGameObjectEvent (202244, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202244, 2, "GossipOnSelectAllIcc")
RegisterGameObjectEvent (202245, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202245, 2, "GossipOnSelectAllIcc")
RegisterGameObjectEvent (202246, 4,"Teleport_TeleportOnViewAllIcc")
RegisterGOGossipEvent(202246, 2, "GossipOnSelectAllIcc")