--[[ Netherstorm -- Wrath Priestess.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Priestess_OnCombat(Unit, Event)
Unit:RegisterEvent("Priestess_Rain", 9000, 0)
end

function Priestess_Rain(Unit, Event) 
Unit:CastSpell(34017) 
end

function Priestess_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Priestess_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Priestess_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18859, 1, "Priestess_OnCombat")
RegisterUnitEvent(18859, 2, "Priestess_OnLeaveCombat")
RegisterUnitEvent(18859, 3, "Priestess_OnKilledTarget")
RegisterUnitEvent(18859, 4, "Priestess_OnDied")