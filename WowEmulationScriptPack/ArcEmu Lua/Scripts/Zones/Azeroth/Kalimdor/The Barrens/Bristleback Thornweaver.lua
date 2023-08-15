--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlebackThornweaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlebackThornweaver_Thorns", 3000, 1)
	Unit:RegisterEvent("BristlebackThornweaver_EntanglingRoots", 12000, 0)
end

function BristlebackThornweaver_Thorns(Unit, Event) 
	Unit:CastSpell(782) 
end

function BristlebackThornweaver_EntanglingRoots(Unit, Event) 
	Unit:FullCastSpellOnTarget(12747, 	Unit:GetMainTank()) 
end

function BristlebackThornweaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlebackThornweaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BristlebackThornweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3261, 1, "BristlebackThornweaver_OnCombat")
RegisterUnitEvent(3261, 2, "BristlebackThornweaver_OnLeaveCombat")
RegisterUnitEvent(3261, 3, "BristlebackThornweaver_OnKilledTarget")
RegisterUnitEvent(3261, 4, "BristlebackThornweaver_OnDied")