--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BoilingElemental_OnCombat(Unit, Event)
	UnitRegisterEvent("BoilingElemental_SteamJet", 15000, 0)
end

function BoilingElemental_SteamJet(Unit, Event) 
	UnitCastSpell(11983) 
end

function BoilingElemental_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BoilingElemental_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BoilingElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10757, 1, "BoilingElemental_OnCombat")
RegisterUnitEvent(10757, 2, "BoilingElemental_OnLeaveCombat")
RegisterUnitEvent(10757, 3, "BoilingElemental_OnKilledTarget")
RegisterUnitEvent(10757, 4, "BoilingElemental_OnDied")