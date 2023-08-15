--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KodoBull_OnCombat(Unit, Event)
Unit:RegisterEvent("KodoBull_Tramble", 6000, 0)
end

function KodoBull_Tramble(pUnit, Event) 
pUnit:CastSpell(5568, pUnit:GetClosestPlayer()) 
end

function KodoBull_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KodoBull_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KodoBull_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2973, 1, "KodoBull_OnCombat")
RegisterUnitEvent(2973, 2, "KodoBull_OnLeaveCombat")
RegisterUnitEvent(2973, 3, "KodoBull_OnKilledTarget")
RegisterUnitEvent(2973, 4, "KodoBull_OnDied")
