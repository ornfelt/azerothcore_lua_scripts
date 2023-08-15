--[[ Netherstorm -- Kirin'Var Apprentice.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Apprentice_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Apprentice_Hammer",1500,0)
end

function Apprentice_Hammer(Unit,Event)
    Unit:FullCastSpellOnTarget(37554,Unit:GetClosestPlayer())
end

function Apprentice_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Apprentice_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20409, 1, "Apprentice_OnEnterCombat")
RegisterUnitEvent (20409, 2, "Apprentice_OnLeaveCombat")
RegisterUnitEvent (20409, 4, "Apprentice_OnDied")