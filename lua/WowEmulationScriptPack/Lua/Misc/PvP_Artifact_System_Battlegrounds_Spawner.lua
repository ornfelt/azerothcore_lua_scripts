local CreatureID = 1
local objectID = 716101
local spawntime = 120000
local allthebgstuff = {--can have different amount of places
{{650.189,-281.391,30.889,1.0},{361.518,-287.152,-43.529,1.0},{-255.812,-296.7999,6.692,1.0},{-918.953,-399.092,51.141,1.0},{-1255.777,-336.276,60.337,1.0}},--alterac
{{933.331,1433.723,345.535,0.151},{1523.811,1481.757,351.911,3.141},{1283.676,1436.666,315.224,3.23},{1197.36,1519.311,307.172,2.387},{1250.342,1328.478,315.276,1.07}},--WSG
{{849.984,834.229,-57.809,1.0},{758.660,1228.497,20.637,1.0},{1139.385,1190.335,-52.840,1.0},{1000.000,1067.515,-51.546,1.0},{1215.054,807.304,-103.093,1.0}},--arathi
{{2142.916,1519.574,1149.792,1.0},{2117.916,1562.115,1159.511,1.0},{2172.882,1581.311,1159.512,1.0},{2331.291,1542.370,1171.010,1.0},{2133.865,1415.011,1156.149,1.0}},--EotS
{{1292.979,-64.611,34.05,1.0},{1461.003,62.632,7.556,1.0},{1501.675,-77.887,5.741,1.0},{1165.480,-255.992,66.683,1.0},{1171.888,60.06,69.037,1.0}},--SotA
{{9266288,-734.810,4.298,1.0},{781.6555,-628.389,9.655,1.0},{825.892,-337.80,12.487,1.0},{281.532,-1101.0299,19.547,1.0},{724.075,-1014.315,134.762,1.0}},--Isle of Conquest
}
function onSpawnInBG(event, creature)
	creature:RegisterEvent(makeChest, {60000, 80000}, 0)	
end
function makeChest(event, delay, repeats, creature)
	local currentMap = creature:GetMapId()
	local chance = math.random(10)
	if(chance > 6) then
	print(chance)
		local plrs = creature:GetMap():GetPlayers()
		for k, v in pairs(plrs) do
			v:SendBroadcastMessage("|TInterface/ICONS/exclam:35:35|t |cFFff0000A powerful artifact has awoken on the battlefield. |TInterface/ICONS/exclam:35:35|t")
			v:SendAreaTriggerMessage("|TInterface/ICONS/exclam:35:35|t |cFFff0000A powerful artifact has awoken on the battlefield. |TInterface/ICONS/exclam:35:35|t")
		end	
		if(currentMap == 30) then
			local choice = math.random(#allthebgstuff[1])
			print(choice)
			creature:SummonGameObject( objectID, allthebgstuff[1][choice][1], allthebgstuff[1][choice][2], allthebgstuff[1][choice][3], allthebgstuff[1][choice][4], spawntime)
		elseif(currentMap == 489) then
			local choice = math.random(#allthebgstuff[2])
			print(choice)
			creature:SummonGameObject( objectID, allthebgstuff[2][choice][1], allthebgstuff[2][choice][2], allthebgstuff[2][choice][3], allthebgstuff[2][choice][4], spawntime)
		elseif(currentMap == 529) then
			local choice = math.random(#allthebgstuff[3])
			print(choice)
			creature:SummonGameObject( objectID, allthebgstuff[3][choice][1], allthebgstuff[3][choice][2], allthebgstuff[3][choice][3], allthebgstuff[3][choice][4], spawntime)
		elseif(currentMap == 566) then
			local choice = math.random(#allthebgstuff[4])
			print(choice)
			creature:SummonGameObject( objectID, allthebgstuff[4][choice][1], allthebgstuff[4][choice][2], allthebgstuff[4][choice][3], allthebgstuff[4][choice][4], spawntime)
		elseif(currentMap == 607) then
			local choice = math.random(#allthebgstuff[5])
			print(choice)
			creature:SummonGameObject( objectID, allthebgstuff[5][choice][1], allthebgstuff[5][choice][2], allthebgstuff[5][choice][3], allthebgstuff[5][choice][4], spawntime)
		elseif(currentMap == 628) then
			local choice = math.random(#allthebgstuff[6])
			print(choice)
			creature:SummonGameObject( objectID, allthebgstuff[6][choice][1], allthebgstuff[6][choice][2], allthebgstuff[6][choice][3], allthebgstuff[6][choice][4], spawntime)
		end
	end
end


RegisterCreatureEvent( CreatureID, 5, onSpawnInBG )