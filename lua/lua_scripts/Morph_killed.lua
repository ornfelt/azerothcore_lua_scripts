local enabled = false


local function MORPH(event, player, killed)

		local x = player:GetX()
		local y = player:GetY()
		local z = player:GetZ()
		local o = player:GetO()
		local map = player:GetMap()
		local mapID = map:GetMapId()
		local areaId = map:GetAreaId( x, y, z )
		local faction = player:GetFaction()
		local Target = player:GetSelection()
		local playername = player:GetName()
		local isDungeon = map:IsDungeon()
		local spawnedCreature
		local DefaultModel = player:GetNativeDisplayId()
		local CurrentModel = player:GetDisplayId()
		local EnemyModel = killed:GetDisplayId()
		local creatureFamily = killed:GetCreatureType()
		
	local r = math.random(1,100)
	local level = player:GetLevel()
	if r == 25 and (creatureFamily == 7 or creatureFamily == 9 or creatureFamily == 6 or creatureFamily == 3) and not isDungeon then
	player:SetDisplayId(EnemyModel)
	end
	
end

if enabled then
RegisterPlayerEvent(7, MORPH)
end