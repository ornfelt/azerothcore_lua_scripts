--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Chilltusk_OnCombat(Unit, Event)
Unit:RegisterEvent("Chilltusk_IceSlash", 6000, 0)
Unit:RegisterEvent("Chilltusk_TuskStrike", 5000, 0)
end

function Chilltusk_IceSlash(Unit, Event) 
Unit:FullCastSpellOnTarget(51878, Unit:GetMainTank()) 
end

function Chilltusk_TuskStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50410, Unit:GetMainTank()) 
end

function Chilltusk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Chilltusk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Chilltusk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27005, 1, "Chilltusk_OnCombat")
RegisterUnitEvent(27005, 2, "Chilltusk_OnLeaveCombat")
RegisterUnitEvent(27005, 3, "Chilltusk_OnKilledTarget")
RegisterUnitEvent(27005, 4, "Chilltusk_OnDied")