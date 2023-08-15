--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScourgeDeathspeaker_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgeDeathspeaker_Fireball", 6000, 0)
Unit:RegisterEvent("ScourgeDeathspeaker_FlameoftheSeer", 3000, 1)
end

function ScourgeDeathspeaker_Fireball(Unit, Event) 
Unit:FullCastSpellOnTarget(52282, Unit:GetMainTank()) 
end

function ScourgeDeathspeaker_FlameoftheSeer(Unit, Event) 
Unit:CastSpell(52281) 
end

function ScourgeDeathspeaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgeDeathspeaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgeDeathspeaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27615, 1, "ScourgeDeathspeaker_OnCombat")
RegisterUnitEvent(27615, 2, "ScourgeDeathspeaker_OnLeaveCombat")
RegisterUnitEvent(27615, 3, "ScourgeDeathspeaker_OnKilledTarget")
RegisterUnitEvent(27615, 4, "ScourgeDeathspeaker_OnDied")