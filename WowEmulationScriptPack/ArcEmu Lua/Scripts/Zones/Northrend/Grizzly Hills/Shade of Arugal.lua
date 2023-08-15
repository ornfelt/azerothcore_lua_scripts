--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadeofArugal_OnCombat(Unit, Event)
Unit:RegisterEvent("ShadeofArugal_PhaseOut", 45000, 0)
Unit:RegisterEvent("ShadeofArugal_ShadowBolt", 8000, 0)
Unit:RegisterEvent("ShadeofArugal_WorgensCommand", 15000, 1)
end

function ShadeofArugal_PhaseOut(Unit, Event) 
Unit:FullCastSpellOnTarget(53052, Unit:GetMainTank()) 
end

function ShadeofArugal_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(53086, Unit:GetMainTank()) 
end

function ShadeofArugal_WorgensCommand(Unit, Event) 
Unit:FullCastSpellOnTarget(53070, Unit:GetMainTank()) 
end

function ShadeofArugal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShadeofArugal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShadeofArugal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27018, 1, "ShadeofArugal_OnCombat")
RegisterUnitEvent(27018, 2, "ShadeofArugal_OnLeaveCombat")
RegisterUnitEvent(27018, 3, "ShadeofArugal_OnKilledTarget")
RegisterUnitEvent(27018, 4, "ShadeofArugal_OnDied")