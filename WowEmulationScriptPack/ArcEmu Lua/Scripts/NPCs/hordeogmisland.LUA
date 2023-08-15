local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200111 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{530, -1673.1029052734, 8383.2802734375, -22.123943328857},
	{530, -1675.5777587891, 8383.2939453125, -19.649068832397},
	{530, -1685.1931152344, 8384.96484375, -9.5961322784424},
	{530, -1694.7974853516, 8393.765625, -4.866020202636},
	{530, -1688.1676025391, 8407.8212890625, 1.1253226995468},
	{530, -1664.4392089844, 8432.2158203125, 2.9909462928772},
	{530, -1651.3248291016, 8438.169921875, 3.7871141433716},
	{530, -1629.8044433594, 8443.9619140625, 5.0094590187073},
	{530, -1617.6007080078, 8447.341796875, 5.7866220474243},
	{530, -1604.3031005859, 8451.6533203125, 6.0170216560364},
	{530, -1584.3272705078, 8458.0703125, 5.1303391456604},
	{530, -1579.2468261719, 8459.7021484375, 4.9048266410828},
	{1, 16225.962890625, 15803.934570313, 3.5417432785034}
}


function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Fly To Quest Zone.", 1, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

function Flight_Master_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Flight To The Mob Area", 3, 0)
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

RegisterUnitGossipEvent(200111, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200111, 2, "Flight_Master_OnGossipSelect")