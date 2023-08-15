--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverCovenantScout_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverCovenantScout_MultiShot", 8000, 0)
Unit:RegisterEvent("SilverCovenantScout_Shoot", 6000, 0)
end

function SilverCovenantScout_MultiShot(Unit, Event) 
Unit:FullCastSpellOnTarget(14443, Unit:GetMainTank()) 
end

function SilverCovenantScout_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SilverCovenantScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverCovenantScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverCovenantScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30238, 1, "SilverCovenantScout_OnCombat")
RegisterUnitEvent(30238, 2, "SilverCovenantScout_OnLeaveCombat")
RegisterUnitEvent(30238, 3, "SilverCovenantScout_OnKilledTarget")
RegisterUnitEvent(30238, 4, "SilverCovenantScout_OnDied")