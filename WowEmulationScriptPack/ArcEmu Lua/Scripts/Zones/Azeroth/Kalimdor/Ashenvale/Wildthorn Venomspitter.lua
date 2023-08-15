--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WildthornVenomspitter_OnCombat(Unit, Event)
	Unit:RegisterEvent("WildthornVenomspitter_VenomSpit", 8000, 0)
end

function WildthornVenomspitter_VenomSpit(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6917, 	pUnit:GetMainTank()) 
end

function WildthornVenomspitter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WildthornVenomspitter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3820, 1, "WildthornVenomspitter_OnCombat")
RegisterUnitEvent(3820, 2, "WildthornVenomspitter_OnLeaveCombat")
RegisterUnitEvent(3820, 4, "WildthornVenomspitter_OnDied")