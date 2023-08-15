--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Grocklar_OnCombat(Unit, Event)
Unit:RegisterEvent("Grocklar_StoneFist", 3000, 1)
Unit:RegisterEvent("Grocklar_StoneStomp", 8000, 0)
end

function Grocklar_StoneFist(Unit, Event) 
Unit:CastSpell(49676) 
end

function Grocklar_StoneStomp(Unit, Event) 
Unit:FullCastSpellOnTarget(49675, Unit:GetMainTank()) 
end

function Grocklar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Grocklar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Grocklar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32422, 1, "Grocklar_OnCombat")
RegisterUnitEvent(32422, 2, "Grocklar_OnLeaveCombat")
RegisterUnitEvent(32422, 3, "Grocklar_OnKilledTarget")
RegisterUnitEvent(32422, 4, "Grocklar_OnDied")