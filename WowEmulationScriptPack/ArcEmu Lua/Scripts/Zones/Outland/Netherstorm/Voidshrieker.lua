--[[ Netherstorm -- Voidshrieker.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Voidshrieker_OnCombat(Unit, Event)
Unit:RegisterEvent("Voidshrieker_Spawn", 8000, 0)
Unit:RegisterEvent("Voidshrieker_Bolt", 6000, 0)
end

function Voidshrieker_Spawn(Unit, Event) 
Unit:CastSpell(34302) 
end

function Voidshrieker_Bolt(Unit, Event) 
Unit:FullCastSpellOnTarget(34344, Unit:GetMainTank()) 
end

function Voidshrieker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Voidshrieker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Voidshrieker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18870, 1, "Voidshrieker_OnCombat")
RegisterUnitEvent(18870, 2, "Voidshrieker_OnLeaveCombat")
RegisterUnitEvent(18870, 3, "Voidshrieker_OnKilledTarget")
RegisterUnitEvent(18870, 4, "Voidshrieker_OnDied")