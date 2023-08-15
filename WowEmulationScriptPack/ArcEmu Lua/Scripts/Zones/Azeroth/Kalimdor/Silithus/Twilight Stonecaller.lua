--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightStonecaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightStonecaller_Fireball", 8000, 0)
	Unit:RegisterEvent("TwilightStonecaller_Petrify", 10000, 0)
end

function TwilightStonecaller_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(9053, 	Unit:GetMainTank()) 
end

function TwilightStonecaller_Petrify(Unit, Event) 
	Unit:FullCastSpellOnTarget(11020, 	Unit:GetMainTank()) 
end

function TwilightStonecaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightStonecaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightStonecaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11882, 1, "TwilightStonecaller_OnCombat")
RegisterUnitEvent(11882, 2, "TwilightStonecaller_OnLeaveCombat")
RegisterUnitEvent(11882, 3, "TwilightStonecaller_OnKilledTarget")
RegisterUnitEvent(11882, 4, "TwilightStonecaller_OnDied")