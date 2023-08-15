--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GelkisWindchaser_OnCombat(Unit, Event)
	Unit:RegisterEvent("GelkisWindchaser_HealingWave", 13000, 0)
	Unit:RegisterEvent("GelkisWindchaser_LightningBolt", 8000, 0)
end

function GelkisWindchaser_HealingWave(Unit, Event) 
	Unit:CastSpell(959) 
end

function GelkisWindchaser_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function GelkisWindchaser_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GelkisWindchaser_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GelkisWindchaser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4649, 1, "GelkisWindchaser_OnCombat")
RegisterUnitEvent(4649, 2, "GelkisWindchaser_OnLeaveCombat")
RegisterUnitEvent(4649, 3, "GelkisWindchaser_OnKilledTarget")
RegisterUnitEvent(4649, 4, "GelkisWindchaser_OnDied")