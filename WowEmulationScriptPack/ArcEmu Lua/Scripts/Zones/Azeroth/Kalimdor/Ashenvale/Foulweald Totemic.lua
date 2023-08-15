--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FoulwealdTotemic_OnCombat(Unit, Event)
	Unit:RegisterEvent("FoulwealdTotemic_SearingTotem", 2000, 1)
end

function FoulwealdTotemic_SearingTotem(pUnit, Event) 
	pUnit:CastSpell(6363) 
end

function FoulwealdTotemic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FoulwealdTotemic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3750, 1, "FoulwealdTotemic_OnCombat")
RegisterUnitEvent(3750, 2, "FoulwealdTotemic_OnLeaveCombat")
RegisterUnitEvent(3750, 4, "FoulwealdTotemic_OnDied")