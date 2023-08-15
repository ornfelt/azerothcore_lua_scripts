--[[ Nagrand - Alliance Halaani Guard.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Performa, August 25th, 2008. ]]

function AllianceHalaaniGuard_Shoot(Unit, event, miscunit, misc)
	Unit:FullCastSpellOnTarget(23337,Unit:GetMainTank())
end

function AllianceHalaaniGuard(Unit, event, miscunit, misc)
	Unit:RegisterEvent("AllianceHalaaniGuard_Shoot",0,0)
end

function AllianceHalaaniGuard_Death(Unit)
    Unit:RemoveEvents()
end

function AllianceHalaaniGuard_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

RegisterUnitEvent(18256, 1, "AllianceHalaaniGuard")
RegisterUnitEvent(18256, 2, "AllianceHalaaniGuard_OnLeaveCombat")
RegisterUnitEvent(18256, 4, "AllianceHalaaniGuard_Death")