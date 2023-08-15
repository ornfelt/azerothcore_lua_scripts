--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MakrinniRazorclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("MakrinniRazorclaw_SunderArmor", 5000, 0)
end

function MakrinniRazorclaw_SunderArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13444, 	pUnit:GetMainTank()) 
end

function MakrinniRazorclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MakrinniRazorclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6350, 1, "MakrinniRazorclaw_OnCombat")
RegisterUnitEvent(6350, 2, "MakrinniRazorclaw_OnLeaveCombat")
RegisterUnitEvent(6350, 4, "MakrinniRazorclaw_OnDied")