--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HoaryTemplar_OnCombat(Unit, Event)
	Unit:RegisterEvent("HoaryTemplar_LightningShield", 6000, 0)
end

function HoaryTemplar_LightningShield(Unit, Event) 
	Unit:CastSpell(19514) 
end

function HoaryTemplar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HoaryTemplar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HoaryTemplar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15212, 1, "HoaryTemplar_OnCombat")
RegisterUnitEvent(15212, 2, "HoaryTemplar_OnLeaveCombat")
RegisterUnitEvent(15212, 3, "HoaryTemplar_OnKilledTarget")
RegisterUnitEvent(15212, 4, "HoaryTemplar_OnDied")