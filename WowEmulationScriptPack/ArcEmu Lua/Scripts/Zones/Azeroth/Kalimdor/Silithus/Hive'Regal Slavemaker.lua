--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveRegalSlavemaker_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveRegalSlavemaker_VolatileInfection", 10000, 0)
end

function HiveRegalSlavemaker_VolatileInfection(Unit, Event) 
	Unit:FullCastSpellOnTarget(3584, 	Unit:GetMainTank()) 
end

function HiveRegalSlavemaker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveRegalSlavemaker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveRegalSlavemaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11733, 1, "HiveRegalSlavemaker_OnCombat")
RegisterUnitEvent(11733, 2, "HiveRegalSlavemaker_OnLeaveCombat")
RegisterUnitEvent(11733, 3, "HiveRegalSlavemaker_OnKilledTarget")
RegisterUnitEvent(11733, 4, "HiveRegalSlavemaker_OnDied")