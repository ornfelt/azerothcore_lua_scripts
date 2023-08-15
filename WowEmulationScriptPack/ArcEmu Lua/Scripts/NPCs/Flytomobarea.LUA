local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200037 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{1, 16217.343750, 15803.192383, 3.229750},
	{1, 16220.615234, 15825.697266, 7.890772},
	{1, 16257.167969, 15876.914063, 24.896547},
	{1, 16248.118164, 15922.081055, 36.944977},
	{1, 16208.971690, 15959.494141, 43.171654},
	{1, 16218.323242, 16010.194336, 42.870663},
	{1, 16233.277344, 16024.011719, 42.619984},
	{1, 16220.471680, 16035.652344, 42.042980},
	{1, 16225.819336, 16053.399414, 40.973923},
	{1, 16229.049805, 16061.954102, 33.828403}
}


function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Fly To Mob Area.", 1, 0)
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

RegisterUnitGossipEvent(200037, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200037, 2, "Flight_Master_OnGossipSelect")