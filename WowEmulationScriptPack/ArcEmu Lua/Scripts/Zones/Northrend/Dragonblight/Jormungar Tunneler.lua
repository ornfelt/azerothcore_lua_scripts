--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function JormungarTunneler_OnCombat(Unit, Event)
Unit:RegisterEvent("JormungarTunneler_CorrodeFlesh", 4000, 1)
end

function JormungarTunneler_CorrodeFlesh(Unit, Event) 
Unit:FullCastSpellOnTarget(51879, Unit:GetMainTank()) 
end

function JormungarTunneler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function JormungarTunneler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function JormungarTunneler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26467, 1, "JormungarTunneler_OnCombat")
RegisterUnitEvent(26467, 2, "JormungarTunneler_OnLeaveCombat")
RegisterUnitEvent(26467, 3, "JormungarTunneler_OnKilledTarget")
RegisterUnitEvent(26467, 4, "JormungarTunneler_OnDied")