--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MagnataurPatriarch_OnCombat(Unit, Event)
Unit:RegisterEvent("MagnataurPatriarch_Throw", 5000, 0)
end

function MagnataurPatriarch_Throw(Unit, Event) 
Unit:FullCastSpellOnTarget(38556, Unit:GetMainTank()) 
end

function MagnataurPatriarch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagnataurPatriarch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagnataurPatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26295, 1, "MagnataurPatriarch_OnCombat")
RegisterUnitEvent(26295, 2, "MagnataurPatriarch_OnLeaveCombat")
RegisterUnitEvent(26295, 3, "MagnataurPatriarch_OnKilledTarget")
RegisterUnitEvent(26295, 4, "MagnataurPatriarch_OnDied")