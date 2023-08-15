--[[ Netherstorm -- Sunfury Bloodwarder.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Bloodwarder_OnCombat(Unit, Event)
Unit:RegisterEvent("Bloodwarder_Enrage", 25000, 1)
Unit:RegisterEvent("Bloodwarder_Mark", 10000, 0)
end

function Bloodwarder_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function Bloodwarder_Mark(Unit, Event) 
Unit:FullCastSpellOnTarget(35877, Unit:GetMainTank()) 
end

function Bloodwarder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bloodwarder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bloodwarder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18853, 1, "Bloodwarder_OnCombat")
RegisterUnitEvent(18853, 2, "Bloodwarder_OnLeaveCombat")
RegisterUnitEvent(18853, 3, "Bloodwarder_OnKilledTarget")
RegisterUnitEvent(18853, 4, "Bloodwarder_OnDied")