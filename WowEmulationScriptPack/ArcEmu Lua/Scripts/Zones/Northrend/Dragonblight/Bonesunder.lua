--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Bonesunder_OnCombat(Unit, Event)
Unit:RegisterEvent("Bonesunder_BoneCrack", 10000, 0)
end

function Bonesunder_BoneCrack(Unit, Event) 
Unit:CastSpell(52080) 
end

function Bonesunder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bonesunder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bonesunder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27006, 1, "Bonesunder_OnCombat")
RegisterUnitEvent(27006, 2, "Bonesunder_OnLeaveCombat")
RegisterUnitEvent(27006, 3, "Bonesunder_OnKilledTarget")
RegisterUnitEvent(27006, 4, "Bonesunder_OnDied")