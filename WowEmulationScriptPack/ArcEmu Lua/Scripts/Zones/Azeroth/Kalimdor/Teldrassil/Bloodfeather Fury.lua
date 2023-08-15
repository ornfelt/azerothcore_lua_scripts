--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodfeatherFury_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodfeatherFury_Savagery", 8000, 0)
end

function BloodfeatherFury_Savagery(Unit, Event) 
	Unit:CastSpell(5515) 
end

function BloodfeatherFury_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodfeatherFury_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BloodfeatherFury_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2019, 1, "BloodfeatherFury_OnCombat")
RegisterUnitEvent(2019, 2, "BloodfeatherFury_OnLeaveCombat")
RegisterUnitEvent(2019, 3, "BloodfeatherFury_OnKilledTarget")
RegisterUnitEvent(2019, 4, "BloodfeatherFury_OnDied")