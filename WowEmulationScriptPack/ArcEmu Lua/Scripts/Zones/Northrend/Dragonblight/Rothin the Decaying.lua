--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RothintheDecaying_OnCombat(Unit, Event)
Unit:RegisterEvent("RothintheDecaying_AegisofNeltharion", 4000, 1)
Unit:RegisterEvent("RothintheDecaying_Shadowflame", 7000, 0)
Unit:RegisterEvent("RothintheDecaying_ShadowBolt", 8000, 0)
end

function RothintheDecaying_AegisofNeltharion(Unit, Event) 
Unit:CastSpell(51512) 
end

function RothintheDecaying_Shadowflame(Unit, Event) 
Unit:CastSpell(51337) 
end

function RothintheDecaying_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function RothintheDecaying_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RothintheDecaying_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RothintheDecaying_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27355, 1, "RothintheDecaying_OnCombat")
RegisterUnitEvent(27355, 2, "RothintheDecaying_OnLeaveCombat")
RegisterUnitEvent(27355, 3, "RothintheDecaying_OnKilledTarget")
RegisterUnitEvent(27355, 4, "RothintheDecaying_OnDied")