--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Dreamstalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("Dreamstalker_CorrosiveAcidBreath", 6000, 0)
	Unit:RegisterEvent("Dreamstalker_Sleep", 14000, 0)
end

function Dreamstalker_CorrosiveAcidBreath(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20667, 	pUnit:GetMainTank()) 
end

function Dreamstalker_Sleep(pUnit, Event) 
	pUnit:CastSpell(20669) 
end

function Dreamstalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Dreamstalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12498, 1, "Dreamstalker_OnCombat")
RegisterUnitEvent(12498, 2, "Dreamstalker_OnLeaveCombat")
RegisterUnitEvent(12498, 4, "Dreamstalker_OnDied")