--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SandfuryHideskinner_OnCombat(Unit, Event)
	Unit:RegisterEvent("SandfuryHideskinner_Backstab", 4000, 0)
end

function SandfuryHideskinner_Backstab(Unit, Event) 
	Unit:FullCastSpellOnTarget(7159, 	Unit:GetMainTank()) 
end

function SandfuryHideskinner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SandfuryHideskinner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SandfuryHideskinner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5645, 1, "SandfuryHideskinner_OnCombat")
RegisterUnitEvent(5645, 2, "SandfuryHideskinner_OnLeaveCombat")
RegisterUnitEvent(5645, 3, "SandfuryHideskinner_OnKilledTarget")
RegisterUnitEvent(5645, 4, "SandfuryHideskinner_OnDied")