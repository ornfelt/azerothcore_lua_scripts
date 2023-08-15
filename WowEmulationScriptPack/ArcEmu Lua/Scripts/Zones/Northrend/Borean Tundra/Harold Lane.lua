--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HaroldLane_OnCombat(Unit, Event)
Unit:RegisterEvent("HaroldLane_BearTrap", 2000, 1)
Unit:RegisterEvent("HaroldLane_ThrowBearPelt", 8000, 0)
end

function HaroldLane_BearTrap(Unit, Event) 
Unit:CastSpell(53432) 
end

function HaroldLane_ThrowBearPelt(Unit, Event) 
Unit:FullCastSpellOnTarget(53425, Unit:GetMainTank()) 
end

function HaroldLane_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HaroldLane_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HaroldLane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25804, 1, "HaroldLane_OnCombat")
RegisterUnitEvent(25804, 2, "HaroldLane_OnLeaveCombat")
RegisterUnitEvent(25804, 3, "HaroldLane_OnKilledTarget")
RegisterUnitEvent(25804, 4, "HaroldLane_OnDied")