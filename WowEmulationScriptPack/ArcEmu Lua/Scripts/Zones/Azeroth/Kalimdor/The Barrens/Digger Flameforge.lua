--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DiggerFlameforge_OnCombat(Unit, Event)
	Unit:RegisterEvent("DiggerFlameforge_Backhand", 8000, 0)
	Unit:RegisterEvent("DiggerFlameforge_ThrowDynamite", 12000, 0)
end

function DiggerFlameforge_Backhand(Unit, Event) 
	Unit:FullCastSpellOnTarget(6253, 	Unit:GetMainTank()) 
end

function DiggerFlameforge_ThrowDynamite(Unit, Event) 
	Unit:CastSpell(7978) 
end

function DiggerFlameforge_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DiggerFlameforge_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DiggerFlameforge_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5849, 1, "DiggerFlameforge_OnCombat")
RegisterUnitEvent(5849, 2, "DiggerFlameforge_OnLeaveCombat")
RegisterUnitEvent(5849, 3, "DiggerFlameforge_OnKilledTarget")
RegisterUnitEvent(5849, 4, "DiggerFlameforge_OnDied")