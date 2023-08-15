--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GameltheCruel_OnCombat(Unit, Event)
Unit:RegisterEvent("GameltheCruel_MortalStrike", 6000, 0)
end

function GameltheCruel_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(13737, Unit:GetMainTank()) 
end

function GameltheCruel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GameltheCruel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GameltheCruel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26449, 1, "GameltheCruel_OnCombat")
RegisterUnitEvent(26449, 2, "GameltheCruel_OnLeaveCombat")
RegisterUnitEvent(26449, 3, "GameltheCruel_OnKilledTarget")
RegisterUnitEvent(26449, 4, "GameltheCruel_OnDied")