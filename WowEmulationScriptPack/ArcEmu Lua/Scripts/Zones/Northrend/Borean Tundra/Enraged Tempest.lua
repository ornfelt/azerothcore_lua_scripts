--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnragedTempest_OnCombat(Unit, Event)
Unit:RegisterEvent("EnragedTempest_Enrage", 10000, 0)
Unit:RegisterEvent("EnragedTempest_Zephyr", 9000, 1)
end

function EnragedTempest_Enrage(Unit, Event) 
Unit:CastSpell(50420) 
end

function EnragedTempest_Zephyr(Unit, Event) 
Unit:CastSpell(50215) 
end

function EnragedTempest_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnragedTempest_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnragedTempest_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25415, 1, "EnragedTempest_OnCombat")
RegisterUnitEvent(25415, 2, "EnragedTempest_OnLeaveCombat")
RegisterUnitEvent(25415, 3, "EnragedTempest_OnKilledTarget")
RegisterUnitEvent(25415, 4, "EnragedTempest_OnDied")