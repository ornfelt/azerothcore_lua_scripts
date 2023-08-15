--[[ Shattrath City -- Shattrath City Peacekeeper.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Peacekeeper_OnCombat(Unit, Event)
Unit:RegisterEvent("Peacekeeper_Block", 5000, 0)
end

function Peacekeeper_Block(Unit, Event) 
Unit:CastSpell(12169) 
end

function Peacekeeper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Peacekeeper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Peacekeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19687, 1, "Peacekeeper_OnCombat")
RegisterUnitEvent(19687, 2, "Peacekeeper_OnLeaveCombat")
RegisterUnitEvent(19687, 3, "Peacekeeper_OnKilledTarget")
RegisterUnitEvent(19687, 4, "Peacekeeper_OnDied")