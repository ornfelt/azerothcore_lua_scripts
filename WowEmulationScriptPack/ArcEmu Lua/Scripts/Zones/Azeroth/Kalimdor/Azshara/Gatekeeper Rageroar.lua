--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GatekeeperRageroar_OnCombat(Unit, Event)
	Unit:RegisterEvent("GatekeeperRageroar_EntanglingRoots", 10000, 0)
end

function GatekeeperRageroar_EntanglingRoots(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12747, 	pUnit:GetMainTank()) 
end

function GatekeeperRageroar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GatekeeperRageroar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6651, 1, "GatekeeperRageroar_OnCombat")
RegisterUnitEvent(6651, 2, "GatekeeperRageroar_OnLeaveCombat")
RegisterUnitEvent(6651, 4, "GatekeeperRageroar_OnDied")