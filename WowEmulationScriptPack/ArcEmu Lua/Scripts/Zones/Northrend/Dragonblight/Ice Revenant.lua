--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IceRevenant_OnCombat(Unit, Event)
Unit:RegisterEvent("IceRevenant_IcyTorrent", 7000, 0)
end

function IceRevenant_IcyTorrent(Unit, Event) 
Unit:FullCastSpellOnTarget(51584, Unit:GetMainTank()) 
end

function IceRevenant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceRevenant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceRevenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26283, 1, "IceRevenant_OnCombat")
RegisterUnitEvent(26283, 2, "IceRevenant_OnLeaveCombat")
RegisterUnitEvent(26283, 3, "IceRevenant_OnKilledTarget")
RegisterUnitEvent(26283, 4, "IceRevenant_OnDied")