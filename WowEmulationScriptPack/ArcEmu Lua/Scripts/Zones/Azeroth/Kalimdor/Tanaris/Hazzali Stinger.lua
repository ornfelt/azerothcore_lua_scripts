--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HazzaliStinger_OnCombat(Unit, Event)
	Unit:RegisterEvent("HazzaliStinger_VenomSting", 10000, 0)
end

function HazzaliStinger_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function HazzaliStinger_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HazzaliStinger_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HazzaliStinger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5450, 1, "HazzaliStinger_OnCombat")
RegisterUnitEvent(5450, 2, "HazzaliStinger_OnLeaveCombat")
RegisterUnitEvent(5450, 3, "HazzaliStinger_OnKilledTarget")
RegisterUnitEvent(5450, 4, "HazzaliStinger_OnDied")