require 'zbg_functions'


function GameTime(pUnit, Event)
	local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	pUnit:RegisterEvent("TimeUpdate", 1000, 0)
	if (GameStatus == "1") then
		pUnit:RegisterEvent("GamePreStart", 1000, 125)
	elseif GameStatus == 2 then	-- In case of Force start? Not working when BG countdown started already.
		pUnit:RegisterEvent("GameStarted", 1000, 0)
	end
end

function TimeUpdate(pUnit, Event)
	--		local PlayerName = v:GetName()
	--		local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	--		local NewPlayerTeam = CharDBQuery("SELECT guid FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	--		local RdmPlayerTeam = v:GetRandomFriend()
	--		local Messaged = CharDBQuery("SELECT messaged FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	--		local Team1Towers = CharDBQuery("SELECT t1towers FROM zbg_data"):GetColumn(0):GetString()
	--		local Team2Towers = CharDBQuery("SELECT t2towers FROM zbg_data"):GetColumn(0):GetString()
			local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
-- Time the battleground is running already.
	-- if GameStatus ~= 1 then
		PlayTime =  CharDBQuery("SELECT playtime FROM zbg_data"):GetColumn(0):GetString()	
		PlayTime = PlayTime + 1		
		CharDBQuery("UPDATE zbg_data SET playtime= '"..PlayTime.."' ")
-- Check if the script should run or not.
	local GameStatus = CharDBQuery("SELECT status FROM zbg_data"):GetColumn(0):GetString()
	if (GameStatus == "0") then
		pUnit:Despawn(1, 0)
	end
end	

RegisterUnitEvent(970004, 18, "GameTime")