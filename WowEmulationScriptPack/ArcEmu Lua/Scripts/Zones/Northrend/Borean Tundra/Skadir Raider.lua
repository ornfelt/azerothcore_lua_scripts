--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SkadirRaider_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirRaider_FreezingTrap", 1000, 1)
Unit:RegisterEvent("SkadirRaider_ThrowSpear", 6000, 0)
end

function SkadirRaider_FreezingTrap(Unit, Event) 
Unit:CastSpell(43414) 
end

function SkadirRaider_ThrowSpear(Unit, Event) 
Unit:FullCastSpellOnTarget(43413, Unit:GetMainTank()) 
end

function SkadirRaider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirRaider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirRaider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25522, 1, "SkadirRaider_OnCombat")
RegisterUnitEvent(25522, 2, "SkadirRaider_OnLeaveCombat")
RegisterUnitEvent(25522, 3, "SkadirRaider_OnKilledTarget")
RegisterUnitEvent(25522, 4, "SkadirRaider_OnDied")