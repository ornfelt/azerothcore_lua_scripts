--[[ Netherstorm -- Sunfury Geologist.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Geologist_OnCombat(Unit, Event)
Unit:RegisterEvent("Geologist_Armor", 10000, 0)
Unit:RegisterEvent("Geologist_Rock", 6000, 0)
end

function Geologist_Armor(Unit, Event) 
Unit:FullCastSpellOnTarget(35918, Unit:GetMainTank()) 
end

function Geologist_Rock(Unit, Event) 
Unit:FullCastSpellOnTarget(36645, Unit:GetMainTank()) 
end

function Geologist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Geologist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Geologist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19779, 1, "Geologist_OnCombat")
RegisterUnitEvent(19779, 2, "Geologist_OnLeaveCombat")
RegisterUnitEvent(19779, 3, "Geologist_OnKilledTarget")
RegisterUnitEvent(19779, 4, "Geologist_OnDied")