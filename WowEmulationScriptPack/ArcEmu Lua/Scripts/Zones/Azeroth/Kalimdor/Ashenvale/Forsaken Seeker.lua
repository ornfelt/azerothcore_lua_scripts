--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForsakenSeeker_OnCombat(Unit, Event)
	Unit:RegisterEvent("ForsakenSeeker_Heal", 12000, 0)
	Unit:RegisterEvent("ForsakenSeeker_HolySmite", 7000, 0)
end

function ForsakenSeeker_Heal(pUnit, Event) 
	pUnit:CastSpell(2054) 
end

function ForsakenSeeker_HolySmite(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9734, 	pUnit:GetMainTank()) 
end

function ForsakenSeeker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ForsakenSeeker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3732, 1, "ForsakenSeeker_OnCombat")
RegisterUnitEvent(3732, 2, "ForsakenSeeker_OnLeaveCombat")
RegisterUnitEvent(3732, 4, "ForsakenSeeker_OnDied")