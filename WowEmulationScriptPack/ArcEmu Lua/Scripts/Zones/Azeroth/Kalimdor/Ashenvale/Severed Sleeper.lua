--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SeveredSleeper_OnCombat(Unit, Event)
	Unit:RegisterEvent("SeveredSleeper_Sleep", 12000, 1)
end

function SeveredSleeper_Sleep(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8399, 	pUnit:GetMainTank()) 
end

function SeveredSleeper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SeveredSleeper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3801, 1, "SeveredSleeper_OnCombat")
RegisterUnitEvent(3801, 2, "SeveredSleeper_OnLeaveCombat")
RegisterUnitEvent(3801, 4, "SeveredSleeper_OnDied")