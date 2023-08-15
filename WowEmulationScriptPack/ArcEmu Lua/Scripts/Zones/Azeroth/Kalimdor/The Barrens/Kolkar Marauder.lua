--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarMarauder_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarMarauder_Strike", 6000, 0)
end

function KolkarMarauder_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function KolkarMarauder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarMarauder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3275, 1, "KolkarMarauder_OnCombat")
RegisterUnitEvent(3275, 2, "KolkarMarauder_OnLeaveCombat")
RegisterUnitEvent(3275, 3, "KolkarMarauder_OnKilledTarget")
RegisterUnitEvent(3275, 4, "KolkarMarauder_OnDied")