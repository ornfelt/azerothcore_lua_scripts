--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function YoungChimaera_OnCombat(Unit, Event)
	UnitRegisterEvent("YoungChimaera_LightningBolt", 8000, 0)
end

function YoungChimaera_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(9532, 	UnitGetMainTank()) 
end

function YoungChimaera_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function YoungChimaera_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function YoungChimaera_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4032, 1, "YoungChimaera_OnCombat")
RegisterUnitEvent(4032, 2, "YoungChimaera_OnLeaveCombat")
RegisterUnitEvent(4032, 3, "YoungChimaera_OnKilledTarget")
RegisterUnitEvent(4032, 4, "YoungChimaera_OnDied")