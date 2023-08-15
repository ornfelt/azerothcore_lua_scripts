--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodElfBandit_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodElfBandit_Eviscerate", 1000, 0)
	Unit:RegisterEvent("BloodElfBandit_SinisterStrike", 4000, 0)
end

function BloodElfBandit_Eviscerate(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15691, 	pUnit:GetMainTank()) 
end

function BloodElfBandit_SinisterStrike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(14873, 	pUnit:GetMainTank()) 
end

function BloodElfBandit_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodElfBandit_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17591, 1, "BloodElfBandit_OnCombat")
RegisterUnitEvent(17591, 2, "BloodElfBandit_OnLeaveCombat")
RegisterUnitEvent(17591, 4, "BloodElfBandit_OnDied")