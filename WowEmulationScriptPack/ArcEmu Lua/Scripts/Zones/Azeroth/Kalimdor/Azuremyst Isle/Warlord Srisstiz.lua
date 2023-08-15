--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WarlordSrisstiz_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarlordSrisstiz_WateryStrike", 6000, 0)
end

function WarlordSrisstiz_WateryStrike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31275, 	pUnit:GetMainTank()) 
end

function WarlordSrisstiz_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarlordSrisstiz_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17298, 1, "WarlordSrisstiz_OnCombat")
RegisterUnitEvent(17298, 2, "WarlordSrisstiz_OnLeaveCombat")
RegisterUnitEvent(17298, 4, "WarlordSrisstiz_OnDied")