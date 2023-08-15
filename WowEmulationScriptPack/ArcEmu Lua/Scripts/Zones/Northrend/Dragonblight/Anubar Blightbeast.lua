--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AnubarBlightbeast_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarBlightbeast_BlightedShriek", 8000, 0)
Unit:RegisterEvent("AnubarBlightbeast_PoisonBolt", 6000, 0)
end

function AnubarBlightbeast_BlightedShriek(Unit, Event) 
Unit:CastSpell(47443) 
end

function AnubarBlightbeast_PoisonBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(21971, Unit:GetMainTank()) 
end

function AnubarBlightbeast_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarBlightbeast_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarBlightbeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26607, 1, "AnubarBlightbeast_OnCombat")
RegisterUnitEvent(26607, 2, "AnubarBlightbeast_OnLeaveCombat")
RegisterUnitEvent(26607, 3, "AnubarBlightbeast_OnKilledTarget")
RegisterUnitEvent(26607, 4, "AnubarBlightbeast_OnDied")