--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarpHuntressKula_OnCombat(Unit, Event)
Unit:RegisterEvent("WarpHuntressKula_ShootGun", 6000, 0)
end

function WarpHuntressKula_ShootGun(Unit, Event) 
Unit:FullCastSpellOnTarget(61353, Unit:GetMainTank()) 
end

function WarpHuntressKula_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarpHuntressKula_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarpHuntressKula_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32711, 1, "WarpHuntressKula_OnCombat")
RegisterUnitEvent(32711, 2, "WarpHuntressKula_OnLeaveCombat")
RegisterUnitEvent(32711, 3, "WarpHuntressKula_OnKilledTarget")
RegisterUnitEvent(32711, 4, "WarpHuntressKula_OnDied")