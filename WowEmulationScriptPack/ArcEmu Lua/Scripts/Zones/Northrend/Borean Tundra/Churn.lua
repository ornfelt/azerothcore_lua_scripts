--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Churn_OnCombat(Unit, Event)
Unit:RegisterEvent("Churn_ScaldingSteam", 8000, 0)
end

function Churn_ScaldingSteam(Unit, Event) 
Unit:FullCastSpellOnTarget(50206, Unit:GetMainTank()) 
end

function Churn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Churn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Churn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25418, 1, "Churn_OnCombat")
RegisterUnitEvent(25418, 2, "Churn_OnLeaveCombat")
RegisterUnitEvent(25418, 3, "Churn_OnKilledTarget")
RegisterUnitEvent(25418, 4, "Churn_OnDied")