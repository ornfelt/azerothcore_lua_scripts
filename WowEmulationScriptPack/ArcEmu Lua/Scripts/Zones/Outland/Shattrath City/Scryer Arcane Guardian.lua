--[[ Shattrath City -- Scryer Arcane Guardian.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Guardian_OnCombat(Unit, Event)
Unit:RegisterEvent("Guardian_Banish", 10000, 0)
end

function Guardian_Banish(Unit, Event) 
Unit:FullCastSpellOnTarget(36671, Unit:GetMainTank()) 
end

function Guardian_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Guardian_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Guardian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18568, 1, "Guardian_OnCombat")
RegisterUnitEvent(18568, 2, "Guardian_OnLeaveCombat")
RegisterUnitEvent(18568, 3, "Guardian_OnKilledTarget")
RegisterUnitEvent(18568, 4, "Guardian_OnDied")