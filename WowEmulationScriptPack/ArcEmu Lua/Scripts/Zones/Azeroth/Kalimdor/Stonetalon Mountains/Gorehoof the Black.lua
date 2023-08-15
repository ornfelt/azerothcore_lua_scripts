--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GorehooftheBlack_OnCombat(Unit, Event)
	UnitRegisterEvent("GorehooftheBlack_WarStomp", 8000, 0)
end

function GorehooftheBlack_WarStomp(Unit, Event) 
	UnitCastSpell(45) 
end

function GorehooftheBlack_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GorehooftheBlack_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GorehooftheBlack_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11914, 1, "GorehooftheBlack_OnCombat")
RegisterUnitEvent(11914, 2, "GorehooftheBlack_OnLeaveCombat")
RegisterUnitEvent(11914, 3, "GorehooftheBlack_OnKilledTarget")
RegisterUnitEvent(11914, 4, "GorehooftheBlack_OnDied")