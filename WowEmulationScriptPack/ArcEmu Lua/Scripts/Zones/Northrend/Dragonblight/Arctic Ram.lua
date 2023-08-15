--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ArcticRam_OnCombat(Unit, Event)
Unit:RegisterEvent("ArcticRam_Gore", 8000, 0)
end

function ArcticRam_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function ArcticRam_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ArcticRam_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ArcticRam_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26426, 1, "ArcticRam_OnCombat")
RegisterUnitEvent(26426, 2, "ArcticRam_OnLeaveCombat")
RegisterUnitEvent(26426, 3, "ArcticRam_OnKilledTarget")
RegisterUnitEvent(26426, 4, "ArcticRam_OnDied")