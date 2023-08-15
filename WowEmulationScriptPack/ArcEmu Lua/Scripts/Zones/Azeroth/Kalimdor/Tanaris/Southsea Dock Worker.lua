--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SouthseaDockWorker_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaDockWorker_HeadCrack", 10000, 0)
end

function SouthseaDockWorker_HeadCrack(Unit, Event) 
	Unit:FullCastSpellOnTarget(3148, 	Unit:GetMainTank()) 
end

function SouthseaDockWorker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaDockWorker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaDockWorker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7857, 1, "SouthseaDockWorker_OnCombat")
RegisterUnitEvent(7857, 2, "SouthseaDockWorker_OnLeaveCombat")
RegisterUnitEvent(7857, 3, "SouthseaDockWorker_OnKilledTarget")
RegisterUnitEvent(7857, 4, "SouthseaDockWorker_OnDied")