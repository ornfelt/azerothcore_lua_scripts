--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TorturerLeCraft_OnCombat(Unit, Event)
Unit:RegisterEvent("TorturerLeCraft_Hemorrhage", 5000, 0)
Unit:RegisterEvent("TorturerLeCraft_KidneyShot", 10000, 0)
end

function TorturerLeCraft_Hemorrhage(Unit, Event) 
Unit:FullCastSpellOnTarget(30478) 
end

function TorturerLeCraft_KidneyShot(Unit, Event) 
Unit:FullCastSpellOnTarget(30621, Unit:GetMainTank()) 
end

function TorturerLeCraft_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TorturerLeCraft_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TorturerLeCraft_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27209, 1, "TorturerLeCraft_OnCombat")
RegisterUnitEvent(27209, 2, "TorturerLeCraft_OnLeaveCombat")
RegisterUnitEvent(27209, 3, "TorturerLeCraft_OnKilledTarget")
RegisterUnitEvent(27209, 4, "TorturerLeCraft_OnDied")