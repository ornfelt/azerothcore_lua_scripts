--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BerserkOwlbeast_OnCombat(Unit, Event)
	Unit:RegisterEvent("BerserkOwlbeast_Enrage", 1000, 1)
end

function BerserkOwlbeast_Enrage(Unit, Event) 
if 	Unit:GetHealthPct() < 25 then
	Unit:CastSpell(8599) 
end
end

function BerserkOwlbeast_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BerserkOwlbeast_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(7454, 1, "BerserkOwlbeast_OnCombat")
RegisterUnitEvent(7454, 2, "BerserkOwlbeast_OnLeaveCombat")
RegisterUnitEvent(7454, 4, "BerserkOwlbeast_OnDied")