--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AspathatheBroodmother_OnCombat(Unit, Event)
	Unit:RegisterEvent("AspathatheBroodmother_Pollen", 8000, 0)
	Unit:RegisterEvent("AspathatheBroodmother_WingBuffet", 9000, 0)
end

function AspathatheBroodmother_Pollen(Unit, Event) 
	Unit:CastSpell(45610) 
end

function AspathatheBroodmother_WingBuffet(Unit, Event) 
	Unit:CastSpell(32914) 
end

function AspathatheBroodmother_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AspathatheBroodmother_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AspathatheBroodmother_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25498, 1, "AspathatheBroodmother_OnCombat")
RegisterUnitEvent(25498, 2, "AspathatheBroodmother_OnLeaveCombat")
RegisterUnitEvent(25498, 3, "AspathatheBroodmother_OnKilledTarget")
RegisterUnitEvent(25498, 4, "AspathatheBroodmother_OnDied")