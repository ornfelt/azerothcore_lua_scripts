--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DeathKnightChampion_OnCombat(Unit, Event)
Unit:RegisterEvent("DeathKnightChampion_BloodPresence", 1000, 1)
Unit:RegisterEvent("DeathKnightChampion_PlagueStrike", 8000, 0)
end

function DeathKnightChampion_BloodPresence(Unit, Event) 
Unit:CastSpell(50689) 
end

function DeathKnightChampion_PlagueStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50688, Unit:GetMainTank()) 
end

function DeathKnightChampion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DeathKnightChampion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DeathKnightChampion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27288, 1, "DeathKnightChampion_OnCombat")
RegisterUnitEvent(27288, 2, "DeathKnightChampion_OnLeaveCombat")
RegisterUnitEvent(27288, 3, "DeathKnightChampion_OnKilledTarget")
RegisterUnitEvent(27288, 4, "DeathKnightChampion_OnDied")