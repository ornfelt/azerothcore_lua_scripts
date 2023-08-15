--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DalBloodclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("DalBloodclaw_Disarm", 9000, 0)
	Unit:RegisterEvent("DalBloodclaw_Revenge", 6000, 0)
end

function DalBloodclaw_Disarm(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6713, 	pUnit:GetMainTank()) 
end

function DalBloodclaw_Revenge(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12170, 	pUnit:GetMainTank()) 
end

function DalBloodclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DalBloodclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3987, 1, "DalBloodclaw_OnCombat")
RegisterUnitEvent(3987, 2, "DalBloodclaw_OnLeaveCombat")
RegisterUnitEvent(3987, 4, "DalBloodclaw_OnDied")