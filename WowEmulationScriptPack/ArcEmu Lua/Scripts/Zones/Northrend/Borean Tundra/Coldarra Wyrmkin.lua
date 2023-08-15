--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ColdarraWyrmkin_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraWyrmkin_FrostbiteWeapon", 8000, 0)
end

function ColdarraWyrmkin_FrostbiteWeapon(Unit, Event) 
Unit:CastSpell(50416) 
end

function ColdarraWyrmkin_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraWyrmkin_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraWyrmkin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25728, 1, "ColdarraWyrmkin_OnCombat")
RegisterUnitEvent(25728, 2, "ColdarraWyrmkin_OnLeaveCombat")
RegisterUnitEvent(25728, 3, "ColdarraWyrmkin_OnKilledTarget")
RegisterUnitEvent(25728, 4, "ColdarraWyrmkin_OnDied")