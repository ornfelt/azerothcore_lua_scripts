--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NexusGuardian_OnCombat(Unit, Event)
Unit:RegisterEvent("NexusGuardian_FrostBreath", 6500, 0)
Unit:RegisterEvent("NexusGuardian_FrostCleave", 8000, 0)
end

function NexusGuardian_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(47425, Unit:GetMainTank()) 
end

function NexusGuardian_FrostCleave(Unit, Event) 
Unit:CastSpell(51857) 
end

function NexusGuardian_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NexusGuardian_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NexusGuardian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26276, 1, "NexusGuardian_OnCombat")
RegisterUnitEvent(26276, 2, "NexusGuardian_OnLeaveCombat")
RegisterUnitEvent(26276, 3, "NexusGuardian_OnKilledTarget")
RegisterUnitEvent(26276, 4, "NexusGuardian_OnDied")