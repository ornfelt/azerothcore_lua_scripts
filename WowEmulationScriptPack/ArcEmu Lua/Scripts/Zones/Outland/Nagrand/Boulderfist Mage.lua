--[[ Nagrand- Boulderfist Mage.lua

This script was written and is protected
by the GPL v2. This script was released
by Succy of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Succy, July, 18th, 2008. ]]

function Bouldertfistmage_Frostbolt(Unit, event, miscunit, misc)
	Unit:FullCastSpellOnTarget(9672,Unit:GetMainTank())
end

function Bouldertfistmage_Fireblast(Unit, event, miscunit, misc)
	Unit:FullCastSpell(20795)
end

function Bouldertfistmage_Bloodlust(Unit, event, miscunit, misc)
	Unit:FullCastSpell(6742)
end

function Bouldertfistmage(unit, event, miscunit, misc)
	unit:RegisterEvent("Bouldertfistmage_Frostbolt",15000,0)
	unit:RegisterEvent("Bouldertfistmage_Fireblast",50000,0)
	unit:RegisterEvent("Bouldertfistmage_Bloodlust",20000,0)
end

function Bouldertfistmage_Death(Unit)
	Unit:RemoveEvents()
end

function Bouldertfistmage_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end


RegisterUnitEvent(17137, 2, "Bouldertfistmage_OnLeaveCombat")
RegisterUnitEvent(17137, 4, "Bouldertfistmage_Death")
RegisterUnitEvent(17137, 1,"Bouldertfistmage")