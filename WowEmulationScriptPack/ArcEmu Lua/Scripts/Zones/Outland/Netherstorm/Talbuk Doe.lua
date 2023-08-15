--[[ Netherstorm -- Talbuk Doe.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Doe_OnCombat(Unit, Event)
Unit:RegisterEvent("Doe_Gore", 5000, 0)
end

function Doe_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function Doe_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Doe_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Doe_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20610, 1, "Doe_OnCombat")
RegisterUnitEvent(20610, 2, "Doe_OnLeaveCombat")
RegisterUnitEvent(20610, 3, "Doe_OnKilledTarget")
RegisterUnitEvent(20610, 4, "Doe_OnDied")