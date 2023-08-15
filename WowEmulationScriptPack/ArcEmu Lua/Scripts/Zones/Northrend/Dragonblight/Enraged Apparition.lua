--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnragedApparition_OnCombat(Unit, Event)
Unit:RegisterEvent("EnragedApparition_Enrage", 10000, 1)
end

function EnragedApparition_Enrage(Unit, Event) 
Unit:CastSpell(50420) 
end

function EnragedApparition_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnragedApparition_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnragedApparition_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27551, 1, "EnragedApparition_OnCombat")
RegisterUnitEvent(27551, 2, "EnragedApparition_OnLeaveCombat")
RegisterUnitEvent(27551, 3, "EnragedApparition_OnKilledTarget")
RegisterUnitEvent(27551, 4, "EnragedApparition_OnDied")