--[[ Netherstorm -- Sunfury Bowman.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Sunfury_Bowman_OnCombat(Unit, Event)
Unit:RegisterEvent("Sunfury_Bowman_Net", 8000, 0)
Unit:RegisterEvent("Sunfury_Bowman_Immolation_Arrow", 6000, 0)
Unit:RegisterEvent("Sunfury_Bowman_Shoot", 6000, 0)
end

function Sunfury_Bowman_Immolation_Arrow(Unit, Event) 
Unit:FullCastSpellOnTarget(37847, Unit:GetMainTank()) 
end

function Sunfury_Bowman_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(12024, Unit:GetMainTank()) 
end

function Sunfury_Bowman_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function Sunfury_Bowman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sunfury_Bowman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sunfury_Bowman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20207, 1, "Sunfury_Bowman_OnCombat")
RegisterUnitEvent(20207, 2, "Sunfury_Bowman_OnLeaveCombat")
RegisterUnitEvent(20207, 3, "Sunfury_Bowman_OnKilledTarget")
RegisterUnitEvent(20207, 4, "Sunfury_Bowman_OnDied")