--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function HandofArgusSwordsman_OnCombat(Unit, Event)
	Unit:RegisterEvent("HandofArgusSwordsman_BattleSgout", 2000, 1)
	Unit:RegisterEvent("HandofArgusSwordsman_Strike", 6000, 0)
end

function HandofArgusSwordsman_BattleSgout(pUnit, Event) 
	pUnit:CastSpell(9128) 
end

function HandofArgusSwordsman_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function HandofArgusSwordsman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HandofArgusSwordsman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17704, 1, "HandofArgusSwordsman_OnCombat")
RegisterUnitEvent(17704, 2, "HandofArgusSwordsman_OnLeaveCombat")
RegisterUnitEvent(17704, 4, "HandofArgusSwordsman_OnDied")