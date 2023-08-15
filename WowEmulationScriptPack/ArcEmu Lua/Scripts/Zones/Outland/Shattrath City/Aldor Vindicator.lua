--[[ Shattrath City -- Aldor Vindicator.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 28th, 2008. ]]

function Vindicator_OnCombat(Unit, Event)
Unit:RegisterEvent("Vindicator_Banish", 7000, 0)
end

function Vindicator_Banish(Unit, Event) 
Unit:FullCastSpellOnTarget(36642, Unit:GetMainTank()) 
end

function Vindicator_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Vindicator_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Vindicator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18549, 1, "Vindicator_OnCombat")
RegisterUnitEvent(18549, 2, "Vindicator_OnLeaveCombat")
RegisterUnitEvent(18549, 3, "Vindicator_OnKilledTarget")
RegisterUnitEvent(18549, 4, "Vindicator_OnDied")