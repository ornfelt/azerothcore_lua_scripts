--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WinterfinShorestriker_OnCombat(Unit, Event)
Unit:RegisterEvent("WinterfinShorestriker_RushedAssault", 7000, 0)
end

function WinterfinShorestriker_RushedAssault(Unit, Event) 
Unit:CastSpell(50262) 
end

function WinterfinShorestriker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WinterfinShorestriker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WinterfinShorestriker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25215, 1, "WinterfinShorestriker_OnCombat")
RegisterUnitEvent(25215, 2, "WinterfinShorestriker_OnLeaveCombat")
RegisterUnitEvent(25215, 3, "WinterfinShorestriker_OnKilledTarget")
RegisterUnitEvent(25215, 4, "WinterfinShorestriker_OnDied")