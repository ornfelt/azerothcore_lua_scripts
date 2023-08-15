--[[ Netherstorm -- Void Conduit.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Conduit_OnCombat(Unit, Event)
Unit:RegisterEvent("Conduit_Dummy", 9000, 0)
end

function Conduit_Dummy(Unit, Event) 
Unit:FullCastSpellOnTarget(36780, Unit:GetMainTank()) 
end

function Conduit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Conduit_OnKilledTarget(Unit, Event)
Unit:RemoveEvents()
end

function Conduit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end



RegisterUnitEvent(20899, 1, "Conduit_OnCombat")
RegisterUnitEvent(20899, 2, "Conduit_OnLeaveCombat")
RegisterUnitEvent(20899, 3, "Conduit_OnKilledTarget")
RegisterUnitEvent(20899, 4, "Conduit_OnDied")