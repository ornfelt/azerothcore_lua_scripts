local npcid = 990091
function jukebox_On_Gossip(unit, event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(1,"Play Anguish Walk", 1, 0)
unit:GossipMenuAddItem(1,"Play Vigil Walk Music", 2, 0)
unit:GossipMenuAddItem(1,"Play Brewfest Music", 3, 0)
unit:GossipMenuAddItem(1,"Play Nagrand Music", 4, 0)
unit:GossipMenuAddItem(1,"Play Power of the Horde", 5, 0)
unit:GossipMenuAddItem(1,"Play Silvermoon City Music", 6, 0)
unit:GossipMenuAddItem(1,"Play Drama Music", 7, 0)
unit:GossipMenuAddItem(1,"Play Dwarf Music", 8, 0)
unit:GossipMenuAddItem(1,"Play Stormwind City Music", 9, 0)
unit:GossipMenuAddItem(1,"Play Irish Ditty Music", 10, 0)
unit:GossipMenuAddItem(1,"Play Horde Tavern Music", 11, 0)
unit:GossipMenuAddItem(1,"Play Alliance Tavern Music", 12, 0)
unit:GossipSendMenu(player)
end

function jukebox_on_gossip_select(pUnit, event, player, id, intid, code, pMisc)
if(intid == 1) then 
player:PlaySoundToSet(11700)
pUnit:SendChatMessage(12, 0, "Anguish Walk is on the spin - board")
player:GossipComplete(player)
end
if(intid == 2) then
player:PlaySoundToSet(11702)
pUnit:SendChatMessage(12, 0, "Wow, Vigil Walk... now that's something new")
player:GossipComplete(player)
end
if(intid == 3) then
player:PlaySoundToSet(11810)
pUnit:SendChatMessage(12, 0, "Can someone get me a beer... it goes well with this song")
player:GossipComplete(player)
end
if(intid == 4) then
player:PlaySoundToSet(10849)
pUnit:SendChatMessage(12, 0, "Uhmmm... Nagrand music? You have to be kidding me")
player:GossipComplete(player)
end
if(intid == 5) then
player:PlaySoundToSet(11803)
pUnit:SendChatMessage(12, 0, "POWER OF THE HORDE!!!")
player:GossipComplete(player)
end
if(intid == 6) then
player:PlaySoundToSet(9801)
pUnit:SendChatMessage(12, 0, "Ok, now some Silvermoon City music")
player:GossipComplete(player)
end
if(intid == 7) then
player:PlaySoundToSet(11706)
pUnit:SendChatMessage(12, 0, "Where's the drama. I LIKEZ ME SOME FIGHTZ!")
player:GossipComplete(player)
end
if(intid == 8) then
player:PlaySoundToSet(11810)
pUnit:SendChatMessage(12, 0, "Irish music is in this 1-3 minutes")
player:GossipComplete(player)
end
if(intid == 9) then
player:PlaySoundToSet(2532)
pUnit:SendChatMessage(12, 0, "Some, Human music...")
player:GossipComplete(player)
end
if(intid == 10) then
player:PlaySoundToSet(11805)
pUnit:SendChatMessage(12, 0, "Ok, Irish Music...")
player:GossipComplete(player)
end
if(intid == 11) then
player:PlaySoundToSet(5234)
pUnit:SendChatMessage(12, 0, "WOO HOOO, HORDE 4EVER!!!")
player:GossipComplete(player)
end
if(intid == 12) then
player:PlaySoundToSet(4516)
pUnit:SendChatMessage(12, 0, "Woo hoo, Alliance... yay")
player:GossipComplete(player)
end
end

RegisterUnitGossipEvent(990091, 1, "jukebox_On_Gossip")
RegisterUnitGossipEvent(990091, 2, "jukebox_on_gossip_select")