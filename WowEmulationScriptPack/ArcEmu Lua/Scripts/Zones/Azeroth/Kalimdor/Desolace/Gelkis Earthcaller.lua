--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GelkisEarthcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("GelkisEarthcaller_Fireball", 8000, 0)
	Unit:RegisterEvent("GelkisEarthcaller_SummonGelkisRumbler", 4000, 1)
end

function GelkisEarthcaller_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(20815, 	Unit:GetMainTank()) 
end

function GelkisEarthcaller_SummonGelkisRumbler(Unit, Event) 
	Unit:CastSpell(9653) 
end

function GelkisEarthcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GelkisEarthcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GelkisEarthcaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4651, 1, "GelkisEarthcaller_OnCombat")
RegisterUnitEvent(4651, 2, "GelkisEarthcaller_OnLeaveCombat")
RegisterUnitEvent(4651, 3, "GelkisEarthcaller_OnKilledTarget")
RegisterUnitEvent(4651, 4, "GelkisEarthcaller_OnDied")