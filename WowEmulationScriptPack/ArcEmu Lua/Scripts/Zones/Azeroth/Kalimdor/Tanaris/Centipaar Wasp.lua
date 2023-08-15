--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CentipaarWasp_OnCombat(Unit, Event)
	Unit:RegisterEvent("CentipaarWasp_Poison", 10000, 0)
	Unit:RegisterEvent("CentipaarWasp_Thrash", 6000, 0)
end

function CentipaarWasp_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetMainTank()) 
end

function CentipaarWasp_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function CentipaarWasp_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CentipaarWasp_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CentipaarWasp_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5455, 1, "CentipaarWasp_OnCombat")
RegisterUnitEvent(5455, 2, "CentipaarWasp_OnLeaveCombat")
RegisterUnitEvent(5455, 3, "CentipaarWasp_OnKilledTarget")
RegisterUnitEvent(5455, 4, "CentipaarWasp_OnDied")