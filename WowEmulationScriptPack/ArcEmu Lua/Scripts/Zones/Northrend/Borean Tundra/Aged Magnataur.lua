--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AgedMagnataur_OnCombat(Unit, Event)
	Unit:RegisterEvent("AgedMagnataur_PlagueCloud", 2000, 2)
end

function AgedMagnataur_PlagueCloud(Unit, Event) 
	Unit:CastSpell(50366) 
end

function AgedMagnataur_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AgedMagnataur_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AgedMagnataur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24954, 1, "AgedMagnataur_OnCombat")
RegisterUnitEvent(24954, 2, "AgedMagnataur_OnLeaveCombat")
RegisterUnitEvent(24954, 3, "AgedMagnataur_OnKilledTarget")
RegisterUnitEvent(24954, 4, "AgedMagnataur_OnDied")