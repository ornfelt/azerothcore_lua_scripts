--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BerylSorcerer_OnCombat(Unit, Event)
	Unit:RegisterEvent("BerylSorcerer_Blink", 11000, 0)
	Unit:RegisterEvent("BerylSorcerer_Frostbolt", 8000, 0)
end

function BerylSorcerer_Blink(Unit, Event) 
	Unit:CastSpell(50648) 
end

function BerylSorcerer_Frostbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9672, 	Unit:GetMainTank()) 
end

function BerylSorcerer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BerylSorcerer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BerylSorcerer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25316, 1, "BerylSorcerer_OnCombat")
RegisterUnitEvent(25316, 2, "BerylSorcerer_OnLeaveCombat")
RegisterUnitEvent(25316, 3, "BerylSorcerer_OnKilledTarget")
RegisterUnitEvent(25316, 4, "BerylSorcerer_OnDied")