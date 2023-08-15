--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitchwingWindcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("WitchwingWindcaller_EnvelopingWinds", 10000, 0)
end

function WitchwingWindcaller_EnvelopingWinds(Unit, Event) 
	Unit:FullCastSpellOnTarget(6728, 	Unit:GetMainTank()) 
end

function WitchwingWindcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WitchwingWindcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WitchwingWindcaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3280, 1, "WitchwingWindcaller_OnCombat")
RegisterUnitEvent(3280, 2, "WitchwingWindcaller_OnLeaveCombat")
RegisterUnitEvent(3280, 3, "WitchwingWindcaller_OnKilledTarget")
RegisterUnitEvent(3280, 4, "WitchwingWindcaller_OnDied")