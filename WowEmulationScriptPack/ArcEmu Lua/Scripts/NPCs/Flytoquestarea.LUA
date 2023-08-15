local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200039 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{1, 16227.350585938, 16060.040039063, 33.696102142334},
	{1, 16231.749023438, 16037.03515625, 41.580249786377},
	{1, 16220.421875, 15976.833007813, 39.546241760254},
	{1, 16225.178710938, 15930.282226563, 33.371894836426},
	{1, 16257.448242188, 15897.748046875, 26.903760910034},
	{1, 16246.51171875, 15860.900390625, 21.242902755737},
	{1, 16223.165039063, 15831.670898438, 9.9416656494141},
	{1, 16194.716796875, 15832.034179688, 14.817043304443},
	{1, 16160.34375, 15828.9453125, 17.267534255981},
	{1, 16180.709960938, 15796.3046875, 15.628900527954},
	{1, 16225.643554688, 15803.577148438, 3.5191562175751}
}


function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Flight To The Quest Area.", 1, 0)
pUnit:GossipMenuAddItem(9, "Never Mind", 2, 0)
pUnit:GossipSendMenu(player)
end

function Flight_Master_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "na", 3, 0)
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

RegisterUnitGossipEvent(200039, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200039, 2, "Flight_Master_OnGossipSelect")