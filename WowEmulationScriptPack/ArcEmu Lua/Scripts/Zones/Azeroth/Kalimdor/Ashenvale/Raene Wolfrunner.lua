--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RaeneWolfrunner_OnCombat(Unit, Event)
	Unit:RegisterEvent("RaeneWolfrunner_Net", 10000, 0)
	Unit:RegisterEvent("RaeneWolfrunner_Shoot", 6000, 0)
	Unit:RegisterEvent("RaeneWolfrunner_Volley", 20000, 0)
	Unit:RegisterEvent("RaeneWolfrunner_Explosive Shot", 12000, 0)
	Unit:RegisterEvent("RaeneWolfrunner_MultiShot", 15000, 0)
end

function RaeneWolfrunner_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6533, 	pUnit:GetMainTank()) 
end

function RaeneWolfrunner_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function RaeneWolfrunner_Volley(pUnit, Event) 
	pUnit:CastSpell(22908) 
end

function RaeneWolfrunner_ExplosiveShot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15495, 	pUnit:GetMainTank()) 
end

function RaeneWolfrunner_MultiShot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(21390, 	pUnit:GetMainTank()) 
end

function RaeneWolfrunner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RaeneWolfrunner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3691, 1, "RaeneWolfrunner_OnCombat")
RegisterUnitEvent(3691, 2, "RaeneWolfrunner_OnLeaveCombat")
RegisterUnitEvent(3691, 4, "RaeneWolfrunner_OnDied")