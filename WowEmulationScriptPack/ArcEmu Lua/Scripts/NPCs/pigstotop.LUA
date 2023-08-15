local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200041 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{1, 16207.37890625, 16085.354492188, 0.40919071435928},
	{1, 16208.934570313, 16091.013671875, 5.2252016067505},
	{1, 16206.413085938, 16100.517578125, 12.193020820618},
	{1, 16194.514648438, 16103.350585938, 17.795667648315},
	{1, 16183.21484375, 16098.034179688, 26.08095741272},
	{1, 16180.2890625, 16089.693359375, 32.600158691406},
	{1, 16182.752929688, 16081.220703125, 40.017932891846},
	{1, 16195.3671875, 16070.194335938, 38.975921630859},
	{1, 16214.841796875, 16064.237304688, 33.875274658203}
}


function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Fly to the top.", 1, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

function Flight_Master_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Fly to the top", 3, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 2) then
player:GossipComplete()
end

if (intid == 3) then
		CustomFlightPath = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(GMIslandtomobs) do
		CustomFlightPath:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(CustomFlightPath, GetDisplay)
		player:GossipComplete()
end
end

RegisterUnitGossipEvent(200041, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200041, 2, "Flight_Master_OnGossipSelect")