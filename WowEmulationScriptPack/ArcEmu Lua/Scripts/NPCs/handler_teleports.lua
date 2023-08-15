require 'zbg_functions'


-- Teleport coords

-- Team 1
local team1_map = 169
local team1_x = -3494.90
local team1_y = 789
local team1_z = 92.1
local team1_faction = 72 -- Stormwind

-- Team 2
local team2_map = 169
local team2_x = -3494.90
local team2_y = 892
local team2_z = 92.1
local team2_faction = 76 -- Orgrimmar


-- If player chooses to join team 1:

function chooseteam1(pGameObject, event, player)
	local PlayerName = player:GetName()
	local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	local t1_players = CharDBQuery("SELECT t1players FROM zbg_data"):GetColumn(0):GetString()
	local t2_players = CharDBQuery("SELECT t2players FROM zbg_data"):GetColumn(0):GetString()
	local team_balance = 1
		if (t1_players > t2_players) then
			team_balance = t2_players / t1_players
		end
		if (team_balance <= 0.88) then
			player:SendBroadcastMessage("Please join team 2 to make the teams balanced!")
		elseif (player:IsInGroup() == true) then
			player:SendBroadcastMessage("Please leave your current group first!")
		else
			t1players_new = t1_players +1
			CharDBQuery("INSERT INTO zbg_players VALUES ('"..GetPlayerGUID.."','"..PlayerName.."','1','25', '1','0')")		
			CharDBQuery("UPDATE zbg_data SET t1players= '"..t1players_new.."' ")	
			player:SetFaction(team1_faction)
			player:Teleport(team1_map, team1_x, team1_y, team1_z)
				for k,v in pairs(GetPlayersInMap(169)) do
					v:SendBroadcastMessage(PlayerName.." joined team 1!")
				end
			local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
			if (GameStatus == "0") then
				CharDBQuery("UPDATE zbg_data SET status= '1' ")
			end
		end
end

-- If player chooses to join team 2:

function chooseteam2(pGameObject, event, player)
	local PlayerName = player:GetName()
	local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	local t1_players = CharDBQuery("SELECT t1players FROM zbg_data"):GetColumn(0):GetString()
	local t2_players = CharDBQuery("SELECT t2players FROM zbg_data"):GetColumn(0):GetString()
	local team_balance = 1
		if (t1_players < t2_players) then
			team_balance = t1_players / t2_players
		end
		if (team_balance <= 0.88) then
			player:SendBroadcastMessage("Please join team 1 to make the teams balanced!")
		elseif (player:IsInGroup() == true) then
			player:SendBroadcastMessage("Please leave your current group first!")
		else
			t2players_new = t2_players +1
			CharDBQuery("INSERT INTO zbg_players VALUES ('"..GetPlayerGUID.."','"..PlayerName.."','2','25', '1','0')")		
			CharDBQuery("UPDATE zbg_data SET t2players= '"..t2players_new.."' ")	
			player:SetFaction(team2_faction)
			player:Teleport(team2_map, team2_x, team2_y, team2_z)
				for k,v in pairs(GetPlayersInMap(169)) do
					v:SendBroadcastMessage(PlayerName.." joined team 2!")
				end
			local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
			if (GameStatus == "0") then
				CharDBQuery("UPDATE zbg_data SET status= '1' ")
			end
		end
end


RegisterGameObjectEvent(970001, 4, chooseteam1)
RegisterGameObjectEvent(970002, 4, chooseteam2)