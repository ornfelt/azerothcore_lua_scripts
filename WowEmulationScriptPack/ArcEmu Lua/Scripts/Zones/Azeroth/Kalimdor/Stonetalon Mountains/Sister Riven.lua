--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SisterRiven_OnCombat(Unit, Event)
	UnitRegisterEvent("SisterRiven_FireShieldII", 1000, 1)
	UnitRegisterEvent("SisterRiven_FlameLash", 4000, 1)
	UnitRegisterEvent("SisterRiven_FlameSpike", 6000, 1)
end

function SisterRiven_FireShieldII(Unit, Event) 
	UnitCastSpell(184) 
end

function SisterRiven_FlameLash(Unit, Event) 
	UnitFullCastSpellOnTarget(3356, 	UnitGetMainTank()) 
end

function SisterRiven_FlameSpike(Unit, Event) 
	UnitCastSpell(6725) 
end

function SisterRiven_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SisterRiven_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SisterRiven_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5930, 1, "SisterRiven_OnCombat")
RegisterUnitEvent(5930, 2, "SisterRiven_OnLeaveCombat")
RegisterUnitEvent(5930, 3, "SisterRiven_OnKilledTarget")
RegisterUnitEvent(5930, 4, "SisterRiven_OnDied")