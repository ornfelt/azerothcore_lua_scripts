function Social_OnGossip(unit, event, player)
    unit:GossipCreateMenu(50, player, 0)
	unit:GossipMenuAddItem(0,"Show Me Who's In The World", 1,0)
	unit:GossipMenuAddItem(0,"What Revision Are We Running?", 2,0)
	unit:GossipMenuAddItem(0,"BattleGrounds", 4,0)
	unit:GossipMenuAddItem(0,"Arena's", 5,0)
	unit:GossipMenuAddItem(0,"NPC Windows", 6,0)
	unit:GossipMenuAddItem(0,"Player Tools", 7,0)
	unit:GossipMenuAddItem(0,"Show Me My Honor", 900,0)
	unit:GossipMenuAddItem(0,"Show Me My Arena Points", 901,0)
	unit:GossipMenuAddItem(0,"Nevermind", 999,0)
	unit:GossipSendMenu(player)
	end


function Social_OnSelect (unit, event, player, id, intid, code)

if(intid == 4) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(0,"Alterac Valley", 700,0)
unit:GossipMenuAddItem(0,"Warsong Gulch", 701,0)
unit:GossipMenuAddItem(0,"Arathi Basin", 702,0)
unit:GossipMenuAddItem(0,"Eye of The Storm", 703,0)
unit:GossipMenuAddItem(0,"Strand of The Ancient", 704,0)
unit:GossipMenuAddItem(0,"Isle Of Conquest", 705,0)
unit:GossipMenuAddItem(0,"Nevermind", 999,0)
unit:GossipSendMenu(player)
end

if(intid == 5) then
unit:GossipCreateMenu(3544, player, 0)
unit:GossipMenuAddItem(0,"2VS2", 706,0)
unit:GossipMenuAddItem(0,"3VS3", 707,0)
unit:GossipMenuAddItem(0,"5VS5", 708,0)
unit:GossipMenuAddItem(0,"Nevermind", 999,0)
unit:GossipSendMenu(player)
end

if(intid == 6) then
unit:GossipCreateMenu(3545, player, 0)
unit:GossipMenuAddItem(0,"Trainer", 800,0)
unit:GossipMenuAddItem(0,"InnKeeper", 801,0)
unit:GossipMenuAddItem(0,"Bank Window", 802,0)
unit:GossipMenuAddItem(0,"Auction Window", 803,0)
unit:GossipMenuAddItem(0,"Nevermind", 999,0)
unit:GossipSendMenu(player)
end

if(intid == 7) then
unit:GossipCreateMenu(3546, player, 0)
unit:GossipMenuAddItem(0,"Player Speed (25)", 600,0)
unit:GossipMenuAddItem(0,"Sex Changer", 601,0)
unit:GossipMenuAddItem(0,"Nevermind", 999,0)
unit:GossipSendMenu(player)
end

if(intid == 601) then
unit:GossipCreateMenu(3547, player, 0)
unit:GossipMenuAddItem(0,"Male", 620,0)
unit:GossipMenuAddItem(0,"Female", 621,0)
unit:GossipMenuAddItem(0,"Nevermind", 999,0)
unit:GossipSendMenu(player)
end

if (intid == 1) then
GetPlayersInWorld()
player:GossipComplete()
end
if (intid == 2) then
GetArcemuRevision()
player:GossipComplete()
end
if (intid == 700) then
player:SendBattlegroundWindow(1)
player:GossipComplete()
end
if (intid == 701) then
player:SendBattlegroundWindow(2)
player:GossipComplete()
end
if (intid == 702) then
player:SendBattlegroundWindow(3)
player:GossipComplete()
end
if (intid == 706) then
player:SendBattlegroundWindow(4)
player:GossipComplete()
end
if (intid == 707) then
player:SendBattlegroundWindow(5)
player:GossipComplete()
end
if (intid == 708) then
player:SendBattlegroundWindow(6)
player:GossipComplete()
end
if (intid == 703) then
player:SendBattlegroundWindow(7)
player:GossipComplete()
end
if (intid == 704) then
player:SendBattlegroundWindow(9)
player:GossipComplete()
end
if (intid == 705) then
player:SendBattlegroundWindow(30)
player:GossipComplete()
end
if (intid == 800) then
player:SendTrainerWindow(unit)
player:GossipComplete()
end
if (intid == 801) then
player:SendInnkeeperWindow(unit)
player:GossipComplete()
end
if (intid == 802) then
player:SendBankWindow(unit)
player:GossipComplete()
end
if (intid == 803) then
player:SendAuctionWindow(unit)
player:GossipComplete()
end
if (intid == 900) then
player:GetTotalHonor()
player:GossipComplete()
end
if (intid == 901) then
player:GetArenaPoints()
player:GossipComplete()
end
if (intid == 600) then
player:SetPlayerSpeed(25)
player:GossipComplete()
end
if (intid == 620) then
unit:SetGender(0)
player:GossipComplete()
end
if (intid == 621) then
unit:SetGender(1)
player:GossipComplete()
end
if (intid == 999) then
player:GossipComplete()
end
end

RegisterUnitGossipEvent(99900, 1, "Social_OnGossip")
RegisterUnitGossipEvent(99900, 2, "Social_OnSelect")