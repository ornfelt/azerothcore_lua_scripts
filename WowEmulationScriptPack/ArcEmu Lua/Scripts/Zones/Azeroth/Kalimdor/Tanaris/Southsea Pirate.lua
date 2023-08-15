--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SouthseaPirate_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaPirate_Strike", 6000, 0)
end

function SouthseaPirate_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function SouthseaPirate_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaPirate_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaPirate_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7855, 1, "SouthseaPirate_OnCombat")
RegisterUnitEvent(7855, 2, "SouthseaPirate_OnLeaveCombat")
RegisterUnitEvent(7855, 3, "SouthseaPirate_OnKilledTarget")
RegisterUnitEvent(7855, 4, "SouthseaPirate_OnDied")