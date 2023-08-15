--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakFlameGuard_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakFlameGuard_DemoralizingShout", 10000, 0)
end

function GalakFlameGuard_DemoralizingShout(Unit, Event) 
	UnitCastSpell(13730) 
end

function GalakFlameGuard_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakFlameGuard_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakFlameGuard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7404, 1, "GalakFlameGuard_OnCombat")
RegisterUnitEvent(7404, 2, "GalakFlameGuard_OnLeaveCombat")
RegisterUnitEvent(7404, 3, "GalakFlameGuard_OnKilledTarget")
RegisterUnitEvent(7404, 4, "GalakFlameGuard_OnDied")