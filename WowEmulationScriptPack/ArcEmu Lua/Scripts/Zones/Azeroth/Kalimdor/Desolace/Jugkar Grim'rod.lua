--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function JugkarGrimrod_OnCombat(Unit, Event)
	Unit:RegisterEvent("JugkarGrimrod_CurseofWeakness", 5000, 1)
	Unit:RegisterEvent("JugkarGrimrod_Immolate", 6000, 1)
	Unit:RegisterEvent("JugkarGrimrod_ShadowBolt", 8000, 0)
end

function JugkarGrimrod_CurseofWeakness(Unit, Event) 
	Unit:FullCastSpellOnTarget(12741, 	Unit:GetMainTank()) 
end

function JugkarGrimrod_Immolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(20787, 	Unit:GetMainTank()) 
end

function JugkarGrimrod_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(12471, 	Unit:GetMainTank()) 
end

function JugkarGrimrod_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function JugkarGrimrod_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function JugkarGrimrod_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5771, 1, "JugkarGrimrod_OnCombat")
RegisterUnitEvent(5771, 2, "JugkarGrimrod_OnLeaveCombat")
RegisterUnitEvent(5771, 3, "JugkarGrimrod_OnKilledTarget")
RegisterUnitEvent(5771, 4, "JugkarGrimrod_OnDied")