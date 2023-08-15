--[[ Netherstorm -- Veronia.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Veronia_OnCombat(Unit, Event)
Unit:RegisterEvent("Veronia_Fight", 8000, 0)
end

function Veronia_Fight(Unit, Event) 
Unit:CastSpell(34905) 
end

function Veronia_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Veronia_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Veronia_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20162, 1, "Veronia_OnCombat")
RegisterUnitEvent(20162, 2, "Veronia_OnLeaveCombat")
RegisterUnitEvent(20162, 3, "Veronia_OnKilledTarget")
RegisterUnitEvent(20162, 4, "Veronia_OnDied")