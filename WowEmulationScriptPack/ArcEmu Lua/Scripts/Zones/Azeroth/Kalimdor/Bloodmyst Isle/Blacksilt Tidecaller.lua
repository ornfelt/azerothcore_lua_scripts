--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlacksiltTidecaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlacksiltTidecaller_LightningShield", 5000, 0)
	Unit:RegisterEvent("BlacksiltTidecaller_Rejuvenation", 10000, 0)
end

function BlacksiltTidecaller_LightningShield(pUnit, Event) 
	pUnit:CastSpell(12550) 
end

function BlacksiltTidecaller_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(12160) 
end

function BlacksiltTidecaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlacksiltTidecaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17327, 1, "BlacksiltTidecaller_OnCombat")
RegisterUnitEvent(17327, 2, "BlacksiltTidecaller_OnLeaveCombat")
RegisterUnitEvent(17327, 4, "BlacksiltTidecaller_OnDied")