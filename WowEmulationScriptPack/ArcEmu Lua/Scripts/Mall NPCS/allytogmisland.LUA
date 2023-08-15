local GetDisplay = 22471 --- Change this to a flying mount you want
local NPCID = 200110 --Default NPC ID

--==Below Is The Coords Of Each Node, Top to Bottom, Set Them to What you want ALL CREDITS TO Xzomblie==--

local GMIslandtomobs = {
	{0, 4331.634765625, -2921.8408203125, 38.814640045166},
	{0, 4329.931640625, -2913.744140625, 39.752639770508},
	{0, 4326.9663085938, -2899.6472167969, 37.239635467529},
	{0, 4319.6298828125, -2887.3884277344, 33.910846710205},
	{0, 4306.859375, -2878.4702148438, 31.95036315918},
	{0, 4296.0317382813, -2862.4289550781, 30.555179595947},
	{0, 4289.8706054688, -2847.4650878906, 29.93487739563},
	{0, 4274.2485351563, -2835.4013671875, 29.723115921021},
	{0, 4256.080078125, -2832.7456054688, 30.210277557373},
	{0, 4246.6782226563, -2846.4543457031, 31.345508575439},
	{0, 4245.099609375, -2867.34765625, 32.752918243408},
	{0, 4249.0239257813, -2876.13671875, 33.430114746094},
	{0, 4254.8139648438, -2876.8666992188, 33.730415344238},
	{0, 4254.6328125, -2868.9165039063, 30.080018997192},
	{0, 4259.5131835938, -2850.25, 20.983232498169},
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

RegisterUnitGossipEvent(200110, 1, "Flight_Master_OnGossipTalk")
RegisterUnitGossipEvent(200110, 2, "Flight_Master_OnGossipSelect")