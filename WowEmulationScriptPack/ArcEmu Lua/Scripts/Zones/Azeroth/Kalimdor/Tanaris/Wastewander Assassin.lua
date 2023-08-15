--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WastewanderAssassin_OnCombat(Unit, Event)
	Unit:RegisterEvent("WastewanderAssassin_Execute", 5000, 0)
end

function WastewanderAssassin_Execute(Unit, Event) 
	Unit:FullCastSpellOnTarget(7160, 	Unit:GetMainTank()) 
end

function WastewanderAssassin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WastewanderAssassin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WastewanderAssassin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5623, 1, "WastewanderAssassin_OnCombat")
RegisterUnitEvent(5623, 2, "WastewanderAssassin_OnLeaveCombat")
RegisterUnitEvent(5623, 3, "WastewanderAssassin_OnKilledTarget")
RegisterUnitEvent(5623, 4, "WastewanderAssassin_OnDied")