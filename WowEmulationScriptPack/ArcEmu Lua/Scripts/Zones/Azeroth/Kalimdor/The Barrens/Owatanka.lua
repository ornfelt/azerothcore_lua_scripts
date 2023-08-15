--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Owatanka_OnCombat(Unit, Event)
	Unit:RegisterEvent("Owatanka_ChainedBolt", 6000, 0)
end

function Owatanka_ChainedBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(6254, 	Unit:GetMainTank()) 
end

function Owatanka_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Owatanka_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Owatanka_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3473, 1, "Owatanka_OnCombat")
RegisterUnitEvent(3473, 2, "Owatanka_OnLeaveCombat")
RegisterUnitEvent(3473, 3, "Owatanka_OnKilledTarget")
RegisterUnitEvent(3473, 4, "Owatanka_OnDied")