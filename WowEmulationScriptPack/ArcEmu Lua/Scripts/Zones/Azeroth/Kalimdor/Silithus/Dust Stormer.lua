--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DustStormer_OnCombat(Unit, Event)
	Unit:RegisterEvent("DustStormer_LightningShield", 6000, 0)
	Unit:RegisterEvent("DustStormer_LightningCloud", 10000, 0)
end

function DustStormer_LightningShield(Unit, Event) 
	Unit:CastSpell(19514) 
end

function DustStormer_LightningCloud(Unit, Event) 
	Unit:CastSpell(19513) 
end

function DustStormer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DustStormer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DustStormer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11744, 1, "DustStormer_OnCombat")
RegisterUnitEvent(11744, 2, "DustStormer_OnLeaveCombat")
RegisterUnitEvent(11744, 3, "DustStormer_OnKilledTarget")
RegisterUnitEvent(11744, 4, "DustStormer_OnDied")