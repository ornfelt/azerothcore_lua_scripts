--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoMachineSmith_OnCombat(Unit, Event)
	UnitRegisterEvent("VentureCoMachineSmith_CompactHarvestReaper", 6000, 1)
end

function VentureCoMachineSmith_CompactHarvestReaper(Unit, Event) 
	UnitCastSpell(7979) 
end

function VentureCoMachineSmith_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VentureCoMachineSmith_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VentureCoMachineSmith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3993, 1, "VentureCoMachineSmith_OnCombat")
RegisterUnitEvent(3993, 2, "VentureCoMachineSmith_OnLeaveCombat")
RegisterUnitEvent(3993, 3, "VentureCoMachineSmith_OnKilledTarget")
RegisterUnitEvent(3993, 4, "VentureCoMachineSmith_OnDied")