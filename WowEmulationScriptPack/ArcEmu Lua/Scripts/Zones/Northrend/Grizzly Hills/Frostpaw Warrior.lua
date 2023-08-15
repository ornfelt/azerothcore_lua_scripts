--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrostpawWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("FrostpawWarrior_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("FrostpawWarrior_Pummel", 12000, 0)
Unit:RegisterEvent("FrostpawWarrior_Rend", 10000, 0)
end

function FrostpawWarrior_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function FrostpawWarrior_Pummel(Unit, Event) 
Unit:FullCastSpellOnTarget(12555, Unit:GetMainTank()) 
end

function FrostpawWarrior_Rend(Unit, Event) 
Unit:FullCastSpellOnTarget(12054, Unit:GetMainTank()) 
end

function FrostpawWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrostpawWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrostpawWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26357, 1, "FrostpawWarrior_OnCombat")
RegisterUnitEvent(26357, 2, "FrostpawWarrior_OnLeaveCombat")
RegisterUnitEvent(26357, 3, "FrostpawWarrior_OnKilledTarget")
RegisterUnitEvent(26357, 4, "FrostpawWarrior_OnDied")