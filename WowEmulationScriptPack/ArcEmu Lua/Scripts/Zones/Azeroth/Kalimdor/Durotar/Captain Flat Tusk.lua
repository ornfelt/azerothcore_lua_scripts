--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CaptainFlatTusk_OnCombat(Unit, Event)
	UnitRegisterEvent("CaptainFlatTusk_HeroicStrike", 5000, 0)
end

function CaptainFlatTusk_HeroicStrike(Unit, Event) 
	UnitFullCastSpellOnTarget(25710, 	UnitGetMainTank()) 
end

function CaptainFlatTusk_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CaptainFlatTusk_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CaptainFlatTusk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5824, 1, "CaptainFlatTusk_OnCombat")
RegisterUnitEvent(5824, 2, "CaptainFlatTusk_OnLeaveCombat")
RegisterUnitEvent(5824, 3, "CaptainFlatTusk_OnKilledTarget")
RegisterUnitEvent(5824, 4, "CaptainFlatTusk_OnDied")