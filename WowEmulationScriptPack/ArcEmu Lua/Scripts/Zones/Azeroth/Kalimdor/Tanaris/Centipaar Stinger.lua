--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CentipaarStinger_OnCombat(Unit, Event)
	Unit:RegisterEvent("CentipaarStinger_VenomSting", 10000, 0)
	Unit:RegisterEvent("CentipaarStinger_Thrash", 6000, 0)
end

function CentipaarStinger_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function CentipaarStinger_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function CentipaarStinger_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CentipaarStinger_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CentipaarStinger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5456, 1, "CentipaarStinger_OnCombat")
RegisterUnitEvent(5456, 2, "CentipaarStinger_OnLeaveCombat")
RegisterUnitEvent(5456, 3, "CentipaarStinger_OnKilledTarget")
RegisterUnitEvent(5456, 4, "CentipaarStinger_OnDied")