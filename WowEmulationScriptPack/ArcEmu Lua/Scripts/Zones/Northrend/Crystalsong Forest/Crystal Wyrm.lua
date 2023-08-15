--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CrystalWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("CrystalWyrm_FrostBreath", 8000, 0)
end

function CrystalWyrm_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(47425, Unit:GetMainTank()) 
end

function CrystalWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrystalWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrystalWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31393, 1, "CrystalWyrm_OnCombat")
RegisterUnitEvent(31393, 2, "CrystalWyrm_OnLeaveCombat")
RegisterUnitEvent(31393, 3, "CrystalWyrm_OnKilledTarget")
RegisterUnitEvent(31393, 4, "CrystalWyrm_OnDied")