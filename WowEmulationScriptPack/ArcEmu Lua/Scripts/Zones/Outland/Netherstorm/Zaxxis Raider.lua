--[[ Netherstorm -- Zaxxis Raider.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Raider_OnCombat(Unit, Event)
Unit:RegisterEvent("Raider_Energy", 8000, 0)
end

function Raider_Energy(Unit, Event) 
Unit:CastSpell(35922) 
end

function Raider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Raider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Raider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18875, 1, "Raider_OnCombat")
RegisterUnitEvent(18875, 2, "Raider_OnLeaveCombat")
RegisterUnitEvent(18875, 3, "Raider_OnKilledTarget")
RegisterUnitEvent(18875, 4, "Raider_OnDied")