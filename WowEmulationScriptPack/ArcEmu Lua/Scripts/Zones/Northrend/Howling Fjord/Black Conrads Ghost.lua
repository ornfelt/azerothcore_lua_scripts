--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackConradsGhost_OnCombat(Unit, Event)
Unit:RegisterEvent("BlackConradsGhost_BladeFlurry", 11000, 0)
Unit:RegisterEvent("BlackConradsGhost_GhostlyStrike", 8000, 0)
end

function BlackConradsGhost_BladeFlurry(Unit, Event) 
Unit:CastSpell(51211) 
end

function BlackConradsGhost_GhostlyStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(31022, Unit:GetMainTank()) 
end

function BlackConradsGhost_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlackConradsGhost_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlackConradsGhost_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24790, 1, "BlackConradsGhost_OnCombat")
RegisterUnitEvent(24790, 2, "BlackConradsGhost_OnLeaveCombat")
RegisterUnitEvent(24790, 3, "BlackConradsGhost_OnKilledTarget")
RegisterUnitEvent(24790, 4, "BlackConradsGhost_OnDied")