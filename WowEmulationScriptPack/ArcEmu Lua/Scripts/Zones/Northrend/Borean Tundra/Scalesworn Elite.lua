--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScaleswornElite_OnCombat(Unit, Event)
Unit:RegisterEvent("ScaleswornElite_ArcaneSurge", 15000, 0)
Unit:RegisterEvent("ScaleswornElite_IceShard", 10000, 0)
end

function ScaleswornElite_ArcaneSurge(Unit, Event) 
Unit:FullCastSpellOnTarget(61272, Unit:GetMainTank()) 
end

function ScaleswornElite_IceShard(Unit, Event) 
Unit:FullCastSpellOnTarget(61269, Unit:GetMainTank()) 
end

function ScaleswornElite_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScaleswornElite_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScaleswornElite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32534, 1, "ScaleswornElite_OnCombat")
RegisterUnitEvent(32534, 2, "ScaleswornElite_OnLeaveCombat")
RegisterUnitEvent(32534, 3, "ScaleswornElite_OnKilledTarget")
RegisterUnitEvent(32534, 4, "ScaleswornElite_OnDied")