--[[ Netherstorm -- Sunfury Blood Knight.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Knight_OnCombat(Unit, Event)
end

function Knight_Heal(Unit, Event) 
Unit:CastSpell(36476) 
end

function Knight_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function Knight_Breaker(Unit, Event) 
Unit:FullCastSpellOnTarget(35871, Unit:GetMainTank()) 
end

function Knight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Knight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Knight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21089, 1, "Knight_OnCombat")
RegisterUnitEvent(21089, 2, "Knight_OnLeaveCombat")
RegisterUnitEvent(21089, 3, "Knight_OnKilledTarget")
RegisterUnitEvent(21089, 4, "Knight_OnDied")