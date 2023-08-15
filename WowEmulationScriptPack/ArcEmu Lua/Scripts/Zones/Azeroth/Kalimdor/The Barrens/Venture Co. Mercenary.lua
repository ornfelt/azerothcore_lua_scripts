--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoMercenary_OnCombat(Unit, Event)
	Unit:RegisterEvent("VentureCoMercenary_Shoot", 6000, 0)
end

function VentureCoMercenary_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function VentureCoMercenary_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VentureCoMercenary_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function VentureCoMercenary_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3382, 1, "VentureCoMercenary_OnCombat")
RegisterUnitEvent(3382, 2, "VentureCoMercenary_OnLeaveCombat")
RegisterUnitEvent(3382, 3, "VentureCoMercenary_OnKilledTarget")
RegisterUnitEvent(3382, 4, "VentureCoMercenary_OnDied")