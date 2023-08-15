--[[ Netherstorm -- Sunfury Magister.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Magister_OnCombat(Unit, Event)
Unit:RegisterEvent("Magister_Fireball", 6000, 0)
Unit:RegisterEvent("Magister_Surge", 10000, 0)
end

function Magister_Fireball(Unit, Event) 
Unit:FullCastSpellOnTarget(9053, Unit:GetMainTank()) 
end

function Magister_Surge(Unit, Event) 
Unit:CastSpell(35778) 
end

function Magister_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Magister_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Magister_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18855, 1, "Magister_OnCombat")
RegisterUnitEvent(18855, 2, "Magister_OnLeaveCombat")
RegisterUnitEvent(18855, 3, "Magister_OnKilledTarget")
RegisterUnitEvent(18855, 4, "Magister_OnDied")