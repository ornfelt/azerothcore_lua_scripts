--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Zalazane_OnCombat(Unit, Event)
	Unit:RegisterEvent("Zalazane_Shrink", 6000, 0)
	Unit:RegisterEvent("Zalazane_HealingWave", 12000, 0)
end

function Zalazane_Shrink(Unit, Event) 
	Unit:FullCastSpellOnTarget(7289, 	Unit:GetMainTank()) 
end

function Zalazane_HealingWave(Unit, Event) 
	Unit:CastSpell(332) 
end

function Zalazane_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Zalazane_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Zalazane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3205, 1, "Zalazane_OnCombat")
RegisterUnitEvent(3205, 2, "Zalazane_OnLeaveCombat")
RegisterUnitEvent(3205, 3, "Zalazane_OnKilledTarget")
RegisterUnitEvent(3205, 4, "Zalazane_OnDied")