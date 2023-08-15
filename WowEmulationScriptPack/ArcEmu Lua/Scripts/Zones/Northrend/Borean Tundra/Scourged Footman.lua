--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScourgedFootman_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgedFootman_BladeFlurry", 10000, 0)
Unit:RegisterEvent("ScourgedFootman_MortalStrike", 8000, 0)
end

function ScourgedFootman_BladeFlurry(Unit, Event) 
Unit:CastSpell(33735) 
end

function ScourgedFootman_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(32736, Unit:GetMainTank()) 
end

function ScourgedFootman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgedFootman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgedFootman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25981, 1, "ScourgedFootman_OnCombat")
RegisterUnitEvent(25981, 2, "ScourgedFootman_OnLeaveCombat")
RegisterUnitEvent(25981, 3, "ScourgedFootman_OnKilledTarget")
RegisterUnitEvent(25981, 4, "ScourgedFootman_OnDied")