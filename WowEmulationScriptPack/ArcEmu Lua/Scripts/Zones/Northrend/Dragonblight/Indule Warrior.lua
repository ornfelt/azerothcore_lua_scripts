--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InduleWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("InduleWarrior_SpectralStrike", 6000, 0)
end

function InduleWarrior_SpectralStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(51786, Unit:GetMainTank()) 
end

function InduleWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InduleWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InduleWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26344, 1, "InduleWarrior_OnCombat")
RegisterUnitEvent(26344, 2, "InduleWarrior_OnLeaveCombat")
RegisterUnitEvent(26344, 3, "InduleWarrior_OnKilledTarget")
RegisterUnitEvent(26344, 4, "InduleWarrior_OnDied")