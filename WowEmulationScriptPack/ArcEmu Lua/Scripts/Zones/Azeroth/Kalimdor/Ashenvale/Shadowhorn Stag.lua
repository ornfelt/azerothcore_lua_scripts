--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadowhornStag_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadowhornStag_ShadowhornCharge", 8000, 0)
end

function ShadowhornStag_ShadowhornCharge(pUnit, Event) 
	pUnit:CastSpell(6921) 
end

function ShadowhornStag_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ShadowhornStag_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3817, 1, "ShadowhornStag_OnCombat")
RegisterUnitEvent(3817, 2, "ShadowhornStag_OnLeaveCombat")
RegisterUnitEvent(3817, 4, "ShadowhornStag_OnDied")