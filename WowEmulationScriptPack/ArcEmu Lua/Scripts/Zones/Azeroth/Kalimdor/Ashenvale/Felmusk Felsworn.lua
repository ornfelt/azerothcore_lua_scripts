--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FelmuskFelsworn_OnCombat(Unit, Event)
	Unit:RegisterEvent("FelmuskFelsworn_OverwhelmingStench", 10000, 0)
end

function FelmuskFelsworn_OverwhelmingStench(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6942, 	pUnit:GetMainTank()) 
end

function FelmuskFelsworn_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FelmuskFelsworn_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3762, 1, "FelmuskFelsworn_OnCombat")
RegisterUnitEvent(3762, 2, "FelmuskFelsworn_OnLeaveCombat")
RegisterUnitEvent(3762, 4, "FelmuskFelsworn_OnDied")