--[[ Shattrath City -- Sal'salabim.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Salsalabim_OnCombat(Unit, Event)
Unit:RegisterEvent("Salsalabim_Pull", 6000, 0)
end

function Salsalabim_Pull(Unit, Event) 
Unit:FullCastSpellOnTarget(31705, Unit:GetMainTank()) 
end

function Salsalabim_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Salsalabim_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Salsalabim_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18584, 1, "Salsalabim_OnCombat")
RegisterUnitEvent(18584, 2, "Salsalabim_OnLeaveCombat")
RegisterUnitEvent(18584, 3, "Salsalabim_OnKilledTarget")
RegisterUnitEvent(18584, 4, "Salsalabim_OnDied")