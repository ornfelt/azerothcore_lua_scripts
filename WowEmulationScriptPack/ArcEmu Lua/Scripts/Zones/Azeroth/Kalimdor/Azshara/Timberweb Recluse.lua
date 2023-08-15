--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimberwebRecluse_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimberwebRecluse_Web", 10000, 0)
end

function TimberwebRecluse_Web(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(745, 	pUnit:GetMainTank()) 
end

function TimberwebRecluse_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimberwebRecluse_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8762, 1, "TimberwebRecluse_OnCombat")
RegisterUnitEvent(8762, 2, "TimberwebRecluse_OnLeaveCombat")
RegisterUnitEvent(8762, 4, "TimberwebRecluse_OnDied")