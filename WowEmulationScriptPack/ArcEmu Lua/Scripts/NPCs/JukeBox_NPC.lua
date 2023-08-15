function craigbox_On_Gossip(unit, event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(1,"Play Anguish Walk", 1, 0)
unit:GossipMenuAddItem(1,"Play Vigil Walk", 2, 0)
unit:GossipMenuAddItem(1,"Play Dwarf Brewfest", 3, 0)
unit:GossipMenuAddItem(1,"Play Nagrand", 4, 0)
unit:GossipMenuAddItem(1,"Play Power of the Horde", 5, 0)
unit:GossipMenuAddItem(1,"Play Silvermoon City", 6, 0)
unit:GossipMenuAddItem(1,"Play Drama Music", 7, 0)
unit:GossipMenuAddItem(1,"Play Dwarf Music", 8, 0)
unit:GossipMenuAddItem(1,"Play Stormwind City", 9, 0)
unit:GossipMenuAddItem(1,"Play Irish Ditty", 10, 0)
unit:GossipMenuAddItem(1,"Play Horde Tavern", 11, 0)
unit:GossipMenuAddItem(1,"Play Alliance Tavern", 12, 0)
unit:GossipSendMenu(player)
end

function craigbox_on_gossip_select(pUnit, event, player, id, intid, code, pMisc)
if(intid == 1) then 
player:PlaySoundToSet(11700)
pUnit:SendChatMessage(12, 0, "Now Playing:  Anguish Walk")
player:GossipComplete(player)
end
if(intid == 2) then
player:PlaySoundToSet(11702)
pUnit:SendChatMessage(12, 0, "Now Playing:  Vigil Walk")
player:GossipComplete(player)
end
if(intid == 3) then
player:PlaySoundToSet(11810)
pUnit:SendChatMessage(12, 0, "Now Playing:  Dwarf Brewfest ")
player:GossipComplete(player)
end
if(intid == 4) then
player:PlaySoundToSet(10849)
pUnit:SendChatMessage(12, 0, "Now Playing: Nagrand")
player:GossipComplete(player)
end
if(intid == 5) then
player:PlaySoundToSet(11803)
pUnit:SendChatMessage(12, 0, "Now Playing: Power of the Horde")
player:GossipComplete(player)
end
if(intid == 6) then
player:PlaySoundToSet(9801)
pUnit:SendChatMessage(12, 0, "Now Playing: Silvermoon City")
player:GossipComplete(player)
end
if(intid == 7) then
player:PlaySoundToSet(11706)
pUnit:SendChatMessage(12, 0, "Now Playing: Drama Music")
player:GossipComplete(player)
end
if(intid == 8) then
player:PlaySoundToSet(11810)
pUnit:SendChatMessage(12, 0, "Now Playing: Dwarf Music")
player:GossipComplete(player)
end
if(intid == 9) then
player:PlaySoundToSet(2532)
pUnit:SendChatMessage(12, 0, "Now Playing: Stormwind City")
player:GossipComplete(player)
end
if(intid == 10) then
player:PlaySoundToSet(11805)
pUnit:SendChatMessage(12, 0, "Now Playing: Irish Ditty")
player:GossipComplete(player)
end
if(intid == 11) then
player:PlaySoundToSet(5234)
pUnit:SendChatMessage(12, 0, "Now Playing: Horde Tavern")
player:GossipComplete(player)
end
if(intid == 12) then
player:PlaySoundToSet(4516)
pUnit:SendChatMessage(12, 0, "Now Playing: Alliance Tavern")
player:GossipComplete(player)
end
end

RegisterUnitGossipEvent(200038, 1, "craigbox_On_Gossip")
RegisterUnitGossipEvent(200038, 2, "craigbox_on_gossip_select")