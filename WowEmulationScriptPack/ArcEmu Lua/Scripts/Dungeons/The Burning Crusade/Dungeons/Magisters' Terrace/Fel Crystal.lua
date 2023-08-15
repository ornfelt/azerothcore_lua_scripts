--[[ Mob -- Fel Crystal.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 01, 2009. ]]

function FelCrystal_OnSpawn(Unit,Event)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatCapable(1)
	Unit:SetCombatTargetingCapable(1)
end

function FelCrystal_OnDied(Unit,Event)
	Unit:RemoveEvents()
	Unit:RegisterEvent("FelCrystal_RemoveFromWorld", 3500, 1)
end

function FelCrystal_RemoveFromWorld(Unit,Event)
	Unit:RemoveFromWorld()
end

RegisterUnitEvent(24722,18,"FelCrystal_OnSpawn")
RegisterUnitEvent(24722,4,"FelCrystal_OnDied")