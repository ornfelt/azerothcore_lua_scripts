local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200040 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{1, 16215.0703125, 16059.840820313, 33.894947052002},
	{1, 16210.923828125, 16047.940429688, 36.855388641357},
	{1, 16202.358398438, 16051.552734375, 44.984069824219},
	{1, 16198.086914063, 16058.036132813, 46.270408630371},
	{1, 16196.0625, 16063.547851563, 42.460155487061},
	{1, 16195.42578125, 16087.309570313, 24.369068145752},
	{1, 16205.198242188, 16087.188476563, 17.510608673096},
	{1, 16200.807617188, 16083.98046875, 7.8020811080933},
	{1, 16199.55078125, 16089.782226563, 2.0905103683472},
	{1, 16207.348632813, 16082.212890625, 1.1910399198532}
}


function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Fly to the bottom.", 1, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

function Flight_Master_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Fly to the bottom", 3, 0)
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

RegisterUnitGossipEvent(200040, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200040, 2, "Flight_Master_OnGossipSelect")