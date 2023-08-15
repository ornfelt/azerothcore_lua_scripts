--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DireMottledBoar_OnCombat(Unit, Event)
	UnitRegisterEvent("DireMottledBoar_BoarCharge", 6000, 0)
end

function DireMottledBoar_BoarCharge(Unit, Event) 
	UnitCastSpell(3385) 
end

function DireMottledBoar_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DireMottledBoar_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DireMottledBoar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3099, 1, "DireMottledBoar_OnCombat")
RegisterUnitEvent(3099, 2, "DireMottledBoar_OnLeaveCombat")
RegisterUnitEvent(3099, 3, "DireMottledBoar_OnKilledTarget")
RegisterUnitEvent(3099, 4, "DireMottledBoar_OnDied")