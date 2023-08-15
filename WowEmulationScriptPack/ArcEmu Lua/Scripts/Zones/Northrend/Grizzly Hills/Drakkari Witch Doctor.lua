--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrakkariWitchDoctor_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariWitchDoctor_SuperiorHealingWard", 4000, 1)
Unit:RegisterEvent("DrakkariWitchDoctor_VoodooDoll", 7000, 0)
end

function DrakkariWitchDoctor_SuperiorHealingWard(Unit, Event) 
Unit:CastSpell(32194) 
end

function DrakkariWitchDoctor_VoodooDoll(Unit, Event) 
Unit:FullCastSpellOnTarget(52695, Unit:GetMainTank()) 
end

function DrakkariWitchDoctor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariWitchDoctor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariWitchDoctor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27555, 1, "DrakkariWitchDoctor_OnCombat")
RegisterUnitEvent(27555, 2, "DrakkariWitchDoctor_OnLeaveCombat")
RegisterUnitEvent(27555, 3, "DrakkariWitchDoctor_OnKilledTarget")
RegisterUnitEvent(27555, 4, "DrakkariWitchDoctor_OnDied")