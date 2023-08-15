--[[ Netherstorm -- Sunfury Warp-Master.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Master_OnCombat(Unit, Event)
Unit:RegisterEvent("Master_Beam", 6000, 0)
end

function Master_Beam(Unit, Event) 
Unit:FullCastSpellOnTarget(35919, Unit:GetMainTank()) 
end

function Master_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Master_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Master_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18857, 1, "Master_OnCombat")
RegisterUnitEvent(18857, 2, "Master_OnLeaveCombat")
RegisterUnitEvent(18857, 3, "Master_OnKilledTarget")
RegisterUnitEvent(18857, 4, "Master_OnDied")