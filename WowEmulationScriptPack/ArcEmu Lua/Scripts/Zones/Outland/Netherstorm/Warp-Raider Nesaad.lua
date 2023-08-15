--[[ Netherstorm -- Warp-Raider Nesaad.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Nesaad_OnCombat(Unit, Event)
Unit:RegisterEvent("Nesaad_Flux", 7000, 0)
end

function Nesaad_Flux(Unit, Event) 
Unit:CastSpell(35924) 
end

function Nesaad_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Nesaad_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Nesaad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19641, 1, "Nesaad_OnCombat")
RegisterUnitEvent(19641, 2, "Nesaad_OnLeaveCombat")
RegisterUnitEvent(19641, 3, "Nesaad_OnKilledTarget")
RegisterUnitEvent(19641, 4, "Nesaad_OnDied")