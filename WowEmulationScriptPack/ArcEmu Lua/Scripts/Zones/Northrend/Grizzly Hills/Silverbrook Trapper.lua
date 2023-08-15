--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverbrookTrapper_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookTrapper_HookedNet", 12000, 0)
Unit:RegisterEvent("SilverbrookTrapper_Shoot", 6000, 0)
end

function SilverbrookTrapper_HookedNet(Unit, Event) 
Unit:FullCastSpellOnTarget(13608, Unit:GetMainTank()) 
end

function SilverbrookTrapper_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SilverbrookTrapper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookTrapper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookTrapper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26679, 1, "SilverbrookTrapper_OnCombat")
RegisterUnitEvent(26679, 2, "SilverbrookTrapper_OnLeaveCombat")
RegisterUnitEvent(26679, 3, "SilverbrookTrapper_OnKilledTarget")
RegisterUnitEvent(26679, 4, "SilverbrookTrapper_OnDied")