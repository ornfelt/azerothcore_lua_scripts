--[[ Netherstorm -- Fel Imp.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Imp_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Imp_Bolt",2000,0)
end

function Imp_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(36227,Unit:GetClosestPlayer())
end

function Imp_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Imp_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21135, 1, "Imp_OnEnterCombat")
RegisterUnitEvent (21135, 2, "Imp_OnLeaveCombat")
RegisterUnitEvent (21135, 4, "Imp_OnDied")
