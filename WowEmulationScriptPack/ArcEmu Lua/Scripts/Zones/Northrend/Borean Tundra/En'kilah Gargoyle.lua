--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnkilahGargoyle_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahGargoyle_GargoyleStrike", 6000, 0)
end

function EnkilahGargoyle_GargoyleStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(16564, Unit:GetMainTank()) 
end

function EnkilahGargoyle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahGargoyle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahGargoyle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25387, 1, "EnkilahGargoyle_OnCombat")
RegisterUnitEvent(25387, 2, "EnkilahGargoyle_OnLeaveCombat")
RegisterUnitEvent(25387, 3, "EnkilahGargoyle_OnKilledTarget")
RegisterUnitEvent(25387, 4, "EnkilahGargoyle_OnDied")