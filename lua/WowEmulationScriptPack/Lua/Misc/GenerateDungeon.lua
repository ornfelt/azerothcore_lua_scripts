--[[
TO BE DONE
 - - - - - - - - - - 
add a check for how many pieces are being made, cap it at a certain value
]]
local mapId = 0
local InstanceId = 0
local distanceApart = 2000 -- yards between dungeon instances
local allCurrentDungeons = {}
local pieces = {
	{piece1ID,
	x,-- possibly move the x/y/z/o of these to a global for starting
	y,
	z,
	o,
		{--NPC spawns(requires a lot of testing ingame for x/y/z/o)
			{npcid1,x,y,z,o},
			{npcid2,x,y,z,o},
		},
		howManyPiecesRequired, --amount of other pieces that would be attached
		{
		{optionpiece1ID,x,y,z,o},--x/y/z/o differences to add another piece(requires a lot of testing ingame for x/y/z/o)
		{optionpiece2ID,x,y,z,o},
		},
	},
	{piece2ID,
	x,
	y,
	z,
	o,
		{--NPC spawns(requires a lot of testing ingame for x/y/z/o)
			{npcid1,x,y,z,o},
			{npcid2,x,y,z,o},
		},
		howManyPiecesRequired, --amount of other pieces that would be attached
		{
		{optionpiece1ID,x,y,z,o},--x/y/z/o differences to add another piece(requires a lot of testing ingame for x/y/z/o)
		{optionpiece2ID,x,y,z,o},
		},
	},
}

local function spawnMobOnTile(rand,gameObject,allModels)
	for i,v in pairs(pieces[rand][6]) do
		 local creature = PerformIngameSpawn( 1, v[1], mapId, instanceId, v[2] + gameObject:GetX(), v[3] + gameObject:GetY(), v[4] + gameObject:GetZ(), v[5] + gameObject:GetO())
		table.insert(allModels,{1,creature})
	end
end

local function spawnConnectingObject(rand1,gameObject,allModels)
	local gameObject1 = PerformIngameSpawn( 2, pieces[rand1][1], mapId, InstanceId, pieces[rand1][2] + gameObject:GetX(), pieces[rand1][3] + gameObject:GetY(), pieces[rand1][4] + gameObject:GetZ(), pieces[rand1][5] + gameObject:GetO())
	table.insert(allModels,{2,gameObject1})
	spawnMobOnTile(rand1,gameObject1,allModels)
	if(pieces[rand1][7] ~= 1) then
		local rand2 = math.random(#pieces[rand1][7])
		spawnConnectingObject(rand2,gameObject,allModels)
	end
end

local function startEvent(player)
	local allModels = {}
	local totalPasses = 0
	local hasMore == true
	local rand = 1--start with a single opening piece(possibly add more start areas later)
	local space = (distanceApart * (#allCurrentDungeons -1))
	
	local gameObject = PerformIngameSpawn( 2, pieces[rand][1], mapId, InstanceId, pieces[rand][2] + space, pieces[rand][3] + space, pieces[rand][4] + space, pieces[rand][5])
	table.insert(allModels,{2,gameObject})
	totalPasses = totalPasses+1
	player:Teleport( mapId, pieces[rand][2] + space, pieces[rand][3] + space, pieces[rand][4] + space + 15, pieces[rand][5])
	spawnMobOnTile(rand,gameObject,allModels)
	
	--while (totalPasses < 2) do
		local rand1 = math.random(#pieces[rand][7])
		spawnConnectingObject(rand1,gameObject,allModels) --can loop inside itself
		totalPasses = totalPasses+1
	--end
		--gameObject:GetX()
		--gameObject:GetY()
		--gameObject:GetZ()
		--gameObject:GetO()
		
		
	table.insert(allCurrentDungeons,{player:GetGUIDLow(),allModels})
end

local function endEvent(player)
	for i,v in pairs(allCurrentDungeons) do
		if(v[1] == player:GetGUIDLow()) then
			for i,v in pairs(v[2]) do
				if(v[1] == 1) then
					v[2]:DespawnOrUnsummon(0)
				else
					v[2]:Despawn()
				end
			end
			break
		end
	end
end