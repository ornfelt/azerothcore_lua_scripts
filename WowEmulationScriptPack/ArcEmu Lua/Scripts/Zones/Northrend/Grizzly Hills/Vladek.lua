--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Vladek_OnCombat(Unit, Event)
Unit:RegisterEvent("Vladek_Enrage", 10000, 0)
end

function Vladek_Enrage(Unit, Event) 
Unit:CastSpell(32714) 
end

function Vladek_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Vladek_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Vladek_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27547, 1, "Vladek_OnCombat")
RegisterUnitEvent(27547, 2, "Vladek_OnLeaveCombat")
RegisterUnitEvent(27547, 3, "Vladek_OnKilledTarget")
RegisterUnitEvent(27547, 4, "Vladek_OnDied")