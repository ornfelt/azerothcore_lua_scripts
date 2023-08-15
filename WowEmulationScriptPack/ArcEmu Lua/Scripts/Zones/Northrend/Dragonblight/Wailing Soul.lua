--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WailingSoul_OnCombat(Unit, Event)
Unit:RegisterEvent("WailingSoul_TugSoul", 10000, 0)
end

function WailingSoul_TugSoul(Unit, Event) 
Unit:FullCastSpellOnTarget(50027, Unit:GetMainTank()) 
end

function WailingSoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WailingSoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WailingSoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27836, 1, "WailingSoul_OnCombat")
RegisterUnitEvent(27836, 2, "WailingSoul_OnLeaveCombat")
RegisterUnitEvent(27836, 3, "WailingSoul_OnKilledTarget")
RegisterUnitEvent(27836, 4, "WailingSoul_OnDied")