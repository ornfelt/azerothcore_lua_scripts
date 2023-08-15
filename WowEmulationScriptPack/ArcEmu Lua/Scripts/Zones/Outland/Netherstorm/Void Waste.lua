--[[ Netherstorm -- Void Waste.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Waste_OnCombat(Unit, Event)
Unit:RegisterEvent("Waste_Toxic", 3000, 0)
end

function Waste_Toxic(Unit, Event) 
Unit:FullCastSpellOnTarget(36519, Unit:GetMainTank()) 
end

function Waste_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Waste_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Waste_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20778, 1, "Waste_OnCombat")
RegisterUnitEvent(20778, 2, "Waste_OnLeaveCombat")
RegisterUnitEvent(20778, 3, "Waste_OnKilledTarget")
RegisterUnitEvent(20778, 4, "Waste_OnDied")