--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ChieftainGurgleboggle_OnCombat(Unit, Event)
Unit:RegisterEvent("ChieftainGurgleboggle_FlipAttack", 8000, 0)
end

function ChieftainGurgleboggle_FlipAttack(Unit, Event) 
Unit:FullCastSpellOnTarget(50533, Unit:GetMainTank()) 
end

function ChieftainGurgleboggle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ChieftainGurgleboggle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ChieftainGurgleboggle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25725, 1, "ChieftainGurgleboggle_OnCombat")
RegisterUnitEvent(25725, 2, "ChieftainGurgleboggle_OnLeaveCombat")
RegisterUnitEvent(25725, 3, "ChieftainGurgleboggle_OnKilledTarget")
RegisterUnitEvent(25725, 4, "ChieftainGurgleboggle_OnDied")