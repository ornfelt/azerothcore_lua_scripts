--[[ Nagrand - Aged Clefthoof.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Performa, August 25th, 2008. ]]

function AgedClefthoof_Charge(Unit, event, miscunit, misc)
	Unit:FullCastSpellOnTarget(32021,Unit:GetMainTank())
end

function AgedClefthoof(Unit, event, miscunit, misc)
	Unit:RegisterEvent("AgedClefthoof_Charge",10000,0)
end

function AgedClefthoof_Death(Unit)
    Unit:RemoveEvents()
end

function AgedClefthoof_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

RegisterUnitEvent(17133, 1, "AgedClefthoof")	
RegisterUnitEvent(17133, 2, "AgedClefthoof_OnLeaveCombat")
RegisterUnitEvent(17133, 4, "AgedClefthoof_Death")