--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Rocklance_OnCombat(Unit, Event)
	Unit:RegisterEvent("Rocklance_Cleave", 4000, 0)
	Unit:RegisterEvent("Rocklance_DefensiveStance", 2000, 1)
	Unit:RegisterEvent("Rocklance_SunderArmor", 6000, 0)
end

function Rocklance_Cleave(Unit, Event) 
	Unit:CastSpell(15496) 
end

function Rocklance_DefensiveStance(Unit, Event) 
	Unit:CastSpell(7164) 
end

function Rocklance_SunderArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(21081, 	Unit:GetMainTank()) 
end

function Rocklance_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Rocklance_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Rocklance_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5841, 1, "Rocklance_OnCombat")
RegisterUnitEvent(5841, 2, "Rocklance_OnLeaveCombat")
RegisterUnitEvent(5841, 3, "Rocklance_OnKilledTarget")
RegisterUnitEvent(5841, 4, "Rocklance_OnDied")