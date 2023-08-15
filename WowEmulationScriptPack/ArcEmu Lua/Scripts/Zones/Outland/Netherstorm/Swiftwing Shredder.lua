--[[ Netherstorm -- Swiftwing Shredder.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Shredder_OnCombat(Unit, Event)
Unit:RegisterEvent("Shredder_Blast", 6000, 0)
Unit:RegisterEvent("Shredder_Shield", 1000, 1)
end

function Shredder_Blast(Unit, Event) 
Unit:FullCastSpellOnTarget(36594, Unit:GetMainTank()) 
end

function Shredder_Shield(Unit, Event) 
Unit:CastSpell(19514) 
end

function Shredder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Shredder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Shredder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20673, 1, "Shredder_OnCombat")
RegisterUnitEvent(20673, 2, "Shredder_OnLeaveCombat")
RegisterUnitEvent(20673, 3, "Shredder_OnKilledTarget")
RegisterUnitEvent(20673, 4, "Shredder_OnDied")