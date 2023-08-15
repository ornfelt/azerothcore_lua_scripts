--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WoundedWestfallInfantry_OnCombat(Unit, Event)
Unit:RegisterEvent("WoundedWestfallInfantry_HolyShock", 6000, 0)
Unit:RegisterEvent("WoundedWestfallInfantry_SealofCommand", 4000, 1)
end

function WoundedWestfallInfantry_HolyShock(Unit, Event) 
Unit:FullCastSpellOnTarget(32771, Unit:GetMainTank()) 
end

function WoundedWestfallInfantry_SealofCommand(Unit, Event) 
Unit:CastSpell(29385) 
end

function WoundedWestfallInfantry_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoundedWestfallInfantry_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoundedWestfallInfantry_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27482, 1, "WoundedWestfallInfantry_OnCombat")
RegisterUnitEvent(27482, 2, "WoundedWestfallInfantry_OnLeaveCombat")
RegisterUnitEvent(27482, 3, "WoundedWestfallInfantry_OnKilledTarget")
RegisterUnitEvent(27482, 4, "WoundedWestfallInfantry_OnDied")