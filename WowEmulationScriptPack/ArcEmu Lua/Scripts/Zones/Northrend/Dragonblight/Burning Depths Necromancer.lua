--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningDepthsNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("BurningDepthsNecromancer_PowerRelease", 7000, 0)
end

function BurningDepthsNecromancer_PowerRelease(Unit, Event) 
Unit:FullCastSpellOnTarget(51431, Unit:GetMainTank()) 
end

function BurningDepthsNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BurningDepthsNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BurningDepthsNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27358, 1, "BurningDepthsNecromancer_OnCombat")
RegisterUnitEvent(27358, 2, "BurningDepthsNecromancer_OnLeaveCombat")
RegisterUnitEvent(27358, 3, "BurningDepthsNecromancer_OnKilledTarget")
RegisterUnitEvent(27358, 4, "BurningDepthsNecromancer_OnDied")