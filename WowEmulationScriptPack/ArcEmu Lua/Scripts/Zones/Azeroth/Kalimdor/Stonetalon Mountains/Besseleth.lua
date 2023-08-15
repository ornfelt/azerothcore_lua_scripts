--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Besseleth_OnCombat(Unit, Event)
	UnitRegisterEvent("Besseleth_VenomSting", 10000, 0)
	UnitRegisterEvent("Besseleth_Web", 12000, 0)
end

function Besseleth_VenomSting(Unit, Event) 
	UnitFullCastSpellOnTarget(5416, 	UnitGetMainTank()) 
end

function Besseleth_Web(Unit, Event) 
	UnitFullCastSpellOnTarget(745, 	UnitGetMainTank()) 
end

function Besseleth_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function Besseleth_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function Besseleth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11921, 1, "Besseleth_OnCombat")
RegisterUnitEvent(11921, 2, "Besseleth_OnLeaveCombat")
RegisterUnitEvent(11921, 3, "Besseleth_OnKilledTarget")
RegisterUnitEvent(11921, 4, "Besseleth_OnDied")