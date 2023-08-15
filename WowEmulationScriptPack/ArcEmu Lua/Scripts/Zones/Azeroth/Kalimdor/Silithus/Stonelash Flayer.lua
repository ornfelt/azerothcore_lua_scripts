--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StonelashFlayer_OnCombat(Unit, Event)
	Unit:RegisterEvent("StonelashFlayer_Thrash", 5000, 0)
	Unit:RegisterEvent("StonelashFlayer_VenomSting", 8000, 0)
end

function StonelashFlayer_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function StonelashFlayer_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function StonelashFlayer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StonelashFlayer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function StonelashFlayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11737, 1, "StonelashFlayer_OnCombat")
RegisterUnitEvent(11737, 2, "StonelashFlayer_OnLeaveCombat")
RegisterUnitEvent(11737, 3, "StonelashFlayer_OnKilledTarget")
RegisterUnitEvent(11737, 4, "StonelashFlayer_OnDied")