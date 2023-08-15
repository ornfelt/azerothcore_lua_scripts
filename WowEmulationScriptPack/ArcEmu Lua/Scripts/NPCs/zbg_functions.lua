



---------------
--[Functions]--
---------------




---------------
--[Message]---
---------------
		
function GameAnnouncer(Message)
	local tbl = GetPlayersInMap(169)
	for k,v in pairs(tbl) do
		v:SendBroadcastMessage(Message)
	end
end

-------------------
--[Registerevent]--
-------------------

function VerdantRegister(function1, command, player)
	if (code == command) then
		player:SendBroadcastMessage("You have executed the following command:");
		player:SendBroadcastMessage(command)					
		RegisterTimedEvent("function1", 1000, 1)
	end
end

--------------
--[ForceStart]--
--------------

function ForceStart(function1, command)
	local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "1") then
		PlayTime = 120
		CharDBQuery("UPDATE zbg_data SET playtime= '120' ")
		pUnit:RegisterEvent("GameStarted", 1000, 1)
	else
		player:SendBroadcastMessage("You can't force the battleground to start when it's in status"..GameStatus)
	end
end

--------------
--[PreStart]--
--------------


function GamePreStart(pUnit, Event)
local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "1") then
		-- Announces every 30 seconds before start.
		if (PlayTime < 120) then
			if (math.floor(math.sin(PlayTime*math.pi/30) * 10^8 + 0.5) / 10^8 == 0) then
				local TimeToGo = 120 - PlayTime
				GameAnnouncer(TimeToGo.. " seconds before start!");
			end
		elseif (PlayTime >= 120) then
			pUnit:RegisterEvent("GameStarted", 1000, 1)
			local GameStatus = 2
			CharDBQuery("UPDATE zbg_data SET status= '"..GameStatus.."' ")
		end
	end
end


-----------------
--[GameStarted]--
-----------------

function GameStarted(pUnit, Event)
local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "2") then
		PlayTime = 0
		CharDBQuery("UPDATE zbg_data SET playtime= '"..PlayTime.."' ")
		GameAnnouncer("May the best team win!");
		local tbl = GetPlayersInMap(169)
		for k,v in pairs(tbl) do
			v:PlaySoundToPlayer(8233)
		end
	-- Team 1 gate
		local team1_x = -3527
		local team1_y = 792
		local team1_z = 92.1
	--Team 2 gate
		local team2_x = -3527
		local team2_y = 894
		local team2_z = 92.1
		local OpenGate1 = pUnit:GetGameObjectNearestCoords(team1_x, team1_y, team1_z, 970003)
		local OpenGate2 = pUnit:GetGameObjectNearestCoords(team2_x, team2_y, team2_z, 970003)				
		OpenGate1:Despawn(1000, 10000)
		OpenGate2:Despawn(1000, 10000)
		GameStatus = 3
		CharDBQuery("UPDATE zbg_data SET status= '"..GameStatus.."' ")
		RegisterTimedEvent("GameRunning", 1000, 0)
	end
end


-----------------
--[Game Running]--
-----------------

function GameRunning(pUnit, Event)
local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "3") then
	--	CharDBQuery("UPDATE zbg_data SET status= '4' ")
	--	GameStatus = 4
		if ( first_run == nil) then
			first_run = "true"
			RegisterTimedEvent("DuelCountdown", 1000, 300)
		end
	--	GameAnnouncer("test0");
	end
-- End game with GameStatus 4:
	if (GameStatus == "4") then
		RegisterTimedEvent("GameEnded1", 1000, 1)
		GameAnnouncer("The Game has ended!");
	end
end


-------------------
--[DuelCountdown]--
-------------------

function DuelCountdown(pUnit, Event)
--GameAnnouncer(DuelCountdown_number");
	if (second_run == nil) then
		second_run = "true"
		DuelCountdown_numberoriginal = os.time()
	elseif (second_run == "true") then
 		DuelCountdown_number = os.difftime(os.time(), DuelCountdown_numberoriginal)
		GameAnnouncer(DuelCountdown_number);
 		local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
		if (DuelCountdown_number == 300) then
			--GameAnnouncer("The Duel will start!");
			RegisterTimedEvent("BattlegroundDuel", 1000, 1)
			DuelCountdown_number = 0
		elseif ( DuelCountdown_number >= 270) then
		--	GameAnnouncer("test2");
			if (math.floor(math.sin(os.difftime(os.time(), DuelCountdown_number)*math.pi/10) * 10^8 + 0.5) / 10^8 == 0) then
				GameAnnouncer("test3");
				DuelCountdown_real = 30 - os.difftime(os.time(), DuelCountdown_number)
				GameAnnouncer(DuelCountdown_real.." seconds before duel...");
			end
		end
	end			
--	if (math.floor(math.sin(PlayTime*math.pi/10) * 10^8 + 0.5) / 10^8 == 0) then
--ifelse (math.floor(math.sin(PlayTime*math.pi/150) * 10^8 + 0.5) / 10^8 == 0)
end


-------------
--[Endgame]--
-------------

function ForceGameEnd(item, event)
	-- Teleport coords
	local team_map = 169
	local team_x = -3367.274
	local team_y = -2678.413
	local team_z = 92.01
	local tbl = GetPlayersInMap(169)	
	for k,v in pairs(tbl) do
		v:Teleport(team_map, team_x, team_y, team_z)
		v:Unroot()
		v:SetCombatCapable(1)
	end
	RegisterTimedEvent("ForceCleanData", 1000, 1)
end




---------------
--[GameEnded]--
---------------

function GameEnded1(pUnit, Event)
	CharDBQuery("UPDATE zbg_data SET playtime= '0' ")	
	CharDBQuery("UPDATE zbg_data SET status= '1' ")
	local tbl = GetPlayersInMap(169)	
	for k,v in pairs(tbl) do
		v:Root()
	end
	RegisterTimedEvent("GameEndedCountdown", 1000, 35)
end	

------------------------
--[GameEndedCountdown]--
------------------------


function GameEndedCountdown(pUnit, Event)
local PlayTime = CharDBQuery("SELECT playtime FROM zbg_data"):GetColumn(0):GetString()
	if (math.floor(math.sin(PlayTime*math.pi/5) * 10^8 + 0.5) / 10^8 == 0) then
		local TimeLeft = 30 - PlayTime
		GameAnnouncer(TimeLeft.. " seconds before the closing of the Battleground!!");
	elseif (PlayTime == "31") then
		RegisterTimedEvent("ForceGameEnd", 1000, 1)
	end
end


---------------
--[Cleandata]--
---------------

function ForceCleanData(item, event)
	GameAnnouncer("Cleaning Game Data");
	cb = { [0] = "zbg_data", [1]="zbg_players"}
	local tbl = GetPlayersInMap(169)
	for k,v in pairs(tbl) do
		v:SetFaction(0)
	end
	local i = 0
		while ( i < 2) do
			CharDBQuery("DELETE FROM "..cb[i].."")
		if cb[i] == cb[0] then
			CharDBQuery("INSERT INTO zbg_data VALUES ('0','0','9','9','0','0')")
		end
		if cb[i] == cb[1] then
			CharDBQuery("INSERT INTO zbg_players VALUES ('0','0','0','0','0','0')")
		end
		i = i+1
	end
end




-----------------
--[TowerSpawns]--
-----------------

local T1 = T1 or {}
local T2 = T2 or {}

function TowerSpawns()
local Team1Towers = CharDBQuery("SELECT t1towers FROM zbg_data"):GetColumn(0):GetString()
local Team2Towers = CharDBQuery("SELECT t2towers FROM zbg_data"):GetColumn(0):GetString()
local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	GameStatus = 5
	if (GameStatus ~= "0") then
		GameAnnouncer("Trying to spawn towers...");
		T1[1] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 14, 0)
	--[[	T1[2] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T1[3] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T1[4] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T1[5] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T1[6] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)	]]
		T2[1] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
	--[[	T2[2] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T2[3] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T2[4] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T2[5] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)
		T2[6] = PerformIngameSpawn(1, 970100, 169, -3504, 786, 92, 0.6, 35, 0)	]]
		GameAnnouncer("Towers are now spawned");
		i = 1
		while i <= #T1 do
			T1[i]:Root()
			T2[i]:Root()
			T1[i]:DisableCombat(1)
			T2[i]:DisableCombat(1)
		i = i + 1
		end
	else
	end
end

------------------
--[TowerDeleted]--
------------------


function TowerRemoved()
	GameAnnouncer("Trying to delete towers...");
	i = 1
	while i <= #T1 do
		T1[i]:Despawn(2000, 0)
		T2[i]:Despawn(2000, 0)
	i = i +1
	end
	GameAnnouncer("Towers deleted");
end