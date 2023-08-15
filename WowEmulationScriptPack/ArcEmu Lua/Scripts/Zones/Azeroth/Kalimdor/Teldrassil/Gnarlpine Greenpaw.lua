--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Greenpaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("Greenpaw_Rejuvenation", 10000, 0)
	Unit:RegisterEvent("Greenpaw_Shock", 6000, 0)
end

function Greenpaw_Rejuvenation(Unit, Event) 
	Unit:CastSpell(774) 
end

function Greenpaw_Shock(Unit, Event) 
	Unit:FullCastSpellOnTarget(2606, 	Unit:GetMainTank()) 
end

function Greenpaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Greenpaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Greenpaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(1993, 1, "Greenpaw_OnCombat")
RegisterUnitEvent(1993, 2, "Greenpaw_OnLeaveCombat")
RegisterUnitEvent(1993, 3, "Greenpaw_OnKilledTarget")
RegisterUnitEvent(1993, 4, "Greenpaw_OnDied")