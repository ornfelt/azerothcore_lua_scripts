--[[ Shattrath City -- Avatar of Terokk.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 28th, 2008. ]]

function Terokk_OnCombat(Unit, Event)
Unit:RegisterEvent("Terokk_Charge", 1000, 1)
Unit:RegisterEvent("Terokk_Burst", 6000, 0)
end

function Terokk_Charge(Unit, Event) 
Unit:FullCastSpellOnTarget(24193, Unit:GetMainTank()) 
end

function Terokk_Burst(Unit, Event) 
Unit:FullCastSpellOnTarget(39068, Unit:GetMainTank()) 
end

function Terokk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Terokk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Terokk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(22375, 1, "Terokk_OnCombat")
RegisterUnitEvent(22375, 2, "Terokk_OnLeaveCombat")
RegisterUnitEvent(22375, 3, "Terokk_OnKilledTarget")
RegisterUnitEvent(22375, 4, "Terokk_OnDied")