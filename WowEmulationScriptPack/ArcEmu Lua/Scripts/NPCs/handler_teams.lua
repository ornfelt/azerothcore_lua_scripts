function TeamCheck1(pUnit, Event)
	local check1 = GetPlayersInMap(169)
	if (check1 ~= nil) then 
		pUnit:RegisterEvent("TeamCheck2", 5000, 0)
	end
end

function TeamCheck2(pUnit, Event)
local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "0") then
		pUnit:Despawn(1, 0)
	end
	local tbl = GetPlayersInMap(169)
	for k,v in pairs(tbl) do
		if (v:IsInGroup() == false) and (v:GetY() >= -2600) then
			local PlayerName = v:GetName()
			local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
			local NewPlayerTeam = CharDBQuery("SELECT guid FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
			local RdmPlayerTeam = v:GetRandomFriend()
			local Messaged = CharDBQuery("SELECT messaged FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
			if (RdmPlayerTeam ~= nil) then
			--[[	while ( RdmPlayerTeam:IsCreature() == true ) do
					RdmPlayerTeam = v:GetRandomFriend()
				end
				while ( RdmPlayerTeam:GetY() <= -2600 ) do
					RdmPlayerTeam = v:GetRandomFriend()
				end
			]]	
				if (RdmPlayerTeam:IsInGroup() == true) and (v:GetFaction() == RdmPlayerTeam:GetFaction()) then
					RdmPlayerTeam = RdmPlayerTeam:GetGroupLeader()
					RdmPlayerTeam:AddGroupMember(v)
					elseif (RdmPlayerTeam:IsInGroup() == false) then
						if Messaged ~= "1" then
							v:SendBroadcastMessage("Currently, there isn't any group of your team yet, please invite somebody of your own team and more players will automatically join the group when joining Verdant Fields.")
							CharDBQuery("UPDATE zbg_players SET messaged= '1' WHERE guid="..GetPlayerGUID.."")
						end
				else
				end
			elseif (RdmPlayerTeam == nil) then
				if (Messaged ~= 2) then
					v:SendBroadcastMessage("Currently, there isn't anyone else near you of the same team, goodluck!")
					CharDBQuery("UPDATE zbg_players SET messaged= '2' WHERE guid="..GetPlayerGUID.."")
				end
			end
		else
		end
	end
end

RegisterUnitEvent(970002, 18, "TeamCheck1")