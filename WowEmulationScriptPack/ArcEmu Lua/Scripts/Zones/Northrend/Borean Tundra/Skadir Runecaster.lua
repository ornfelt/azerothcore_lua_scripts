--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SkadirRunecaster_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirRunecaster_LightningBolt", 8000, 0)
Unit:RegisterEvent("SkadirRunecaster_RuneofRetribution", 2000, 2)
end

function SkadirRunecaster_LightningBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9532, Unit:GetMainTank()) 
end

function SkadirRunecaster_RuneofRetribution(Unit, Event) 
Unit:CastSpell(49871, Unit:GetMainTank()) 
end

function SkadirRunecaster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirRunecaster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirRunecaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25520, 1, "SkadirRunecaster_OnCombat")
RegisterUnitEvent(25520, 2, "SkadirRunecaster_OnLeaveCombat")
RegisterUnitEvent(25520, 3, "SkadirRunecaster_OnKilledTarget")
RegisterUnitEvent(25520, 4, "SkadirRunecaster_OnDied")