--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HighChiefBristlelimb_OnCombat(Unit, Event)
	Unit:RegisterEvent("HighChiefBristlelimb_DemoralizingRoar", 2000, 1)
	Unit:RegisterEvent("HighChiefBristlelimb_Maul", 6000, 0)
end

function HighChiefBristlelimb_DemoralizingRoar(pUnit, Event) 
	pUnit:CastSpell(20753) 
end

function HighChiefBristlelimb_Maul(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15793, 	pUnit:GetMainTank()) 
end

function HighChiefBristlelimb_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HighChiefBristlelimb_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17702, 1, "HighChiefBristlelimb_OnCombat")
RegisterUnitEvent(17702, 2, "HighChiefBristlelimb_OnLeaveCombat")
RegisterUnitEvent(17702, 4, "HighChiefBristlelimb_OnDied")