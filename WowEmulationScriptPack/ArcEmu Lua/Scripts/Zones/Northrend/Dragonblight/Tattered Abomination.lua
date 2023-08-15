--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TatteredAbomination_OnCombat(Unit, Event)
Unit:RegisterEvent("TatteredAbomination_ScourgeHook", 7000, 0)
end

function TatteredAbomination_ScourgeHook(Unit, Event) 
Unit:FullCastSpellOnTarget(50335, Unit:GetMainTank()) 
end

function TatteredAbomination_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TatteredAbomination_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TatteredAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27797, 1, "TatteredAbomination_OnCombat")
RegisterUnitEvent(27797, 2, "TatteredAbomination_OnLeaveCombat")
RegisterUnitEvent(27797, 3, "TatteredAbomination_OnKilledTarget")
RegisterUnitEvent(27797, 4, "TatteredAbomination_OnDied")