--[[ Shattrath City -- Ironspine Petrifier.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Petrifier_OnCombat(Unit, Event)
Unit:RegisterEvent("Petrifier_Glare", 10000, 0)
end

function Petrifier_Glare(Unit, Event) 
Unit:FullCastSpellOnTarget(32905, Unit:GetMainTank()) 
end

function Petrifier_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Petrifier_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Petrifier_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21854, 1, "Petrifier_OnCombat")
RegisterUnitEvent(21854, 2, "Petrifier_OnLeaveCombat")
RegisterUnitEvent(21854, 3, "Petrifier_OnKilledTarget")
RegisterUnitEvent(21854, 4, "Petrifier_OnDied")