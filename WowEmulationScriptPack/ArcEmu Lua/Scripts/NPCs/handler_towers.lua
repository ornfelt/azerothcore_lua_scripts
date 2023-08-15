require 'zbg_functions'

local spawned = 0

function TowerStats(pUnit, Event)
	pUnit:RegisterEvent("TowerStatsCheck", 3000, 0)
end

RegisterUnitEvent(970006, 18, "TowerStats")