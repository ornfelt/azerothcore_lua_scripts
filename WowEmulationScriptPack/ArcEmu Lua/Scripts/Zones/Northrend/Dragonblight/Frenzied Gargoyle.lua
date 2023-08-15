--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FrenziedGargoyle_OnCombat(Unit, Event)
Unit:RegisterEvent("FrenziedGargoyle_GargoyleStrike", 6500, 0)
end

function FrenziedGargoyle_GargoyleStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(31664, Unit:GetMainTank()) 
end

function FrenziedGargoyle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrenziedGargoyle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrenziedGargoyle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27691, 1, "FrenziedGargoyle_OnCombat")
RegisterUnitEvent(27691, 2, "FrenziedGargoyle_OnLeaveCombat")
RegisterUnitEvent(27691, 3, "FrenziedGargoyle_OnKilledTarget")
RegisterUnitEvent(27691, 4, "FrenziedGargoyle_OnDied")