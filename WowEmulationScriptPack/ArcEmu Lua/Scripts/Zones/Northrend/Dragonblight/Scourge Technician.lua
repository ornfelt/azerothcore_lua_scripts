--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScourgeTechnician_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgeTechnician_Lobotomize", 6000, 0)
end

function ScourgeTechnician_Lobotomize(Unit, Event) 
Unit:FullCastSpellOnTarget(51316, Unit:GetMainTank()) 
end

function ScourgeTechnician_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgeTechnician_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgeTechnician_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27799, 1, "ScourgeTechnician_OnCombat")
RegisterUnitEvent(27799, 2, "ScourgeTechnician_OnLeaveCombat")
RegisterUnitEvent(27799, 3, "ScourgeTechnician_OnKilledTarget")
RegisterUnitEvent(27799, 4, "ScourgeTechnician_OnDied")