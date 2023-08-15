--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GrumbaldOneEye_OnCombat(Unit, Event)
Unit:RegisterEvent("GrumbaldOneEye_ElementalEnlightenment", 3000, 1)
Unit:RegisterEvent("GrumbaldOneEye_FireBlast", 6000, 0)
Unit:RegisterEvent("GrumbaldOneEye_FrostNova", 9000, 0)
Unit:RegisterEvent("GrumbaldOneEye_FrostfireBolt", 9500, 0)
end

function GrumbaldOneEye_ElementalEnlightenment(Unit, Event) 
Unit:CastSpell(52495) 
end

function GrumbaldOneEye_FireBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(13339, Unit:GetMainTank()) 
end

function GrumbaldOneEye_FrostNova(Unit, Event) 
Unit:CastSpell(11831) 
end

function GrumbaldOneEye_FrostfireBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(51779, Unit:GetMainTank()) 
end

function GrumbaldOneEye_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GrumbaldOneEye_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GrumbaldOneEye_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26681, 1, "GrumbaldOneEye_OnCombat")
RegisterUnitEvent(26681, 2, "GrumbaldOneEye_OnLeaveCombat")
RegisterUnitEvent(26681, 3, "GrumbaldOneEye_OnKilledTarget")
RegisterUnitEvent(26681, 4, "GrumbaldOneEye_OnDied")