local enabled = true
local hirebot = "hirebot"
local spawndur = 180000


local function Timed(eventid, delay, repeats, worldobject)
	worldobject:DespawnOrUnsummon( 1000 )
	worldobject:RemoveEvents()
end


local function checkdespawn(eventid, delay, repeats, player)
local HireNPCnear = player:GetNearestCreature( 60, 70000 )

local nearplayer = HireNPCnear:GetNearestPlayer( 5 )


if nearplayer == nil then
--spawnedHire:DespawnOrUnsummon( 1000 )
player:RemoveEventById( eventid )
HireNPCnear:RegisterEvent(Timed, 2000, 1, player)
end

end

local function Hirefunc(event, player)
		local x = player:GetX()
		local y = player:GetY()
		local z = player:GetZ()
		local o = player:GetO()

	local HireNPCnear = player:GetNearestCreature( 60, 70000 )
	local spawnedHire
	if HireNPCnear == nil then
	spawnedHire = player:SpawnCreature( 70000, x+1, y+1, z+0.5, o-3.5, 1, spawndur )
	else
	player:SendAreaTriggerMessage("Hire NPC nearby")
	end
	
	
	eventid = player:RegisterEvent(checkdespawn, 1000, 0, player)
	
end


local function PlrMenu(event, player, message, Type, lang)
	
	if (message:lower() == hirebot) then
		local mingmrank = 3
		if (GMonly and player:GetGMRank() < mingmrank) then
		player:SendBroadcastMessage("|cff5af304Only a GM can use this command.|r")
		return false
		else
		Hirefunc(event, player)
		return false
	end
	end
end


if enabled then
RegisterPlayerEvent(42, PlrMenu)
end
