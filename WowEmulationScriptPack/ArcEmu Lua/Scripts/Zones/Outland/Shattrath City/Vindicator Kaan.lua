--[[ Shattrath City -- Vindicator Kaan.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Kaan_OnCombat(Unit, Event)
Unit:RegisterEvent("Kaan_Banish", 7000, 0)
end

function Kaan_Banish(Unit, Event) 
Unit:FullCastSpellOnTarget(36642, Unit:GetMainTank()) 
end

function Kaan_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Kaan_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Kaan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23271, 1, "Kaan_OnCombat")
RegisterUnitEvent(23271, 2, "Kaan_OnLeaveCombat")
RegisterUnitEvent(23271, 3, "Kaan_OnKilledTarget")
RegisterUnitEvent(23271, 4, "Kaan_OnDied")