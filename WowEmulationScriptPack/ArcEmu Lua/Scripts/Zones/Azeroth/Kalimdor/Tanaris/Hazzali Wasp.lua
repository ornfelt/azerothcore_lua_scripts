--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HazzaliWasp_OnCombat(Unit, Event)
	Unit:RegisterEvent("HazzaliWasp_Poison", 10000, 0)
end

function HazzaliWasp_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetMainTank()) 
end

function HazzaliWasp_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HazzaliWasp_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HazzaliWasp_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5453, 1, "HazzaliWasp_OnCombat")
RegisterUnitEvent(5453, 2, "HazzaliWasp_OnLeaveCombat")
RegisterUnitEvent(5453, 3, "HazzaliWasp_OnKilledTarget")
RegisterUnitEvent(5453, 4, "HazzaliWasp_OnDied")