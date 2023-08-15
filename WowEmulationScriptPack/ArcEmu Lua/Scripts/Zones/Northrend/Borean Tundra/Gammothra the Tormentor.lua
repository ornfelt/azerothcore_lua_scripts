--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GammothratheTormentor_OnCombat(Unit, Event)
Unit:RegisterEvent("GammothratheTormentor_MagnataurCharge", 10000, 0)
Unit:RegisterEvent("GammothratheTormentor_TuskStrike", 8000, 0)
end

function GammothratheTormentor_MagnataurCharge(Unit, Event) 
Unit:CastSpell(50413) 
end

function GammothratheTormentor_TuskStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50410, Unit:GetMainTank()) 
end

function GammothratheTormentor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GammothratheTormentor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GammothratheTormentor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25789, 1, "GammothratheTormentor_OnCombat")
RegisterUnitEvent(25789, 2, "GammothratheTormentor_OnLeaveCombat")
RegisterUnitEvent(25789, 3, "GammothratheTormentor_OnKilledTarget")
RegisterUnitEvent(25789, 4, "GammothratheTormentor_OnDied")