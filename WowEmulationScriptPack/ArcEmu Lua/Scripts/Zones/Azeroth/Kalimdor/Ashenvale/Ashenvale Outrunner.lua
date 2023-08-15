--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AshenvaleOutrunner_OnCombat(Unit, Event)
	Unit:RegisterEvent("AshenvaleOutrunner_ScorpidSting", 8000, 0)
	Unit:RegisterEvent("AshenvaleOutrunner_Shoot", 6000, 0)
	Unit:RegisterEvent("AshenvaleOutrunner_SnapKick", 10000, 0)
end

function AshenvaleOutrunner_ScorpidSting(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(18545, 	pUnit:GetMainTank()) 
end

function AshenvaleOutrunner_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function AshenvaleOutrunner_SnapKick(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8646, 	pUnit:GetMainTank()) 
end

function AshenvaleOutrunner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AshenvaleOutrunner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12856, 1, "AshenvaleOutrunner_OnCombat")
RegisterUnitEvent(12856, 2, "AshenvaleOutrunner_OnLeaveCombat")
RegisterUnitEvent(12856, 4, "AshenvaleOutrunner_OnDied")