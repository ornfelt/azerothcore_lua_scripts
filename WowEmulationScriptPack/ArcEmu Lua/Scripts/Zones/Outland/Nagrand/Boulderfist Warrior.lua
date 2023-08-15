--[[ Nagrand- Boulderfist Mage.lua

This script was written and is protected
by the GPL v2. This script was released
by Succy of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Succy, July, 18th, 2008. ]]

function BoulderfistWarrior_Charge(Unit, event, miscunit, misc)
	Unit:FullCastSpellOnTarget(31994,Unit:GetMainTank())
end

function BoulderfistWarrior(unit, event, miscunit, misc)
	unit:RegisterEvent("BoulderfistWarrior_Charge",10000,0)
end

function BoulderfistWarrior_Death(Unit)
	Unit:RemoveEvents()
end

function BoulderfistWarrior_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17136, 1,"BoulderfistWarrior")
RegisterUnitEvent(17136, 2, "BoulderfistWarrior_OnLeaveCombat")
RegisterUnitEvent(17136, 4, "BoulderfistWarrior_Death")