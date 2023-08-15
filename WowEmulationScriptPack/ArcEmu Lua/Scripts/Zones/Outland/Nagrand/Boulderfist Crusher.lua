--[[ Nagrand - Boulderfist Crusher.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Performa, August 25th, 2008. ]]

function Boulderfistcrusher_Pulverize(Unit, event, miscunit, misc)
	Unit:FullCastSpellOnTarget(2676,Unit:GetMainTank())
end

function Boulderfistcrusher(Unit, event, miscunit, misc)
    Unit:RegisterEvent("Boulderfistcrusher_Pulverize",12000,0)
end

function Boulderfistcrusher_Death(Unit)
    Unit:RemoveEvents()
end

function Boulderfistcrusher_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

RegisterUnitEvent(17134, 1, "Boulderfistcrusher")
RegisterUnitEvent(17134, 2, "Boulderfistcrusher_OnLeaveCombat")
RegisterUnitEvent(17134, 3, "Boulderfistcrusher_Death")