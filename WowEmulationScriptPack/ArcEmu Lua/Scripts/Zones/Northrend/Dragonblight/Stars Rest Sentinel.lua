--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StarsRestSentinel_OnCombat(Unit, Event)
Unit:RegisterEvent("StarsRestSentinel_FrostArrow", 8000, 0)
Unit:RegisterEvent("StarsRestSentinel_Shoot", 6000, 0)
end

function StarsRestSentinel_FrostArrow(Unit, Event) 
Unit:FullCastSpellOnTarget(47059, Unit:GetMainTank()) 
end

function StarsRestSentinel_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(23337, Unit:GetMainTank()) 
end

function StarsRestSentinel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function StarsRestSentinel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function StarsRestSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26448, 1, "StarsRestSentinel_OnCombat")
RegisterUnitEvent(26448, 2, "StarsRestSentinel_OnLeaveCombat")
RegisterUnitEvent(26448, 3, "StarsRestSentinel_OnKilledTarget")
RegisterUnitEvent(26448, 4, "StarsRestSentinel_OnDied")