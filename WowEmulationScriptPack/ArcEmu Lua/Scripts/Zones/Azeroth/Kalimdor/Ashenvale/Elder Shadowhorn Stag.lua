--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ElderShadowhornStag_OnCombat(Unit, Event)
	Unit:RegisterEvent("ElderShadowhornStag_ShadowhornCharge", 8000, 0)
end

function ElderShadowhornStag_ShadowhornCharge(pUnit, Event) 
	pUnit:CastSpell(6921) 
end

function ElderShadowhornStag_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ElderShadowhornStag_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3818, 1, "ElderShadowhornStag_OnCombat")
RegisterUnitEvent(3818, 2, "ElderShadowhornStag_OnLeaveCombat")
RegisterUnitEvent(3818, 4, "ElderShadowhornStag_OnDied")