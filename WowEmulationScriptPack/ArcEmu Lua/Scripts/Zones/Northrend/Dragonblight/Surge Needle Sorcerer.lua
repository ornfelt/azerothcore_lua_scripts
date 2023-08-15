--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SurgeNeedleSorcerer_OnCombat(Unit, Event)
Unit:RegisterEvent("SurgeNeedleSorcerer_ArcaneBlast", 6500, 0)
end

function SurgeNeedleSorcerer_ArcaneBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(51797, Unit:GetMainTank()) 
end

function SurgeNeedleSorcerer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SurgeNeedleSorcerer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SurgeNeedleSorcerer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26257, 1, "SurgeNeedleSorcerer_OnCombat")
RegisterUnitEvent(26257, 2, "SurgeNeedleSorcerer_OnLeaveCombat")
RegisterUnitEvent(26257, 3, "SurgeNeedleSorcerer_OnKilledTarget")
RegisterUnitEvent(26257, 4, "SurgeNeedleSorcerer_OnDied")