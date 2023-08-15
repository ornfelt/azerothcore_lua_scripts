--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function thLegionInfantryman_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionInfantryman_ConcussionBlow", 10000, 0)
Unit:RegisterEvent("thLegionInfantryman_DemoralizingShout", 2000, 1)
end

function thLegionInfantryman_ConcussionBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(32588, Unit:GetMainTank()) 
end

function thLegionInfantryman_DemoralizingShout(Unit, Event) 
Unit:CastSpell(16244) 
end

function thLegionInfantryman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionInfantryman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionInfantryman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27160, 1, "thLegionInfantryman_OnCombat")
RegisterUnitEvent(27160, 2, "thLegionInfantryman_OnLeaveCombat")
RegisterUnitEvent(27160, 3, "thLegionInfantryman_OnKilledTarget")
RegisterUnitEvent(27160, 4, "thLegionInfantryman_OnDied")