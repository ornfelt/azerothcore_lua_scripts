--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MoonrestStalker_OnCombat(Unit, Event)
Unit:RegisterEvent("MoonrestStalker_ManaBurn", 4000, 0)
end

function MoonrestStalker_ManaBurn(Unit, Event) 
Unit:FullCastSpellOnTarget(2691, Unit:GetRandomPlayer(4)) 
end

function MoonrestStalker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MoonrestStalker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MoonrestStalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26281, 1, "MoonrestStalker_OnCombat")
RegisterUnitEvent(26281, 2, "MoonrestStalker_OnLeaveCombat")
RegisterUnitEvent(26281, 3, "MoonrestStalker_OnKilledTarget")
RegisterUnitEvent(26281, 4, "MoonrestStalker_OnDied")