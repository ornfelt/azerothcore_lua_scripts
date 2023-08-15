--[[ Netherstorm -- Zaxxis Stalker.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Stalker_OnCombat(Unit, Event)
Unit:RegisterEvent("Stalker_Backstab", 6000, 0)
Unit:RegisterEvent("Stalker_Warp", 8000, 0)
end

function Stalker_Backstab(Unit, Event) 
Unit:FullCastSpellOnTarget(7159, Unit:GetMainTank()) 
end

function Stalker_Warp(Unit, Event) 
Unit:CastSpell(32920) 
end

function Stalker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Stalker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Stalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19642, 1, "Stalker_OnCombat")
RegisterUnitEvent(19642, 2, "Stalker_OnLeaveCombat")
RegisterUnitEvent(19642, 3, "Stalker_OnKilledTarget")
RegisterUnitEvent(19642, 4, "Stalker_OnDied")