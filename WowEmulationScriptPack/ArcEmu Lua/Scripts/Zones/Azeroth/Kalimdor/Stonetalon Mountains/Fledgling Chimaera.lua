--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FledglingChimaera_OnCombat(Unit, Event)
	UnitRegisterEvent("FledglingChimaera_CorrosivePoison", 10000, 0)
end

function FledglingChimaera_CorrosivePoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3397, 	UnitGetMainTank()) 
end

function FledglingChimaera_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function FledglingChimaera_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function FledglingChimaera_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4031, 1, "FledglingChimaera_OnCombat")
RegisterUnitEvent(4031, 2, "FledglingChimaera_OnLeaveCombat")
RegisterUnitEvent(4031, 3, "FledglingChimaera_OnKilledTarget")
RegisterUnitEvent(4031, 4, "FledglingChimaera_OnDied")