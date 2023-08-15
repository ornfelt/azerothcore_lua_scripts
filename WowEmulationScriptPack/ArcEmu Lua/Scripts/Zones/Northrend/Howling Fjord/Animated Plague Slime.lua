--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AnimatedPlagueSlime_OnCombat(Unit, Event)
Unit:RegisterEvent("AnimatedPlagueSlime_DarkSludge", 4000, 2)
end

function AnimatedPlagueSlime_DarkSludge(Unit, Event) 
Unit:FullCastSpellOnTarget(3335, Unit:GetMainTank()) 
end

function AnimatedPlagueSlime_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnimatedPlagueSlime_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnimatedPlagueSlime_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24279, 1, "AnimatedPlagueSlime_OnCombat")
RegisterUnitEvent(24279, 2, "AnimatedPlagueSlime_OnLeaveCombat")
RegisterUnitEvent(24279, 3, "AnimatedPlagueSlime_OnKilledTarget")
RegisterUnitEvent(24279, 4, "AnimatedPlagueSlime_OnDied")