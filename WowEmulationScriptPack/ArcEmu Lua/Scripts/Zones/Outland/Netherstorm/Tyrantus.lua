--[[ Netherstorm -- Tyrantus.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Tyrantus_OnCombat(Unit, Event)
Unit:RegisterEvent("Tyrantus_Wood", 7000, 0)
Unit:RegisterEvent("Tyrantus_Fear", 6000, 0)
end

function Tyrantus_Wood(Unit, Event) 
Unit:FullCastSpellOnTarget(35321, Unit:GetMainTank()) 
end

function Tyrantus_Fear(Unit, Event) 
Unit:FullCastSpellOnTarget(36629, Unit:GetClosestPlayer()) 
end

function Tyrantus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tyrantus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tyrantus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20931, 1, "Tyrantus_OnCombat")
RegisterUnitEvent(20931, 2, "Tyrantus_OnLeaveCombat")
RegisterUnitEvent(20931, 3, "Tyrantus_OnKilledTarget")
RegisterUnitEvent(20931, 4, "Tyrantus_OnDied")