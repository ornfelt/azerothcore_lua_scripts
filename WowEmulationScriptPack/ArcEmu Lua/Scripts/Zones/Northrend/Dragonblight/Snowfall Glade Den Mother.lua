--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SnowfallGladeDenMother_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallGladeDenMother_Enrage", 10000, 1)
end

function SnowfallGladeDenMother_Enrage(Unit, Event) 
Unit:CastSpell(48193) 
end

function SnowfallGladeDenMother_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallGladeDenMother_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallGladeDenMother_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26199, 1, "SnowfallGladeDenMother_OnCombat")
RegisterUnitEvent(26199, 2, "SnowfallGladeDenMother_OnLeaveCombat")
RegisterUnitEvent(26199, 3, "SnowfallGladeDenMother_OnKilledTarget")
RegisterUnitEvent(26199, 4, "SnowfallGladeDenMother_OnDied")