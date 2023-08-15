local npcid = 68000

function Tele_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(100, player, 0)
pUnit:GossipMenuAddItem(5, "Main Cities", 10,0)
pUnit:GossipSendMenu(player)
end
if (intid == 10) then
pUnit:GossipCreateMenu(100, player, 0)
pUnit:GossipMenuAddItem(player, 5, "Stormwind", 20, 0)
pUnit:GossipMenuAddItem(player, 5, "Ironforge", 21, 0)
pUnit:GossipMenuAddItem(player, 5, "Darnassus", 22, 0)
pUnit:GossipMenuAddItem(player, 5, "The Exodar", 23, 0)
pUnit:GossipMenuAddItem(player, 5, "Orgrimmar", 16, 0)
pUnit:GossipMenuAddItem(player, 5, "Undercity", 17, 0)
pUnit:GossipMenuAddItem(player, 5, "Thunder Bluff", 18, 0)
pUnit:GossipMenuAddItem(player, 5, "Silvermoon City", 19, 0)
pUnit:GossipMenuAddItem(player, 5, "Shattrath", 24, 0)
pUnit:GossipSendMenu(player)
end

if(intid == 24) then
player:Teleport(530, -1887.510010, 5359.379883, -12.427300)
end
if(intid == 16) then
player:Teleport(1, 1371.068970, -4370.801758, 26.052483)
end
if(intid == 17) then
player:Teleport(0, 2050.203125, 285.650604, 56.994549)
end
if(intid == 18) then
player:Teleport(1, -1304.569946, 205.285004, 68.681396)
end
if(intid == 19) then
player:Teleport(530, 9400.486328, -7278.376953, 14.206780)
end
if(intid == 20) then
player:Teleport(0, -9100.480469, 406.950745, 92.594185)
end
if(intid == 21) then
player:Teleport(0, -5028.265137, -825.976563, 495.301575)
end
if(intid == 22) then
player:Teleport(1, 9985.907227, 1971.155640, 1326.815674)
end
if(intid == 23) then
player:Teleport(530, -4072.202393, -12014.337891, -1.277277)
end



RegisterUnitGossipEvent(npcid, 1, "Tele_OnGossipTalk")



