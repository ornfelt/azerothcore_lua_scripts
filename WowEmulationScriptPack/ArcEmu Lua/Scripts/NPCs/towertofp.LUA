local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200109 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{0, 4340.4970703125, -2918.3083496094, 1.6183279752731},
	{0, 4350.4946289063, -2910.0302734375, 5.2162895202637},
	{0, 4354.1318359375, -2906.6733398438, 10.99903678894},
	{0, 4357.4907226563, -2896.6704101563, 18.064514160156},
	{0, 4349.0385742188, -2893.9672851563, 26.506475448608},
	{0, 4342.0805664063, -2900.0825195313, 34.903430938721},
	{0, 4342.345703125, -2906.4694824219, 41.383785247803},
	{0, 4343.0053710938, -2913.6472167969, 41.157196044922},
	{0, 4336.2421875, -2920.8947753906, 40.811092376709},
	{0, 4333.900390625, -2923.4448242188, 38.961624145508}
}


function Flight_Master_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(50, player, 0)
pUnit:GossipMenuAddItem(9, "Flight To The Top Of The Tower.", 1, 0)
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

RegisterUnitGossipEvent(200109, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200109, 2, "Flight_Master_OnGossipSelect")