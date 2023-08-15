--[[ Shattrath City -- A'dal.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 28th, 2008. ]]

function Adal_OnCombat(Unit, Event)
Unit:RegisterEvent("Adal_Ultimate", 1000, 1)
end

function Adal_Ultimate(Unit, Event) 
Unit:CastSpell(35076) 
end

function Adal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Adal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Adal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18481, 1, "Adal_OnCombat")
RegisterUnitEvent(18481, 2, "Adal_OnLeaveCombat")
RegisterUnitEvent(18481, 3, "Adal_OnKilledTarget")
RegisterUnitEvent(18481, 4, "Adal_OnDied")