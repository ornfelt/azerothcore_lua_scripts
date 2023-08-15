--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ClamMasterK_OnCombat(Unit, Event)
Unit:RegisterEvent("ClamMasterK_HookedNet", 8000, 0)
end

function ClamMasterK_HookedNet(Unit, Event) 
Unit:FullCastSpellOnTarget(49711, Unit:GetMainTank()) 
end

function ClamMasterK_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ClamMasterK_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ClamMasterK_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25800, 1, "ClamMasterK_OnCombat")
RegisterUnitEvent(25800, 2, "ClamMasterK_OnLeaveCombat")
RegisterUnitEvent(25800, 3, "ClamMasterK_OnKilledTarget")
RegisterUnitEvent(25800, 4, "ClamMasterK_OnDied")