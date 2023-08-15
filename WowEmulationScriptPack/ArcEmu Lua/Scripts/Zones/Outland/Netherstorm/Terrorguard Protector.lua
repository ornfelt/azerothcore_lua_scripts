--[[ Netherstorm -- Terrorguard Protector.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Protector_OnCombat(Unit, Event)
Unit:RegisterEvent("Protector_Cleave", 7000, 0)
Unit:RegisterEvent("Protector_Flames", 5000, 0)
end

function Protector_Cleave(Unit, Event) 
Unit:FullCastSpellOnTarget(15496, Unit:GetMainTank()) 
end

function Protector_Flames(Unit, Event) 
Unit:FullCastSpellOnTarget(37488, Unit:GetMainTank()) 
end

function Protector_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Protector_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Protector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21923, 1, "Protector_OnCombat")
RegisterUnitEvent(21923, 2, "Protector_OnLeaveCombat")
RegisterUnitEvent(21923, 3, "Protector_OnKilledTarget")
RegisterUnitEvent(21923, 4, "Protector_OnDied")