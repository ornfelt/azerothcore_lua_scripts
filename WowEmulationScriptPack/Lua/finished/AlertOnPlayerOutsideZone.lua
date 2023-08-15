local ACCOUNT_LEVEL = 2
local PLAYER_EVENT_ON_UPDATE_ZONE = 27
local ALLOWED_ZONES = {
    [5000]=true, -- spark
    [1581]=true, -- darkmines outside spark
 --   [3711]=true -- sholazar
 --	[12]=true, -- elwynn
 --	[1519]=true, -- stormwind
 --	[1537]=true, -- ironforge
 --	[44]=true, -- redridge
 --	[10]=true, -- duskwood
	[33]=true, -- stranglethorn
	[1377]=true, -- Silithus, but bugged custom cave in Stranglethorn
 --	[41]=true, -- deadwind
 --	[51]=true, -- searing gorge
 -- [8]=true, -- swamp of sorrows
 --	[4]=true, -- Blasted Lands
 --	[1]=true, -- dun morogh
 --	[40]=true, -- westfall
 -- [46]=true, -- burning steppes
}

local function AlertOnUnallowedZone(event, player, newZone, newArea)
	-- do not print gm
	if (player:GetGMRank() >= ACCOUNT_LEVEL) then
		return false
	-- print message, tp player?
	elseif ALLOWED_ZONES[newZone] == nil then
        local logmessage = "**" .. player:GetAccountName() .. "** with their character **" .. player:GetName() .. "** is now in an **unallowed** zone (".. newZone .."). They might be hacking!"
        PrintInfo(logmessage)
        SendToDiscordAlert(logmessage)
    end
end




RegisterPlayerEvent(PLAYER_EVENT_ON_UPDATE_ZONE, AlertOnUnallowedZone)