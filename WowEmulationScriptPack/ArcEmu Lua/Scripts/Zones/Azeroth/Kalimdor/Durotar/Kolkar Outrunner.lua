--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarOutrunner_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarOutrunner_Shoot", 6000, 0)
end

function KolkarOutrunner_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function KolkarOutrunner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarOutrunner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarOutrunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3120, 1, "KolkarOutrunner_OnCombat")
RegisterUnitEvent(3120, 2, "KolkarOutrunner_OnLeaveCombat")
RegisterUnitEvent(3120, 3, "KolkarOutrunner_OnKilledTarget")
RegisterUnitEvent(3120, 4, "KolkarOutrunner_OnDied")