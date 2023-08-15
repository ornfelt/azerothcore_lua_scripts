--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CaptainFairmount_OnCombat(Unit, Event)
	Unit:RegisterEvent("CaptainFairmount_BattleShout", 1000, 1)
	Unit:RegisterEvent("CaptainFairmount_FrighteningShout", 12000, 0)
	Unit:RegisterEvent("CaptainFairmount_Pummel", 8000, 0)
end

function CaptainFairmount_BattleShout(Unit, Event) 
	Unit:CastSpell(9128) 
end

function CaptainFairmount_FrighteningShout(Unit, Event) 
	Unit:FullCastSpellOnTarget(19134, 	Unit:GetMainTank()) 
end

function CaptainFairmount_Pummel(Unit, Event) 
	Unit:FullCastSpellOnTarget(12555, 	Unit:GetMainTank()) 
end

function CaptainFairmount_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CaptainFairmount_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CaptainFairmount_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3393, 1, "CaptainFairmount_OnCombat")
RegisterUnitEvent(3393, 2, "CaptainFairmount_OnLeaveCombat")
RegisterUnitEvent(3393, 3, "CaptainFairmount_OnKilledTarget")
RegisterUnitEvent(3393, 4, "CaptainFairmount_OnDied")