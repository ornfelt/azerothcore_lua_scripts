--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlacksouledKeeper_OnCombat(Unit, Event)
Unit:RegisterEvent("BlacksouledKeeper_Wrath", 5000, 0)
end

function BlacksouledKeeper_Wrath(Unit, Event) 
Unit:FullCastSpellOnTarget(43619, Unit:GetMainTank()) 
end

function BlacksouledKeeper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlacksouledKeeper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlacksouledKeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23875, 1, "BlacksouledKeeper_OnCombat")
RegisterUnitEvent(23875, 2, "BlacksouledKeeper_OnLeaveCombat")
RegisterUnitEvent(23875, 3, "BlacksouledKeeper_OnKilledTarget")
RegisterUnitEvent(23875, 4, "BlacksouledKeeper_OnDied")