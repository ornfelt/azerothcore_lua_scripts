--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Icefist_OnCombat(Unit, Event)
Unit:RegisterEvent("Icefist_IceSlash", 6000, 0)
Unit:RegisterEvent("Icefist_TuskStrike", 8000, 0)
end

function Icefist_IceSlash(Unit, Event) 
Unit:FullCastSpellOnTarget(51878, Unit:GetMainTank()) 
end

function Icefist_TuskStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50410, Unit:GetMainTank()) 
end

function Icefist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icefist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icefist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27004, 1, "Icefist_OnCombat")
RegisterUnitEvent(27004, 2, "Icefist_OnLeaveCombat")
RegisterUnitEvent(27004, 3, "Icefist_OnKilledTarget")
RegisterUnitEvent(27004, 4, "Icefist_OnDied")