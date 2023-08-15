--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaptainJacobs_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainJacobs_BladeFlurry", 10000, 0)
Unit:RegisterEvent("CaptainJacobs_MortalStrike", 8000, 0)
end

function CaptainJacobs_BladeFlurry(Unit, Event) 
Unit:CastSpell(33735) 
end

function CaptainJacobs_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(32736, Unit:GetMainTank()) 
end

function CaptainJacobs_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainJacobs_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainJacobs_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26252, 1, "CaptainJacobs_OnCombat")
RegisterUnitEvent(26252, 2, "CaptainJacobs_OnLeaveCombat")
RegisterUnitEvent(26252, 3, "CaptainJacobs_OnKilledTarget")
RegisterUnitEvent(26252, 4, "CaptainJacobs_OnDied")