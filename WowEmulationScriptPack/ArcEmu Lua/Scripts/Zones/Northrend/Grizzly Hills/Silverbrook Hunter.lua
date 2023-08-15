--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverbrookHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookHunter_ImprovedWingClip", 14000, 0)
Unit:RegisterEvent("SilverbrookHunter_Shoot", 6000, 0)
end

function SilverbrookHunter_ImprovedWingClip(Unit, Event) 
Unit:FullCastSpellOnTarget(47168, Unit:GetMainTank()) 
end

function SilverbrookHunter_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SilverbrookHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27546, 1, "SilverbrookHunter_OnCombat")
RegisterUnitEvent(27546, 2, "SilverbrookHunter_OnLeaveCombat")
RegisterUnitEvent(27546, 3, "SilverbrookHunter_OnKilledTarget")
RegisterUnitEvent(27546, 4, "SilverbrookHunter_OnDied")