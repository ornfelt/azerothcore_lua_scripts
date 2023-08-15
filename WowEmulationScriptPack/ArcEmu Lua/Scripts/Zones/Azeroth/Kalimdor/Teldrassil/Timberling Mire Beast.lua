--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimberlingMireBeast_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimberlingMireBeast_MiringMud", 8000, 0)
end

function TimberlingMireBeast_MiringMud(Unit, Event) 
	Unit:FullCastSpellOnTarget(5567, 	Unit:GetMainTank()) 
end

function TimberlingMireBeast_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimberlingMireBeast_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TimberlingMireBeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2029, 1, "TimberlingMireBeast_OnCombat")
RegisterUnitEvent(2029, 2, "TimberlingMireBeast_OnLeaveCombat")
RegisterUnitEvent(2029, 3, "TimberlingMireBeast_OnKilledTarget")
RegisterUnitEvent(2029, 4, "TimberlingMireBeast_OnDied")