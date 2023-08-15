--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScoutTungok_OnCombat(Unit, Event)
Unit:RegisterEvent("ScoutTungok_Enrage", 10000, 0)
end

function ScoutTungok_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function ScoutTungok_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScoutTungok_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScoutTungok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25440, 1, "ScoutTungok_OnCombat")
RegisterUnitEvent(25440, 2, "ScoutTungok_OnLeaveCombat")
RegisterUnitEvent(25440, 3, "ScoutTungok_OnKilledTarget")
RegisterUnitEvent(25440, 4, "ScoutTungok_OnDied")