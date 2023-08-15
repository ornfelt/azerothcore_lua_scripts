--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistlefurShaman_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistlefurShaman_Bloodlust", 2000, 2)
	Unit:RegisterEvent("ThistlefurShaman_HealingWave", 13000, 0)
end

function ThistlefurShaman_Bloodlust(pUnit, Event) 
	pUnit:CastSpell(6742) 
end

function ThistlefurShaman_HealingWave(pUnit, Event) 
	pUnit:CastSpell(11986) 
end

function ThistlefurShaman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistlefurShaman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3924, 1, "ThistlefurShaman_OnCombat")
RegisterUnitEvent(3924, 2, "ThistlefurShaman_OnLeaveCombat")
RegisterUnitEvent(3924, 4, "ThistlefurShaman_OnDied")