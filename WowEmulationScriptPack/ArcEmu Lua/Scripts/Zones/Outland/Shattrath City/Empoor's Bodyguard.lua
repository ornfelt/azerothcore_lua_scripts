--[[ Shattrath City -- Empoor's Bodyguard.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function Bodyguard_OnCombat(Unit, Event)
Unit:RegisterEvent("Bodyguard_Demoralize", 10000, 0)
Unit:RegisterEvent("Bodyguard_Rend", 6000, 0)
end

function Bodyguard_Demoralize(Unit, Event) 
Unit:FullCastSpellOnTarget(13730, Unit:GetClosestPlayer()) 
end

function Bodyguard_Rend(Unit, Event) 
Unit:FullCastSpellOnTarget(11977, Unit:GetMainTank()) 
end

function Bodyguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bodyguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bodyguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18483, 1, "Bodyguard_OnCombat")
RegisterUnitEvent(18483, 2, "Bodyguard_OnLeaveCombat")
RegisterUnitEvent(18483, 3, "Bodyguard_OnKilledTarget")
RegisterUnitEvent(18483, 4, "Bodyguard_OnDied")