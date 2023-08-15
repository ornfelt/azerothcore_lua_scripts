--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WindshearOverlord_OnCombat(Unit, Event)
	UnitRegisterEvent("WindshearOverlord_BattleFury", 2000, 1)
end

function WindshearOverlord_BattleFury(Unit, Event) 
	UnitCastSpell(3631) 
end

function WindshearOverlord_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function WindshearOverlord_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function WindshearOverlord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4004, 1, "WindshearOverlord_OnCombat")
RegisterUnitEvent(4004, 2, "WindshearOverlord_OnLeaveCombat")
RegisterUnitEvent(4004, 3, "WindshearOverlord_OnKilledTarget")
RegisterUnitEvent(4004, 4, "WindshearOverlord_OnDied")