--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BranchSnapper_OnCombat(Unit, Event)
	Unit:RegisterEvent("BranchSnapper_DeadlyPoison", 10000, 0)
	Unit:RegisterEvent("BranchSnapper_KnockAway", 8000, 0)
end

function BranchSnapper_DeadlyPoison(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3583, 	pUnit:GetMainTank()) 
end

function BranchSnapper_KnockAway(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10101, 	pUnit:GetMainTank()) 
end

function BranchSnapper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BranchSnapper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10641, 1, "BranchSnapper_OnCombat")
RegisterUnitEvent(10641, 2, "BranchSnapper_OnLeaveCombat")
RegisterUnitEvent(10641, 4, "BranchSnapper_OnDied")