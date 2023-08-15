--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilverCovenantHorseman_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverCovenantHorseman_MultiShot", 8000, 0)
Unit:RegisterEvent("SilverCovenantHorseman_Shoot", 6000, 0)
end

function SilverCovenantHorseman_MultiShot(Unit, Event) 
Unit:FullCastSpellOnTarget(14443, Unit:GetMainTank()) 
end

function SilverCovenantHorseman_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SilverCovenantHorseman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverCovenantHorseman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverCovenantHorseman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30263, 1, "SilverCovenantHorseman_OnCombat")
RegisterUnitEvent(30263, 2, "SilverCovenantHorseman_OnLeaveCombat")
RegisterUnitEvent(30263, 3, "SilverCovenantHorseman_OnKilledTarget")
RegisterUnitEvent(30263, 4, "SilverCovenantHorseman_OnDied")