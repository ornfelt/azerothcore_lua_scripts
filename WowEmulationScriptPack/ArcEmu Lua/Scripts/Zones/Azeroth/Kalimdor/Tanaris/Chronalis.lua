--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Chronalis_OnCombat(Unit, Event)
	Unit:RegisterEvent("Chronalis_SandBreath", 10000, 0)
	Unit:RegisterEvent("Chronalis_Cleave", 5000, 0)
end

function Chronalis_Cleave(Unit, Event) 
	Unit:CastSpell(40505) 
end

function Chronalis_SandBreath(Unit, Event) 
	Unit:FullCastSpellOnTarget(20717, 	Unit:GetMainTank()) 
end

function Chronalis_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Chronalis_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Chronalis_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8197, 1, "Chronalis_OnCombat")
RegisterUnitEvent(8197, 2, "Chronalis_OnLeaveCombat")
RegisterUnitEvent(8197, 3, "Chronalis_OnKilledTarget")
RegisterUnitEvent(8197, 4, "Chronalis_OnDied")