--[[ Netherstorm -- Wrath Lord.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Lord_OnCombat(Unit, Event)
Unit:RegisterEvent("Lord_Cleave", 6000, 0)
end

function Lord_Cleave(Unit, Event) 
Unit:FullCastSpellOnTarget(15496, Unit:GetMainTank()) 
end

function Lord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Lord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Lord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20929, 1, "Lord_OnCombat")
RegisterUnitEvent(20929, 2, "Lord_OnLeaveCombat")
RegisterUnitEvent(20929, 3, "Lord_OnKilledTarget")
RegisterUnitEvent(20929, 4, "Lord_OnDied")