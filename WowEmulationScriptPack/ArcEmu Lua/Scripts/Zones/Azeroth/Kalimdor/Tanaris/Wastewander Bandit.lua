--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WastewanderBandit_OnCombat(Unit, Event)
	Unit:RegisterEvent("WastewanderBandit_Backstab", 5000, 0)
	Unit:RegisterEvent("WastewanderBandit_Gouge", 6000, 0)
end

function WastewanderBandit_Backstab(Unit, Event) 
	Unit:FullCastSpellOnTarget(8721, 	Unit:GetMainTank()) 
end

function WastewanderBandit_Gouge(Unit, Event) 
	Unit:FullCastSpellOnTarget(8629, 	Unit:GetMainTank()) 
end

function WastewanderBandit_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WastewanderBandit_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WastewanderBandit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5618, 1, "WastewanderBandit_OnCombat")
RegisterUnitEvent(5618, 2, "WastewanderBandit_OnLeaveCombat")
RegisterUnitEvent(5618, 3, "WastewanderBandit_OnKilledTarget")
RegisterUnitEvent(5618, 4, "WastewanderBandit_OnDied")