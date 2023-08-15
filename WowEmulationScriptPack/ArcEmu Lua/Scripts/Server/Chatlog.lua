cddcdm = ""
local file = io.open("scripts/chat.txt", "a")
function OnChat_Command(event, player, message, type, language)
		swm = string.lower(message)
		if (swm:find(cddcdm.." ") == false) then
		else
			pg = player:GetGuildName()
			msgtype = MSG(type)
			tom = type
			local plrname = player:GetName()
			local giddy = message:gsub(cddcdm.."","")
			if (tom == 10) then
				file:write("("..GetGameTime()..") "..plrname.." "..giddy"\n")
			else
				file:write("("..GetGameTime()..") ["..plrname.."] "..msgtype..": "..giddy.."\n")
				file:flush()
			end
		end
end
RegisterServerHook(16, "OnChat_Command")
function MSG(type)
	if (type == 1) then
		return("says")
	elseif (type == 4) then
		return("guild("..pg..")")
	elseif (type == 6) then
		return("yells")
	elseif (type == 51) then
		return("party")
	elseif (type == 17) then
		return("(General/trade/LocalDefense/custom)")
	elseif (type == 39) then
		return("raid")
	elseif (type == 45) then
		return("Battleground")
	elseif (type == 7) then
		return("Whispers")
	else
		return(type)
	end
end