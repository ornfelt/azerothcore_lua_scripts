--[[ Netherstorm -- Sunfury Researcher.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Researcher_OnCombat(Unit, Event)
Unit:RegisterEvent("Researcher_Armor", 6000, 0)
end

function Researcher_Armor(Unit, Event) 
Unit:FullCastSpellOnTarget(35918, Unit:GetMainTank()) 
end

function Researcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Researcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Researcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20136, 1, "Researcher_OnCombat")
RegisterUnitEvent(20136, 2, "Researcher_OnLeaveCombat")
RegisterUnitEvent(20136, 3, "Researcher_OnKilledTarget")
RegisterUnitEvent(20136, 4, "Researcher_OnDied")