local mobCoords = {
	[570] = {--mapid
		[1] = {1,2,3},{1,2,3},--mobtype = {x,y,z}
		[2] = {1,2,3}
	},
	[571] = {
		[1] = {1,2,3},
		[2] = {1,2,3}
	}
}

local mobTypes = {
	{1,2,4,3,5},--mobtype1, list of creatureIDs
	{1,3}--mobtype2, list of creatureIDs
}

local healthSpell = 1
local speedSpell = 1
local damageSpell = 1
----------
curMobs = {}

function despawnCreatures(player)
	if(curMobs[player:GetGUIDLow()] ~= nil)then
		for i,v in pairs(curMobs[player:GetGUIDLow()])do
			v:DespawnOrUnsummon()
		end
	end
end

function spawnCreatures(player)
	local mobTable = mobCoords[player:GetMapId()]
	for i,v in pairs(mobTable) do
		for q,c in pairs(v) do
			local creature = PerformIngameSpawn( 1, mobTypes[q][math.random(#mobTypes[q])], player:GetMapId(), player:GetInstanceId(), v[1], v[2], v[3], math.random(100)/100 )
			local floorNum = playerCurFloor[player:GetGUIDLow()]
			local healthAura = creature:AddAura( healthSpell, creature)
			local speedAura = creature:AddAura( speedSpell, creature)
			local damageAura = creature:AddAura( damageSpell, creature)
			if(floorNum > 1)then
				floorNum = floorNum*(math.floor(floorNum/5)+1)
				healthAura:SetStackAmount(floorNum)
				speedAura:SetStackAmount(floorNum)
				damageAura:SetStackAmount(floorNum)
			end
			table.insert(curMobs[player:GetGUIDLow()],creature)
		end
	end
end