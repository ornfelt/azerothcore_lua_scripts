-- What this script does:
-- On player save intervals, provide characters an item in a multiplier amount up to 3 maximum.
-- Every hour a function is ran that checks the last known server timestamp, if greater than 24 hours, clean the count table/daily multipliers.

-- How often do you want to reward coins? default: 1 hour (60min)
TIME_IN_SECONDS = 3600

-- how often do you want to clear the player's caps?
TIME_TO_CLEAR = 86400

--spellid of gear token buff for bonus generation
MONEY_BUFF = 2000043

local function WageCuck(event, player)
	local Played_Query1 = CharDBQuery("SELECT totaltime FROM characters WHERE guid = " ..player:GetGUIDLow().. ";")
	local Played_Query2 = WorldDBQuery("SELECT `time`, `count` FROM timestamps WHERE guid = " ..player:GetGUIDLow().. " AND `type` = 1;")
	local player_guid = player:GetGUIDLow()
	count = 0
	
	if (Played_Query2 == nil) then
		WorldDBExecute("INSERT INTO `elunaworld`.`timestamps` (`type`, `guid`, `time`, `count`) VALUES ('1','" ..player_guid.. "', '" ..Played_Query1:GetInt32(0).. "', '0');")
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_counters` (`value_1`, `value_2`, `script_name`) VALUES ('1', '" ..player_guid.. "', 'WageCuckServer.lua');")
		local Played_Query2 = WorldDBQuery("SELECT `time`, `count` FROM timestamps WHERE guid = " ..player_guid.. " AND `type` = 1;")
		-- yeeaaahhh the queries turn nil here so im just gonna make it return false annnnnnnnnnnnd yeaaaaaahhhhhhh
		return false
	end
	
	if (player:GetMapId() == 36) then -- if player is not in the Spark/spawn.
		return false
	elseif (player:IsAFK() == true) then
		return false
	elseif ((Played_Query1:GetInt32(0) - Played_Query2:GetInt32(0) >= TIME_IN_SECONDS)) then -- If (players current playtime - latest timestamp) is more than TIME_IN_SECONDS.
		-- if big # - smaller # is greater than TIME_IN_SECONDS, then
		count = Played_Query2:GetInt32(1)
		
		mult = 3000
		
		if player:HasAura(MONEY_BUFF) == true then
			local aura = player:GetAura(MONEY_BUFF)
			mult = mult * 2
			-- funny enough, having 0 stacks doesnt unaura something.
			aura:SetStackAmount(aura:GetStackAmount() - 1)
			if aura:GetStackAmount() == 0 then
				player:RemoveAura(MONEY_BUFF)
			end
		end
		
		WorldDBExecute("UPDATE timestamps SET `time` = " ..Played_Query1:GetInt32(0).. ", `count` = `count` + 1 WHERE `type` = 1 AND guid = " ..player_guid.. ";")

-- no longer needed after removing gear tokens i believe. will keep in case of fire.
--		WorldDBExecute("UPDATE eluna_counters SET `value_1` = `value_1` + " ..mult2.. " WHERE `value_2` = " ..player_guid.. " AND `script_name` = 'WageCuckServer.lua';")
		local how_much_to_add = mult
		PrintInfo("[Wage]: Adding " .. how_much_to_add .. " to ".. player:GetName())
        ChangeCurrency(player, how_much_to_add)
		return
	end
end

-- every hour this function is ran. it gets the gametime and puts it in a table if it doesnt exist. if it does, and its compared to an old timestamp, and that timestamp is 24+ hours old, reset count.
local function GetDailyTime(eventId, delay, repeats)
	local Played_Query3 = WorldDBQuery("SELECT `time` FROM timestamps WHERE `type` = 2") -- type 2 = server gametime, saved every "CreateLuaEvent".
	if (Played_Query3 == nil) then
		WorldDBExecute("INSERT INTO `elunaworld`.`timestamps` (`type`, `time`) VALUES ('2', '" ..tostring(GetGameTime()).. "');") -- type 2 = server gametime, saved every "CreateLuaEvent".
	elseif ((GetGameTime() - Played_Query3:GetInt32(0)) >= TIME_TO_CLEAR) then -- if (Current servertime - saved servertime) is more than 7 days (604800 seconds)
		WorldDBExecute("UPDATE timestamps SET `count` = 0 WHERE `type` = 1;") -- Reset times the character has gotten their reward the last 7 days.
		WorldDBExecute("UPDATE timestamps SET `time` = " ..tostring(GetGameTime()).. " WHERE `type` = 2;")
		PrintInfo("[Wage]: Flushing wages...")
		--SendWorldMessage("[Wage]: Flushing wages...")
	end
end



-- on every player save interval via worldserver.cfg
RegisterPlayerEvent(25, WageCuck)
CreateLuaEvent(GetDailyTime, 900000, 0) -- 900,000 milliseconds is 15 minutes. That's the save interval in worldserver config.
