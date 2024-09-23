local mountA = 33030 
local mountH = 33030
local NPCID = 26842 --flight master ID

--(map ID, X, Y, Z)
local MallToGakam = {
	{571,3531.33007813,3442.41992188,55.2398986816},
	{571,3591.04003906,3422.37988281,76.075302124},
	{571,3672.84008789,3406.22998047,84.8355026245},
	{571,3808.45996094,3372.42993164,91.3994979858},
	{571,3911.79003906,3355.36010742,90.3628005981},
	{571,4039.41992188,3302.06005859,81.0441970825},
	{571,4112.52978516,3248.29003906,78.158203125},
	{571,4168.45019531,3239.66992187,80.6540985107},
	{571,4299.29003906,3289.48999023,87.0535964966},
	{571,4311.37988281,3329.76000977,84.3403015137},
	{571,4299.20019531,3327.45996094,78.7881011963}
}
local MallToGakamPath = AddTaxiPath(MallToGakam,mountA,mountH)


local GakamToMall = {
	{571,4299.20019531,3327.45996094,78.7881011963},
	{571,4311.37988281,3329.76000977,84.3403015137},
	{571,4299.29003906,3289.48999023,87.0535964966},
	{571,4168.45019531,3239.66992187,80.6540985107},
	{571,4112.52978516,3248.29003906,78.158203125},
	{571,4039.41992188,3302.06005859,81.0441970825},
	{571,3911.79003906,3355.36010742,90.3628005981},
	{571,3808.45996094,3372.42993164,91.3994979858},
	{571,3672.84008789,3406.22998047,84.8355026245},
	{571,3591.04003906,3422.37988281,76.075302124},
	{571,3531.33007813,3442.41992188,55.2398986816},
	{571,3520.82910200,3447.67163100,43.3153760000}
}
local GakamToMallPath = AddTaxiPath(GakamToMall,mountA,mountH)

local MalltoTimeless = {
{571,3520.83,3447,43.3151},
{571,3529.62,3442.7,54.1891},
{571,3560.65,3427.38,64.0538},
{571,3594.85,3392.76,84.5331},
{571,3597.76,3354.26,98.4715},
{571,3568.9,3318.33,109.45},
{571,3525.54,3303.03,115.319},
{571,3474.74,3290,117.522},
{571,3422.52,3267.79,112.547},
{571,3317.39,3205.97,101.605},
{571,3264.81,3203.97,98.0086},
{571,3226.26,3236.78,86.4634},
{571,3180.26,3285.24,65.8094},
{571,3136.32,3317.64,47.6489},
{571,3055.17,3345.53,21.2071},
{571,3038.76,3369.1,47.8384},
{571,3013.12,3381.65,78.0072},
{571,2967.69,3353.99,93.3255},
{571,2918.07,3304.76,93.9043},
{571,2859.99,3239.4,90.8072},
{571,2802.57,3173.46,87.5247},
{571,2745.14,3107.53,84.2421},
{571,2699.2,3054.77,81.6161},
{571,2650.27,3005.18,77.0945},
{571,2601.56,2942.54,59.4074},
{571,2563.57,2884.47,52.3548},
{571,2522.36,2827.96,49.5457},
{571,2481.15,2771.44,46.7365},
{571,2450.24,2729.06,44.6296},
{571,2409.03,2672.55,41.8205},
{571,2378.18,2630.1,40.2525},
{571,2347.41,2587.56,39.657},
{571,2306.97,2533.05,42.1924},
{571,2261.58,2485.79,60.131},
{571,2222.13,2461.26,84.291},
{571,2154.54,2420.66,121.792},
{571,2112.64,2393.06,137.13},
{571,2056.9,2353.17,150.98},
{571,2016.53,2319.97,155.179},
{571,1969.18,2275.79,146.427},
{571,1921.72,2230.21,122.689},
{571,1848.55,2165.11,84.9141},
{571,1795.15,2125.12,64.0629},
{571,1736.31,2090.84,48.5633},
{571,1672.76,2062.99,39.499},
{571,1607.08,2040.03,32.0573},
{571,1556.94,2025.36,26.8924},
{571,1489.75,2006.42,21.9843},
{571,1421.83,1989.69,19.5874},
{571,1370.83,1977.28,18.9691},
{571,1303.21,1959.19,18.433},
{571,1253.1,1943.63,17.9543},
{571,1195.74,1917.76,19.3454},
{571,1164.17,1871.53,24.7689},
{571,1154.4,1816.69,28.2476},
{571,1161.23,1747.33,25.6713},
{571,1175.66,1696.92,23.7704},
{571,1204.48,1633.32,22.7011},
{571,1229.66,1573.76,22.1607},
{571,1249.37,1506.67,21.126},
{571,1302.27,1467.76,17.4878},
{571,1344.96,1462.48,13.904},
{571,1388.63,1462.52,9.98747}
}
local MalltoTimeless = AddTaxiPath(MalltoTimeless,mountA,mountH)

local MalltoStromgarde = {
{571,3520.83,3447,43.3151},
{571,3529.62,3442.7,54.1891},
{571,3560.65,3427.38,64.0538},
{571,3594.85,3392.76,84.5331},
{571,3597.76,3354.26,98.4715},
{571,3568.9,3318.33,109.45},
{571,3525.54,3303.03,115.319},
{571,3474.74,3290,117.522},
{571,3422.52,3267.79,112.547},
{571,3317.39,3205.97,101.605},
{571,3264.81,3203.97,98.0086},
{571,3226.26,3236.78,86.4634},
{571,3180.26,3285.24,65.8094},
{571,3136.32,3317.64,47.6489},
{571,3055.17,3345.53,21.2071}
}
local MalltoStromgarde = AddTaxiPath(MalltoStromgarde,mountA,mountH)


function OnFirstTalk(event, Player, unit)
	Player:GossipMenuAddItem(9, "Show Me Flights.", 0, 1)
	Player:GossipMenuAddItem(9, "Never Mind", 0, 2)
	Player:GossipSendMenu(1, unit)
end

function OnSelect(event, player, unit, sender, intid, code)
    if (intid == 1) then
        areaId = player:GetAreaId()
        if(areaId == 4158) then
            player:GossipMenuAddItem(1, "|TInterface\\icons\\Achievement_Zone_Durotar:30:30:-15:0|tGakam'kar", 0, 3)
			  player:GossipMenuAddItem(1, "|TInterface\\icons\\tokenofthedead:30:30:-15:0|tTimeless Isle", 0, 5)
			  player:GossipMenuAddItem(1, "|TInterface\\icons\\Achievement_Zone_ArathiHighlands_01:30:30:-15:0|tStromgarde", 0, 6)
			  player:GossipMenuAddItem(1, "Never Mind", 0, 2)
			  player:GossipSendMenu(2, unit)
        end
		
        if(areaId == 4160) then
            player:GossipMenuAddItem(1, "|TInterface\\icons\\Omni_trinket:30:30:-15:0|tCity of Aken", 0, 4)
			player:GossipMenuAddItem(1, "Never Mind", 0, 2)
			player:GossipSendMenu(2, unit)
        end
end

	if (intid == 2) then
		player:GossipComplete()
	end

	if (intid == 3) then
		player:StartTaxi(MallToGakamPath) --could add a horde/alliance faction check so you could do horde/alliance mounts
		player:GossipComplete()
	end

	if (intid == 4) then
		player:StartTaxi(GakamToMallPath) --could add a horde/alliance faction check so you could do horde/alliance mounts
		player:GossipComplete()
	end
	if (intid == 5) then
		player:StartTaxi(MalltoTimeless) --could add a horde/alliance faction check so you could do horde/alliance mounts
		player:GossipComplete()
	end
	if (intid == 6) then
		player:StartTaxi(MalltoStromgarde) --could add a horde/alliance faction check so you could do horde/alliance mounts
		player:GossipComplete()
	end
--add another here, be sure to change the array variable name in secodn line for ipairs

end

RegisterCreatureGossipEvent(NPCID, 1, OnFirstTalk)
RegisterCreatureGossipEvent(NPCID, 2, OnSelect)