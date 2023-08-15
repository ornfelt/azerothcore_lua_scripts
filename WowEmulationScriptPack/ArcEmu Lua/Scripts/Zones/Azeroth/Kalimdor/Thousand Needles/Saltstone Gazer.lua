--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SaltstoneGazer_OnCombat(Unit, Event)
	UnitRegisterEvent("SaltstoneGazer_CrystalGaze", 12000, 0)
end

function SaltstoneGazer_CrystalGaze(Unit, Event) 
	UnitFullCastSpellOnTarget(3635, 	UnitGetMainTank()) 
end

function SaltstoneGazer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SaltstoneGazer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SaltstoneGazer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4150, 1, "SaltstoneGazer_OnCombat")
RegisterUnitEvent(4150, 2, "SaltstoneGazer_OnLeaveCombat")
RegisterUnitEvent(4150, 3, "SaltstoneGazer_OnKilledTarget")
RegisterUnitEvent(4150, 4, "SaltstoneGazer_OnDied")