-- Description:
-- This file holds a function similar to .server shutdown
-- gives a warning/countdown every 15 seconds before reloading the UI as a courtesy
-- Author: grimreapaa

-- ADMIN_RANK is a variable set by globals/config.ext
-- ADMIN_RANK = 3 -- uncomment this if you are missing that file

local function Reload_Eluna_Timer_Effect(eventid, delay, repeats, player) -- what happens when timer function is ran
	tick = tick + 1 -- a counter so we know how many times the event has ticked
--	print(tick, repeats)
--	print("mod:" ..(tick % 15))
	if repeats == 1 then
		ReloadEluna()
	elseif (tick % 15) == 0 and (seconds - tick) > 0 then -- % 15 is a modulo statement. it divides by 15 and prints the remainder. if 14 % 15 then print 14. if 15 % 15, then print 0.
		SendWorldMessage( "[Eluna]: Reloading the UI in " ..seconds - tick.. " seconds." )
	end
end

local function Reload_Eluna(event, player, command)
	if (command:find("eluna reload") ~= 1) then
		return
	elseif (player:GetGMRank() < ADMIN_RANK) then
		return
	else
		local parameters = {}
		local parameters = getCommandParameters(command)
		seconds = parameters[3]
		if seconds == nil then
			ReloadEluna()
			return false
		elseif tonumber(seconds) == nil then
			player:SendBroadcastMessage("Syntax: .eluna reload $seconds\nReloads the Eluna LUA engine.\nParameter $seconds delays the reload and announces similarly to a server shutdown.\nPlease do not logout when using this command.")
			return false
		end
		tick = 0
		SendWorldMessage( "[Eluna]: A UI reload has been scheduled in " .. seconds.. " seconds." )
		player:RegisterEvent( Reload_Eluna_Timer_Effect, 1000, seconds )
		return false
	end
end

RegisterPlayerEvent(42, Reload_Eluna)