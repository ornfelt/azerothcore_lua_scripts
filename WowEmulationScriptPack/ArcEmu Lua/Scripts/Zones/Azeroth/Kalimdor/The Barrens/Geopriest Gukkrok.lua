--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GeopriestGukkrok_OnCombat(Unit, Event)
	Unit:RegisterEvent("GeopriestGukkrok_Heal", 15000, 0)
	Unit:RegisterEvent("GeopriestGukkrok_PowerWordShield", 6000, 1)
	Unit:RegisterEvent("GeopriestGukkrok_Renew", 10000, 0)
end

function GeopriestGukkrok_Heal(Unit, Event) 
	Unit:CastSpell(2054) 
end

function GeopriestGukkrok_PowerWordShield(Unit, Event) 
	Unit:CastSpell(600) 
end

function GeopriestGukkrok_Renew(Unit, Event) 
	Unit:CastSpell(6075) 
end

function GeopriestGukkrok_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GeopriestGukkrok_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GeopriestGukkrok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5863, 1, "GeopriestGukkrok_OnCombat")
RegisterUnitEvent(5863, 2, "GeopriestGukkrok_OnLeaveCombat")
RegisterUnitEvent(5863, 3, "GeopriestGukkrok_OnKilledTarget")
RegisterUnitEvent(5863, 4, "GeopriestGukkrok_OnDied")