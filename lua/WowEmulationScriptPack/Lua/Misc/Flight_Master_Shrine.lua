local mountA = 985326 
local mountH = 985326
local NPCID = 268420 --flight master ID

--(map ID, X, Y, Z)
local ShrineToRift = {
	{571,-11840.068359,11963.835938,138.475464},
	{571,-11869.657227,11971.374023,157.892334},
	{571,-11956.526367,11999.458984,187.846817},
	{571,-12066.919922,12048.042969,105.725037},
	{571,-12037.121094,12121.728519,33.195724},
	{571,-12071.252930,12066.263672,-3.732744},
	{571,-12090.960938,12065.684570,-6.276078}
}
local ShrineToRift = AddTaxiPath(ShrineToRift,mountA,mountH)


local RiftToShrine = {
	{571,-12090.960938,12065.684570,-6.276078},
	{571,-12071.252930,12066.263672,-3.732744},
	{571,-12037.121094,12121.728519,33.195724},
	{571,-12066.919922,12048.042969,105.725037},
	{571,-11956.526367,11999.458984,187.846817},
	{571,-11869.657227,11971.374023,157.892334},
	{571,-11840.068359,11963.835938,138.475464}
}
local RiftToShrine = AddTaxiPath(RiftToShrine,mountA,mountH)

function OnFirstTalk(event, Player, unit)
	Player:GossipMenuAddItem(9, "Show Me Flights.", 0, 1)
	Player:GossipMenuAddItem(9, "Never Mind", 0, 2)
	Player:GossipSendMenu(1, unit)
end

function OnSelect(event, player, unit, sender, intid, code)
    if (intid == 1) then
	 areaId = player:GetAreaId()
        if(areaId == 4418) then
            player:GossipMenuAddItem(1, "|TInterface\\icons\\Achievement_Zone_Durotar:30:30:-15:0|tTake me to the Rifts.", 0, 3)
			player:GossipMenuAddItem(1, "Never Mind", 0, 2)
			player:GossipSendMenu(2, unit)
		end
		if(areaId == 4421) then
			player:GossipMenuAddItem(1, "|TInterface\\icons\\tokenofthedead:30:30:-15:0|tTake me to the Shrine.", 0, 5)
			player:GossipMenuAddItem(1, "Never Mind", 0, 2)
			player:GossipSendMenu(2, unit)
        end
	end

	if (intid == 2) then
		player:GossipComplete()
	end

	if (intid == 3) then
		player:StartTaxi(ShrineToRift) --could add a horde/alliance faction check so you could do horde/alliance mounts
		player:GossipComplete()
	end

	if (intid == 5) then
		player:StartTaxi(RiftToShrine) --could add a horde/alliance faction check so you could do horde/alliance mounts
		player:GossipComplete()
	end
--add another here, be sure to change the array variable name in secodn line for ipairs

end

RegisterCreatureGossipEvent(NPCID, 1, OnFirstTalk)
RegisterCreatureGossipEvent(NPCID, 2, OnSelect)