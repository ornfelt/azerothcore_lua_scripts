local REGISTERID = 940012
local id = 941001

function Elemental_Complete(player, quest)
	player:SpawnCreature(id, 5061.783, -2112.326, 1369.243, 2, 14, 0)
end

RegisterQuestEvent(REGISTERID, 1, "Elemental_Complete")

	