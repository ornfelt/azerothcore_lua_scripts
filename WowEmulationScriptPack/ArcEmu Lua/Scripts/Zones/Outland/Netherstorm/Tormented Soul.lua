--[[ Netherstorm -- Tormented Soul.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Soul_OnCombat(Unit, Event)
Unit:RegisterEvent("Soul_Immune", 6000, 0)
end

function Soul_Immune(Unit, Event) 
Unit:FullCastSpellOnTarget(36153, Unit:GetMainTank()) 
end

function Soul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Soul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Soul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20512, 1, "Soul_OnCombat")
RegisterUnitEvent(20512, 2, "Soul_OnLeaveCombat")
RegisterUnitEvent(20512, 3, "Soul_OnKilledTarget")
RegisterUnitEvent(20512, 4, "Soul_OnDied")