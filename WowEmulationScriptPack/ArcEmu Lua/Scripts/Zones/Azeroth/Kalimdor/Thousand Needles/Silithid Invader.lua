--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilithidInvader_OnCombat(Unit, Event)
	UnitRegisterEvent("SilithidInvader_PierceArmor", 10000, 0)
end

function SilithidInvader_PierceArmor(Unit, Event) 
	UnitFullCastSpellOnTarget(6016, 	UnitGetMainTank()) 
end

function SilithidInvader_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SilithidInvader_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SilithidInvader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4131, 1, "SilithidInvader_OnCombat")
RegisterUnitEvent(4131, 2, "SilithidInvader_OnLeaveCombat")
RegisterUnitEvent(4131, 3, "SilithidInvader_OnKilledTarget")
RegisterUnitEvent(4131, 4, "SilithidInvader_OnDied")