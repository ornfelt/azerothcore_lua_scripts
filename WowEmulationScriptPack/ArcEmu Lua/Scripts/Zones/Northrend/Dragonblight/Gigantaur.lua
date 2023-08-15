--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Gigantaur_OnCombat(Unit, Event)
Unit:RegisterEvent("Gigantaur_GiganticBlow", 6000, 0)
Unit:RegisterEvent("Gigantaur_Hamstring", 8000, 0)
end

function Gigantaur_GiganticBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(52139, Unit:GetMainTank()) 
end

function Gigantaur_Hamstring(Unit, Event) 
Unit:FullCastSpellOnTarget(9080, Unit:GetMainTank()) 
end

function Gigantaur_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Gigantaur_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Gigantaur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26836, 1, "Gigantaur_OnCombat")
RegisterUnitEvent(26836, 2, "Gigantaur_OnLeaveCombat")
RegisterUnitEvent(26836, 3, "Gigantaur_OnKilledTarget")
RegisterUnitEvent(26836, 4, "Gigantaur_OnDied")