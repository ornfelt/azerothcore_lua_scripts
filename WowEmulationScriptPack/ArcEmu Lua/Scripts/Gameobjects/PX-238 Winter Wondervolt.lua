--[[ PX-238 Winter Wondervolt
	For use on CNA-WoW only
	Do not release
	Copyright (C) Harry Copp, 2010 ]]--#
	
local GoId = 180796

function WinterWondervoltOnSpawn(event, player)
	if (player:InInFront() == true) then
		if ((player:GetDistance() <= 2) == true) then
			player:CastSpell(26272) -- PX-238 Winter Wondervolt
		end
	end
end

RegisterGameObjectEvent(GoId, 2, "WinterWondervoltOnSpawn")