--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HegginStonewhisker_OnCombat(Unit, Event)
	Unit:RegisterEvent("HegginStonewhisker_FireShot", 9000, 0)
	Unit:RegisterEvent("HegginStonewhisker_Shoot", 6000, 0)
end

function HegginStonewhisker_FireShot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6979, 	Unit:GetMainTank()) 
end

function HegginStonewhisker_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function HegginStonewhisker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HegginStonewhisker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HegginStonewhisker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5847, 1, "HegginStonewhisker_OnCombat")
RegisterUnitEvent(5847, 2, "HegginStonewhisker_OnLeaveCombat")
RegisterUnitEvent(5847, 3, "HegginStonewhisker_OnKilledTarget")
RegisterUnitEvent(5847, 4, "HegginStonewhisker_OnDied")