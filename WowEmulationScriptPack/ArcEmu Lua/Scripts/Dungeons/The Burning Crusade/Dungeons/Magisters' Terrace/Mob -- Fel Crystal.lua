--[[ Mob -- Fel Crystal.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 01, 2009. ]]

function FelCrystal_OnSpawn(pUnit,Event)
	pUnit:StopMovement(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatTargetingCapable(1)
end

function FelCrystal_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("FelCrystal_RemoveFromWorld", 3500, 1)
end

function FelCrystal_RemoveFromWorld(pUnit,Event)
	pUnit:RemoveFromWorld()
end

RegisterUnitEvent(24722,18,"FelCrystal_OnSpawn")
RegisterUnitEvent(24722,4,"FelCrystal_OnDied")