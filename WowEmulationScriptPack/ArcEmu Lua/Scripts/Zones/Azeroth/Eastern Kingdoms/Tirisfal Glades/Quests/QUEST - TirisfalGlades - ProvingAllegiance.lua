--[[

	This is created by zdroid9770  :D

	� Copyright 2012

]]

--[[ Lillith Nefara ]]--
function LillithNefara_onSpawn(unit)
	unit:SendChatMessage(11, 1, "You have disturbed my rest. Now face my wrath!")
end
RegisterUnitEvent(1946, 6, "LillithNefara_onSpawn")
