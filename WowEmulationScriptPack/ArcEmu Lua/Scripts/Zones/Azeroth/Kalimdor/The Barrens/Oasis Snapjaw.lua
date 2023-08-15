--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function OasisSnapjaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("OasisSnapjaw_SlingDirt", 12000, 0)
end

function OasisSnapjaw_SlingDirt(Unit, Event) 
	Unit:FullCastSpellOnTarget(6530, 	Unit:GetMainTank()) 
end

function OasisSnapjaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function OasisSnapjaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function OasisSnapjaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3461, 1, "OasisSnapjaw_OnCombat")
RegisterUnitEvent(3461, 2, "OasisSnapjaw_OnLeaveCombat")
RegisterUnitEvent(3461, 3, "OasisSnapjaw_OnKilledTarget")
RegisterUnitEvent(3461, 4, "OasisSnapjaw_OnDied")