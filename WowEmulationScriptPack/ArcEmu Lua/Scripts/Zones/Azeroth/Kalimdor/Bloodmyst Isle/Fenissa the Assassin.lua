--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FenissatheAssassin_OnCombat(Unit, Event)
	Unit:RegisterEvent("FenissatheAssassin_Gouge", 8000, 0)
	Unit:RegisterEvent("FenissatheAssassin_SinisterStrike", 6000, 0)
end

function FenissatheAssassin_Gouge(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(38863, 	pUnit:GetMainTank()) 
end

function FenissatheAssassin_SinisterStrike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(14873, 	pUnit:GetMainTank()) 
end

function FenissatheAssassin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FenissatheAssassin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(22060, 1, "FenissatheAssassin_OnCombat")
RegisterUnitEvent(22060, 2, "FenissatheAssassin_OnLeaveCombat")
RegisterUnitEvent(22060, 4, "FenissatheAssassin_OnDied")