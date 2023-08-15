--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WintersSister_OnCombat(Unit, Event)
Unit:RegisterEvent("WintersSister_FrostShock", 6000, 0)
end

function WintersSister_FrostShock(Unit, Event) 
Unit:FullCastSpellOnTarget(12548, Unit:GetMainTank()) 
end

function WintersSister_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WintersSister_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WintersSister_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26456, 1, "WintersSister_OnCombat")
RegisterUnitEvent(26456, 2, "WintersSister_OnLeaveCombat")
RegisterUnitEvent(26456, 3, "WintersSister_OnKilledTarget")
RegisterUnitEvent(26456, 4, "WintersSister_OnDied")