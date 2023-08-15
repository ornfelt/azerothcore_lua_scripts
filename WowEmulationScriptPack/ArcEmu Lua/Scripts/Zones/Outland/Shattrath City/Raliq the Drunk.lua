--[[ Shattrath City -- Raliq the Drunk.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Drunk_OnCombat(Unit, Event)
Unit:RegisterEvent("Drunk_Knock", 8000, 0)
end

function Drunk_Knock(Unit, Event) 
Unit:FullCastSpellOnTarget(10966, Unit:GetMainTank()) 
end

function Drunk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Drunk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Drunk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18585, 1, "Drunk_OnCombat")
RegisterUnitEvent(18585, 2, "Drunk_OnLeaveCombat")
RegisterUnitEvent(18585, 3, "Drunk_OnKilledTarget")
RegisterUnitEvent(18585, 4, "Drunk_OnDied")