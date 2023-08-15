local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 112551 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local MyFlightPath = {
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z},
	{MapID, X, Y, Z}
}

--==This is a Test FP That I Used==--
local GMIslandTest = {
	{1, 16219.55, 16218.45, 24},
	{1, 16216.6767, 16238.53, 22},
	{1, 16239.335, 16209.313477, 36},
	{1, 16281.969727, 16200.87, 40},
	{1, 16325.37, 16231.52, 38},
	{1, 16267.65, 16280.12, 37},
	{1, 16244.87, 16298.25, 47},
	{1, 16228.31, 16302.50, 48},
	{1, 16211.47, 16311.51, 42},
	{1, 16211.47, 16311.51, 42},
	{169, 9.100800, -3704.780029, 92.513901}
}



local Hometoparty = {
	{169, 20.455, -3709.52, 100.5},
	{169, 45.92, -3705.6, 109},
	{169, 67.36, -3700.229, 112.75},
	{169, 87.091324, -3709.968, 110.858},
	{169, 133.73, -3731.03, 106.879},
	{169, 127.414, -3743.542236, 106.8466},
	{169, 159.877, -3775.81, 98},
	{169, 159.877, -3775.81, 98},
	{169, 159.877, -3775.81, 98},
	{169, 159.877, -3775.81, 98},
	{0, 4230.770996, -2705.957764, 5.885439}
}


local Hometogmisland = {
	{169, 20.455, -3709.52, 100.5},
	{169, 45.92, -3705.6, 109},
	{169, 67.36, -3700.229, 112.75},
	{169, 87.091324, -3709.968, 110.858},
	{169, 133.73, -3731.03, 106.879},
	{169, 127.414, -3743.542236, 106.8466},
	{169, 159.877, -3775.81, 98},
	{169, 159.877, -3775.81, 98},
	{169, 159.877, -3775.81, 98},
	{169, 159.877, -3775.81, 98},
	{1, 16222.193359, 16280.415039, 22.956253}
}


local hptohome = {
	{0, 4233.78, -2712.17, 12.34},
	{0, 4237.83, -2742.43, 21.34},
	{169, 9.100800, -3704.780029, 92.513901}
}


local hptogm = {
	{0, 4233.78, -2712.17, 12.34},
	{0, 4237.83, -2742.43, 21.34},
	{1, 16222.193359, 16280.415039, 22.956253}
}


local targettohome = {
	{169, -507.03, -3743, 94.18},
	{169, -485, -3743.255, 112},
	{169, -426, -3742.46, 121.76},
	{169, -338.02, -3743.50, 130.5},
	{169, -330, -3774.111, 130.1},
	{169, -245.181, -3776.07, 133.904},
	{169, -132, -3708.804, 135.787},
	{169, -53.538, -3644.95, 140.93},
	{169, -0.280, -3677.589, 135.58},
	{169, 18.563608, -3706.224, 104.58},
	{169, 9.100800, -3704.780029, 92.513901}
}


local gmtoparty = {
	{1, 16219.55, 16218.45, 24},
	{1, 16216.6767, 16238.53, 22},
	{1, 16239.335, 16209.313477, 36},
	{1, 16281.969727, 16200.87, 40},
	{1, 16325.37, 16231.52, 38},
	{1, 16267.65, 16280.12, 37},
	{1, 16244.87, 16298.25, 47},
	{1, 16228.31, 16302.50, 48},
	{1, 16211.47, 16311.51, 42},
	{1, 16211.47, 16311.51, 42},
	{0, 4230.770996, -2705.957764, 5.885439}
}


local undeadstarttohome = {
	{0, 1660.811, 1680.57, 123.633},
	{0, 1643.691, 1678.4246, 128.365},
	{0, 1641.559, 1677.36500, 128.6750},
	{0, 1642.494116, 1665.225, 133.859909},
	{0, 1650.181, 1663.6395, 136.932},
	{0, 1670.326416, 1663.270142, 144.398621},
	{0, 1682.504, 1665.329956, 145.734},
	{0, 1686.027466, 1682.556519, 152.593719},
	{0, 1657.404419, 1664.696899, 155.7017},
	{0, 1644.782715, 1665.355103, 154.933151},
	{169, 9.100800, -3704.780029, 92.513901}
}

function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Flight Points From Home.", 1, 0)
pUnit:GossipMenuAddItem(9, "Flight Points From Gmisland", 10, 0)
pUnit:GossipMenuAddItem(9, "Flight Points From 24 Hour Party", 11, 0)
pUnit:GossipMenuAddItem(9, "Flight Points From Undead starting area", 14, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

function Flight_Master_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Home To GM Island", 5, 0)
pUnit:GossipMenuAddItem(9, "Home To 24 Hour Party", 6, 0)
pUnit:GossipMenuAddItem(9, "Target to home", 9, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 10) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "GM Island To Home", 4, 0)
pUnit:GossipMenuAddItem(9, "GM Island To 24 Hour Party", 13, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 11) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "24 Hour Party To Home", 7, 0)
pUnit:GossipMenuAddItem(9, "24 Hour Party To Gmisland", 8, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end


if (intid == 14) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Undead Starting Area To Home", 15, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 2) then
player:GossipComplete()
end

if (intid == 3) then
		CustomFlightPath = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(MyFlightPath) do
		CustomFlightPath:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(CustomFlightPath, GetDisplay)
		player:GossipComplete()
end

if (intid == 4) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(GMIslandTest) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 5) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(Hometogmisland) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 6) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(Hometoparty) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 7) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(hptohome) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 8) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(hptogm) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 9) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(targettohome) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 13) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(gmtoparty) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end

if (intid == 15) then
		GMIslandJoy = LuaTaxi:CreateTaxi()
        for I, MyFP in ipairs(undeadstarttohome) do
		GMIslandJoy:AddPathNode(MyFP[1], MyFP[2], MyFP[3], MyFP[4])
		end
		player:StartTaxi(GMIslandJoy, GetDisplay)
		player:GossipComplete()
end
end

RegisterUnitGossipEvent(NPCID, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(NPCID, 2, "Flight_Master_OnGossipSelect")