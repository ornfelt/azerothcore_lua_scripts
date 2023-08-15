--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ChimaeraMatriarch_OnCombat(Unit, Event)
	UnitRegisterEvent("ChimaeraMatriarch_CorrosivePoison", 10000, 0)
end

function ChimaeraMatriarch_CorrosivePoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3397, 	UnitGetMainTank()) 
end

function ChimaeraMatriarch_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ChimaeraMatriarch_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ChimaeraMatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(6167, 1, "ChimaeraMatriarch_OnCombat")
RegisterUnitEvent(6167, 2, "ChimaeraMatriarch_OnLeaveCombat")
RegisterUnitEvent(6167, 3, "ChimaeraMatriarch_OnKilledTarget")
RegisterUnitEvent(6167, 4, "ChimaeraMatriarch_OnDied")