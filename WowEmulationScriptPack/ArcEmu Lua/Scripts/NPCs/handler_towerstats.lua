function TowerStats(pUnit, Event)
	pUnit:RegisterEvent("TowerStatsCheck", 3000, 0)
end

function TowerStatsCheck(pUnit, Event)
local tbl = GetPlayersInMap(169)
	for k,v in pairs(tbl) do
		if (v:GetY() >= -2600) then
			local PlayerName = v:GetName()
			local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
			local NewPlayerTeam = CharDBQuery("SELECT guid FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
			local RdmPlayerTeam = v:GetRandomFriend()
			local Messaged = CharDBQuery("SELECT messaged FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
			local Team1Towers = CharDBQuery("SELECT t1towers FROM zbg_data"):GetColumn(0):GetString()
			local Team2Towers = CharDBQuery("SELECT t2towers FROM zbg_data"):GetColumn(0):GetString()
			local p = LuaPacket:CreatePacket(707,18)
				p:WriteULong(2328)
				p:WriteULong(Team1Towers)		-- team 1 red score
			v:SendPacketToPlayer(p)
			p = LuaPacket:CreatePacket(707,8)
				p:WriteULong(2327) 
				p:WriteULong(Team2Towers)		-- team 2 blue Score
			v:SendPacketToPlayer(p)
		end
	end
	local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "0") then
		pUnit:Despawn(1, 0)
	end
end

RegisterUnitEvent(970003, 18, "TowerStats")