--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Bjomolf_OnCombat(Unit, Event)
Unit:RegisterEvent("Bjomolf_GnawBone", 8000, 0)
end

function Bjomolf_GnawBone(Unit, Event) 
Unit:FullCastSpellOnTarget(50046, Unit:GetMainTank()) 
end

function Bjomolf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bjomolf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bjomolf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24516, 1, "Bjomolf_OnCombat")
RegisterUnitEvent(24516, 2, "Bjomolf_OnLeaveCombat")
RegisterUnitEvent(24516, 3, "Bjomolf_OnKilledTarget")
RegisterUnitEvent(24516, 4, "Bjomolf_OnDied")