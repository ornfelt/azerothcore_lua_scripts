--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ElderMottledBoar_OnCombat(Unit, Event)
	UnitRegisterEvent("ElderMottledBoar_BoarCharge", 6000, 0)
end

function ElderMottledBoar_BoarCharge(Unit, Event) 
	UnitCastSpell(3385) 
end

function ElderMottledBoar_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ElderMottledBoar_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ElderMottledBoar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3100, 1, "ElderMottledBoar_OnCombat")
RegisterUnitEvent(3100, 2, "ElderMottledBoar_OnLeaveCombat")
RegisterUnitEvent(3100, 3, "ElderMottledBoar_OnKilledTarget")
RegisterUnitEvent(3100, 4, "ElderMottledBoar_OnDied")