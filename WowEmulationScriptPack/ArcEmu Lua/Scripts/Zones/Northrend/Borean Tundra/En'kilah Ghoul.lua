--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnkilahGhoul_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahGhoul_FleshRip", 8000, 0)
end

function EnkilahGhoul_FleshRip(Unit, Event) 
Unit:FullCastSpellOnTarget(38056, Unit:GetMainTank()) 
end

function EnkilahGhoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahGhoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahGhoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25393, 1, "EnkilahGhoul_OnCombat")
RegisterUnitEvent(25393, 2, "EnkilahGhoul_OnLeaveCombat")
RegisterUnitEvent(25393, 3, "EnkilahGhoul_OnKilledTarget")
RegisterUnitEvent(25393, 4, "EnkilahGhoul_OnDied")