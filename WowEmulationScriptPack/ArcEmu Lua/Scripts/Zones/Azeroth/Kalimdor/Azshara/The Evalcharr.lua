--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TheEvalcharr_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheEvalcharr_Fireball", 8000, 0)
	Unit:RegisterEvent("TheEvalcharr_LightningBreath", 5000, 0)
end

function TheEvalcharr_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(21549, 	pUnit:GetMainTank()) 
end

function TheEvalcharr_LightningBreath(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15797, 	pUnit:GetMainTank()) 
end

function TheEvalcharr_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheEvalcharr_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8660, 1, "TheEvalcharr_OnCombat")
RegisterUnitEvent(8660, 2, "TheEvalcharr_OnLeaveCombat")
RegisterUnitEvent(8660, 4, "TheEvalcharr_OnDied")