--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeSummoner_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeSummoner_ShadowBolt", 8000, 0)
	Unit:RegisterEvent("BurningBladeSummoner_SummonImp", 5000, 1)
end

function BurningBladeSummoner_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20825, 	Unit:GetMainTank()) 
end

function BurningBladeSummoner_SummonImp(Unit, Event) 
	Unit:CastSpell(11939) 
end

function BurningBladeSummoner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeSummoner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4668, 1, "BurningBladeSummoner_OnCombat")
RegisterUnitEvent(4668, 2, "BurningBladeSummoner_OnLeaveCombat")
RegisterUnitEvent(4668, 4, "BurningBladeSummoner_OnDied")