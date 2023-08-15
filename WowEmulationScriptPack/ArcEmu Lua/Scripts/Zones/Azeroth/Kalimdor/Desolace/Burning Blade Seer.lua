--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeSeer_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeSeer_FlameBuffet", 8000, 0)
	Unit:RegisterEvent("BurningBladeSeer_Flamestrike", 11000, 0)
end

function BurningBladeSeer_FlameBuffet(Unit, Event) 
	Unit:FullCastSpellOnTarget(9658, 	Unit:GetMainTank()) 
end

function BurningBladeSeer_Flamestrike(Unit, Event) 
	Unit:CastSpell(11829) 
end

function BurningBladeSeer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeSeer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(13019, 1, "BurningBladeSeer_OnCombat")
RegisterUnitEvent(13019, 2, "BurningBladeSeer_OnLeaveCombat")
RegisterUnitEvent(13019, 4, "BurningBladeSeer_OnDied")