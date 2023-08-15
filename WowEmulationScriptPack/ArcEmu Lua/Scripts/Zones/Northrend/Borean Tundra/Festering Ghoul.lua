--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FesteringGhoul_OnCombat(Unit, Event)
Unit:RegisterEvent("FesteringGhoul_RotArmor", 10000, 0)
end

function FesteringGhoul_RotArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50361, Unit:GetMainTank()) 
end

function FesteringGhoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FesteringGhoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FesteringGhoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25660, 1, "FesteringGhoul_OnCombat")
RegisterUnitEvent(25660, 2, "FesteringGhoul_OnLeaveCombat")
RegisterUnitEvent(25660, 3, "FesteringGhoul_OnKilledTarget")
RegisterUnitEvent(25660, 4, "FesteringGhoul_OnDied")