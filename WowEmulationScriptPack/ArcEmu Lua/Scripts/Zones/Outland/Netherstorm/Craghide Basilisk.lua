--[[ Netherstorm -- Craghide Basilisk.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Basilisk_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Basilisk_Gaze",45000,0)
    Unit:RegisterEvent("Basilisk_Charge",1000,0)
end

function Basilisk_Gaze(Unit,Event)
    Unit:FullCastSpellOnTarget(35313, Unit:GetClosestPlayer())
end

function Basilisk_Charge(Unit,Event)
    Unit:FullCastSpellOnTarget(35385, Unit:GetClosestPlayer())
end

function Basilisk_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Basilisk_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20607, 1, "Basilisk_OnEnterCombat")
RegisterUnitEvent (20607, 2, "Basilisk_OnLeaveCombat")
RegisterUnitEvent (20607, 4, "Basilisk_OnDied")
