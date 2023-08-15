--[[ Netherstorm -- Sunfury Centurion.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Centurion_OnCombat(Unit, Event)
Unit:RegisterEvent("Centurion_Enrage", 25000, 1)
Unit:RegisterEvent("Centurion_Breaker", 10000, 0)
end

function Centurion_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function Centurion_Breaker(Unit, Event) 
Unit:CastSpell(35871) 
end

function Centurion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Centurion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Centurion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20140, 1, "Centurion_OnCombat")
RegisterUnitEvent(20140, 2, "Centurion_OnLeaveCombat")
RegisterUnitEvent(20140, 3, "Centurion_OnKilledTarget")
RegisterUnitEvent(20140, 4, "Centurion_OnDied")