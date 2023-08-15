--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ChillmereTidehunter_OnCombat(Unit, Event)
Unit:RegisterEvent("ChillmereTidehunter_Net", 8000, 0)
Unit:RegisterEvent("ChillmereTidehunter_Throw", 6000, 0)
end

function ChillmereTidehunter_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(6533, Unit:GetMainTank()) 
end

function ChillmereTidehunter_Throw(Unit, Event) 
Unit:FullCastSpellOnTarget(38556, Unit:GetMainTank()) 
end

function ChillmereTidehunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ChillmereTidehunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ChillmereTidehunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24460, 1, "ChillmereTidehunter_OnCombat")
RegisterUnitEvent(24460, 2, "ChillmereTidehunter_OnLeaveCombat")
RegisterUnitEvent(24460, 3, "ChillmereTidehunter_OnKilledTarget")
RegisterUnitEvent(24460, 4, "ChillmereTidehunter_OnDied")