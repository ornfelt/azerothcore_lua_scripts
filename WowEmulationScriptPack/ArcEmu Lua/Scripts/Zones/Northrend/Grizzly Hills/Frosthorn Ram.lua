--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrosthornRam_OnCombat(Unit, Event)
Unit:RegisterEvent("FrosthornRam_HoofStrike", 7000, 0)
end

function FrosthornRam_HoofStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(29577, Unit:GetMainTank()) 
end

function FrosthornRam_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrosthornRam_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrosthornRam_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23740, 1, "FrosthornRam_OnCombat")
RegisterUnitEvent(23740, 2, "FrosthornRam_OnLeaveCombat")
RegisterUnitEvent(23740, 3, "FrosthornRam_OnKilledTarget")
RegisterUnitEvent(23740, 4, "FrosthornRam_OnDied")