--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarInvader_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarInvader_FlingTorch", 2000, 1)
	Unit:RegisterEvent("KolkarInvader_RushingCharge", 8000, 0)
	Unit:RegisterEvent("KolkarInvader_Strike", 6000, 0)
	Unit:RegisterEvent("KolkarInvader_Tetanus", 4000, 1)
end

function KolkarInvader_FlingTorch(Unit, Event) 
	Unit:CastSpell(14292) 
end

function KolkarInvader_RushingCharge(Unit, Event) 
	Unit:CastSpell(6268) 
end

function KolkarInvader_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function KolkarInvader_Tetanus(Unit, Event) 
	Unit:FullCastSpellOnTarget(8014, 	Unit:GetMainTank()) 
end

function KolkarInvader_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarInvader_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarInvader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(9524, 1, "KolkarInvader_OnCombat")
RegisterUnitEvent(9524, 2, "KolkarInvader_OnLeaveCombat")
RegisterUnitEvent(9524, 3, "KolkarInvader_OnKilledTarget")
RegisterUnitEvent(9524, 4, "KolkarInvader_OnDied")