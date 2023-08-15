--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function KerlonianEvershade_OnCombat(Unit, Event)
	Unit:RegisterEvent("KerlonianEvershade_BearForm", 1000, 1)
end

function KerlonianEvershade_BearForm(pUnit, Event) 
	pUnit:CastSpell(18309) 
end

function KerlonianEvershade_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KerlonianEvershade_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11218, 1, "KerlonianEvershade_OnCombat")
RegisterUnitEvent(11218, 2, "KerlonianEvershade_OnLeaveCombat")
RegisterUnitEvent(11218, 4, "KerlonianEvershade_OnDied")