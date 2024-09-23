local dungeonStartPoints = {--mapID,x,y,z,o
	{570,1,2,3,0},
	{571,1,2,3,0}
}
----------

playerCurFloor = {}
local curMapIds = {}

for i,v in pairs(dungeonStartPoints)do
	curMapIds[i] = v[1]
end

function isCorrectMap(player)
	local curPlayerMap = player:GetMapId()
	for i,v in pairs(curMapIds)do
		if(curPlayerMap == v)then
			return true
		end
	end
	return false
end

local function movePlayerToMap(player)
	curMobs[player:GetGUIDLow()] = {}
	if(playerCurFloor[player:GetGUIDLow()] ~= nil)then
		playerCurFloor[player:GetGUIDLow()] = playerCurFloor[player:GetGUIDLow()] + 1
	else
		playerCurFloor[player:GetGUIDLow()] = 1
	end
	local choiceMap = dungeonStartPoints[math.random(#dungeonStartPoints)]
	player:Teleport( choiceMap[1], choiceMap[2], choiceMap[3], choiceMap[4], choiceMap[5])
end

function resetDungeon(player)
	despawnCreatures(player)
	movePlayerToMap(player)
	spawnCreatures(player)
end

function exitDungeon(player)
	despawnCreatures(player)
	curMobs[player:GetGUIDLow()] = nil
	playerCurFloor[player:GetGUIDLow()] = nil
	playerToSpellEffectCacheRandDung[player:GetGUIDLow()] = nil
	player:Teleport( 570, 1, 1, 1, 1)--dungeon Exit, prolly on some GoB click like a door
end