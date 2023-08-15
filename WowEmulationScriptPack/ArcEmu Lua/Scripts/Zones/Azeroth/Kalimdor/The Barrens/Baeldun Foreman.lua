--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function BaeldunForeman_OnCombat(Unit, Event)
	Unit:RegisterEvent("BaeldunForeman_TorchToss", 8000, 0)
end

function BaeldunForeman_TorchToss(Unit, Event) 
	Unit:FullCastSpellOnTarget(6257, 	Unit:GetMainTank()) 
end

function BaeldunForeman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BaeldunForeman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BaeldunForeman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3375, 1, "BaeldunForeman_OnCombat")
RegisterUnitEvent(3375, 2, "BaeldunForeman_OnLeaveCombat")
RegisterUnitEvent(3375, 3, "BaeldunForeman_OnKilledTarget")
RegisterUnitEvent(3375, 4, "BaeldunForeman_OnDied")