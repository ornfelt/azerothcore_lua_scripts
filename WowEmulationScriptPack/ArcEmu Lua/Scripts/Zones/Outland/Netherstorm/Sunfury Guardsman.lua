--[[ Netherstorm -- Sunfury Guardsman.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Guardsman_OnCombat(Unit, Event)
Unit:RegisterEvent("Guardsman_Enrage", 25000, 0)
Unit:RegisterEvent("Guardsman_Mark", 10000, 0)
end

function Guardsman_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function Guardsman_Mark(Unit, Event) 
Unit:FullCastSpellOnTarget(35877, Unit:GetMainTank()) 
end

function Guardsman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Guardsman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Guardsman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18850, 1, "Guardsman_OnCombat")
RegisterUnitEvent(18850, 2, "Guardsman_OnLeaveCombat")
RegisterUnitEvent(18850, 3, "Guardsman_OnKilledTarget")
RegisterUnitEvent(18850, 4, "Guardsman_OnDied")