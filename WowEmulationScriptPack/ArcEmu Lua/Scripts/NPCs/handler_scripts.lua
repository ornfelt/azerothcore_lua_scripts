local spawned = "false"


function GameTime(pUnit, event)
	pUnit:RegisterEvent("CheckGameStatus", 1000, 0)
end


function CheckGameStatus(pUnit, event)
local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
-- pUnit:SendChatMessage(12, 0, spawned)
	if (GameStatus == "1") and (spawned == "false") then
		local x= pUnit:GetX()
		local y= pUnit:GetY()
		local z= pUnit:GetZ()
		local o= pUnit:GetO()
		local faction = pUnit:GetFaction()
		local duration = 0
		spawned = "true"
		entry = {"970002","970003","970004"}
		i = 1
		while ( i <= 3) do
			pUnit:SpawnCreature(entry[i], x, y, z, o, faction, duration)
			i = i+1
		end
	elseif (GameStatus == "0") then
		spawned = "false"
--[[ 
	elseif (GameStatus ~= "1") then
		
		local x= pUnit:GetX()
		local y= pUnit:GetY()
		local z= pUnit:GetZ()
		
		pUnit = {"970002","970003","970004"}
		i = 1
	
		while ( i <= 3) do
			local creature = pUnit:GetCreatureNearestCoords(x, y, z, 970002)
			pUnit:SendChatMessage(12, 0, creature)
			--  creature:Despawn(0, 0)	
		end
]]
	end
end

RegisterUnitEvent(970005, 18, "GameTime")
