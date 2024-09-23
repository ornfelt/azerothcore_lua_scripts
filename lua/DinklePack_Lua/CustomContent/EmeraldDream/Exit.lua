--local CLOSE_DISTANCE = 5 -- Max distance when the player should get teleported

--local UNIQUE_OBJECT = 900000 -- Unique GameObject ID

--local TELEPORT_MAP = MapID -- Map ID to teleport the player to
--local TELEPORT_X = Xcoords -- X Coordinates when you type .gps in-game.
--local TELEPORT_Y = Ycoords -- Y Coordinates when you type .gps in-game.
--local TELEPORT_Z = Zcoords -- Z Coordinates when you type .gps in-game.
--local TELEPORT_O = Orientation -- Orientation coordinates when you type .gps in-game.

--function OnExit(event, go, player)
	--go:RegisterEvent(CheckForPlayersExit, 1000, 0)
--end

--function CheckForPlayersExit(event, delay, repeat_times, go, player)
--	local players_in_range = go:GetPlayersInRange(CLOSE_DISTANCE)
--	for _, player in pairs(players_in_range) do
--		player:Teleport(TELEPORT_MAP, TELEPORT_X, TELEPORT_Y, TELEPORT_Z, TELEPORT_O)
--	end
--end

--RegisterGameObjectEvent(UNIQUE_OBJECT, 2, OnExit)