--[[ Nagrand - Banthar.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Performa, August 25th, 2008. ]]

function Banthar_Spell(Unit, event, miscunit, misc)
    Unit:FullCastSpellOnTarget(32023,Unit:GetMainTank())
end

function Banthar(Unit, event, miscunit, misc)
    Unit:RegisterEvent("Banthar_Spell", 20000, 0)
end

function Banthar_Death(Unit)
    Unit:RemoveEvents()
end

function Banthar_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

RegisterUnitEvent(18259, 1, "Banthar")
RegisterUnitEvent(18259, 2, "Banthar_OnLeaveCombat")
RegisterUnitEvent(18259, 3, "Banthar_Death")