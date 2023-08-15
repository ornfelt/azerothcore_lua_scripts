--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VarothensGhost_OnCombat(Unit, Event)
	Unit:RegisterEvent("VarothensGhost_CurseofWeakness", 8000, 0)
end

function VarothensGhost_CurseofWeakness(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(21007, 	pUnit:GetMainTank()) 
end

function VarothensGhost_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VarothensGhost_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6118, 1, "VarothensGhost_OnCombat")
RegisterUnitEvent(6118, 2, "VarothensGhost_OnLeaveCombat")
RegisterUnitEvent(6118, 4, "VarothensGhost_OnDied")