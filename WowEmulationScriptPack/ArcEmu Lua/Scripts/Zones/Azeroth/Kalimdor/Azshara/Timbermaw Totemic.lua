--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimbermawTotemic_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimbermawTotemic_HealingWard", 13000, 0)
end

function TimbermawTotemic_HealingWard(pUnit, Event) 
	pUnit:CastSpell(5605) 
end

function TimbermawTotemic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimbermawTotemic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6186, 1, "TimbermawTotemic_OnCombat")
RegisterUnitEvent(6186, 2, "TimbermawTotemic_OnLeaveCombat")
RegisterUnitEvent(6186, 4, "TimbermawTotemic_OnDied")