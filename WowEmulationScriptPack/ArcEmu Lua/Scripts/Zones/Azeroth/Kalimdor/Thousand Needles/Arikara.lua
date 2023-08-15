--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Arikara_OnCombat(Unit, Event)
	UnitRegisterEvent("Arikara_CurseofVengeance", 10000, 3)
	UnitRegisterEvent("Arikara_Enrage", 120000, 0)
end

function Arikara_CurseofVengeance(Unit, Event) 
	UnitFullCastSpellOnTarget(17213, 	UnitGetMainTank()) 
end

function Arikara_Enrage(Unit, Event)
if 	UnitGetHealthPct() < 25 then
	UnitCastSpell(8599) 
end
end

function Arikara_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function Arikara_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function Arikara_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10882, 1, "Arikara_OnCombat")
RegisterUnitEvent(10882, 2, "Arikara_OnLeaveCombat")
RegisterUnitEvent(10882, 3, "Arikara_OnKilledTarget")
RegisterUnitEvent(10882, 4, "Arikara_OnDied")