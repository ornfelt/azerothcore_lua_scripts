--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmbershardCrusher_OnCombat(Unit, Event)
	Unit:RegisterEvent("AmbershardCrusher_CrushArmor", 5000, 1)
end

function AmbershardCrusher_CrushArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(21055, 	Unit:GetMainTank()) 
end

function AmbershardCrusher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AmbershardCrusher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11781, 1, "AmbershardCrusher_OnCombat")
RegisterUnitEvent(11781, 2, "AmbershardCrusher_OnLeaveCombat")
RegisterUnitEvent(11781, 4, "AmbershardCrusher_OnDied")