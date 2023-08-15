--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Drakegore_OnCombat(Unit, Event)
Unit:RegisterEvent("Drakegore_BurningFists", 2000, 1)
Unit:RegisterEvent("Drakegore_MagnataurCharge", 6000, 0)
end

function Drakegore_BurningFists(Unit, Event) 
Unit:CastSpell(52101) 
end

function Drakegore_MagnataurCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(52088, Unit:GetMainTank()) 
end

function Drakegore_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Drakegore_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Drakegore_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27009, 1, "Drakegore_OnCombat")
RegisterUnitEvent(27009, 2, "Drakegore_OnLeaveCombat")
RegisterUnitEvent(27009, 3, "Drakegore_OnKilledTarget")
RegisterUnitEvent(27009, 4, "Drakegore_OnDied")