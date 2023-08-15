--[[ Netherstorm -- Warp-Gate Engineer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]


function Engineer_OnCombat(Unit, Event)
Unit:RegisterEvent("Engineer_Swipe", 6000, 0)
end

function Engineer_Swipe(Unit, Event) 
Unit:FullCastSpellOnTarget(35147, Unit:GetMainTank()) 
end

function Engineer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Engineer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Engineer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20404, 1, "Engineer_OnCombat")
RegisterUnitEvent(20404, 2, "Engineer_OnLeaveCombat")
RegisterUnitEvent(20404, 3, "Engineer_OnKilledTarget")
RegisterUnitEvent(20404, 4, "Engineer_OnDied")